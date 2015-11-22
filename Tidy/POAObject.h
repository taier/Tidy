//
//  POAObject.h
//  Tidy
//
//  Created by Deniss Kaibagarovs on 22/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>

@interface POAObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longotude;

@end
