//
//  PLFloatingLabelTextView.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFloatingLabelTextView.h"
#import "PureLayout.h"
#import "PLExtras-UIView.h"

@interface PLFloatingLabelTextView ()
{
    NSLayoutConstraint *placeholderLabelTopConstraint;
    NSLayoutConstraint *textviewTopConstraint;
    NSLayoutConstraint *floatingLabelCenterConstraint;
}

@end

@implementation PLFloatingLabelTextView

-(void)setup
{
    // create the additional floating label
    _floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
    
    _floatingLabelOffset = 18.0f;
    [super setup];
}

-(void)setFloatingFont:(UIFont *)font
{
    _floatingLabel.font = font;
}

-(UIFont*)floatingFont
{
    return _floatingLabel.font;
}

-(void)setFloatingColor:(UIColor *)color
{
    _floatingLabel.textColor = color;
}

-(UIColor *)floatingColor
{
    return _floatingLabel.textColor;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _floatingLabel.text = placeholder;
    [super setPlaceholder:placeholder];
}

-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_floatingLabel];
    placeholderLabelTopConstraint = nil;
    textviewTopConstraint = nil;
    floatingLabelCenterConstraint = nil;
    [super removeInsetConstraints];
}


- (void)updateConstraints
{
    if (self.superview)
    {
        if (![self hasConstraintsForView:self.textview])
        {
            textviewTopConstraint = [self.textview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.contentInsets.top];
            [self.textview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:self.contentInsets.left];
            [self.textview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:self.contentInsets.bottom];
            [self.textview autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:self.contentInsets.right];
        }
        if (![self hasConstraintsForView:self.placeholderLabel])
        {
            [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
            placeholderLabelTopConstraint = [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.contentInsets.top];
        }
        if (![self hasConstraintsForView:_floatingLabel])
        {
            [_floatingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
            floatingLabelCenterConstraint = [_floatingLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.placeholderLabel withOffset:0];
        }
    }
    [super updateConstraints];
}



-(void)updateWithElement:(PLFormTextViewElement*)element
{
    self.element = element;
    self.text = element.value;
    self.placeholder = element.placeholderText;
    if (element.value.length >0)
    {
        [self showFloatingLabel:NO];
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    // call the delegate to inform of value changed
    self.element.value = textView.text;
    
    BOOL firstResponder = self.textview.isFirstResponder;
    if (!self.textview.text || 0 == [self.textview.text length])
    {
        [self hideFloatingLabel:firstResponder];
    }
    else
    {
        [self showFloatingLabel:firstResponder];
    }
    
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

- (void)showFloatingLabel:(BOOL)animated
{
    // calculate the offset
    floatingLabelCenterConstraint.constant = - self.floatingLabelOffset;
    placeholderLabelTopConstraint.constant = self.contentInsets.top + (self.floatingLabelOffset / 2.0f);
    textviewTopConstraint.constant = self.contentInsets.top + (self.floatingLabelOffset / 2.0f);
    
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
        self.placeholderLabel.alpha = 0.0f;
        [self layoutIfNeeded];
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else
    {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    floatingLabelCenterConstraint.constant = 0;
    placeholderLabelTopConstraint.constant = self.contentInsets.top;
    textviewTopConstraint.constant = self.contentInsets.top;
    
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
        self.placeholderLabel.alpha = 1.0f;
        [self layoutIfNeeded];
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else
    {
        hideBlock();
    }
}

@end
