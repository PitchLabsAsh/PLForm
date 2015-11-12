//
//  PLValidatorAccept.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLValidatorAccept.h"
#import "PLConditionAccept.h"

@implementation PLValidatorAccept

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[PLConditionAccept alloc] init]];
    }
    
    return self;
}

@end
