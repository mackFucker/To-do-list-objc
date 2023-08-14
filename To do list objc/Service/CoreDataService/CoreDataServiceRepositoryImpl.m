//
//  CoreDataService.m
//  To do list objc
//
//  Created by дэвид Кихтенко on 09.08.2023.
//

#import "CoreDataServiceRepositoryImpl.h"

@implementation CoreDataServiceRepositoryImpl

NSMutableArray<NSManagedObject *> *_notesData;
id<NotifyAboutChanges> _delegate;

+ (instancetype)sharedInstance {
    
    static CoreDataServiceRepositoryImpl *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _notesData = [[NSMutableArray alloc] init ];
        sharedInstance = [[CoreDataServiceRepositoryImpl alloc] init];
    });
    return sharedInstance;
}

- (void)setDelegate:(id<NotifyAboutChanges>)delegate {
    _delegate = delegate;
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
    [_delegate notify:@(_notesData.count - 1) type: TypeofChangesAdd];
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
    [_delegate notify:@(_notesData.count - 1) type: TypeofChangesEdit];
}

- (void)deleteNote: (NSNumber *)index {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:_notesData[index.intValue]];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Could not save. %@, %@", error, error.userInfo);
    }
    [_notesData removeObjectAtIndex:index.intValue];
    [_delegate notify:@(_notesData.count - 1) type: TypeofChangesDelete];
}

- (void)receivingFromPersistenStore {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];

    NSError *error = nil;
    NSArray *notes = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
       NSLog(@"Could not fetch. %@, %@", error, [error userInfo]);
    }
    notes = [notes sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
       int id1 = [[obj1 valueForKey:@"id"] intValue];
       int id2 = [[obj2 valueForKey:@"id"] intValue];
       if (id1 < id2) {
          return NSOrderedAscending;
       } else if (id1 > id2) {
          return NSOrderedDescending;
       } else {
          return NSOrderedSame;
       }
    }];
    _notesData = [notes mutableCopy];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.persistentContainer.viewContext;
    return context;
}

@end
