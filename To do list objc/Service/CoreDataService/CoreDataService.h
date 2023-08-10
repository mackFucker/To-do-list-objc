//
//  CoreDataService.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataService : NSObject

- (void)addNote:(NSNumber *)noteID title:(NSString *)title;
- (NSMutableArray *)getNotesData;


@end

NS_ASSUME_NONNULL_END
