//
//  CustomCell.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "CustomCell.h"

@implementation CustomCell

UILabel *_titleLabel;
UILabel *_secondLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setupUI];
        [self _setupLayout];
    }
    return self;
}

- (void)_setupUI {
     _titleLabel = UILabel.new;
     _secondLabel = UILabel.new;
    
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:_titleLabel];
    
    _secondLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.contentView addSubview:_secondLabel];
    
    self.contentView.backgroundColor = UIColor.lightGrayColor;
    self.contentView.layer.cornerRadius = 10.0;
}

- (void)setupNote:(NSString *)title noteText:(NSString*)noteText {
    _titleLabel.text = title;
    _secondLabel.text = noteText;
}

- (void)_setupLayout {
    [NSLayoutConstraint activateConstraints:@[
        [_titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8],
        [_titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8],
        [_titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
       
        [_secondLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8],
        [_secondLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
        [_secondLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8]
    ]];
}

@end
