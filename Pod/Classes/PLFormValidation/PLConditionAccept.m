//
//  PLConditionAccept.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLConditionAccept.h"
//#import "PLSwitchFormElement.h"

@implementation PLConditionAccept

- (BOOL)check:(PLFormElement *)element;
{
//    if (![element isKindOfClass:[PLSwitchFormElement class]])
//        return NO;
//    
//    return ((PLSwitchFormElement*)element).value;
    return NO;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return PLLocalizedString(@"PLKeyConditionViolationAccept", nil);
}

@end
