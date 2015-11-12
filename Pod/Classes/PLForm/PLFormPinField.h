//
//  BBPinField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PLFormElement.h"
#import "PLStyleView.h"
#import "PLFormPinDot.h"

@interface PLFormPinFieldElement : PLFormElement

+ (instancetype)pinFieldElementWithID:(NSInteger)elementID pinLength:(NSInteger)pinLength delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, assign) NSInteger pinLength;
@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* originalValue;

@end


@interface PLFormPinField : PLStyleView

@property (nonatomic, strong) PLFormPinFieldElement* element;
@property (nonatomic, readonly) UITextField *textfield;

-(PLFormPinDot*)createDotWithTag:(NSInteger)tag;
-(void)updateWithElement:(PLFormPinFieldElement*)element;

@end
