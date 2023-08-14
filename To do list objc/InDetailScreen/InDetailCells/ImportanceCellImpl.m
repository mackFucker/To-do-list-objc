//
//  ImportanceCell.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 02.08.2023.
//

#import "ImportanceCellImpl.h"

@implementation ImportanceCellImpl

UILabel *_label;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setupUI];
        [self _setupLayout];
    }
    return self;
}

- (void)_setupUI {
    _label = UILabel.new;
    _label.translatesAutoresizingMaskIntoConstraints = false;
    _label.text = @"importance";
    
    self.contentView.backgroundColor = UIColor.lightGrayColor;
    self.contentView.layer.cornerRadius = 10;
    [self.contentView addSubview:_label];
    
}

- (void)_setupLayout {
    [NSLayoutConstraint activateConstraints:@[
        [_label.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [_label.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10]
    ]];
}

@end
