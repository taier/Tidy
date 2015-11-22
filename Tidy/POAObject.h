@import UIKit;
#import <Foundation/Foundation.h>

@interface POAObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longotude;

@end
