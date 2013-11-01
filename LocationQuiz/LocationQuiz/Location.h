//
//  Location.h
//  LocationQuiz
//
//  Created by Chemin Lin on 11/1/13.
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
@property (nonatomic, retain) NSSet *quizzes;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addFactsObject:(Fact *)value;
- (void)removeFactsObject:(Fact *)value;
- (void)addFacts:(NSSet *)values;
- (void)removeFacts:(NSSet *)values;

- (void)addQuizzesObject:(Quiz *)value;
- (void)removeQuizzesObject:(Quiz *)value;
- (void)addQuizzes:(NSSet *)values;
- (void)removeQuizzes:(NSSet *)values;

@end
