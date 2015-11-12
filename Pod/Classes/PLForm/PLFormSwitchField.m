//
//  PLFormSwitchField.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormSwitchField.h"
#import "PureLayout.h"
#import "PLStyleSettings.h"
#import "PLExtras-UIView.h"

@implementation PLFormSwitchFieldElement

+ (instancetype)switchFieldElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormSwitchFieldElement* element = [PLFormSwitchFieldElement new];
    element.elementID = elementID;
    element.delegate = delegate;
    element.value = value;
    element.originalValue = value;
    element.labelText = labelText;
    return element;
}

-(NSString*)valueAsString
{
    return @(self.value).stringValue;
}

@end


@implementation PLFormSwitchField

-(void)setup
{
    [super setup];
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];

    _valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _valueLabel.font = [PLStyleSettings sharedInstance].h1Font;
    _valueLabel.textAlignment = NSTextAlignmentLeft;
    
    _switchControl = [[UISwitch alloc] initWithFrame:self.bounds];
    [_switchControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
}



- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    
    [_valueLabel removeFromSuperview];
    [_valueLabel removeConstraints:_valueLabel.constraints];
    [self addSubview:_valueLabel];

    [_switchControl removeFromSuperview];
    [_switchControl removeConstraints:_switchControl.constraints];
    [self addSubview:_switchControl];
    
    // ensure contraints get rebuilt
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_valueLabel])
    {
        [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
        [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right + _switchControl.bounds.size.width];
        [_valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    
    if (![self hasConstraintsForView:_switchControl])
    {
        [_switchControl autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
        [_switchControl autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    
    [super updateConstraints];
}

-(void)updateWithElement:(PLFormSwitchFieldElement*)element
{
    self.element = element;
    
    _valueLabel.text = element.labelText;
    _switchControl.on = element.value;
}


- (BOOL)canBecomeFirstResponder
{
    return [_switchControl canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_switchControl becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_switchControl resignFirstResponder];
}

- (IBAction)valueChanged:(UISwitch *)sender {
    _element.value = sender.on;
    
    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }
}

@end
