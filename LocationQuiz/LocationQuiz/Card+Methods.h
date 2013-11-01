//
//  Card+Methods.h
//  LocationQuiz
//
//  Created by Chemin Lin on 10/31/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "Card.h"

@interface Card (Methods)

- (id) initWithTitle:(NSString *)title andOrder:(NSNumber *)order onQuiz:(Quiz *)quiz withAttachment:(NSString *)attachment;

@end
