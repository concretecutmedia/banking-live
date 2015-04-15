//
//  TweetTableViewCell.h
//  TwitterBankingStream
//
//  Created by Danuta Dramowicz on 13/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userScreennameLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end
