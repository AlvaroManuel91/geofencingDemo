//
//  ViewController.h
//  Geofences_demo
//
//  Created by Adrian Mendez Agama on 11/22/17.
//  Copyright © 2017 Alvaro Herrera Cotrina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocation *bcpLocation;

@property (nonatomic,strong) CLRegion *region;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

- (BOOL)verifyWhenPointLocation:(CLLocation*)location isInsidePoint:(CLLocation*)center withRadius:(int)radius;

@end

