//
//  NoteModel.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import "NoteModel.h"

@implementation NoteModel

@dynamic noteID;
@dynamic title;
@dynamic noteText;

- (instancetype)init:(NSNumber *)noteID title:(NSString *)title {
    self = [super init];
    if (self) {
        self.noteID = noteID;
        self.title = title;
        self.noteText = @"";
    }
    return self;
}

@end
