//
//  ViewController.m
//  Geofences_demo
//
//  Created by Adrian Mendez Agama on 11/22/17.
//  Copyright © 2017 Alvaro Herrera Cotrina. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -
#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self askForPermission];
}

#pragma mark -
#pragma mark - Private

- (void)askForPermission {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    self.bcpLocation = [[CLLocation alloc] initWithLatitude:-12.179259 longitude:-77.014641];
    self.titleLbl.text = @"";
    self.titleLbl.numberOfLines = 0;
    self.titleLbl.textColor = [UIColor colorWithRed:254.0f/255.0f green:94.0f/255.0f blue:68.0f/255.0f alpha:1.0f];

    self.view.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:56.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
    
    // for iOS 8
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }

    [self.locationManager startUpdatingLocation];
}

- (void)setUpGeofences {
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(-12.173805, -77.013135);
    self.region = [[CLCircularRegion alloc]initWithCenter:center radius:100.0 identifier:@"BCP Chorrillos"];
    [self.locationManager startMonitoringForRegion:self.region];
}

- (void)showSorryAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alerta" message:@"Ocurrió un error con el GPS" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alertController addAction:okButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -
#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLLocationDistance distance = [newLocation distanceFromLocation:self.bcpLocation];
    
    NSLog(@"Latitude = %f  Longitude = %f distance: %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude,distance);
    
    if(distance >0 && distance <100) {
        NSLog(@"Esta dentro");
        self.titleLbl.text = @"Dentro del BCP 😄";
    }else {
        NSLog(@"Salio del area");
        self.titleLbl.text = @"Fuera del BCP 😞";
    }
}

- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error{
    NSLog(@"Error with Updating");
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"failed to recived user's location");
}

- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager requestStateForRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"ENTER REGION ----- %s, %@", __PRETTY_FUNCTION__, region);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"EXIT REGION ----- %s, %@", __PRETTY_FUNCTION__, region);
}

#pragma mark -
#pragma mark - CLLocation Test

- (BOOL)verifyWhenPointLocation:(CLLocation*)location isInsidePoint:(CLLocation*)center withRadius:(int)radius {
    CLLocationDistance distance = [location distanceFromLocation:center];
    
    if(distance > 0 && distance < radius) {
        NSLog(@"Esta dentro");
        self.titleLbl.text = @"Dentro del BCP 😄";
        return YES;
    }else {
        NSLog(@"Salio del area");
        self.titleLbl.text = @"Fuera del BCP 😞";
        return FALSE;
    }
}

@end
