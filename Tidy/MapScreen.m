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
#import "POAScreen.h"

@import MapKit;

@interface MapScreen () <MKMapViewDelegate, POAScreenDelegate> {
    
    POAScreen *_poaScreen;
    CGRect _bottomViewRect;
    CGRect _mapViewRect;
    BOOL _POAScreenVisible;
    ARClusteredAnnotation *_selectedAnnotation;
}

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


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
    [self updateBottomViewRect];
    [self updateMapViewRect];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupPOAScreen];
}


#pragma mark Setup

- (void)setupUIAdjustments {
    self.buttonAdd.layer.cornerRadius = self.buttonAdd.frame.size.width /2;
}

- (void)setupPOAScreen {
    
    if(_poaScreen) {
        return; // Already Added
    }
    
    _poaScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"SCREEN_POA"];
    _poaScreen.delegate = self;
    [self.viewBottom addSubview:_poaScreen.view];
    
    [self.viewBottom setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)setupMapDemoData {
    
    double lalatitudet = 56.9516828;
    double longotude = 24.1063869;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lalatitudet;
    coordinate.longitude = longotude;
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 5000, 5000) animated:YES];
    
    NSMutableArray *pins = [NSMutableArray array];
    
    for(int i=0;i<30;i++) {
        CGFloat latDelta = rand()*0.125/RAND_MAX - 0.08;
        CGFloat lonDelta = rand()*0.130/RAND_MAX - 0.08;
        
        CGFloat lat = lalatitudet;
        CGFloat lng = longotude;
        
        CLLocationCoordinate2D newCoord = {lat+latDelta, lng+lonDelta};
        MKAnnotationView *pin = [[MKAnnotationView alloc] init];
        
        [pins addObject:pin];
        
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = newCoord;
        point.title = @"Where am I?";
        point.subtitle = @"I'm here!!!";
        
        [self.mapView addAnnotation:point];
        
    }
    
    [self.mapView addAnnotations:pins];

}


#pragma mark UI Updates

- (void)showPOAScreen:(BOOL)show withAnnotation:(ARClusteredAnnotation *) annotation {
    
    _POAScreenVisible = show;
    
    CGRect newFrameBottomView = self.viewBottom.frame;
    newFrameBottomView.origin.y = show ? 300 : self.view.frame.size.height - 44;
    newFrameBottomView.size.height = show ? self.view.frame.size.height : 44;
    _bottomViewRect = newFrameBottomView;
    
    CGRect newFramePOA = _poaScreen.view.frame;
    newFramePOA.size = newFrameBottomView.size;
    
    CGRect newFrameMapViewFrame = self.mapView.frame;
    newFrameMapViewFrame.size.height = show ? self.view.frame.size.height - newFrameBottomView.origin.y - 30: self.view.frame.size.height - 108;
    
    if(show) {
        _poaScreen.view.frame = newFramePOA;
    } else {
//        _mapViewRect = newFrameMapViewFrame;
//        self.mapView.frame = newFrameMapViewFrame;
    }
    
    [_poaScreen setAppearanceHidden:!show];
    
    [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewBottom.frame = newFrameBottomView;
        self.buttonAdd.alpha = show ? 0 : 1;
    } completion:^(BOOL finish){
//        _mapViewRect = newFrameMapViewFrame;
//        self.mapView.frame = newFrameMapViewFrame;
        if (!show) {
            _poaScreen.view.frame = newFramePOA;
        } else {
            
        }
    }];
    
}

- (void)updateBottomViewRect {
    
    if(CGRectIsEmpty(_bottomViewRect)) {
        _bottomViewRect = self.viewBottom.frame;
    }
    
    self.viewBottom.frame = _bottomViewRect;
}

- (void)updateMapViewRect {
    
    if(CGRectIsEmpty(_mapViewRect)) {
        _mapViewRect = self.mapView.frame;
    }
    
    self.mapView.frame = _mapViewRect;
}

#pragma mark MKMapViewDelegate methods


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
//    [self.mapView animateAnnotationViews:views];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    [self.mapView updateClustering];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    ARClusteredAnnotation *annotation = (ARClusteredAnnotation *)view.annotation;
    _selectedAnnotation = annotation;
    
    [self showPOAScreen:true withAnnotation:annotation];
}

#pragma mark POA Screen Delegate

- (void)closePOAScreen {
     [self showPOAScreen:false withAnnotation:_selectedAnnotation];
}

@end
