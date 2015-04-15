//
//  TwitterStreamTableViewController.m
//  TwitterBankingStream
//
//  Created by Danuta Dramowicz on 13/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import "TwitterStreamTableViewController.h"
#import "TweetTableViewCell.h"
#import <TwitterKit/TwitterKit.h>
#import "Tweet.h"
#import "TweetParser.h"

@interface TwitterStreamTableViewController ()

{
    NSArray *tweets;
    NSTimer *timer;
}

@end

@implementation TwitterStreamTableViewController

static NSString *feedURL = @"https://stream.twitter.com/1.1/statuses/filter.json";


- (void)viewDidLoad {
    [super viewDidLoad];

    tweets = [NSArray new];
    
    [self connectToStreamingAPI];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.activityIndicator startAnimating];
}

#pragma mark - Connecting To Streaming API Methods

- (void)connectToStreamingAPI {
    
    NSDictionary *params = @{@"track" : @"banking", @"filter_level" : @"none"};
    
    NSError *requestError;
    
    NSURLRequest *twitterRequest = [[Twitter sharedInstance].APIClient URLRequestWithMethod:@"GET"
                                                                                        URL:feedURL
                                                                                 parameters:params
                                                                                      error:&requestError];
    
    if (requestError) {
        NSLog(@"request error: %@", [requestError localizedDescription]);
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:twitterRequest
                                                                  delegate:self
                                                          startImmediately:YES];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    
    if (data) {
        if ([self.activityIndicator isAnimating]) {
            [self.activityIndicator stopAnimating];
        }
    }
    else {
        if (![self.activityIndicator isAnimating]) {
            [self.activityIndicator startAnimating];
        }
    }
    
    TweetParser *tweetParser = [[TweetParser alloc] initWithData:data];
    
    NSArray *updatedTweets = [tweetParser addTweetsToArray:tweets];
    
    tweets = updatedTweets;
    
    [self.tableView reloadData];

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    if (![self.activityIndicator isAnimating]) {
        [self.activityIndicator startAnimating];
    }
    
    [timer invalidate];
    timer = nil;
    
    NSLog(@"The connection failed with error: %@", [error localizedDescription]);
    
    // attempt to reconnect
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(connectToStreamingAPI) userInfo:nil repeats:NO];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[TweetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tweetCell"];

    }
    
    Tweet *tweet = [tweets objectAtIndex:indexPath.row];
    
    cell.tweetTextView.text = tweet.text;
    cell.userScreennameLabel.text = [NSString stringWithFormat:@"@%@",tweet.user.screenName];
    cell.userNameLabel.text = tweet.user.name;
    
    
    return cell;
}

@end
