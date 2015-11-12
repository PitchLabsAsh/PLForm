//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLValidatorRange.h"
#import "PLConditionRange.h"


@implementation PLValidatorRange


@synthesize range = _range;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        PLConditionRange *rangeCondition = [[PLConditionRange alloc] init];
        [self addCondition:rangeCondition];
    }
    
    return self;
}

- (id)initWithRange:(NSRange)range
{
    self = [super init];
    if(self)
    {
        [self setRange: range];
    }

    return self;
}


#pragma mark - Range

- (void)setRange:(NSRange)range
{
    _range = range;
    
    // Remove all added range coniditons
    [self removeConditionOfClass:[PLConditionRange class]];
    
    // Add new range condition
    PLConditionRange *rangeCondition   = [[PLConditionRange alloc] init];
    rangeCondition.range                = _range;
    [self addCondition:rangeCondition];
}


@end
