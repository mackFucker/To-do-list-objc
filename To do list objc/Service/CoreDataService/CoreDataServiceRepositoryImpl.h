//
//  CoreDataService.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "NoteModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TypeofChanges) {
    TypeofChangesDelete,
    TypeofChangesAdd,
    TypeofChangesEdit,
    TypeofChangesToggle
};

@protocol NotifyAboutChanges <NSObject>

- (void) notify:(NSNumber*)index type:(TypeofChanges)type;

@end

@protocol CoreDataServiceRepository <NSObject>

- (void)addNote:(NSString *)title;
- (NSMutableArray *)getNotesData;
- (NoteModel *)getNote:(NSNumber *)index;
- (void)editNote:(NoteModel *)data;
- (void)deleteNote:(NSNumber *)index;
- (void)receivingFromPersistenStore;
- (void)setDelegate:(id<NotifyAboutChanges>)delegate;

+ (instancetype)sharedInstance;

@end

@interface CoreDataServiceRepositoryImpl : NSObject<CoreDataServiceRepository>

@end

NS_ASSUME_NONNULL_END
