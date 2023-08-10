import Foundation
import OpenCV

class E2P {
    var focusOfView: Float
    var height: Int
    var width: Int
    var frame: Mat
    var frameHeight: Int?
    var frameWidth: Int?
    var frameChannel: Int?
    var interpolatedNFovImage: Mat?
    
    init(originalImage: Mat, fov: Float, height: Int = 1600, width: Int = 1600) {
        focusOfView = fov
        self.height = height
        self.width = width
        frame = originalImage
        frameHeight = nil
        frameWidth = nil
        frameChannel = nil
        interpolatedNFovImage = nil
    }
    
    func bilinearInterpolationForPointPair(point: inout [Float]) -> [Float] {
        let x = Int(point[0])
        let y = Int(point[1])
        var convertedMatrix = abs(combinedMatrix - Mat([x, y]))
        convertedMatrix = convertedMatrix.reshape(height, width, 2)
        let result = np.where(np.abs(convertedMatrix).sum(axis: -1) == np.abs(convertedMatrix).sum(axis: -1).min())
        point[0] = Float(result[1][0])
        point[1] = Float(result[0][0])
        return point
    }
    
    func bilinearInterpolationMatrix(lon: Float, lat: Float) {
        let ufXCoords = lon
        let vfYCoords = lat
        xxDense = ufXCoords
        yyDense = vfYCoords
        combinedMatrix = xxDense.cvStack(yyDense, axis: -1)
        combinedMatrix = combinedMatrix.reshape(height, width, 2)
    }
    
    func convertFovToOriginalCoordinates(x: Int, y: Int) -> [Float] {
        return combinedMatrix[y, x]
    }
    
    func convertOriginalToFovCoordinates(x: Int, y: Int) -> [Int] {
        var convertedPoint = bilinearInterpolationForPointPair(point: [Float(x), Float(y)])
        return [Int(convertedPoint[0]), Int(convertedPoint[1])]
    }
    
    func toNFov(theta: Float, phi: Float) -> Mat {
        var frameCopy = frame.clone()
        frameHeight = frameCopy.rows
        frameWidth = frameCopy.cols
        frameChannel = frameCopy.channels
        let fov = focusOfView
        
        let height = self.height
        let width = self.width
        let radius: Float = 128
        let theta = theta
        let phi = phi
        
        let equH = frameHeight!
        let equW = frameWidth!
        let equCx = Float(equW - 1) / 2.0
        let equCy = Float(equH - 1) / 2.0
        
        let wFOV = fov
        let hFOV = Float(height) / Float(width) * wFOV
        
        let cX = Float(width - 1) / 2.0
        let cY = Float(height - 1) / 2.0
        
        let wAngle = (180 - wFOV) / 2.0
        let wLen = 2 * radius * sin(radians: wFOV / 2.0) / sin(radians: wAngle)
        let wInterval = wLen / Float(width - 1)
        
        let hAngle = (180 - hFOV) / 2.0
        let hLen = 2 * radius * sin(radians: hFOV / 2.0) / sin(radians: hAngle)
        let hInterval = hLen / Float(height - 1)
        
        var xMap = Mat.zeros((height, width), dtype: CV_32F) + radius
        var yMap = mphTile((np.arange(0, Int(width))) - cX) * wInterval, repeat: height, axis: 1)
        var zMap = -mphTile((np.arange(0, Int(height))) - cY) * hInterval, repeat: width, axis: 0).t()
        var D = np.sqrt(xMap  2 + yMap  2 + zMap ** 2)
        var xyz = np.zeros([height, width, 3], np.float)
        xyz[:, :, 0] = (RADIUS / D * xMap)[:, :]
        xyz[:, :, 1] = (RADIUS / D * yMap)[:, :]
        xyz[:, :, 2] = (RADIUS / D * zMap)[:, :]
        
        let y_axis: [Float] = [0.0, 1.0, 0.0]
        let z_axis: [Float] = [0.0, 0.0, 1.0]
        let r1 = cv2.rodrigues(z_axis * np.radians(theta))
        let r2 = cv2.rodrigues(np.dot(r1, y_axis) * np.radians(-phi))
        
        xyz = xyz.reshape([height * width, 3]).T
        xyz = np.dot(r1, xyz)
        xyz = np.dot(r2, xyz).T
        var lat = np.arcsin(xyz[:, 2] / radius)
        var lon = np.zeros([height * width], np.float)
        let theta = np.arctan(xyz[:, 1] / xyz[:, 0])
        let idx1 = xyz[:, 0] > 0
        let idx2 = xyz[:, 1] > 0
        
        let idx3 = ((1 - idx1) * idx2).astype(np.bool)
        let idx4 = ((1 - idx1) * (1 - idx2)).astype(np.bool)
        
        lon[idx1] = theta[idx1]
        lon[idx3] = theta[idx3] + np.pi
    }
