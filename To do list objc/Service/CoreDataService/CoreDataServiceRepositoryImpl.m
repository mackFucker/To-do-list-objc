//
//  CoreDataService.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import "CoreDataServiceRepositoryImpl.h"

@implementation CoreDataServiceRepositoryImpl

NSMutableArray<NSManagedObject *> *_notesData;

- (void)addNote:(NSNumber *)noteID title:(NSString *)title {
    
}

- (NSMutableArray *)getNotesData {
    return _notesData;
}

- (void)editNote:(NSNumber *)index {
    
}

- (void)deleteNote: (NSNumber *)index {
    
}

@end
