//
//  PLFloatingLabelTextField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PLFormTextField.h"


@interface PLFloatingLabelTextField : PLFormTextField

@property (nonatomic, readonly) UILabel *floatingLabel;

@property (nonatomic, strong) UIFont *floatingFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *floatingColor UI_APPEARANCE_SELECTOR;

@end
