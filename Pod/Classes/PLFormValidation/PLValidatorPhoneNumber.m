//
//  PLValidatorPhoneNumber.m
//  Pods
//
//  Created by Ashey Thwaites on 23/06/2017.
//
//

#import "PLValidatorPhoneNumber.h"
#import "PLConditionPhoneNumber.h"


@implementation PLValidatorPhoneNumber

- (id)init
{
    self = [super init];
    if (self)
    {
        [self addCondition:[[PLConditionPhoneNumber alloc] init]];
    }
    
    return self;
}
@end
