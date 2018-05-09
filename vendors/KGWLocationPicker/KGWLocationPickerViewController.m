//
//  KGWLocationPickerViewController.m
//  KGWLocationPicker
//
//  Created by koogawa on 2016/04/23.
//  Copyright © 2016 koogawa. All rights reserved.
//

#import "KGWLocationPickerViewController.h"
#import <MapKit/MapKit.h>

@interface KGWLocationPickerViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) MKPointAnnotation *pointAnnotation;
@property (nonatomic, strong) UIBarButtonItem *currentButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) KGWLocationPickerSuccessReturnBlock success;
@property (nonatomic, copy) KGWLocationPickerFauilreBlock failure;
@property (nonatomic, assign) BOOL isInitialized;

@end

@implementation KGWLocationPickerViewController

- (id)initWithSucess:(KGWLocationPickerSuccessReturnBlock)success onFailure:(KGWLocationPickerFauilreBlock)failure;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        self.success = success;
        self.failure = failure;
    }
    return self;
}

- (void)loadView
{
    [super loadView];

    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *cancel =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                  target:self
                                                  action:@selector(didTapCancelButton)];
    self.navigationItem.leftBarButtonItem = cancel;

    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(didTapDoneButton)];
    self.navigationItem.rightBarButtonItem = doneButton;

    self.currentButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:100
                                                  target:self
                                                  action:@selector(didTapCurrentButton)];
    self.currentButton.enabled = NO;

    [self setToolbarItems:@[self.currentButton] animated:NO];

    [self.navigationController setToolbarHidden:NO animated:NO];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method

- (void)didTapCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapDoneButton
{
    if (CLLocationCoordinate2DIsValid(self.mapView.centerCoordinate)) {
        if (self.success) {
            self.success(self.mapView.centerCoordinate);
        }
    } else {
        if (self.failure) {
            self.failure(nil);
        }
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapCurrentButton
{
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];

    self.currentButton.enabled = NO;
}


#pragma mark - MapView delegate

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    if (!self.isInitialized) {
        return;
    }

    self.currentButton.enabled = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!self.isInitialized) {
        return;
    }

    CLLocationCoordinate2D coordinate;
    coordinate.latitude = mapView.region.center.latitude;
    coordinate.longitude = mapView.region.center.longitude;
    [self.pointAnnotation setCoordinate:mapView.region.center];
}


#pragma mark - CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];

    if (!self.isInitialized) {
        MKCoordinateRegion region;
        region.span.latitudeDelta = 0.005;
        region.span.longitudeDelta = 0.005;
        region.center.latitude = newLocation.coordinate.latitude;
        region.center.longitude = newLocation.coordinate.longitude;
        [self.mapView setRegion:region animated:YES];

        self.pointAnnotation = [[MKPointAnnotation alloc] init];
        self.pointAnnotation.coordinate = newLocation.coordinate;
        [self.mapView addAnnotation:self.pointAnnotation];

        self.isInitialized = YES;
    }
}

@end
