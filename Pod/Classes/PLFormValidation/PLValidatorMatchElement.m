//
//  PLValidatorMatchElement.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLValidatorMatchElement.h"
#import "PLConditionMatchElement.h"

@implementation PLValidatorMatchElement

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[PLConditionMatchElement alloc] init]];
    }
    
    return self;
}

@end
