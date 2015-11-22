//
//  TagViewCell.m
//  Tidy
//
//  Created by Andrey Podshibyakin on 11/22/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "TagViewCell.h"

@implementation TagViewCell

- (void)setup {
    self.layer.cornerRadius = 4.0;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.titleLabel.text = self.title;
}

@end
