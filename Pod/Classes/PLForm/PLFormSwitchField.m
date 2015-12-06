//
//  PLFormSwitchField.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormSwitchField.h"
#import "PureLayout.h"
#import "PLExtras-UIView.h"

@implementation PLFormSwitchFieldElement

+ (instancetype)switchFieldElementWithID:(NSInteger)elementID title:(NSString *)title value:(BOOL)value delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormSwitchFieldElement* element = [PLFormSwitchFieldElement new];
    element.elementID = elementID;
    element.delegate = delegate;
    element.value = value;
    element.originalValue = value;
    element.title = title;
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
    
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _switchControl = [[UISwitch alloc] initWithFrame:self.bounds];
    [_switchControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_switchControl];
    
    _contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
}

-(void)dealloc
{
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return [_switchControl canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_switchControl becomeFirstResponder];
}

- (BOOL)canResignFirstResponder
{
    return [_switchControl canResignFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_switchControl resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_switchControl isFirstResponder];
}

-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_titleLabel];
    [self setNeedsUpdateConstraints];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    [self removeInsetConstraints];
}

- (void)updateConstraints
{
    if (self.superview)
    {
        if (![self hasConstraintsForView:_titleLabel])
        {
            [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
            [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right + _switchControl.bounds.size.width];
            [_titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        }
        
        if (![self hasConstraintsForView:_switchControl])
        {
            [_switchControl autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
            [_switchControl autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        }
    }
    
    [super updateConstraints];
}



-(void)updateWithElement:(PLFormSwitchFieldElement*)element
{
    self.element = element;
    _titleLabel.text = element.title;
    _switchControl.on = element.value;
}


- (IBAction)valueChanged:(UISwitch *)sender {
    _element.value = sender.on;
    
    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }
}

@end
