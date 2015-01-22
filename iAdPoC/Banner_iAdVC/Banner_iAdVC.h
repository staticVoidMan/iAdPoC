//
//  Banner_iAdVC.h
//  iAdPoC
//
//  Created by staticVoidMan on 20/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Banner_iAdVCDelegate <NSObject>
@required
-(void)requestIAdBannerCompletedWithSuccess:(BOOL)success;
@end

@interface Banner_iAdVC : UIViewController

@property (nonatomic, weak) id<Banner_iAdVCDelegate> delegate;

@end
