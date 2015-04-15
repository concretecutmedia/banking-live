//
//  User.m
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 15/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        [self setValue:[dictionary objectForKey:@"screen_name"] forKey:@"screenName"];
        [self setValue:[dictionary objectForKey:@"name"] forKey:@"name"];
    }
    return self;
    
}

@end
