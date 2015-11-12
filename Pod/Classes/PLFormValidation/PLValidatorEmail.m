
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLValidatorEmail.h"
#import "PLConditionEmail.h"


@implementation PLValidatorEmail


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[PLConditionEmail alloc] init]];
    }
    
    return self;
}


@end
