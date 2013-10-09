//
//  Card.h
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "Answer.h"

@interface Card : NSObject

@property (strong, nonatomic) Question *question;
@property (strong, nonatomic) NSArray *answers;
@property (strong, nonatomic) NSNumber *difficulty;
@property (strong, nonatomic) NSNumber *order;



-(NSArray*)randomizedAnswers;



@end
