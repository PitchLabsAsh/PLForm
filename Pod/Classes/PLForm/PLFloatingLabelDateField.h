//
//  BBDateField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormDateField.h"

//IB_DESIGNABLE

@interface PLFloatingLabelDateField : PLFormDateField

@property (nonatomic, readonly) UILabel *floatingLabel;
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, readonly) UILabel *valueLabel;

@property (nonatomic) NSString *placeholder;
@property (nonatomic) NSInteger datePickerMode;

@end
