//
//  PLFormAutoCompleteField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLStyleView.h"
#import "PLFormElement.h"

@interface PLFormAutoCompleteFieldElement : PLFormElement

+ (id)selectElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText values:(NSArray*)values delegate:(id<PLFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText values:(NSArray*)values index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;


@property (nonatomic, copy) NSString *placeholderText;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger originalIndex;
@property (nonatomic, retain) NSArray *values;
@property (nonatomic, assign) BOOL displayAllWhenBlank;
@property (nonatomic, assign) BOOL indexRequired;
@property (nonatomic, assign) BOOL clearsOnBeginEditing;

@property (nonatomic, copy)  NSString* value;

@end


@interface PLAutoCompleteCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@end;

@interface PLFormAutoCompleteField : PLStyleView

@property (nonatomic, strong) PLFormAutoCompleteFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic, readonly) UICollectionView *collectionView;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *placeholder;
@property (nonatomic) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSTextAlignment alignment;  // default is NSLeftTextAlignment

@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *placeholderFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

-(void)removeInsetConstraints;
-(void)updateWithElement:(PLFormAutoCompleteFieldElement*)element;
-(void)textFieldDidChange;

@end
