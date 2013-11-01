//
//  Location+Methods.m
//  LocationQuiz
//
//  Created by Chemin Lin on 10/30/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "Location+Methods.h"
#import "SharedStore.h"
#import "Quiz+Methods.h"

@implementation Location (Methods)

- (id) initWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude name:(NSString *)name {
    //    self = [super init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];

    self = (Location *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
     // self = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:nil];
    
    
    
    if (self){
        self.latitude = latitude;
        self.longitude = longitude;
        self.name = name;
    }
    return self;
}

- (id) init {
    return [self initWithLatitude:@0 longitude:@0 name:@""];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ID: %@\nLat: %@\nLong:%@\nName:%@",self.locationID, self.latitude,self.longitude,self.name];
}

@end
