//
//  CoreDataService.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import "CoreDataServiceRepositoryImpl.h"

@implementation CoreDataServiceRepositoryImpl

NSMutableArray<NSManagedObject *> *_notesData;

+ (instancetype)sharedInstance {
    _notesData = [[NSMutableArray alloc] init ];
    
    static CoreDataServiceRepositoryImpl *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CoreDataServiceRepositoryImpl alloc] init];
    });
    return sharedInstance;
}

- (void)addNote:(NSNumber *)noteID title:(NSString *)title {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Note"
                                              inManagedObjectContext:context];
    
    NSManagedObject *note = [[NSManagedObject alloc] initWithEntity:entity
                                     insertIntoManagedObjectContext:context];
    
    [note setValue:noteID forKey:@"id"];
    [note setValue:title forKey:@"title"];
    [note setValue:@"" forKey:@"text"];
    
    [_notesData addObject:note];
}

- (NSMutableArray *)getNotesData {
    return _notesData;
}

- (NoteModel *)getNote:(NSNumber *)index {
    NSManagedObject *noteData = _notesData[index.intValue];
    
    NoteModel *note = [[NoteModel alloc] initWithNoteID: index
                                        title:[noteData valueForKey:@"title"]
                                         text:[noteData valueForKey:@"text"]];
    return note;
}
- (void)editNote:(NSNumber *)index {
    
}

- (void)deleteNote: (NSNumber *)index {
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.persistentContainer.viewContext;
    return context;
}

@end
