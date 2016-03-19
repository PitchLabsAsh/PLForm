//
//  PLConditionMatchElement.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLConditionMatchElement.h"
#import "PLFormTextField.h"

@implementation PLConditionMatchElement

- (id)initWithMatchElement:(PLFormElement *)matchElement;
{
    if (self = [super init])
    {
        self.matchElement = matchElement;
    }
    
    return self;
}

- (BOOL)check:(PLFormElement *)element;
{
    NSString *string = [element valueAsString];
    NSString *matchString = [((PLFormTextFieldElement*)self.matchElement) valueAsString];

    return [string isEqualToString:matchString];
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return PLLocalizedString(@"PLKeyConditionViolationMatchElement", nil);
}

@end
