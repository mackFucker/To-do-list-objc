//
//  CustomCell.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "CustomCell.h"

@implementation CustomCell

UILabel *_titleLabel;
UITextView *_noteTextView;
UILabel *_dateLabel;

UIStackView *_stack;

NSTextAttachment *imageAttachment;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setupUI];
        [self _setupLayout];
    }
    return self;
}

- (void)_setupUI {
    self.contentView.layer.cornerRadius = 10.0;
    
    imageAttachment = [[NSTextAttachment alloc] init];
    imageAttachment.image = [[UIImage systemImageNamed:@"calendar"]
                             imageWithTintColor:[UIColor tintColor]];
    
    _titleLabel = UILabel.new;
    _noteTextView = UITextView.new;
    _dateLabel = UILabel.new;
    _stack = UIStackView.new;
    
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    _noteTextView.translatesAutoresizingMaskIntoConstraints = false;
    _noteTextView.editable = false;
    _noteTextView.selectable = false;
    _noteTextView.pagingEnabled = false;
    _noteTextView.userInteractionEnabled = false;
    _noteTextView.backgroundColor = UIColor.lightGrayColor;
    _noteTextView.backgroundColor = [_noteTextView.backgroundColor colorWithAlphaComponent:0.3];
    [self.contentView addSubview:_noteTextView];
    _noteTextView.layer.cornerRadius = 10;
        
    _stack.axis = UILayoutConstraintAxisVertical;
    _stack.translatesAutoresizingMaskIntoConstraints = false;
    
    [_stack addArrangedSubview:_titleLabel];
    [_stack addArrangedSubview:_dateLabel];

    [self.contentView addSubview:_stack];
}

- (void)setupNote:(NoteModel *)data {
    _titleLabel.text = data.title;
    _noteTextView.text = data.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"11.03.23 "];
    [attributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:imageAttachment]];
    _dateLabel.attributedText = attributedString;
}

- (void)_setupLayout {
    [NSLayoutConstraint activateConstraints:@[
        [_noteTextView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8],
        [_noteTextView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8],
        [_noteTextView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
        [_noteTextView.bottomAnchor constraintEqualToAnchor:_stack.topAnchor constant: -8],

        [_stack.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8],
        [_stack.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
        [_stack.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8]
    ]];
}

@end
