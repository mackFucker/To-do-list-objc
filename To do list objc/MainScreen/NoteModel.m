//
//  NoteModel.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import "NoteModel.h"

@implementation NoteModel

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _noteText = @"";
    }
    return self;
}

@end
