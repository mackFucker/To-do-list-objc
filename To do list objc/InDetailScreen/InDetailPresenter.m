//
//  InDetailPresenter.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import "InDetailPresenter.h"

@implementation InDetailPresenter

@synthesize view;

static id<CoreDataServiceRepository> coreData;

- (void)editNote:(NoteModel*)data {
    [coreData editNote:data];
}

- (instancetype)initWithView: (id<InDetailViewDelegate>)view {
    if(self) {
        self.view = view;
        coreData = [CoreDataServiceRepositoryImpl sharedInstance];

    }
    return self;
}

@end
