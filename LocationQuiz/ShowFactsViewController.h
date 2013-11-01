//
//  ShowFactsViewController.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "Quiz+Methods.h"
#import "SharedStore.h"

@interface ShowFactsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) Quiz *quiz;
@property (strong,nonatomic) NSMutableArray *cardsArray;

@end
