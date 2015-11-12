//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PLLocalization.h"
#import "PLFormElement.h"

#pragma mark - Condition protocol

@protocol PLConditionProtocol <NSObject>

@required

- (BOOL)check:(PLFormElement *)element;
- (NSString *)localizedViolationString;

@end


#pragma mark - Condition interface


@interface PLCondition : NSObject <PLConditionProtocol>
{
@private
    NSString *_localizedViolationString;
}

@property (copy, nonatomic) NSString *localizedViolationString;
@property (nonatomic, copy) NSString *regexString;

+ (PLCondition *) condition;
- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString;
- (id)withLocalizedViolationString:(NSString *)localizedViolationString;
- (id)initWithLocalizedViolationString:(NSString *)localizedViolationString andRegexString:(NSString *)regexString;
- (id)initWithRegexString:(NSString *)regexString;
- (id)withRegexString:(NSString *)regexString;

@end
