//
//  PLNonFloatingExamplesViewController.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//


#import "PLNonFloatingExamplesViewController.h"
#import "PLFormDateField.h"
#import "PLFormSelectField.h"
#import "PLFormTextField.h"
#import "PLFormTextView.h"
#import "PLFormAutoCompleteField.h"
#import "PLFormPinField.h"
#import "PLFormValidator.h"

@interface PLNonFloatingExamplesViewController () <PLFormElementDelegate>
{
    PLFormTextFieldElement *textFieldElement;
    PLFormSelectFieldElement *selectFieldElement;
    PLFormDateFieldElement *dateFieldElement;
    PLFormTextViewElement *textViewElement;
    PLFormAutoCompleteFieldElement *autoCompleteElement;
    PLFormPinFieldElement *pinElement;
}

@property (nonatomic, strong) IBOutlet PLFormDateField *dateField;
@property (nonatomic, strong) IBOutlet PLFormSelectField *selectField;
@property (nonatomic, strong) IBOutlet PLFormTextField *textField;
@property (nonatomic, strong) IBOutlet PLFormTextView *textView;
@property (nonatomic, strong) IBOutlet PLFormAutoCompleteField *autoTextField;
@property (nonatomic, strong) IBOutlet PLFormPinField *pinField;

@end

@implementation PLNonFloatingExamplesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textFieldElement = [PLFormTextFieldElement textInputElementWithID:0 placeholderText:@"Question" value:nil delegate:self];
    selectFieldElement = [PLFormSelectFieldElement selectElementWithID:1 title:@"Select Option" values:@[@"1 minute",@"5 minutes",@"15 minutes",@"1 hour"] index:0 insertBlank:YES delegate:self];
    dateFieldElement = [PLFormDateFieldElement datePickerElementWithID:2 title:@"Enter a date" date:nil datePickerMode:UIDatePickerModeDate delegate:nil];
    textViewElement = [PLFormTextViewElement textViewElementWithID:3 placeholderText:@"Enter some text" value:nil delegate:nil];
    autoCompleteElement = [PLFormAutoCompleteFieldElement selectElementWithID:1 placeholderText:@"Select Option" values:@[@"Dog",@"Cat",@"Rabbity Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse"] delegate:self];
    autoCompleteElement.displayAllWhenBlank = YES;
    autoCompleteElement.indexRequired = YES;
    autoCompleteElement.clearsOnBeginEditing = YES;
    pinElement = [PLFormPinFieldElement pinFieldElementWithID:4 pinLength:5 delegate:self];

    if (self.prePopulate)
    {
        textFieldElement.value = @"Some text";
        selectFieldElement.index = 1;
        dateFieldElement.date = [NSDate date];
        textViewElement.value = @"A longer piece of text";
        autoCompleteElement.index = 1;
    }
    
    [_textField updateWithElement:textFieldElement];
    [_selectField updateWithElement:selectFieldElement];
    [_dateField updateWithElement:dateFieldElement];
    [_textView updateWithElement:textViewElement];
    [_autoTextField updateWithElement:autoCompleteElement];
    [_pinField updateWithElement:pinElement];
    
    PLConditionPresent *presentCondition = [[PLConditionPresent alloc] initWithLocalizedViolationString:NSLocalizedString(@"Please complete all fields", @"Please complete all fields")];
    textFieldElement.validator = [[PLValidator alloc] initWithCondition:presentCondition,nil];
    selectFieldElement.validator = [[PLValidator alloc] initWithCondition:presentCondition,nil];
    dateFieldElement.validator = [[PLValidator alloc] initWithCondition:presentCondition,nil];
    textViewElement.validator = [[PLValidator alloc] initWithCondition:presentCondition,nil];
    autoCompleteElement.validator = [[PLValidator alloc] initWithCondition:presentCondition,nil];
    
    self.formModel = @[textFieldElement, selectFieldElement, dateFieldElement, textViewElement, autoCompleteElement];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // create the model
}


@end
