//
//  PLFormPhoneField.m
//  Pods
//
//  Created by Ash Thwaites on 22/06/2017.
//
//

#import "PLFormPhoneField.h"


@implementation PLFormPhoneField
{
    NSMutableDictionary *placeholderAttributes;
}

-(void)setup
{
    [super setup];
    
    CGRect frame = self.bounds;
    frame.origin.x = 75;
    _numberTextfield = [[UITextField alloc] initWithFrame:frame];
    [_numberTextfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _numberTextfield.delegate = self;
    [self addSubview:_numberTextfield];
    
    frame.origin.x = 0;
    frame.size.width = 60;
    _regionTextfield = [[UITextField alloc] initWithFrame:frame];
    [_regionTextfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _numberTextfield.delegate = self;
    [self addSubview:_numberTextfield];

    
    _contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    placeholderAttributes = [NSMutableDictionary dictionaryWithCapacity:2];
}


-(void)dealloc
{
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return [_numberTextfield canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_numberTextfield becomeFirstResponder];
}

- (BOOL)canResignFirstResponder
{
    return [_numberTextfield canResignFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_numberTextfield resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_numberTextfield isFirstResponder];
}

// attributes
-(void)setFont:(UIFont *)font
{
    _numberTextfield.font = font;
}

-(UIFont*)font
{
    return _numberTextfield.font;
}

-(void)setTextColor:(UIColor *)color
{
    _numberTextfield.textColor = color;
}

-(UIColor *)textColor
{
    return _numberTextfield.textColor;
}


-(void)setPlaceholderColor:(UIColor *)color
{
    placeholderAttributes[NSForegroundColorAttributeName] = color;
    _numberTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_numberTextfield.placeholder attributes:placeholderAttributes];
}

-(UIColor*)placeholderColor
{
    return placeholderAttributes[NSForegroundColorAttributeName];
}

-(void)setPlaceholderFont:(UIFont *)font
{
    placeholderAttributes[NSFontAttributeName] = font;
    _numberTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_numberTextfield.attributedPlaceholder.string attributes:placeholderAttributes];
    
}

-(UIFont*)placeholderFont
{
    return placeholderAttributes[NSFontAttributeName];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (placeholderAttributes.count)
    {
        _numberTextfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_numberTextfield.attributedPlaceholder.string attributes:placeholderAttributes];
    }
    else
    {
        [_numberTextfield setPlaceholder:placeholder];
    }
}

- (NSString*)placeholder
{
    return _numberTextfield.placeholder;
}

-(void)setText:(NSString *)text
{
    _numberTextfield.text = text;
}

-(NSString*)text
{
    return _numberTextfield.text;
}


-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_numberTextfield];
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
        [_numberTextfield autoPinEdgesToSuperviewEdgesWithInsets:_contentInsets];
    }
    [super updateConstraints];
}


-(void)updateWithElement:(PLFormTextFieldElement*)element
{
    self.element = element;
    self.placeholder = element.placeholderText;
    self.text = element.value;
    _numberTextfield.keyboardType = UIKeyboardTypeDefault;
    _numberTextfield.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _numberTextfield.autocorrectionType = (element.textInputAutoCorrect) ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo;
    [self setNeedsLayout];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange {
    // call the delegate to inform of value changed
    self.element.value = _numberTextfield.text;
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





@end
