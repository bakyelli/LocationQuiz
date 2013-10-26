//
//  MapViewController.m
//  LocationQuiz
//
//  Created by Basar Akyelli on 10/10/13.
//  Copyright (c) 2013 Jay Abdallah. All rights reserved.
//

#import "MapViewController.h"
#import "PointOfInterestMapPoint.h"
#import "LandmarkInfoViewController.h"
#import "listTableViewController.h"
#import "SharedStore.h"
#import "Location.h"
#import "AddFactViewController.h"
#import "ShowFactsViewController.h"
#import "AddLocationViewController.h"
#import <MMDrawerController.h>
#import "DrawerTableViewController.h"
//#import "LocationEntity.h"
@interface MapViewController ()
@property (nonatomic, strong) MMDrawerController *drawerController;
@end

@implementation MapViewController


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
    
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc]initWithTitle:@"List" style:UIBarButtonItemStylePlain target:self action:@selector(listBtnPressed:)];
    
    [self.navigationItem setRightBarButtonItem:listButton];
    
    self.title = @"Points of Interest";
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Do any additional setup after loading the view.
    
    
    [self findLocation];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed:)];
    
    [self.navigationItem setLeftBarButtonItem:addButton];

    
}

- (void)addButtonPressed:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    AddLocationViewController *alvc = [storyboard instantiateViewControllerWithIdentifier:@"addLocation"];
    DrawerTableViewController *dtvc = [storyboard instantiateViewControllerWithIdentifier:@"drawerTableView"];
//    alvc.drawerController = self.drawerController;
    dtvc.currentLocation = self.locationManager.location;
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:alvc leftDrawerViewController:dtvc];
    
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:260.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //[self.navigationController pushViewController:self.drawerController animated:YES];
    [self presentViewController:self.drawerController animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Location"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.existinglocations = [[NSMutableArray alloc]init];
    
    self.existinglocations = [[[SharedStore returnSharedStore].managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

    NSLog(@"I have %i items in my data store", [self.existinglocations count]);
    
    [self addPointsOfInterestOnTheMap];

    
}

-(void)listBtnPressed:(id)sender
{
    listTableViewController *ltvc = [[listTableViewController alloc]init];
    ltvc.locations = [[self.mapView annotations] mutableCopy];
    
    
    for(int i=0; i<[ltvc.locations count]; i++)
    {
        id<MKAnnotation> annotation = ltvc.locations[i];
        
        if([annotation isKindOfClass:[MKUserLocation class]])
        {
            NSLog(@"Listed my location!");
            [ltvc.locations removeObjectAtIndex:i];
        }
        
    }
    
    [self.navigationController pushViewController:ltvc animated:YES];

//    AddFactViewController *afvc = [[AddFactViewController alloc]init];
//    [self.navigationController pushViewController:afvc animated:YES];
    
    NSLog(@"List button pressed");
}

-(void)findLocation
{

    [self.locationManager startUpdatingLocation];

    
}
-(void)addPointsOfInterestOnTheMap
{
    
    if([self.existinglocations count] == 0)
    {
       [self addDummyData];
    }


    for(Location *loc in self.existinglocations)
    {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([loc.latitude doubleValue], [loc.longitude doubleValue]);
        NSLog(@"location: %@, coordiate: %.4f, %.4f", loc.name, coord.latitude, coord.longitude);
        
        PointOfInterestMapPoint *mapPoint = [[PointOfInterestMapPoint alloc]initWithCoordinate:coord title:loc.name];
        
        mapPoint.location = loc;
        
        [self.mapView addAnnotation:mapPoint];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier  isEqual: @"AddLocation"])
    {
        
        Location *newLocation = [[SharedStore returnSharedStore] newLocation];
        
        AddLocationViewController *alvc = segue.destinationViewController;
        alvc.location = newLocation;
        
    }
}
-(void)addDummyData
{
    CLLocationCoordinate2D coordinateTimesSquare = CLLocationCoordinate2DMake(40.7577, -73.9857);
    CLLocationCoordinate2D coordinateMoma = CLLocationCoordinate2DMake(40.761424, -73.977625);
    //    CLLocationCoordinate2D coordinateToussads = CLLocationCoordinate2DMake(40.757173, -73.988414);
    //    CLLocationCoordinate2D coordinateChipotle  = CLLocationCoordinate2DMake(40.704961, -74.012918);
    //
    //
    //
    ////
    PointOfInterestMapPoint *pointTimesSquare = [[PointOfInterestMapPoint alloc]initWithCoordinate:coordinateTimesSquare title:@"Times Square"];
    PointOfInterestMapPoint *pointMoma = [[PointOfInterestMapPoint alloc]initWithCoordinate:coordinateMoma title:@"Museum of Modern Art"];
    pointMoma.interestingFacts = @"Interesting facts about MOMA";
    //    PointOfInterestMapPoint *pointToussads = [[PointOfInterestMapPoint alloc]initWithCoordinate:coordinateToussads title:@"Madame Toussads Museum"];
    //
    //    PointOfInterestMapPoint *pointChipotle = [[PointOfInterestMapPoint alloc]initWithCoordinate:coordinateChipotle title:@"Chipotle at Broadway"];
    //
    //    pointChipotle.interestingFacts = @"Chipotle makes the best burritos!";
    //
    //    pointToussads.interestingFacts = @"Interesting facts about Toussads";
    //
    //    pointTimesSquare.interestingFacts = @"In Times Square, there are approximately 1,500,000 daily passers-by including 344,000 riders in or out of the Times Square subway station.";
    //    //
    //   // [self.mapView addAnnotation:pointMoma];
    //    [self.mapView addAnnotation:pointTimesSquare];
    //   // [self.mapView addAnnotation:pointToussads];
    //    [self.mapView addAnnotation:pointChipotle];
    // //   [self startMonitoringLocationForPointsOfInterest];
    //
    ////
    Location *locTimesSquare = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    //
    locTimesSquare.name = pointMoma.title;
    locTimesSquare.latitude = [NSNumber numberWithDouble:pointMoma.coordinate.latitude];
    locTimesSquare.longitude =  [NSNumber numberWithDouble:pointMoma.coordinate.longitude];
    [[SharedStore returnSharedStore] addLocationEntity:locTimesSquare];
    
    
    Location *locTimesSquare2 = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:[SharedStore returnSharedStore].managedObjectContext];
    //
    locTimesSquare2.name = pointTimesSquare.title;
    locTimesSquare2.latitude = [NSNumber numberWithDouble:pointTimesSquare.coordinate.latitude];
    locTimesSquare2.longitude =  [NSNumber numberWithDouble:pointTimesSquare.coordinate.longitude];
    [[SharedStore returnSharedStore] addLocationEntity:locTimesSquare2];
    

}
-(void) startMonitoringLocationForPointsOfInterest
{
    
    NSLog(@"I have %i annotations on the map", [self.mapView.annotations count]);

    
    for(int i=0; i<[self.mapView.annotations count]; i++)
    {
        
        id<MKAnnotation> annotation = [self.mapView.annotations objectAtIndex:i];
        
        if(![annotation isKindOfClass:[MKUserLocation class]])
        {
            PointOfInterestMapPoint *p = (PointOfInterestMapPoint *)annotation;
            CLCircularRegion *regionForMonitoring = [[CLCircularRegion alloc]initWithCenter:p.coordinate radius:400 identifier:p.title];
            
            [self.locationManager startMonitoringForRegion:regionForMonitoring];
        
        }
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    
    if([self insideRegion:(CLCircularRegion *)region theLocation:manager.location])
    {
        NSLog(@"I am manually firing didEnterRegion for: %@", [region identifier]);
        [self locationManager:manager didEnterRegion:region];
    }
    
}
-(BOOL) insideRegion:(CLCircularRegion *)region theLocation:(CLLocation*)location
{

    if([region containsCoordinate:location.coordinate])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void) locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"I entered region: %@", region.identifier);
    UILocalNotification *quizNotification = [[UILocalNotification alloc]init];

    quizNotification.fireDate = [NSDate date];
    quizNotification.alertBody = [NSString stringWithFormat:@"You are near %@. Want to take the quiz?",region.identifier];
    quizNotification.alertAction = region.identifier;
    quizNotification.userInfo = @{@"LocationName":region.identifier};
    
    [[UIApplication sharedApplication] scheduleLocalNotification:quizNotification];
    
    
}

#pragma mark Delegate Methods

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    //id <MKAnnotation> annotation = [view annotation];
    
    PointOfInterestMapPoint *mapPoint = [view annotation];
    
//    LandmarkInfoViewController *l = [[LandmarkInfoViewController alloc]init];
//    l.strLandmarkInterestingFacts = mapPoint.interestingFacts;
//    l.strLandmarkName = mapPoint.title;
//    
//    [self presentViewController:l animated:YES completion:nil];
    
    
    ShowFactsViewController *sfvc = [[ShowFactsViewController alloc]init];
    
    sfvc.location = mapPoint.location;
    
    [self.navigationController pushViewController:sfvc animated:YES];
    
    
    
    
    NSLog(@"Title: %@",mapPoint.title);
    //NSLog(@"Coordinate: %@", mapPoint.coordinate);
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{

    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PointOfInterestMapPoint"];
        if (!pinView)
        {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PointOfInterestMapPoint"];
            pinView.canShowCallout = YES;
            pinView.pinColor = MKPinAnnotationColorGreen;
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
            pinView.rightCalloutAccessoryView = rightButton;
            
            UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loc.png"]];
            pinView.leftCalloutAccessoryView = iconView;
            
            
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
}

#pragma mark Zoom

- (IBAction)zoomToCurrentLocation:(UIBarButtonItem *)sender {
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
}



#pragma mark LocationManagerDelegate stuff

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    MKCoordinateRegion myLocationRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500.0, 1500.0);
    
//    PointOfInterestMapPoint *pointTimesSquare = [[PointOfInterestMapPoint alloc]initWithCoordinate:location.coordinate title:@"THIS IS US"];
//    [self.mapView addAnnotation:pointTimesSquare];

    
    [self.mapView setRegion:myLocationRegion];
    [self.locationManager stopUpdatingLocation];
    

}

-(void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"I paused location updates");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
