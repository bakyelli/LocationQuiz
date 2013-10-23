//
//  LocationEntity.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/22/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LocationEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longtitude;
@property (nonatomic, retain) NSSet *hasCards;
@end

@interface LocationEntity (CoreDataGeneratedAccessors)

- (void)addHasCardsObject:(NSManagedObject *)value;
- (void)removeHasCardsObject:(NSManagedObject *)value;
- (void)addHasCards:(NSSet *)values;
- (void)removeHasCards:(NSSet *)values;

@end
