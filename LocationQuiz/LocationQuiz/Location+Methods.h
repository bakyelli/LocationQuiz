//
//  Location+Methods.h
//  LocationQuiz
//
//  Created by Chemin Lin on 10/30/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "Location.h"

@interface Location (Methods)

- (id)initWithLatitude:(NSNumber *)latitude
             longitude:(NSNumber *)longitude
                  name:(NSString *)name;
@end
