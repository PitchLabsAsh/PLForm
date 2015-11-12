//
//  PLConditionAccept.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLConditionAccept.h"
//#import "BBSwitchFormElement.h"

@implementation PLConditionAccept

- (BOOL)check:(PLFormElement *)element;
{
//    if (![element isKindOfClass:[BBSwitchFormElement class]])
//        return NO;
//    
//    return ((BBSwitchFormElement*)element).value;
    return NO;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationAccept", nil);
}

@end
