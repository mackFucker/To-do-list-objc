//
//  Presenter.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "MainScreenPresenter.h"

@implementation MainScreenPresenter

@synthesize notes;
@synthesize view;

NSMutableArray<NoteModel *> *_notes;

- (void)addNote:(NSString *)title {
    NoteModel *newNote = [[NoteModel alloc] initWithTitle:title];
    [_notes addObject:newNote];
    NSLog(@"%lu", (unsigned long)_notes.count);
}

- (NSMutableArray *)getNotesData {
    return _notes;
}

- (void)initWithView:(id<MainScreenViewDelegate>)view { 
    self.view = view;
    self.view.presenter = self;
    _notes = [[NSMutableArray alloc] init];
}

@end
