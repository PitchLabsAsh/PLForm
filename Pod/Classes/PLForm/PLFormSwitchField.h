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

+ (instancetype)switchFieldElementWithID:(NSInteger)elementID title:(NSString *)title value:(BOOL)value delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, assign) BOOL value;
@property (nonatomic, assign) BOOL originalValue;
@property (nonatomic, copy) NSString *title;

@end


@interface PLFormSwitchField : PLStyleView

@property (nonatomic, strong) PLFormSwitchFieldElement* element;
@property (nonatomic, strong) UISwitch *switchControl;
@property (nonatomic, readonly) UILabel *titleLabel;

@property (nonatomic) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

-(void)updateWithElement:(PLFormSwitchFieldElement*)element;

@end
