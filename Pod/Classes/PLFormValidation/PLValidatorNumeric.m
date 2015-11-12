//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLValidatorNumeric.h"
#import "PLConditionNumeric.h"


@implementation PLValidatorNumeric


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[PLConditionNumeric alloc] init]];
    }
    
    return self;
}


@end
