//
//  TagViewCell.h
//  Tidy
//
//  Created by Andrey Podshibyakin on 11/22/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagViewCell : UICollectionViewCell {
    
}

@property IBOutlet UILabel *titleLabel;
@property NSString *title;

- (void)setup;

@end
