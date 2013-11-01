//
//  ViewController.m
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.quizLabel.text = [NSString stringWithFormat:@"Welcome to the %@ quiz!",self.quizName];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
