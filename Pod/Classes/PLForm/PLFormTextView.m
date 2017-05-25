//
//  PLFormTextView.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormTextView.h"
#import "PLExtras-UIView.h"

@import PureLayout;

@implementation PLFormTextViewElement


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (instancetype)textViewElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormTextViewElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.delegate = delegate;
    element.value = value;
    element.placeholderText = placeholderText;
    element.originalValue = value;
    return element;
}

-(NSString*)valueAsString
{
    return self.value;
}

@end



@interface PLFormTextView ()

@end


@implementation PLFormTextView

-(void)setup
{
    [super setup];
    
    _textview = [[UITextView alloc] initWithFrame:self.bounds];
    _textview.delegate = self;
    _textview.textContainerInset = UIEdgeInsetsZero;
    _textview.textContainer.lineFragmentPadding = 0;
    _textview.backgroundColor = [UIColor clearColor];
    [self addSubview:_textview];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_placeholderLabel];

    _contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
}


-(void)dealloc
{
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return [_textview canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textview becomeFirstResponder];
}

- (BOOL)canResignFirstResponder
{
    return [_textview canResignFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textview resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_textview isFirstResponder];
}

// attributes
-(void)setFont:(UIFont *)font
{
    _textview.font = font;
    _placeholderLabel.font = font;
}

-(UIFont*)font
{
    return _textview.font;
}

-(void)setTextColor:(UIColor *)color
{
    _textview.textColor = color;
}

-(UIColor *)textColor
{
    return _textview.textColor;
}

-(void)setPlaceholderFont:(UIFont *)font
{
    _placeholderLabel.font = font;
}

-(UIFont*)placeholderFont
{
    return _placeholderLabel.font;
}

-(void)setPlaceholderColor:(UIColor *)color
{
    _placeholderLabel.textColor = color;
}

-(UIColor *)placeholderColor
{
    return _placeholderLabel.textColor;
}


-(void)setText:(NSString *)text
{
    _textview.text = text;
}

-(NSString*)text
{
    return _textview.text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
}

-(NSString*)placeholder
{
    return _placeholderLabel.text;
}



-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_textview];
    [self removeConstraintsForView:_placeholderLabel];
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
        if (![self hasConstraintsForView:_textview])
        {
            [_textview autoPinEdgesToSuperviewEdgesWithInsets:_contentInsets];
        }
        if (![self hasConstraintsForView:_placeholderLabel])
        {
            switch (self.alignment) {
                case NSTextAlignmentRight:
                    [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
                    break;
                case NSTextAlignmentCenter:
                    [_placeholderLabel autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self];
                    [self.placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:self.contentInsets.left];
                    break;
                default:
                    [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
                    break;
            }
            
            [_placeholderLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:_contentInsets.top];
        }
    }
    [super updateConstraints];
}


-(void)updateWithElement:(PLFormTextViewElement*)element
{
    self.element = element;
    self.text = element.value;
    self.placeholder = element.placeholderText;
    self.placeholderLabel.hidden = (_textview.text.length >0);
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    // call the delegate to inform of value changed
    self.element.value = textView.text;    
    self.placeholderLabel.hidden = (_textview.text.length >0);
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    // call the delegate to inform of value changed
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (void)setAlignment:(NSTextAlignment)alignment {
    _alignment = alignment;
    self.textview.textAlignment = alignment;
    _placeholderLabel.textAlignment = alignment;
}


@end
