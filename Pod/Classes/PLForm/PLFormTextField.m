
//
//  PLFormTextField.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormTextField.h"
#import "PLExtras-UIView.h"

@import PureLayout;

@implementation PLFormTextFieldElement


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)textInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate
{
    PLFormTextFieldElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.delegate = delegate;
    element.placeholderText = placeholderText;
    element.value = value;
    element.originalValue = value;
    element.inputType = PLTextInputTypeText;
    element.textInputAutoCorrect = YES;
    return element;
}

+ (instancetype)numberInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate
{
    PLFormTextFieldElement* element = [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = PLTextInputTypeNumber;
    return element;
}

+ (instancetype)passwordInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate
{
    PLFormTextFieldElement* element = [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = PLTextInputTypePassword;
    return element;
}

+ (instancetype)emailInputElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate
{
    PLFormTextFieldElement* element = [self textInputElementWithID:elementID placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = PLTextInputTypeEmail;
    return element;
}

-(NSString*)valueAsString
{
    return self.value;
}

@end


@implementation PLFormTextField
{
    NSMutableDictionary *placeholderAttributes;
}

-(void)setup
{
    [super setup];
    
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    [_textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _textfield.delegate = self;
    
    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute: self.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft)
    {
        [self setAlignment:NSTextAlignmentRight];
    }
    
    [self addSubview:_textfield];
    
    _contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    placeholderAttributes = [NSMutableDictionary dictionaryWithCapacity:2];
}


-(void)dealloc
{
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return [_textfield canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textfield becomeFirstResponder];
}

- (BOOL)canResignFirstResponder
{
    return [_textfield canResignFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textfield resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_textfield isFirstResponder];
}

// attributes
-(void)setFont:(UIFont *)font
{
    _textfield.font = font;
}

-(UIFont*)font
{
    return _textfield.font;
}

-(void)setTextColor:(UIColor *)color
{
    _textfield.textColor = color;
}

-(UIColor *)textColor
{
    return _textfield.textColor;
}


-(void)setPlaceholderColor:(UIColor *)color
{
    placeholderAttributes[NSForegroundColorAttributeName] = color;
    _textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textfield.placeholder attributes:placeholderAttributes];
}

-(UIColor*)placeholderColor
{
    return placeholderAttributes[NSForegroundColorAttributeName];
}

-(void)setPlaceholderFont:(UIFont *)font
{
    placeholderAttributes[NSFontAttributeName] = font;
    _textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textfield.attributedPlaceholder.string attributes:placeholderAttributes];
    
}

-(UIFont*)placeholderFont
{
    return placeholderAttributes[NSFontAttributeName];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (placeholderAttributes.count)
    {
        _textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textfield.attributedPlaceholder.string attributes:placeholderAttributes];
    }
    else
    {
        [_textfield setPlaceholder:placeholder];
    }
}

- (NSString*)placeholder
{
    return _textfield.placeholder;
}

-(void)setText:(NSString *)text
{
    _textfield.text = text;
}

-(NSString*)text
{
    return _textfield.text;
}


-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_textfield];
    [self setNeedsUpdateConstraints];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    [self removeInsetConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_textfield] && self.superview)
    {
        [_textfield autoPinEdgesToSuperviewEdgesWithInsets:_contentInsets];
    }
    [super updateConstraints];
}


-(void)updateWithElement:(PLFormTextFieldElement*)element
{
    self.element = element;
    self.placeholder = element.placeholderText;
    self.text = element.value;
    if (element.inputType == PLTextInputTypeNumber)
    {
        _textfield.keyboardType = UIKeyboardTypeNumberPad;
        _textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    else if (element.inputType == PLTextInputTypeEmail)
    {
        _textfield.keyboardType = UIKeyboardTypeEmailAddress;
        _textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    else if (element.inputType == PLTextInputTypePassword)
    {
        _textfield.keyboardType = UIKeyboardTypeDefault;
        _textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textfield.autocorrectionType = UITextAutocorrectionTypeNo;
        _textfield.secureTextEntry = YES;
    }
    else
    {
        _textfield.keyboardType = UIKeyboardTypeDefault;
        _textfield.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        _textfield.autocorrectionType = (element.textInputAutoCorrect) ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo;
    }
    [self setNeedsLayout];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange {
    // call the delegate to inform of value changed
    self.element.value = _textfield.text;
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // call the delegate to inform of value changed
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (void)setAlignment:(NSTextAlignment)alignment {
    _alignment = alignment;
    self.textfield.textAlignment = alignment;
}


@end
