//
//  PLFormDateField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLStyleView.h"
#import "PLFormElement.h"

@interface PLFormDateFieldElement : PLFormElement

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode delegate:(id<PLFormElementDelegate>)delegate;
+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode datePickerMinDate:(NSDate*)mindate datePickerMaxDate:(NSDate*)maxdate delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *originalDate;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, retain) NSDate *minDate;
@property (nonatomic, retain) NSDate *maxDate;
@property (nonatomic, retain) NSDateFormatter *formatter;

@end



@interface PLFormDateField : PLStyleView

@property (nonatomic, strong) PLFormDateFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic, readonly) UILabel *placeholderLabel;
@property (nonatomic, readonly) UILabel *valueLabel;
@property (nonatomic, readonly) UIDatePicker *datePicker;

@property (nonatomic) /*IBInspectable*/ NSString *placeholder;
@property (nonatomic) UIEdgeInsets contentInsets;

-(void)selectedDateDidChange;
-(void)updateWithElement:(PLFormDateFieldElement*)element;

@end
