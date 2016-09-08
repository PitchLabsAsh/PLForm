//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLConditionEmail.h"
#import "PLFormTextField.h"

#define kRegularExpressionEmail @"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,})+$"

@implementation PLConditionEmail

- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString
{
    return [super initWithLocalizedViolationString:localizedViolationString andRegexString:kRegularExpressionEmail];
}

- (id)init
{
    return [super initWithRegexString:kRegularExpressionEmail];
}

#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return PLLocalizedString(@"PLKeyConditionViolationEmail", nil);
}

@end
