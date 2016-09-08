//
//  PLFormTextField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLStyleView.h"
#import "PLFormElement.h"

typedef enum {
    BBTextInputTypeText,
    BBTextInputTypeNumber,
    BBTextInputTypePassword,
    BBTextInputTypeEmail
} BBTextInputType;


@interface PLFormTextFieldElement : PLFormElement

// Designated initializer
+ (instancetype)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate;
+ (instancetype)numberInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate;
+ (instancetype)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate;
+ (instancetype)emailInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* placeholderText;
@property (nonatomic, copy) NSString* originalValue;
@property (nonatomic, assign) BBTextInputType inputType;


@end


@interface PLFormTextField : PLStyleView <UITextFieldDelegate>

@property (nonatomic, strong) PLFormTextFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *placeholder;
@property (nonatomic) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;

// placeholde font can get overridden, so set font first then placeholder font
// TODO add a specific placeholder label rather than relying on the textfield placeholder
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *placeholderFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

-(void)removeInsetConstraints;
-(void)textFieldDidChange;
-(void)updateWithElement:(PLFormTextFieldElement*)element;

@end
