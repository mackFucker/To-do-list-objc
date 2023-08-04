//
//  CustomeTextField.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 04.08.2023.
//

#import "CustomTextField.h"

@implementation CustomTextField

CGFloat widht;
CGFloat height;
UITextField *noteName;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        noteName = UITextField.new;
        noteName.delegate = delegate;
        
        widht = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
        
        [self seupUI];
    }
    return self;
}

-(void)seupUI {
    self.frame = CGRectMake(widht / 2 - widht / 4, height / 5, widht / 2, height / 5);
    self.backgroundColor = UIColor.lightGrayColor;
    self.alpha = 5;
    self.layer.cornerRadius = 10;
    
    noteName.textAlignment = NSTextAlignmentCenter;
    noteName.borderStyle = UITextBorderStyleNone;
    noteName.font = [UIFont systemFontOfSize:16];
    noteName.textColor = [UIColor blackColor];
    noteName.placeholder = @"Enter the name of the note";

    CGFloat x = CGRectGetMidX(self.bounds) - widht / 6;
    CGFloat y = CGRectGetMidY(self.bounds) - height / 10;
    noteName.frame = CGRectMake(x, y, widht / 3, height / 7);
    
    [self addSubview:noteName];
}
-(NSString*)getText {
    return noteName.text;
}

@end
