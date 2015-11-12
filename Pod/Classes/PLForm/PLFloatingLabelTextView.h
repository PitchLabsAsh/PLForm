//
//  PLFloatingLabelTextView.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormTextView.h"

@interface PLFloatingLabelTextView : PLFormTextView

@property (nonatomic) CGFloat floatingLabelOffset;
@property (nonatomic, readonly) UILabel *floatingLabel;

@end
