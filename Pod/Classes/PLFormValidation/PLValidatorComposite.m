
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLValidatorComposite.h"

@implementation PLValidatorComposite

@synthesize validators = _validators;

- (id)initWithValidators:(NSArray *)validators
{
    self = [super init];
    if (self)
    {
        self.validators = [NSMutableArray arrayWithArray:validators];
    }
    
    return self;
}

- (id)init
{
    self = [self initWithValidators:[NSArray array]];
    return self;
}

- (void)addValidator:(id<PLValidatorProtocol>)validator
{
    [self.validators addObject:validator];
}

- (void)addValidatorsFromArray:(NSArray *)validators
{
    [self.validators addObjectsFromArray:validators];
}

#pragma mark - Condition check


- (PLConditionCollection *)checkConditions:(PLFormElement *)element
{
    PLConditionCollection *violatedConditions = [super checkConditions: element];
    
    // Check violated conditions of each composite validator
    if (violatedConditions == nil)
    {
        for (id<PLValidatorProtocol> validator in _validators)
        {
            PLConditionCollection *checkedViolatedConditions = [validator checkConditions:element];
            if (checkedViolatedConditions != nil)
            {
                if (violatedConditions == nil)
                {
                    violatedConditions = [[PLConditionCollection alloc] init];
                }
                for (id<PLConditionProtocol> condition in checkedViolatedConditions)
                {
                    [violatedConditions addCondition:condition];
                }
            }
        }
    }
    
    return violatedConditions;
}

@end
