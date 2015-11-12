
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLCondition.h"

@interface PLConditionNot : PLCondition
{
    
}

@property (strong, nonatomic) id<PLConditionProtocol> condition;

- (id)initWithCondition:(id<PLConditionProtocol>)originalCondition;

@end
