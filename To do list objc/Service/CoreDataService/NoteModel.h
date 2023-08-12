//
//  NoteModel.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface NoteModel : NSObject 

@property (nonatomic, strong) NSNumber *noteID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;

- (instancetype)initWithNoteID:(NSNumber *)noteID
               title:(NSString *)title
                text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END


