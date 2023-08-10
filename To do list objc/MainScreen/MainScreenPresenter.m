//
//  Presenter.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "MainScreenPresenter.h"

@implementation MainScreenPresenter

@synthesize view;

- (instancetype)initWithView:(id<MainScreenViewDelegate>)view {
    if(self) {
        self.view = view;
        self.view.presenter = self;
        _notes = [[NSMutableArray alloc] init];
    }
    return self;
}

NSMutableArray<NoteModel *> *_notes;

- (void)addNote:(NSNumber*)noteID title:(NSString *)title {
    NoteModel *newNote = [[NoteModel alloc] init:noteID title:title];
    [_notes addObject:newNote];
}

- (NSMutableArray *)getNotesData {
    return _notes;
}

@end
