//
//  FISViewController.m
//  objc-Blocks
//
//  Created by Al Tyus on 4/24/14.
//  Copyright (c) 2014 Flatiron School. All rights reserved.
//

#import "FISViewController.h"
#import "UIAlertViewBlocks.h"

@interface FISViewController ()

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"Show Alert" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


}

- (void)showAlert
{
    UIAlertViewBlocks *alertView = [[UIAlertViewBlocks alloc] initWithTitle:@"title"
                                                                    message:@"message"
                                                          cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK"
                                                                   tapBlock:^(UIAlertView *view, NSInteger i) {
                                                                       NSLog(@"%d", i);
                                                                   }];

    alertView.shouldEnableFirstOtherButtonBlock = ^BOOL(UIAlertView *view) {
        NSLog(@"Should Enable First Other Button Block");
        return YES;
    };

    alertView.willPresentBlock = ^(UIAlertView *view) {
        NSLog(@"Will Present Block");

    };

    alertView.didPresentBlock = ^(UIAlertView *view) {
        NSLog(@"Did Present Block");

    };

    alertView.willDismissBlock = ^(UIAlertView *view, NSInteger i) {
        NSLog(@"Will Dismiss Block");
    };

    alertView.didDismissBlock = ^(UIAlertView *view, NSInteger i) {
        NSLog(@"Did Dismiss Block");

    };

    alertView.cancelBlock = ^(UIAlertView *view) {
        NSLog(@"Cancel Block");
    };

    [alertView show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end