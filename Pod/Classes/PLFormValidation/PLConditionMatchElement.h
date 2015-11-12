//
//  PLConditionMatchElement.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLCondition.h"

@interface PLConditionMatchElement : PLCondition

@property (strong, nonatomic) PLFormElement *matchElement;

- (id)initWithMatchElement:(PLFormElement *)matchElement;

@end
