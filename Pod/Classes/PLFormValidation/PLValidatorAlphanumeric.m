//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLValidatorAlphanumeric.h"
#import "PLConditionAlphanumeric.h"


@implementation PLValidatorAlphanumeric


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[PLConditionAlphanumeric alloc] init]];
    }
    
    return self;
}


@end
