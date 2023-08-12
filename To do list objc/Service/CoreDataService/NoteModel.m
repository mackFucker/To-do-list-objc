//
//  NoteModel.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import "NoteModel.h"

@implementation NoteModel

NSNumber *noteID;
NSString *title;
NSString *text;

- (instancetype)initWithNoteID:(NSNumber *)noteID
               title:(NSString *)title
                text:(NSString *)text {
    
    self = [super init];
    if (self) {
        self.noteID = noteID;
        self.title = title;
        self.text = text;
    }
    return self;
}

@end
