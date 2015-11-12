
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLValidator.h"
#import "PLCondition.h"
#import "PLConditionCollection.h"
#import "PLFormElement.h"


@implementation PLValidator

+ (PLValidator *) validator {
    return [[[self class] alloc] init];
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _conditionCollection = [[PLConditionCollection alloc] init];
    }
    
    return self;
}

- (id)initWithCondition:(id<PLConditionProtocol>) firstCondition, ...
{
    if (self = [self init])
    {
        [self addCondition: firstCondition];
        
        va_list args;
        va_start(args, firstCondition);
        
        id<PLConditionProtocol> condition = nil;
        
        while( (condition = va_arg( args, id<PLConditionProtocol>)) != nil )
        {
            [self addCondition: condition];
        }

        va_end(args);
    }
    
    return self;
}

- (id)initWithConditions:(NSArray *) conditions
{
    if (self = [self init])
    {
        for (id<PLConditionProtocol> condition in conditions)
        {
            [self addCondition: condition];
        }
    }
    
    return self;
}

#pragma mark - Deinitialization


#pragma mark - Localized violation string

- (void) setLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index
{
    if (index < [_conditionCollection count])
    {
        id<PLConditionProtocol> conditionProtocol = [_conditionCollection conditionAtIndex:index];
        if ([conditionProtocol isKindOfClass: [PLCondition class]])
        {
            PLCondition *condition = (PLCondition *) conditionProtocol;
            condition.localizedViolationString = localizedViolationString;
        }
    }
}

- (id)withLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index
{
    [self setLocalizedViolationString:localizedViolationString forConditionAtIndex:index];
    return self;
}

- (id)withLocalizedViolationString:(NSString *)localizedViolationString
{
    return [self withLocalizedViolationString:localizedViolationString forConditionAtIndex:0];
}

#pragma mark - Condition


- (void)addCondition:(id <PLConditionProtocol>)condition
{
    if ([condition isKindOfClass:[PLCondition class]])
    {
        [_conditionCollection addCondition:condition];
    }
    else
    {
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added incompatible condition <%@> to validator.", [condition class]], nil];
    }
}


- (void)removeConditionOfClass:(Class <PLConditionProtocol>)conditionClass
{
    for (PLCondition *condition in _conditionCollection)
    {
        if ([condition isKindOfClass:conditionClass])
            [_conditionCollection removeCondition:condition];
    }
}


#pragma mark - Condition check


- (PLConditionCollection *)checkConditions:(PLFormElement *)element
{
    PLConditionCollection *violatedConditions = nil;
    for (PLCondition *condition in _conditionCollection)
    {
        if (NO == [condition check:element])
        {
            if (nil == violatedConditions)
                violatedConditions = [[PLConditionCollection alloc] init];
            
            [violatedConditions addCondition:condition];
        }
    }
    
    return violatedConditions;
}


@end

@implementation PLValidatorSingleCondition

@synthesize condition = _condition;
@dynamic localizedViolationString;

- (id)initWithCondition:(id<PLConditionProtocol>)condition
{
    if (self = [super init])
    {
        [self setCondition: condition];
    }
    
    return self;
}

- (void)setCondition:(id<PLConditionProtocol>)condition
{
    _condition = condition;
    
    [_conditionCollection removeAllConditions];
    [self addCondition: _condition];
}

- (NSString *)localizedViolationString
{
    if ([_conditionCollection count] > 0)
    {
        return [[_conditionCollection conditionAtIndex: 0] localizedViolationString];
    }
    
    return nil;
}

- (void)setLocalizedViolationString:(NSString *)localizedViolationString
{
    [self setLocalizedViolationString: localizedViolationString forConditionAtIndex: 0];
}

@end