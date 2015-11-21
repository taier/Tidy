//
//  POAScreen.h
//  Tidy
//
//  Created by Deniss Kaibagarovs on 21/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol POAScreenDelegate <NSObject>

- (void)closePOAScreen;

@end

@interface POAScreen : UIViewController

@property id<POAScreenDelegate> delegate;

@property (nonatomic, strong) UIViewController *mainController;

- (void)setAppearanceHidden:(BOOL)hidden;

@end
