//
//  PLFormSwitchField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PLFormElement.h"
#import "PLStyleView.h"

@interface PLFormSwitchFieldElement : PLFormElement

+ (instancetype)switchFieldElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, assign) BOOL value;
@property (nonatomic, assign) BOOL originalValue;
@property (nonatomic, copy) NSString *labelText;

@end


@interface PLFormSwitchField : PLStyleView

@property (nonatomic, strong) PLFormSwitchFieldElement* element;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, readonly) UILabel *valueLabel;
@property (nonatomic) UIEdgeInsets contentInsets;

-(void)updateWithElement:(PLFormSwitchFieldElement*)element;

@end
