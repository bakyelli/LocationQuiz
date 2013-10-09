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

@property (strong, nonatomic) Question *questionText;
@property (strong, nonatomic) Answer *answer;




-(Question*)drawRandomQuestion;



@end
