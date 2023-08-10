//
//  NoteModel.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NoteModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface NoteModel : NSManagedObject

@property (nonatomic, strong) NSNumber *noteID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *noteText;

- (instancetype)init:(NSNumber *)noteID title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END


