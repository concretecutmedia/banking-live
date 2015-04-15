//
//  TweetParser.m
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 15/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import "TweetParser.h"
#import "Tweet.h"

@implementation TweetParser


- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

- (NSArray *)addTweetsToArray:(NSArray *)tweetArray {
    
    //convert to data string
    NSString *dataString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    //local var with displayed tweet array
    NSArray *tweetsToDisplay = [NSArray arrayWithArray:tweetArray];
    
    //checking if blank/keep-alive object
    if (dataString.length != 0) {
        
        NSArray *newTweets = [self createObjectArrayFromChunks:dataString];
        
        NSArray *readyTweets = [self createAndInsertNewTweetObjectsFromArray:newTweets toArray:tweetsToDisplay];

        tweetsToDisplay = readyTweets;
    }
    
    return tweetsToDisplay;

}

- (NSArray *)createObjectArrayFromChunks:(NSString *)dataString {
    
    //separating delivered components
    NSArray *separatedArray = [dataString componentsSeparatedByString:@"\r\n"];
    
    NSMutableArray *mutableTweetStringArray = [NSMutableArray new];
    NSError* error;
    
    //checking if components are a message object & adding
    for (NSString *string in separatedArray) {
        if ([string hasPrefix:@"{\"created_at\""] && [string hasSuffix:@"}"]) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                                                 options:kNilOptions
                                                                   error:&error];
            if (error) {
                NSLog(@"There was an error creating the JSON object: %@", [error localizedDescription]);
            }
            else {
            [mutableTweetStringArray addObject:dictionary];
            }
        }
    }
    
    NSArray *messageArray = [NSArray arrayWithArray:mutableTweetStringArray];
    
    return messageArray;
}

- (NSArray *)createAndInsertNewTweetObjectsFromArray:(NSArray *)newTweetsArray toArray:(NSArray *)displayedTweetsArray {
    
    NSMutableArray *mutableTweets = [NSMutableArray arrayWithArray:displayedTweetsArray];
    
    //creating & adding Tweet objects
    for (NSDictionary *dictionary in newTweetsArray) {
        
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [mutableTweets insertObject:tweet atIndex:0];
        
        //remove oldest object if over 10 Tweets in view
        if (mutableTweets.count > 10) {
            [mutableTweets removeLastObject];
        }
    }
    
    NSArray *finishedArray = [NSArray arrayWithArray:mutableTweets];
    
    return finishedArray;
}


@end
