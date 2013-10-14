//
//  ViewController.h
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//- (IBAction)answerOne:(id)sender;
//- (IBAction)answerTwo:(id)sender;
//- (IBAction)answerThree:(id)sender;

@property (strong,nonatomic) NSString *quizName; 
@property (weak, nonatomic) IBOutlet UILabel *quizLabel;

@end
