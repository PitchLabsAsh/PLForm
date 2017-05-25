//
//  PLFloatingLabelAutoCompleteField.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLFloatingLabelAutoCompleteField.h"
#import "PLExtras-UIView.h"

@import PureLayout;

@interface PLFloatingLabelAutoCompleteField ()
{
    NSLayoutConstraint *floatingLabelCenterConstraint;
    NSLayoutConstraint *textFieldCenterConstraint;
}


@end


@implementation PLFloatingLabelAutoCompleteField

@dynamic placeholder;

-(void)setup
{
    [super setup];

    _floatingLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
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


-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_floatingLabel];
    floatingLabelCenterConstraint = nil;
    textFieldCenterConstraint = nil;
    [super removeInsetConstraints];
}


- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    [super setContentInsets:contentInsets];
    
    floatingLabelCenterConstraint = nil;
    textFieldCenterConstraint = nil;
    
    // remove and readd the views to delete the constraints
    [self.floatingLabel removeFromSuperview];
    [self.floatingLabel removeConstraints:self.floatingLabel.constraints];
    [self addSubview:_floatingLabel];
}


- (void)updateConstraints
{
    if (self.superview)
    {
        if (![self hasConstraintsForView:_floatingLabel])
        {
            [_floatingLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
            floatingLabelCenterConstraint = [_floatingLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
            [_floatingLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self];
        }
        if (![self hasConstraintsForView:self.textfield])
        {
            [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
            [self.textfield autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.contentInsets.right];
            textFieldCenterConstraint = [self.textfield autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        }
        if (self.element.index >=0)
        {
            [self showFloatingLabel:NO];
        }
    }
    [super updateConstraints];
}


- (void)setPlaceholder:(NSString *)placeholder
{
    _floatingLabel.text = placeholder;
    [super setPlaceholder:placeholder];
}

-(void)updateWithElement:(PLFormAutoCompleteFieldElement*)element
{
    [super updateWithElement:element];
    if (element.index >=0)
    {
        [self showFloatingLabel:NO];
    }
}

-(void)setText:(NSString *)text
{
    self.textfield.text = text;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)textFieldDidChange {
    [super textFieldDidChange];
    
    // whatever you wanted to do
    BOOL firstResponder = self.textfield.isFirstResponder;
    
    if (!self.textfield.text || 0 == [self.textfield.text length])
    {
        [self hideFloatingLabel:firstResponder];
    }
    else
    {
        [self showFloatingLabel:firstResponder];
    }
}

- (void)showFloatingLabel:(BOOL)animated
{
    // calculate the offset
    CGSize labelSize = [_floatingLabel intrinsicContentSize];
    CGSize textSize = [self.textfield intrinsicContentSize];
    floatingLabelCenterConstraint.constant = - ((self.bounds.size.height - labelSize.height) / 2.0f) + self.contentInsets.top;
    textFieldCenterConstraint.constant = ((self.bounds.size.height - textSize.height) / 2.0f) - self.contentInsets.bottom;
    
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
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
    floatingLabelCenterConstraint.constant = 0.0f;
    textFieldCenterConstraint.constant = 0.0f;
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
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

- (void)setAlignment:(NSTextAlignment)alignment {
    [super setAlignment:alignment];
    //self.label.textAlignment = alignment;
    _floatingLabel.textAlignment = alignment;
    [self removeConstraintsForView:_floatingLabel];
    [self updateConstraints];
}

@end
