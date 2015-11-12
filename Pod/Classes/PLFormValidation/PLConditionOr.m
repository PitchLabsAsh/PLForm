
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLConditionOr.h"

@implementation PLConditionOr
@synthesize conditions = _conditions;

- (id)initWithConditions:(NSArray *)originalConditions
{
    self = [super init];
    if (self)
    {
        self.conditions = [NSMutableArray arrayWithArray:originalConditions];
    }
    
    return self;
}

- (id)initWithConditionOne:(id<PLConditionProtocol>)one two:(id<PLConditionProtocol>)two
{
    self = [self initWithConditions:[NSArray arrayWithObjects:one, two, nil]];
    if (self)
    {
        
    }
    
    return self;
}

- (BOOL)check:(PLFormElement *)element;
{
    BOOL result = NO;
    
    for (id<PLConditionProtocol> condition in _conditions) {
        result = result || [condition check:element];
    }
    
    return result;
}

#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return nil;
}

@end
