//
//  InformationAddScreen.m
//  Tidy
//
//  Created by Deniss Kaibagarovs on 21/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "InformationAddScreen.h"

@interface InformationAddScreen () <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSMutableArray *_tagArray;
}
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation InformationAddScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    // Do any additional setup after loading the view.
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
//    self.mainScrollView.contentSize =
    
}

- (void)setupData {
    _tagArray = [NSMutableArray new];
    
    [_tagArray addObject:@"Trash"];
    [_tagArray addObject:@"Homeless"];
    [_tagArray addObject:@"Pothole"];
    [_tagArray addObject:@"Constraction"];
    [_tagArray addObject:@"Nature"];
    [_tagArray addObject:@"Boards"];
    [_tagArray addObject:@"Nudity"];
    [_tagArray addObject:@"Crime"];
    
}

#pragma mark Collection View Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_tagArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_tag" forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.contentView.frame];
    label.text = [_tagArray objectAtIndex:indexPath.item];
    [cell.contentView addSubview:label];
    
    return cell;

}

@end
