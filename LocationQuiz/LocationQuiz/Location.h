//
//  Location.h
//  LocationQuiz
//
//  Created by Chemin Lin on 10/31/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fact, Quiz;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * locationID;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *facts;
@property (nonatomic, retain) Quiz *quizzes;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addFactsObject:(Fact *)value;
- (void)removeFactsObject:(Fact *)value;
- (void)addFacts:(NSSet *)values;
- (void)removeFacts:(NSSet *)values;

@end
