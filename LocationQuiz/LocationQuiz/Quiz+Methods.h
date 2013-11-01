//
//  Quiz+Methods.h
//  LocationQuiz
//
//  Created by Chemin Lin on 10/31/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "Quiz.h"

@interface Quiz (Methods)

- (id) initWithLocation:(Location *)location;
- (id) initWithQuizID:(NSNumber *)quizID name:(NSString *)quizName;

@end
