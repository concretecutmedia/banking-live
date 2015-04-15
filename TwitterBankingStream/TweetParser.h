//
//  TweetParser.h
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 15/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetParser : NSObject

@property (nonatomic, strong) NSData *data;

- (instancetype)initWithData:(NSData *)data;

- (NSArray *)addTweetsToArray:(NSArray *)tweetArray;

@end
