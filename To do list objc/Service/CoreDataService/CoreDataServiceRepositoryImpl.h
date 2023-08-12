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

@protocol CoreDataServiceRepository <NSObject>

- (void)addNote:(NSNumber *)noteID title:(NSString *)title;
- (NSMutableArray *)getNotesData;
- (NoteModel *)getNote:(NSNumber *)index;
- (void)editNote:(NoteModel *)data;
- (void)deleteNote: (NSNumber *)index;
+ (instancetype)sharedInstance;

@end

@interface CoreDataServiceRepositoryImpl : NSObject<CoreDataServiceRepository>

@end

NS_ASSUME_NONNULL_END
