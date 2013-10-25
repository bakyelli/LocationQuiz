//
//  FSVenue.h
//  APIsAndBlocks
//
//  Created by Basar Akyelli on 10/24/13.
//  Copyright (c) 2013 Basar Akyelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSVenue : NSObject

    @property (nonatomic, strong) NSString *name;
    @property (nonatomic, strong) NSString *venueID;
    @property (nonatomic, strong) NSNumber *latitude;
    @property (nonatomic, strong) NSNumber *longtitude;
    
    +(NSArray *) convertToVenues:(NSArray *)venues; 
    -(id)initWithName:(NSString *)name
              venueID:(NSString *)venueID
             latitude:(NSNumber *)lat
           longtitude:(NSNumber *)lgt;
    
    
@end
