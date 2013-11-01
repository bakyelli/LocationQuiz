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
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Quiz" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    self = (Quiz *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    
    // self = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:nil];
    
    //self = [NSEntityDescription insertNewObjectForEntityForName:@"Quiz" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    if (self){
        self.name = location.name;
        self.location = location;
    }
    return self;
}
- (id) initWithQuizID:(NSNumber *)quizID name:(NSString *)quizName {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Quiz" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    self = (Quiz *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    
    if (self){
        self.quizID = quizID;
        self.name = quizName;
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
