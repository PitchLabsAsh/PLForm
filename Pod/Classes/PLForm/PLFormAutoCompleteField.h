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

+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<PLFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;


@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger originalIndex;
@property (nonatomic, retain) NSArray *values;
@property (nonatomic, assign) BOOL displayAllWhenBlank;
@property (nonatomic, assign) BOOL indexRequired;

@property (nonatomic, copy)  NSString* value;

@end


@interface PLFormAutoCompleteField : PLStyleView

@property (nonatomic, strong) PLFormAutoCompleteFieldElement* element;

@property (nonatomic, readonly) UITextField *textfield;
@property (nonatomic, readonly) UICollectionView *collectionView;

@property (nonatomic) /*IBInspectable*/ NSString *placeholder;
@property (nonatomic) UIEdgeInsets contentInsets;

-(void)updateWithElement:(PLFormAutoCompleteFieldElement*)element;
-(void)textFieldDidChange;

@end
