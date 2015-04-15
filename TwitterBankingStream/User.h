//
//  User.h
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 15/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *imageURL;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
