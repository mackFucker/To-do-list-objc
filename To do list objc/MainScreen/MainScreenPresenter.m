//
//  Presenter.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import "MainScreenPresenter.h"

@implementation MainScreenPresenter

id<CoreDataServiceRepository> coreData;

@synthesize view;

- (instancetype)initWithView:(id<MainScreenViewDelegate>)view {
    if(self) {
        self.view = view;
        self.view.presenter = self;
        coreData = [CoreDataServiceRepositoryImpl sharedInstance];
    }
    return self;
}

- (void)addNote:(NSNumber*)noteID title:(NSString *)title {
    [coreData addNote:noteID
                title:title];
}

- (NSMutableArray *)getNotesData {
    return [coreData getNotesData];
}

- (NoteModel *)getNote:(NSNumber*)index {
    NSLog(@"%@", index);
    return [coreData getNote:index];
}

@end
