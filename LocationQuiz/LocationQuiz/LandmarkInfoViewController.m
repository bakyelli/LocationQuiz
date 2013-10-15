//
//  LandmarkInfoViewController.m
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/10/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "LandmarkInfoViewController.h"

@interface LandmarkInfoViewController ()

@end

@implementation LandmarkInfoViewController

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
    
    self.lblLandmarkName.text = self.strLandmarkName;
    self.lblLandmarkInterestingFacts.text = self.strLandmarkInterestingFacts;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
