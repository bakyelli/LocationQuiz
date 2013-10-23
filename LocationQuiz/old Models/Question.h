//
//  Question.h
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic)  NSString *content;
@property (strong, nonatomic) NSData *audio;


@end
