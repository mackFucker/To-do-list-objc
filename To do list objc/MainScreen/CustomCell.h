//
//  CustomCell.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"

@interface CustomCell : UICollectionViewCell

- (void)setupNote:(NoteModel *)data;

@end
