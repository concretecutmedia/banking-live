//
//  FadeSegue.m
//  TwitterBankingStream
//
//  Created by Dana Dramowicz on 15/04/2015.
//  Copyright (c) 2015 Danuta Dramowicz. All rights reserved.
//

#import "FadeSegue.h"

@implementation FadeSegue

- (void)perform {
    
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    
    [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];
    
    [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];
    
}

@end
