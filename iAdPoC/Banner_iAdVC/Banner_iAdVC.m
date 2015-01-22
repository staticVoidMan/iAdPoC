//
//  Banner_iAdVC.m
//  iAdPoC
//
//  Created by staticVoidMan on 20/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import "Banner_iAdVC.h"
#import <iAd/iAd.h>

@interface Banner_iAdVC () <ADBannerViewDelegate>
{
    IBOutlet ADBannerView *iAdBanner;
}
@end

@implementation Banner_iAdVC
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - iAd Banner Delegates
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    if ([delegate respondsToSelector:@selector(requestIAdBannerCompletedWithSuccess:)]) {
        [delegate requestIAdBannerCompletedWithSuccess:NO];
    }
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner {
    
    
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    if ([delegate respondsToSelector:@selector(requestIAdBannerCompletedWithSuccess:)]) {
        [delegate requestIAdBannerCompletedWithSuccess:YES];
    }
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
}

@end
