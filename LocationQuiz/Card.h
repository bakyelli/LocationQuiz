//
//  Card.h
//  LocationQuiz
//
//  Created by Joe Burgess on 10/23/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Answer, Question, Quiz;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSNumber * difficulty;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) Quiz *quiz;
@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) NSSet *answers;
@end

@interface Card (CoreDataGeneratedAccessors)

- (void)addAnswersObject:(Answer *)value;
- (void)removeAnswersObject:(Answer *)value;
- (void)addAnswers:(NSSet *)values;
- (void)removeAnswers:(NSSet *)values;

@end
