//
//  IndetailViewControllerCollectionViewController.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import <UIKit/UIKit.h>
#import "InDetaileNoteTextCell.h"

@interface InDetailCollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
}
@end
