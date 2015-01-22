//
//  Interstitial_iAdVC.h
//  iAdPoC
//
//  Created by staticVoidMan on 20/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Interstitial_iAdVCDelegate <NSObject>
@optional
-(void)requestIADInterstitalCompletedWithSuccess:(BOOL)success;
@end

@interface Interstitial_iAdVC : UIViewController

@property (nonatomic, weak) id<Interstitial_iAdVCDelegate> delegate;

+(Interstitial_iAdVC *)sharedInstance;
-(void)startRequest;

@end
