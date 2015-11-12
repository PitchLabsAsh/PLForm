
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLValidator.h"


@interface PLValidatorComposite : PLValidator {
@private
    NSMutableArray *_validators;
}

@property (strong, nonatomic) NSMutableArray *validators;


- (id)initWithValidators:(NSArray *)validators;
- (void)addValidator:(id<PLValidatorProtocol>)validator;
- (void)addValidatorsFromArray:(NSArray *)validators;

@end
