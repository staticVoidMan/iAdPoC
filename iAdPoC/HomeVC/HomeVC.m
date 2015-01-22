//
//  HomeVC.m
//  iAdPoC
//
//  Created by staticVoidMan on 20/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import "HomeVC.h"
#import "Banner_iAdVC.h"
#import "Interstitial_iAdVC.h"

@interface HomeVC () <Banner_iAdVCDelegate, Interstitial_iAdVCDelegate>
{
    Banner_iAdVC *iAd;
    
    IBOutlet UIButton *btnToggleBanner;
    IBOutlet UIButton *btnShowInterstitial;
    
    IBOutlet UIActivityIndicatorView *activityIADBanner;
    IBOutlet UIActivityIndicatorView *activityIADInterstitial;
    
    IBOutlet UIView *vwContainerBanner;
    
    IBOutlet NSLayoutConstraint *constraintBottom_Banner;
}
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self btnToggleBannerAd_Act:btnToggleBanner];
    [activityIADBanner stopAnimating];
    [activityIADInterstitial stopAnimating];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedBanner_iAdVC"]) {
        iAd = segue.destinationViewController;
        [iAd setDelegate:self];
        [activityIADBanner startAnimating];
    }
}

#pragma mark - Button Methods
-(IBAction)btnToggleBannerAd_Act:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    
    if (sender.selected) {
        constraintBottom_Banner.constant = 0;
    }
    else {
        constraintBottom_Banner.constant = -vwContainerBanner.bounds.size.height;
    }
    
    [UIView animateWithDuration:0.27f
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

-(IBAction)btnShowInterstitialAd_Act:(UIButton *)sender {
    if (sender.selected) {
        //already requesting
        return;
    }
    
    [sender setSelected:YES];
    
    [[Interstitial_iAdVC sharedInstance] startRequest];
    [[Interstitial_iAdVC sharedInstance] setDelegate:self];
    
    [activityIADInterstitial startAnimating];
}

#pragma mark - Banner_iAdVC Delegates
-(void)requestIAdBannerCompletedWithSuccess:(BOOL)success {
    if(success) {
        [activityIADBanner stopAnimating];
    }
    else {
        [activityIADBanner startAnimating];
    }
    
    [self btnToggleBannerAd_Act:btnToggleBanner];
}

#pragma mark - Interstitial_iAdVCDelegate
-(void)requestIADInterstitalCompletedWithSuccess:(BOOL)success {
    [btnShowInterstitial setSelected:NO];
    [activityIADInterstitial stopAnimating];
}

@end
