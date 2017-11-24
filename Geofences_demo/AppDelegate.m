//
//  AppDelegate.m
//  Geofences_demo
//
//  Created by Adrian Mendez Agama on 11/22/17.
//  Copyright © 2017 Alvaro Herrera Cotrina. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -
#pragma mark - Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.bcpLocation = [[CLLocation alloc] initWithLatitude:-12.179259 longitude:-77.014641];

    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTaskId =
    [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTaskId];
        bgTaskId = UIBackgroundTaskInvalid;
    }];
    
    dispatch_async( dispatch_get_main_queue(), ^{
        self.timer = nil;
        [self initTimer];
        [app endBackgroundTask:bgTaskId];
        bgTaskId = UIBackgroundTaskInvalid;
    });
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark -
#pragma mark - Initializers

- (void)initTimer {
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self
                                                    selector:@selector(checkUpdates:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)checkUpdates:(NSTimer *)timer{
    UIApplication *app = [UIApplication sharedApplication];
    double remaining = app.backgroundTimeRemaining;
    if(remaining < 580.0) {
        [self.locationManager startUpdatingLocation];
        [self.locationManager stopUpdatingLocation];
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
}

#pragma mark -
#pragma mark - CLLocation Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    CLLocationDistance distance = [newLocation distanceFromLocation:self.bcpLocation];
    NSLog(@"Latitude = %f  Longitude = %f distance: %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude,distance);
    
    if(distance >0 && distance <100) {
        NSLog(@"Esta dentro");
        UILocalNotification* n1 = [[UILocalNotification alloc] init];
        //n1.alertBody = [NSString stringWithFormat:@"Te encuentras dentro del BCP"];
        n1.alertBody = [NSString stringWithFormat:@"Te encuentras fuera del BCP"];
        n1.soundName = UILocalNotificationDefaultSoundName;
        n1.fireDate = [NSDate date];
        n1.alertLaunchImage = @"happy.png";
        [[UIApplication sharedApplication] presentLocalNotificationNow:n1];
    }else {
        NSLog(@"Salio del area");
        UILocalNotification* n1 = [[UILocalNotification alloc] init];
        //n1.alertBody = [NSString stringWithFormat:@"Te encuentras fuera del BCP"];
        n1.alertBody = [NSString stringWithFormat:@"Te encuentras dentro del BCP"];
        n1.soundName = UILocalNotificationDefaultSoundName;
        n1.fireDate = [NSDate date];
        n1.alertLaunchImage = @"sad.png";
        [[UIApplication sharedApplication] presentLocalNotificationNow:n1];
    }
    
    
    [self updateLocationWithLatitude:[newLocation coordinate].latitude andLongitude:[newLocation coordinate].longitude];
    
    UIApplication*    app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask =
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self initTimer];
    });
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask =
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    [self initTimer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    });
}

-(void)updateLocationWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude {
}

@end
