//
//  listTableViewController.h
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/14/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface listTableViewController : UITableViewController<UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *quizzes;

@end
