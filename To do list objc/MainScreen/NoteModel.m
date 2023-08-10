//
//  NoteModel.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import "NoteModel.h"

@implementation NoteModel

- (instancetype)init:(NSNumber *)noteID title:(NSString *)title {
    self = [super init];
    if (self) {
        _noteID = noteID;
        _title = title;
        _noteText = @"";
    }
    return self;
}

@end
