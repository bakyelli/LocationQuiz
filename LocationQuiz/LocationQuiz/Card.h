//
//  Card.h
//  LocationQuiz
//
//  Created by Chemin Lin on 11/1/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Quiz;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * attachment;
@property (nonatomic, retain) NSNumber * cardID;
@property (nonatomic, retain) NSNumber * difficulty;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Quiz *quiz;

@end
