//
//  InDetailCollectionViewCell.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"

@interface InDetaileNoteTextCellImpl : UICollectionViewCell

- (void)setup:(NoteModel*)data deledate:(id<UITextViewDelegate>)delegate;
- (NSString *)returnNoteText;

@end

