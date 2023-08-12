//
//  InDetailPresenter.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import <Foundation/Foundation.h>
#import "CoreDataServiceRepositoryImpl.h"

@protocol InDetailPresenterDelegate;

@protocol InDetailViewDelegate <NSObject>

@property id<InDetailPresenterDelegate> presenter;

@end

@protocol InDetailPresenterDelegate <NSObject>

@property(nonatomic,strong) id<InDetailViewDelegate > view;

- (instancetype)initWithView:(id<InDetailViewDelegate>)view;

- (void)editNote:(NoteModel *)data;


@end

@interface InDetailPresenter : NSObject<InDetailPresenterDelegate>

@end
