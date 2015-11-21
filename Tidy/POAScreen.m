//
//  POAScreen.m
//  Tidy
//
//  Created by Deniss Kaibagarovs on 21/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "POAScreen.h"

@interface POAScreen ()

@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewImages;
@property (weak, nonatomic) IBOutlet UIButton *buttonShare;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpVote;
@property (weak, nonatomic) IBOutlet UILabel *labelCount;
@end

@implementation POAScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAppearanceHidden:true];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UI Update methods

- (void)setAppearanceHidden:(BOOL)hidden {
    self.labelCount.hidden = hidden;
    self.buttonUpVote.hidden = hidden;
}

@end
