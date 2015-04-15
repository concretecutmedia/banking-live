//
//  TweetParserSpec.m
//  TwitterBankingStream
//
//  Created by Danuta Dramowicz on 15/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import "Kiwi.h"
#import "TweetParser.h"

SPEC_BEGIN(TweetParserSpec)

describe(@"The Tweet Parser", ^{
    
    __block TweetParser *tweetParser;
    __block NSArray *currentTweets;
    
    beforeEach(^{
        currentTweets = [NSArray new];
    });
    
    afterEach(^{
        currentTweets = nil;
    });
    
    context(@"when initialized with data of ONE tweet object, formatted as expected", ^{
        
        beforeAll(^{
            NSString *tweetString = @"{\"created_at\":\"test body\"}";
            tweetParser = [[TweetParser alloc] initWithData:[tweetString dataUsingEncoding:NSUTF8StringEncoding]];
        });
        afterAll(^{
            tweetParser = nil;
        });
        
        it(@"successfully adds Tweet, resulting in ONE Tweet to display", ^{
            
            NSArray *tweetsToDisplay = [tweetParser addTweetsToArray:currentTweets];
            NSLog(@"tweets to display count is %lu", (unsigned long)tweetsToDisplay.count);
            [[theValue(tweetsToDisplay.count) should] equal:theValue(1)];
        });
        
    });
    
    context(@"when initialized with nil data", ^{
        
        beforeAll(^{
            tweetParser = [[TweetParser alloc] initWithData:nil];
        });
        afterAll(^{
            tweetParser = nil;
        });
        
        it(@"successfully returns current/previous Tweets", ^{
            NSArray *tweetsToDisplay = [tweetParser addTweetsToArray:currentTweets];
            [[tweetsToDisplay should] equal:currentTweets];
        });
    });
    
    context(@"when initialized with ill-formed / chunk data separated by expected \r\n", ^{
        
        beforeAll(^{
            NSString *tweetString = @"{\"created_at\":\"test body\"}\r\n{\"example\" : \"badly formed";
            tweetParser = [[TweetParser alloc] initWithData:[tweetString dataUsingEncoding:NSUTF8StringEncoding]];
        });
        afterAll(^{
            tweetParser = nil;
        });
        
        it(@"successfully finds Tweet object and adds to current Tweets", ^{
                NSArray *tweetsToDisplay = [tweetParser addTweetsToArray:currentTweets];
                [[theValue(tweetsToDisplay.count) should] equal:theValue(1)];
        });
    });
    
    context(@"when initialized with multiple (12) tweets", ^{
        
        beforeAll(^{
            NSString *tweetString = @"{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n{\"created_at\":\"test body\"}\r\n";
            tweetParser = [[TweetParser alloc] initWithData:[tweetString dataUsingEncoding:NSUTF8StringEncoding]];
        });
        afterAll(^{
            tweetParser = nil;
        });
        
        it(@"successfully adds newest Tweet objects, limiting to the latest 10", ^{
            NSArray *tweetsToDisplay = [tweetParser addTweetsToArray:currentTweets];
            [[theValue(tweetsToDisplay.count) should] equal:theValue(10)];
        });
    });
    
});

SPEC_END

