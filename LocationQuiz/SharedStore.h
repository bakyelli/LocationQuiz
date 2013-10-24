//
//  SharedStore.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/22/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Location.h"

@interface SharedStore : NSObject


@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(strong,nonatomic) NSManagedObjectModel *managedObjectModel;

+ (SharedStore *)returnSharedStore;

- (Location *)newLocation;
- (void) addLocationEntity:(Location *)loc;

@end
