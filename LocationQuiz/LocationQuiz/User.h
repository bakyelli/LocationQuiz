//
//  User.h
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSNumber *correctAnswers;
@property (strong, nonatomic) NSNumber *wrongAnswers;


-(NSNumber*)questionsAnswered;
-(NSNumber*)percentageCorrect;
-(NSString*)fullName;




@end
