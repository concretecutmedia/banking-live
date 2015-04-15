//
//  TwitterStreamTableViewController.h
//  TwitterBankingStream
//
//  Created by Danuta Dramowicz on 13/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterStreamTableViewController : UITableViewController <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
