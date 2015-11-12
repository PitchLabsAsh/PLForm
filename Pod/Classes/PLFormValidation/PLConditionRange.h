//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLCondition.h"


@interface PLConditionRange : PLCondition
{
@protected
    NSRange _range;
}

@property (nonatomic, assign) NSRange range;


@end
