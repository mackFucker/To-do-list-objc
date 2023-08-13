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
    
    static CoreDataServiceRepositoryImpl *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _notesData = [[NSMutableArray alloc] init ];
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
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Could not save. %@, %@", error, error.userInfo);
    }
    
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
- (void)editNote:(NoteModel *)data {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [_notesData[data.noteID.intValue] setValue:data.text forKey:@"text"];

    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Could not save. %@, %@", error, error.userInfo);
    }
}

- (void)deleteNote: (NSNumber *)index {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:_notesData[index.intValue]];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Could not save. %@, %@", error, error.userInfo);
    }
    [_notesData removeObjectAtIndex:index.intValue];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.persistentContainer.viewContext;
    return context;
}

@end
