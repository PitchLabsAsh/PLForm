//
//  PLFloatingLabelAutoCompleteField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormAutoCompleteField.h"

@interface PLFloatingLabelAutoCompleteField : PLFormAutoCompleteField

@property (nonatomic, readonly) UILabel *floatingLabel;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *placeholder;

@end
