//
//  PLFloatingLabelSelectField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormSelectField.h"

//IB_DESIGNABLE

@interface PLFloatingLabelSelectField : PLFormSelectField

@property (nonatomic, readonly) UILabel *floatingLabel;
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, readonly) UILabel *valueLabel;

@property (nonatomic) NSString *placeholder;

@end
