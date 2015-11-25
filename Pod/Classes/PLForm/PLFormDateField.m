//
//  PLFormDateField.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormDateField.h"
#import "PureLayout.h"
#import "PLExtras-UIView.h"


@implementation PLFormDateFieldElement

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)datePickerElementWithID:(NSInteger)elementID title:(NSString *)title date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormDateFieldElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.title = title;
    element.date = date;
    element.originalDate = date;
    element.datePickerMode = datePickerMode;
    element.delegate = delegate;    
    return element;
}

+ (id)datePickerElementWithID:(NSInteger)elementID title:(NSString *)title date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode datePickerMinDate:(NSDate*)mindate datePickerMaxDate:(NSDate*)maxdate delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormDateFieldElement* element = [self datePickerElementWithID:elementID title:title date:date datePickerMode:datePickerMode delegate:delegate];
    element.minDate = mindate;
    element.maxDate = maxdate;
    return element;
}

-(NSString*)valueAsString
{
    if (self.formatter)
    {
        return [self.formatter stringFromDate:self.date];
    }
    else
    {
        
        switch (self.datePickerMode) {
            case UIDatePickerModeDate:
                return [NSDateFormatter localizedStringFromDate:self.date
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterNoStyle];
                break;
                
            case UIDatePickerModeTime:
                return [NSDateFormatter localizedStringFromDate:self.date
                                                      dateStyle:NSDateFormatterNoStyle
                                                      timeStyle:NSDateFormatterShortStyle];
                break;
                
            case UIDatePickerModeCountDownTimer:
                // not supported
                 break;
                
            case UIDatePickerModeDateAndTime:
            default:
                return  [NSDateFormatter localizedStringFromDate:self.date
                                                       dateStyle:NSDateFormatterShortStyle
                                                       timeStyle:NSDateFormatterShortStyle];
                break;
        }
    }
    
    return [super valueAsString];
}

@end



@interface PLFormDateField ()
{
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;
}

@property (nonatomic, readwrite) UITextField *textfield;
@property (nonatomic, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) UILabel *valueLabel;
@property (nonatomic, readwrite) UIDatePicker *datePicker;

@end

@implementation PLFormDateField

-(void)setup
{
    [super setup];
    
    // create the value label
    _valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _valueLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_valueLabel];

    // create a title label
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];

    // hidden textfield to trigger the datepicker...
    _datePicker = [[UIDatePicker alloc] init];
    [_datePicker addTarget:self action:@selector(selectedDateDidChange) forControlEvents:UIControlEventValueChanged];
    
    // we use a hidden textfield to attach the datepicker
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    _textfield.hidden = YES;
    [_textfield setInputView:_datePicker];
    [self addSubview:_textfield];
    
    _contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    
    insideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapInside:)];
    [self addGestureRecognizer:insideTapGestureRecognizer];
    outsideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOutside:)];
}

- (BOOL)canBecomeFirstResponder
{
    return [_textfield canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textfield becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow removeGestureRecognizer:outsideTapGestureRecognizer];
    return [_textfield resignFirstResponder];
}


// attributes
-(void)setFont:(UIFont *)font
{
    _titleLabel.font = font;
}

-(UIFont*)font
{
    return _titleLabel.font;
}

-(void)setTextColor:(UIColor *)color
{
    _titleLabel.textColor = color;
}

-(UIColor *)textColor
{
    return _titleLabel.textColor;
}

-(void)setValueFont:(UIFont *)font
{
    _valueLabel.font = font;
}

-(UIFont*)valueFont
{
    return _valueLabel.font;
}

-(void)setValueColor:(UIColor *)color
{
    _valueLabel.textColor = color;
}

-(UIColor *)valueColor
{
    return _valueLabel.textColor;
}

-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

-(NSString*)title
{
    return _titleLabel.text;
}


// handle constraints

-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_titleLabel];
    [self removeConstraintsForView:_valueLabel];
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
        if (![self hasConstraintsForView:_valueLabel])
        {
            [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
            [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
            [_valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        }

        if (![self hasConstraintsForView:_titleLabel])
        {
            [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
            [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
            [_titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        }
    }
    
    [super updateConstraints];
}


-(void)dealloc
{
    [self resignFirstResponder];
}


-(void)updateWithElement:(PLFormDateFieldElement*)element
{
    self.isAccessibilityElement = YES;
    self.accessibilityLabel = element.title;

    self.element = element;
    self.title = element.title;
    
    _datePicker.datePickerMode = element.datePickerMode;
    _datePicker.minimumDate = element.minDate;
    _datePicker.maximumDate = element.maxDate;

    if (element.date)
        _datePicker.date = element.date;
    _valueLabel.text = [element valueAsString];
}

- (void)onTapInside:(UIGestureRecognizer*)sender
{
    [_textfield becomeFirstResponder];
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow addGestureRecognizer:outsideTapGestureRecognizer];
}

- (void)onTapOutside:(UIGestureRecognizer*)sender
{
    [_textfield resignFirstResponder];
    [sender.view removeGestureRecognizer:outsideTapGestureRecognizer];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}


-(void)selectedDateDidChange
{
    // update the value label with formatted date
    _element.date = _datePicker.date;
    _valueLabel.text = [_element valueAsString];
    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }
}



@end
