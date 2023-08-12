//
//  Presenter.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 31.07.2023.
//

#import <Foundation/Foundation.h>
#import "CoreDataServiceRepositoryImpl.h"
#import "NoteModel.h"

@protocol MainScreenPresenterDelegate;

@protocol MainScreenViewDelegate <NSObject>

@property id<MainScreenPresenterDelegate> presenter;

@end

@protocol MainScreenPresenterDelegate <NSObject>

@property(nonatomic,strong) id< MainScreenViewDelegate > view;

- (instancetype)initWithView: (id <MainScreenViewDelegate>) view;

- (void)addNote:(NSNumber *)noteID title:(NSString *)title;
- (NSMutableArray *)getNotesData;
- (NoteModel *)getNote:(NSNumber*)index;

@end

@interface MainScreenPresenter : NSObject <MainScreenPresenterDelegate>

@end

