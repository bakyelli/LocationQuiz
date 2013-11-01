//
//  ShowFactsViewController.m
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "ShowFactsViewController.h"
#import "Card+Methods.h"
#import "AddFactViewController.h"

@interface ShowFactsViewController ()
{
    AVAudioPlayer *player;

}

@end

@implementation ShowFactsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];

    UIBarButtonItem *backToMapButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(backToMapButtonPressed:)];


    
    [self.navigationItem setRightBarButtonItem:addButton];
    [self.navigationItem setLeftBarButtonItem:backToMapButton];
    
    NSLog(@"our location: %@",self.quiz.location);
    NSLog(@"We're seeing facts for %@", self.quiz.name);
    
    self.title = [NSString stringWithFormat:@"%@ - Facts", self.quiz.name];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);
    
    

    
    
    
}

- (void) backToMapButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"rootNavController"];
    [self presentViewController:navController animated:YES completion:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cardsArray = [[self.quiz.cards allObjects] mutableCopy];

    NSLog(@"I have %i cards for this quiz.", [self.quiz.cards count]);
    [self.tableView reloadData];
}

-(void)addButtonPressed:(id)sender
{
    AddFactViewController *addFactVC = [[AddFactViewController alloc]init];
    addFactVC.quiz = self.quiz;
    
    [self.navigationController pushViewController:addFactVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.quiz.cards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Card *card = self.cardsArray[indexPath.row];
    
    cell.textLabel.text = card.title;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Card *cardSelected = [self.cardsArray objectAtIndex:indexPath.row];
    
    NSURL *fileURL = [NSURL URLWithString:cardSelected.attachment];
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    
    //[player setDelegate:self];
    [player play];

}



@end
