//
//  PLFormTextView.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLStyleView.h"
#import "PLFormElement.h"

@interface PLFormTextViewElement : PLFormElement

+ (instancetype)textViewElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* originalValue;
@property (nonatomic, copy) NSString* placeholderText;

@end


@interface PLFormTextView : PLStyleView <UITextViewDelegate>

@property (nonatomic, strong) PLFormTextViewElement* element;

@property (nonatomic, readonly) UITextView *textview;
@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic) NSString *text;
@property (nonatomic) NSString *placeholder;
@property (nonatomic) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSTextAlignment alignment;  // default is NSLeftTextAlignment

@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

-(void)removeInsetConstraints;
-(void)updateWithElement:(PLFormTextViewElement*)element;

@end
