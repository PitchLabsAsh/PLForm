//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLValidatorPresent.h"
#import "PLConditionPresent.h"

@implementation PLValidatorPresent

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[PLConditionPresent alloc] init]];
    }
    
    return self;
}

@end
