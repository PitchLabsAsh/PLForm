//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLConditionPresent.h"
#import "PLFormTextField.h"
#import "PLFormDateField.h"
#import "PLFormSelectField.h"
#import "PLFormAutoCompleteField.h"
#import "PLFormTextView.h"

//#import "BBMultiSelectListFormElement.h"

@implementation PLConditionPresent

- (BOOL)isStringPresent:(NSString *)string//check whether the string value is present or not
{
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
    {
        return NO;
    }
    return YES;
}

- (BOOL)check:(PLFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
    {
        return NO;
    }
    return YES;
}


#pragma mark - Localization

- (NSString *)createLocalizedViolationString
{
    return BBLocalizedString(@"BBKeyConditionViolationPresent", nil);
}

@end
