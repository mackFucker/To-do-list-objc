//
//  InDetailPresenter.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import "InDetailPresenter.h"

@implementation InDetailPresenter

id<CoreDataServiceRepository> _coreData;

@synthesize view;

- (instancetype)initWithView:(id<InDetailViewDelegate>)view {
    if(self) {
        self.view = view;
        self.view.presenter = self;
        _coreData = [CoreDataServiceRepositoryImpl sharedInstance];
    }
    return self;
}

- (void)editNote:(NoteModel*)data {
    [_coreData editNote:data];
}

@end
