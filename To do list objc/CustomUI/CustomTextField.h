//
//  CustomeTextField.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 04.08.2023.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UIView

@property(nonatomic, strong) UITextField *noteName;
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate>)delegate;
-(NSString*)getText;

@end

