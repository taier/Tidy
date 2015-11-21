//
//  ViewController.m
//  Tidy
//
//  Created by Deniss Kaibagarovs on 21/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "MapScreen.h"
#import "ARClusteredMapView.h"
#import "ARClusteredAnnotation.h"

@interface MapScreen () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet ARClusteredMapView *mapView;

@end

@implementation MapScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMapDemoData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupUIAdjustments];
}


#pragma mark Setup

- (void)setupUIAdjustments {
    self.buttonAdd.layer.cornerRadius = self.buttonAdd.frame.size.width /2;
}

- (void)setupMapDemoData {
    
    double lalatitudet = 56.9516828;
    double longotude = 24.1063869;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lalatitudet;
    coordinate.longitude = longotude;
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 5000, 5000) animated:YES];
    
    NSMutableArray *pins = [NSMutableArray array];
    
    for(int i=0;i<200;i++) {
        CGFloat latDelta = rand()*0.125/RAND_MAX - 0.08;
        CGFloat lonDelta = rand()*0.130/RAND_MAX - 0.08;
        
        CGFloat lat = lalatitudet;
        CGFloat lng = longotude;
        
        CLLocationCoordinate2D newCoord = {lat+latDelta, lng+lonDelta};
        ARClusteredAnnotation *pin = [[ARClusteredAnnotation alloc] init];
        pin.title = [NSString stringWithFormat:@"Pin %i",i+1];;
        pin.subtitle = [NSString stringWithFormat:@"Pin %i subtitle",i+1];
        pin.coordinate = newCoord;
        [pins addObject:pin];
    }
    
    [self.mapView addAnnotations:pins];

}

#pragma mark MKMapViewDelegate methods

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    [self.mapView animateAnnotationViews:views];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.mapView updateClustering];
}

@end
