//
//  InDetailCollectionViewCell.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import "InDetaileNoteTextCellImpl.h"

@implementation InDetaileNoteTextCellImpl

UITextView *_text;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setupUI];
        [self _setupLayout];
    }
    return self;
}

- (void)_setupUI {
    _text = UITextView.new;
    _text.backgroundColor = UIColor.lightGrayColor;
    
    [self.contentView addSubview:_text];
    _text.layer.cornerRadius = 10.0;
}

- (void)_setupLayout {
    [_text setFrame: self.contentView.bounds];
}

- (void)setup:(NoteModel*)data {
    _text.text = data.text;
    
}

- (NSString*)returnNoteText {
    return _text.text;
}

@end
