//
//  Answer.h
//  LocationQuiz
//
//  Created by Joe Burgess on 10/23/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card;

@interface Answer : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * isCorrect;
@property (nonatomic, retain) Card *card;

@end
