//
//  LoginViewController.m
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 14/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface LoginViewController ()

{
    TWTRLogInButton *logInButton;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    logInButton =  [TWTRLogInButton
                    buttonWithLogInCompletion:
                    ^(TWTRSession* session, NSError* error) {
                        if (session) {
                            [self performSegueWithIdentifier:@"tableViewSegue" sender:self];
                        } else {
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                                           message:@"There was an error logging in."
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"Cancel"
                                                                 otherButtonTitles:nil];
                            [alert show];
                            
                            NSLog(@"error: %@", [error localizedDescription]);
                        }
                    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
