//
//  CardEntity.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/22/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LocationEntity;

@interface CardEntity : NSManagedObject

@property (nonatomic, retain) NSString * question;
@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) LocationEntity *hasLocation;

@end
