//
//  NoteModel.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import <Foundation/Foundation.h>

@class NoteModel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface NoteModel : NSObject

@property (nonatomic, strong) NSNumber *noteID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *noteText;

- (instancetype)init:(NSNumber *)noteID title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END


