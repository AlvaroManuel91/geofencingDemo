//
//  Geofences_demoTests.m
//  Geofences_demoTests
//
//  Created by Alvaro Herrera Cotrina on 11/22/17.
//  Copyright © 2017 Alvaro Herrera Cotrina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface Geofences_demoTests : XCTestCase

@property ViewController *viewControllerTest;

@end

@implementation Geofences_demoTests

- (void)setUp {
    [super setUp];
    
    self.viewControllerTest = [[ViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVerifyWhenPointIsInsideRadiusSuccess {
    //BCP
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:-12.173805 longitude:-77.013135];
    //INSIDE
    CLLocation *insideLocation = [[CLLocation alloc] initWithLatitude:-12.173111 longitude:-77.012833];
    
    BOOL verifyPoint = [self.viewControllerTest verifyWhenPointLocation:insideLocation isInsidePoint:currentLocation withRadius:100];
    XCTAssertTrue(verifyPoint);
}

- (void)testVerifyWhenPointIsOutsideRadiusSuccess {
    //BCP
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:-12.173805 longitude:-77.013135];
    //INSIDE
    CLLocation *insideLocation = [[CLLocation alloc] initWithLatitude:-12.175111 longitude:-77.095833];
    
    BOOL verifyPoint = [self.viewControllerTest verifyWhenPointLocation:insideLocation isInsidePoint:currentLocation withRadius:100];
    XCTAssertFalse(verifyPoint);
}

- (void)testVerifyWhenPointIsInsideRadiusFailure {
    //BCP
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    //INSIDE
    CLLocation *insideLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    
    BOOL verifyPoint = [self.viewControllerTest verifyWhenPointLocation:insideLocation isInsidePoint:currentLocation withRadius:100];
    XCTAssertTrue(verifyPoint);
}

- (void)testVerifyWhenPointIsOutsideRadiusFailure {
    //BCP
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    //INSIDE
    CLLocation *insideLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    
    BOOL verifyPoint = [self.viewControllerTest verifyWhenPointLocation:insideLocation isInsidePoint:currentLocation withRadius:100];
    XCTAssertFalse(verifyPoint);
}

@end
