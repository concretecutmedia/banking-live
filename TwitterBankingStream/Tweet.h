//
//  Tweet.h
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 14/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) User *user;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
