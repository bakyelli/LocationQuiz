//
//  Quiz.h
//  LocationQuiz
//
//  Created by Joe Burgess on 10/23/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Card, Location;

@interface Quiz : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSSet *cards;
@end

@interface Quiz (CoreDataGeneratedAccessors)

- (void)addCardsObject:(Card *)value;
- (void)removeCardsObject:(Card *)value;
- (void)addCards:(NSSet *)values;
- (void)removeCards:(NSSet *)values;

@end
