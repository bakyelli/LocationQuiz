//
//  Card+Methods.m
//  LocationQuiz
//
//  Created by Chemin Lin on 10/31/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "Card+Methods.h"
#import "SharedStore.h"

@implementation Card (Methods)

- (id) initWithTitle:(NSString *)title andOrder:(NSNumber *)order onQuiz:(Quiz *)quiz withAttachment:(NSString *)attachment {
    self = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    if (self){
        self.title = title;
        self.difficulty = @0;
        self.order = order;
        self.quiz = quiz;
        self.attachment = attachment;
    }
    return self;
}

- (id) init {
    return [self initWithTitle:@"" andOrder:@0 onQuiz:nil withAttachment:nil];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@\n order:%@\n attachment:%@",self.title, self.order, self.attachment];
}


@end
