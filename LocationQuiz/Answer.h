//
//  Answer.h
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject


@property (strong, nonatomic) NSString *firstAnswerOption;
@property (strong, nonatomic) NSString *secondAnswerOption;
@property (strong, nonatomic) NSString *thirdAnswerOption;
@property BOOL correct;


@end
