
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLValidatorAlphabetic.h"
#import "PLConditionAlphabetic.h"


@implementation PLValidatorAlphabetic
@dynamic allowWhitespace;

#pragma mark - Initialization

- (id)init
{
    self = [super initWithCondition:[[PLConditionAlphabetic alloc] init]];
    if (self)
    {
    }
        
    return self;
}

- (BOOL)allowWhitespace
{
    return [(PLConditionAlphabetic *)[self condition] allowWhitespace];
}

- (void)setAllowWhitespace:(BOOL)allowWhitespace
{
    [(PLConditionAlphabetic *)[self condition] setAllowWhitespace:allowWhitespace];
}

@end
