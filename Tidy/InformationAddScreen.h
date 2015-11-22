//
//  InformationAddScreen.h
//  Tidy
//
//  Created by Deniss Kaibagarovs on 21/11/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  POAObject;

@protocol InformationAddScreenDeleagte <NSObject>

- (void)didFinishAdding:(POAObject *)addedObject;

@end

@interface InformationAddScreen : UIViewController
@property id<InformationAddScreenDeleagte> delegate;


@end
