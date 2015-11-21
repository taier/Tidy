//
//  POAScreen.m
//  Tidy
//
//  Created by Deniss Kaibagarovs on 21/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "POAScreen.h"

@interface POAScreen () <UICollectionViewDataSource, UICollectionViewDelegate> {
    
    int _score;
}

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
    [self setupUIAdjustments];
    [self setupData];
    [self setupGesture];
    [self updateVoteCount:true];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setup 

- (void)setupUIAdjustments {
    self.buttonUpVote.layer.cornerRadius = self.buttonUpVote.frame.size.width /2;
}

- (void)setupData {
    _score = 233;
}

- (void)setupGesture {
    
    UISwipeGestureRecognizer *settingbtnpress = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(swipeToClose)];

    settingbtnpress.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:settingbtnpress];
}

#pragma mark Gesturs / Buttons

- (void)swipeToClose {
    [self.delegate closePOAScreen];
}

- (IBAction)onUpVoteButtonPress:(id)sender {
    [self updateVoteCount:true];
}
- (IBAction)onShareButton:(id)sender {
    
    UIImage *trashImage = [UIImage imageNamed:@"trash1.jpg"];
    NSString *message = [NSString stringWithFormat:@"TRASH WITH SCORE - %i",_score];
    
    // NSLog(@"%@",shareBody);
    NSArray *postItems = @[message,trashImage];
    UIActivityViewController *shareActivityVC = [[UIActivityViewController alloc]
                        initWithActivityItems:postItems
                        applicationActivities:nil];

    
    [self.mainController presentViewController:shareActivityVC animated:YES completion:nil];
}

#pragma mark UI Update methods

- (void)updateVoteCount:(BOOL)increase {
    _score = increase ? _score + 1 : _score - 1;
    self.labelCount.text = [NSString stringWithFormat:@"%i",_score];
}

- (void)setAppearanceHidden:(BOOL)hidden {
    
    [UIView animateWithDuration:0.35f animations:^{
        self.labelCount.alpha = hidden ? 0 : 1;
        self.buttonUpVote.alpha = hidden ? 0 : 1;
    }];
}

#pragma mark CollectionView Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"default_cell" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"trash%li.jpg",(indexPath.item + 1)]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = cell.contentView.bounds;

    [cell.contentView addSubview:imageView];
    
    return cell;
}


@end
