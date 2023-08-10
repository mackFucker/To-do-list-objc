//
//  CustomeTextField.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 04.08.2023.
//

#import "AddNoteAnimateView.h"

@implementation AddNoteAnimateView

CGFloat widht;
CGFloat height;

UITextField *noteNameView;
UIButton *button;
UIButton *canselButton;

- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<UITextFieldDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        widht = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
        
        noteNameView = UITextField.new;
        button = UIButton.new;
        canselButton = UIButton.new;
        
        button.layer.cornerRadius = 10;
        [button setTitle: @"addNote" forState:UIControlStateNormal];
        button.titleLabel.tintColor = UIColor.grayColor;
        [button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [button setFrame: self.bounds];
        [button addTarget:self action:@selector(setupUIСreatureActivate)
         forControlEvents: UIControlEventTouchUpInside];
        
        noteNameView.delegate = delegate;
        noteNameView.textAlignment = NSTextAlignmentCenter;
        noteNameView.borderStyle = UITextBorderStyleNone;
        noteNameView.font = [UIFont systemFontOfSize:16];
        noteNameView.textColor = [UIColor blackColor];
        noteNameView.placeholder = @"Enter the name";
        noteNameView.alpha = 0;
        
        canselButton.layer.cornerRadius = 10;
        [canselButton setTitle: @"Cansel" forState:UIControlStateNormal];
        [canselButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [canselButton addTarget:self action:@selector(setupUIСreatureNotActivate)
               forControlEvents: UIControlEventTouchUpInside];
        canselButton.alpha = 0;
        
        self.backgroundColor = UIColor.lightGrayColor;
        self.layer.cornerRadius = 10;
        
        [self addSubview:button];
        [self bringSubviewToFront:button];
    }
    return self;
}

-(void)setupUIСreatureActivate {
    
    CGRect frame = CGRectMake(widht / 2 - widht / 4, height / 5,
                              widht / 2, height / 5);
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
        [button removeFromSuperview];
        
        self.frame = frame;
        
        CGFloat x = CGRectGetMidX(self.bounds) - widht / 6;
        CGFloat y = CGRectGetMidY(self.bounds) - height / 10;
        
        noteNameView.frame = CGRectMake(x, y,
                                        widht / 3, height / 7);
        [self addSubview:noteNameView];
        
        CGFloat cancelButtonWidth = widht / 4;
        CGFloat cancelButtonHeight = height / 10;
        CGFloat cancelButtonX = CGRectGetMidX(self.bounds) - cancelButtonWidth / 2;
        CGFloat cancelButtonY = CGRectGetMaxY(self.bounds) / 1.7;
        canselButton.frame = CGRectMake(cancelButtonX, cancelButtonY, cancelButtonWidth, cancelButtonHeight);
        [self addSubview:canselButton];
        
        noteNameView.alpha = 1;
        canselButton.alpha = 1;
    }
                     completion:^(BOOL finished){
        NSLog(@"Done!");
    }];
}

-(void)setupUIСreatureNotActivate {
    CGRect frame = CGRectMake(widht - 110, 60, 100, 40);
    noteNameView.text = @"";
  
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
        noteNameView.alpha = 0;
        canselButton.alpha = 0;
        [canselButton removeFromSuperview];
        [noteNameView removeFromSuperview];
        [self addSubview:button];
        
        self.frame = frame;
        [button setFrame: self.bounds];
    }
                     completion:^(BOOL finished){
        NSLog(@"Done!");
    }];
}

-(NSString*)getText {
    return noteNameView.text;
}

@end
