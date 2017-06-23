//
//  PLConditionPhoneNumber.m
//  Pods
//
//  Created by Ashey Thwaites on 23/06/2017.
//
//

#import "PLConditionPhoneNumber.h"
@import libPhoneNumber_iOS;

@implementation PLConditionPhoneNumber

- (BOOL)check:(PLFormElement *)element;
{
    NSString *string = [element valueAsString];
    if (!string || string.length == 0 || [string isEqual: [NSNull null]])
        return NO;
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];

    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
    NSError *error = nil;
    NBPhoneNumber *myNumber = [phoneUtil parse:string
                                 defaultRegion:countryCode error:&error];
    if (error == nil)
    {
        return [phoneUtil isValidNumber:myNumber];
    }
    return NO;
}


#pragma mark - Localization

- (NSString *) createLocalizedViolationString
{
    return PLLocalizedString(@"PLKeyConditionViolationPhoneNumber", nil);
}


@end
