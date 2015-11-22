//
//  InformationAddScreen.m
//  Tidy
//
//  Created by Deniss Kaibagarovs on 21/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

@import MapKit;

#import "InformationAddScreen.h"
#import "TagViewCell.h"
#import "POAObject.h"
#import "AppDelegate.h"

@interface InformationAddScreen () <UICollectionViewDelegate, UICollectionViewDataSource, MKMapViewDelegate, UIImagePickerControllerDelegate> {
    NSMutableArray *_tagArray;
    UIImagePickerController *_imagePickerController;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPickedImage;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTtitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;

@end

@implementation InformationAddScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self showCurrentLocationOnMap];
    // Do any additional setup after loading the view.
    
    self.mapView.layer.cornerRadius = 4.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark Setup Methods

- (void)updateUI {
    
}

- (void)showCurrentLocationOnMap {
    [self.mapView setShowsUserLocation:YES];
}

- (void)setupData {
    _tagArray = [NSMutableArray new];
    
    [_tagArray addObject:@"Trash"];
    [_tagArray addObject:@"Homeless"];
    [_tagArray addObject:@"Pothole"];
    [_tagArray addObject:@"Construction"];
    [_tagArray addObject:@"Nature"];
    [_tagArray addObject:@"Boars"];
    [_tagArray addObject:@"Nudity"];
    [_tagArray addObject:@"Crime"];
    
}

#pragma mark Buttons

- (IBAction)onCancelButtonPress:(id)sender {
    [self.delegate didFinishAdding:NULL];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onAddPOAButtonPress:(id)sender {
    POAObject *newPOAObject = [POAObject new];
    
    newPOAObject.title = [self.textFieldTtitle text];
    newPOAObject.desc = [self.textViewDescription text];
    newPOAObject.image = self.imageViewPickedImage.image;
    newPOAObject.latitude = 56.9536134;
    newPOAObject.longotude = 24.0747749;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.lastAddedPOAObject = newPOAObject;
    
    [self.delegate didFinishAdding:newPOAObject];
}

- (IBAction)onAddImageButtonPress:(id)sender {
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePickerController.delegate = self;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark ImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    [self.imageViewPickedImage setImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark MapView Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 300, 300) animated:YES];
}

#pragma mark Collection View Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_tagArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TagViewCell *cell = (TagViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell_tag" forIndexPath:indexPath];
    cell.title = [_tagArray objectAtIndex:indexPath.item];
    [cell setup];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.alpha = cell.alpha == 1 ? 0.6 : 1;
}


@end
