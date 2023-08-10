//
//  InDetailPresenter.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import "InDetailPresenter.h"

@implementation InDetailPresenter

@synthesize view;

- (void)editNote:(NSNumber*)index text:(NSString*)text {
    //    _notes[index.intValue].noteText = text;
}

- (instancetype)initWithView: (id<InDetailViewDelegate>)view {
    if(self) {
        self.view = view;
    }
    return self;
}

@end
