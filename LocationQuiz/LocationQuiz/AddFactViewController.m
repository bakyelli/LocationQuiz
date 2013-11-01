//
//  AddFactViewController.m
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/24/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "AddFactViewController.h"
#import "SharedStore.h"
#import "Quiz+Methods.h"
#import "Card+Methods.h"
#import "ShowFactsViewController.h"
@interface AddFactViewController ()
{
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}
@property (nonatomic) BOOL didRecord;
@end

@implementation AddFactViewController

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
 
    self.titleTextBox.delegate = self;
    self.locationName.text = self.quiz.name;
    
    self.didRecord = NO;
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    
    NSString *fileName = [NSString stringWithFormat:@"%f%@",timeStamp,@".m4a"];
    
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], fileName,nil];
    self.outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof (audioRouteOverride),&audioRouteOverride);


    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    recorder = [[AVAudioRecorder alloc]initWithURL:self.outputFileURL settings:recordSetting error:nil];
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    
    [self.lblMessage setText:@"Ready to record..."];
    
    
    
    
    
    

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recButtonAction:(id)sender {

    if(player.playing)
    {
        [player stop];
        [self.lblMessage setText:@"Ready to record..."];

    }
    
    if(!recorder.recording)
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        [recorder record];
        [self.recBtn setTitle:@"STOP" forState:UIControlStateNormal];
        [self.lblMessage setText:@"Recording..."];
        self.didRecord = YES;
        
    } else{
        [recorder stop];
        [self.recBtn setTitle:@"REC" forState:UIControlStateNormal];
        
        AVAudioSession *audioSesson = [AVAudioSession sharedInstance];
        [audioSesson setActive:NO error:nil];
    }
}

- (IBAction)playBtnPressed:(id)sender {
    if(!recorder.recording)
    {
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:recorder.url error:nil];
        
        [player setDelegate:self];
        [player play];
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.lblMessage setText:@"Ready to record..."];

}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    [self.recBtn setTitle:@"REC" forState:UIControlStateNormal];
    [self.lblMessage setText:@"Ready to play!"];
}
//- (IBAction)done:(id)sender {
//    if (![self.titleTextBox.text isEqualToString:@""] && self.didRecord) {
//        
//        Fact *f = [SharedStore returnSharedStore].newFact;
//        
//        f.title = self.titleTextBox.text;
//        f.soundFilePath = [self.outputFileURL absoluteString];
//        f.dateAdded = [NSDate date];
//        
//        [self.location addFactsObject:f];
//        [[SharedStore returnSharedStore] saveContext];
//        
//        [self returnToShowFacts];
//    }
//}

- (IBAction)done:(id)sender {
    if (![self.titleTextBox.text isEqualToString:@""] && self.didRecord) {
        
        Card *card = [SharedStore returnSharedStore].newCard;
        
        card.title = self.titleTextBox.text;
        card.attachment = [self.outputFileURL absoluteString];
        
        [self.quiz addCardsObject:card];
        
        [[SharedStore returnSharedStore] saveContext];
        
        [self returnToShowFacts];
    }
}


- (IBAction)cancel:(id)sender {
    [self returnToShowFacts];
}

- (void)returnToShowFacts {

    ShowFactsViewController *sfvc = [[ShowFactsViewController alloc]init];
    sfvc.quiz = self.quiz;
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:sfvc];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}
@end
