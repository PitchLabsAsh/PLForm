//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLValidator.h"


#pragma mark - Validator interface

@interface PLValidatorAlphabetic : PLValidatorSingleCondition
{
}

@property (nonatomic) BOOL allowWhitespace;


@end