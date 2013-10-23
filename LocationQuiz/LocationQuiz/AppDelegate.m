//
//  AppDelegate.m
//  LocationQuiz
//
//  Created by Jay Abdallah on 10/9/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SharedStore.h"
#import "Location.h"
#import "Quiz.h"
#import "Card.h"
#import <CoreData/CoreData.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
    // Putting this here just to test the CoreData stuff. Normally all Core Data things should be wrapped in helpers in the DataStore
       NSManagedObjectContext *context = [SharedStore returnSharedStore].managedObjectContext;
    
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Quiz"];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@",@"Joe's awesome quiz"];
    fetchRequest.predicate=predicate;
    
    NSArray *quizzes = [context executeFetchRequest:fetchRequest error:nil];
    
    Quiz *myQuiz = [quizzes firstObject];
    
    Card *newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    newCard.difficulty = @5;
    
    Card *otherCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
    otherCard.difficulty = @3;
    
    NSSet *cards = [NSSet setWithObjects:newCard,otherCard, nil];
    
//    [myQuiz addCards:cards];
    
    NSLog(@"%@",myQuiz);
    
//
//    NSLog(@"%@",myQuiz.location.longitude);
//    
//    NSLog(@"%@",quizzes);
//    Location *newLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:context];
//
//    newLocation.latitude = [NSNumber numberWithDouble:40.7484];
//    newLocation.longitude = [NSNumber numberWithDouble:-73.9657];
//    
//    Quiz *newQuiz = [NSEntityDescription insertNewObjectForEntityForName:@"Quiz" inManagedObjectContext:context];
//    
//    newQuiz.name = @"Joe's awesome quiz";
//    
//    newQuiz.location = newLocation;
//    
//    NSError *error;
//    [context save:&error];
//    
//    if (error != nil){
//        NSLog(@"Error on save %@, User Info: %@",error, error.userInfo);
//    }
//    
//    NSLog(@"%@",newLocation);
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    NSString *locationName = [notification.userInfo valueForKey:@"LocationName"];
    
    
    if(state == UIApplicationStateActive)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:locationName message:notification.alertBody delegate:self cancelButtonTitle:@"Take the quiz!" otherButtonTitles:nil];
        
      //  alert set
        
        [alert show];
        NSLog(@"This location is: %@",[notification.userInfo valueForKey:@"LocationName"]);
        
    }
    else
    {
        ViewController *vc = [[ViewController alloc]init];
        vc.quizName = locationName;
        
        self.window.rootViewController = vc;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
    
        NSString *alertViewTitle = alertView.title;
        ViewController *vc = [[ViewController alloc]init];
        vc.quizName = alertViewTitle;
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
        
        
        
    }
}
@end
