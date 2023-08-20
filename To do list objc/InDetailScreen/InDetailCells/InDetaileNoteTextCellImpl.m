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
    _text.backgroundColor = [_text.backgroundColor colorWithAlphaComponent:0.3];
    
    [self.contentView addSubview:_text];
    _text.layer.cornerRadius = 10.0;
}

- (void)_setupLayout {
    [_text setFrame: self.contentView.bounds];
}

- (void)setup:(NoteModel*)data deledate:(id<UITextViewDelegate>)delegate {
    _text.text = data.text;
    [_text setDelegate:delegate];
}

- (NSString*)returnNoteText {
    return _text.text;
}

@end
