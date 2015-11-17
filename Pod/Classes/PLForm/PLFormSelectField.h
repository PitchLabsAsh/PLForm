//
//  PLFormSelectField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLStyleView.h"
#import "PLFormElement.h"

@interface PLFormSelectFieldElement : PLFormElement

+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values delegate:(id<PLFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values index:(NSInteger)index insertBlank:(BOOL)insertBlank delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger originalIndex;
@property (nonatomic, assign) NSInteger insertBlank;
@property (nonatomic, retain) NSArray *values;

@end


@interface PLFormSelectField : PLStyleView <UIPickerViewDataSource, UIPickerViewDelegate >

@property (nonatomic, strong) PLFormSelectFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *valueLabel;
@property (nonatomic, readonly) UIPickerView *pickerView;

@property (nonatomic) NSString *title;
@property (nonatomic) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *valueFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *valueColor UI_APPEARANCE_SELECTOR;


-(void)removeInsetConstraints;
-(void)updateWithElement:(PLFormSelectFieldElement*)element;

@end
