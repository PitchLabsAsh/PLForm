//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLCondition.h"
#import "PLConditionCollection.h"
#import "PLFormElement.h"


#pragma mark - Validator protocol

@protocol PLCondition;
@protocol PLConditionCollection;

@protocol PLValidatorProtocol <NSObject>

- (void)addCondition:(id <PLConditionProtocol>)condition;
- (void)removeConditionOfClass:(Class <PLConditionProtocol>)conditionClass;
- (PLConditionCollection *)checkConditions:(PLFormElement *)element;

@end


#pragma mark - Validator interface

@class PLConditionCollection;


@interface PLValidator : NSObject <PLValidatorProtocol>
{
@protected
    PLConditionCollection *_conditionCollection;
}

+ (PLValidator *)validator;

- (id)initWithCondition:(id<PLConditionProtocol>)firstCondition, ...;
- (id)initWithConditions:(NSArray *)conditions;
- (void)setLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index;
- (id)withLocalizedViolationString:(NSString *)localizedViolationString forConditionAtIndex:(NSUInteger)index;
- (id)withLocalizedViolationString:(NSString *)localizedViolationString;
- (void)addCondition:(id <PLConditionProtocol>)condition;
- (void)removeConditionOfClass:(Class <PLConditionProtocol>)conditionClass;

- (PLConditionCollection *)checkConditions:(PLFormElement *)element;


@end

@interface PLValidatorSingleCondition : PLValidator
{
    id<PLConditionProtocol> _condition;
}

@property (strong, nonatomic) id<PLConditionProtocol> condition;
@property (copy, nonatomic) NSString *localizedViolationString;

- (id)initWithCondition:(id<PLConditionProtocol>)condition;

@end
