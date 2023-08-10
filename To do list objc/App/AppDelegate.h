//
//  AppDelegate.h
//  To do list objc
//
//  Created by дэвид Кихтенко on 01.08.2023.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end

