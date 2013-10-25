//
//  DrawTableViewController.m
//  LocationQuiz
//
//  Created by Chemin Lin on 10/25/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "DrawerTableViewController.h"
#import "FSVenue.h"

@interface DrawerTableViewController ()

@end

@implementation DrawerTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.venues) {
        return [self.venues count];
    }
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.venues) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"venueCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"venueCell"];
        }
        FSVenue *venue = [self.venues objectAtIndex:indexPath.row];
        cell.textLabel.text = venue.name;
        return cell;
    }
    else {
        return nil;
    }
}
@end
