//
//  AppDelegate.h
//  Geofences_demo
//
//  Created by Adrian Mendez Agama on 11/22/17.
//  Copyright © 2017 Alvaro Herrera Cotrina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocation *bcpLocation;

@property (strong, nonatomic) NSTimer *timer;

@end

