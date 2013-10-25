//
//  FSVenue.m
//  APIsAndBlocks
//
//  Created by Basar Akyelli on 10/24/13.
//  Copyright (c) 2013 Basar Akyelli. All rights reserved.
//

#import "FSVenue.h"

@implementation FSVenue

    -(id)init{
        return [self initWithName:@"" venueID:@"" latitude:@0 longtitude:@0 distance:@0];
        
    }
-(id)initWithName:(NSString *)name venueID:(NSString *)venueID latitude:(NSNumber *)lat longtitude:(NSNumber *)lgt distance:(NSNumber *)distance{
        self = [super init];
        
        if(self)
        {
            _name = name;
            _venueID = venueID;
            _latitude = lat;
            _longtitude = lgt;
            _distance = distance;
        }
        return self;
    }
    
    -(id)initWithVenueDictionary:(NSDictionary *)venue
    {
        return [self initWithName:venue[@"name"]
                          venueID:venue[@"id"]
                         latitude:[NSNumber numberWithDouble:[venue[@"location"][@"lat"] doubleValue]]
                                                  longtitude:[NSNumber numberWithDouble:[venue[@"location"][@"lng"] doubleValue]]
                         distance:[NSNumber numberWithDouble:[venue[@"location"][@"distance"] doubleValue]]];
    }
    +(NSArray *)convertToVenues:(NSArray *)venues
    {
        NSMutableArray *objects = [NSMutableArray arrayWithCapacity:[venues count]];
        
        for(NSDictionary *venue in venues)
        {
            FSVenue *myVenue = [[FSVenue alloc]initWithVenueDictionary:venue];
            
            [objects addObject:myVenue];

        }
        return objects;
    }
    
    
    
    
@end
