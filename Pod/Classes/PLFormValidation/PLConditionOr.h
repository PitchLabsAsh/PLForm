
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLCondition.h"

@interface PLConditionOr : PLCondition
{
    NSMutableArray *_conditions;
}

@property (strong, nonatomic) NSArray *conditions;

- (id)initWithConditions:(NSArray *)originalConditions;
- (id)initWithConditionOne:(id<PLConditionProtocol>)one two:(id<PLConditionProtocol>)two;

@end
