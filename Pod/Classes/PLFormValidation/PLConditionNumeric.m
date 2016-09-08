//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLConditionNumeric.h"
#import "PLFormTextField.h"

@implementation PLConditionNumeric


- (BOOL)check:(PLFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
        return NO;
    
    self.regexString = @"\\d+";
    
    return [super check:element];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return PLLocalizedString(@"PLKeyConditionViolationNumeric", nil);
}


@end
