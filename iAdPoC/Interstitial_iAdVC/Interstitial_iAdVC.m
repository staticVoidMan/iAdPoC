//
//  Interstitial_iAdVC.m
//  iAdPoC
//
//  Created by staticVoidMan on 20/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import "Interstitial_iAdVC.h"
#import <iAd/iAd.h>

@interface Interstitial_iAdVC () <ADInterstitialAdDelegate>
{
    ADInterstitialAd *iAdInterstitial;
    BOOL isRequestingInterstitialAd;
}

//@property (nonatomic, assign) BOOL isRequestingInterstitialAd;
@end

static Interstitial_iAdVC *sharedInstance = nil;

@implementation Interstitial_iAdVC
@synthesize delegate;

+(Interstitial_iAdVC *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)startRequest {
    if (!isRequestingInterstitialAd) {
        iAdInterstitial = [[ADInterstitialAd alloc] init];
        [iAdInterstitial setDelegate:self];
        
        self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyAutomatic;
        [self requestInterstitialAdPresentation];
        
        isRequestingInterstitialAd = YES;
    }
}

#pragma mark - Helper Methods
-(void)showInterstitialAd:(ADInterstitialAd *)interstitialAd {
    [interstitialAd presentInView:self.view];
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose setFrame:CGRectMake(0, 0, 44, 44)];
    [btnClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [btnClose setImageEdgeInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    [btnClose addTarget:self action:@selector(dismissInterstitialAd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClose];
    
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:self
                                                                                             animated:YES
                                                                                           completion:nil];
}

-(void)dismissInterstitialAd {
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 isRequestingInterstitialAd = NO;
                                 iAdInterstitial = nil;
                             }];
}

#pragma mark - iAD Interstitial Delegates
-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    if ([delegate respondsToSelector:@selector(requestIADInterstitalCompletedWithSuccess:)]) {
        [delegate requestIADInterstitalCompletedWithSuccess:NO];
        delegate = nil;
    }
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
    if ([delegate respondsToSelector:@selector(requestIADInterstitalCompletedWithSuccess:)]) {
        [delegate requestIADInterstitalCompletedWithSuccess:YES];
    }
    
    if(interstitialAd.loaded) {
        [self showInterstitialAd:interstitialAd];
    }
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
    [self dismissInterstitialAd];
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {    
    [self dismissInterstitialAd];
}

@end
