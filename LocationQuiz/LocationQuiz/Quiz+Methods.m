//
//  Quiz+Methods.m
//  LocationQuiz
//
//  Created by Chemin Lin on 10/31/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "Quiz+Methods.h"
#import "Location.h"
#import "SharedStore.h"

@implementation Quiz (Methods)
- (id) initWithLocation:(Location *)location {
    //    self = [super init];
    self = [NSEntityDescription insertNewObjectForEntityForName:@"Quiz" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    if (self){
        self.name = location.name;
        self.location = location;
    }
    return self;
}

- (id) init {
    return [self initWithLocation:nil];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Name: %@",self.name];
}

@end
