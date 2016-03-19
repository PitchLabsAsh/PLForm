//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLConditionAlphanumeric.h"
#import "PLFormTextField.h"

@implementation PLConditionAlphanumeric


- (BOOL)check:(PLFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
        return NO;
    
    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9]" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    return numberOfMatches == string.length;
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return PLLocalizedString(@"PLKeyConditionViolationAlphanumeric", nil);
}


@end
