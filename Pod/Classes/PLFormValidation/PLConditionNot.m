//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLConditionNot.h"

@implementation PLConditionNot
@synthesize condition;

- (id)initWithCondition:(id<PLConditionProtocol>)originalCondition
{
    self = [super init];
    if (self)
    {
        self.condition = originalCondition;
    }
    
    return self;
}

- (BOOL)check:(PLFormElement *)element;
{
    BOOL result = [self.condition check:element];
    return !result;
}

#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return nil;
}

@end
