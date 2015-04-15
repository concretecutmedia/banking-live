//
//  Tweet.m
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 14/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        [self setValue:[dictionary objectForKey:@"text"] forKey:@"text"];
        NSDictionary *user = [dictionary objectForKey:@"user"];
        [self setValue:user forKey:@"user"];
        self.user = [[User alloc] initWithDictionary:user];
    }
    return self;
}

@end
