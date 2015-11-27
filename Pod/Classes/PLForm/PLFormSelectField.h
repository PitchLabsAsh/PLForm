//
//  PLFormSelectField.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLStyleView.h"
#import "PLFormElement.h"

@interface PLFormSelectFieldItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) UIImage *image;

+ (id)selectItemWithTitle:(NSString *)title value:(NSString*)value image:(UIImage*)image;

@end

@interface PLFormSelectFieldItemCell : UICollectionViewCell

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@end;

@interface PLFormSelectFieldElement : PLFormElement

+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values delegate:(id<PLFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;
+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values index:(NSInteger)index insertBlank:(BOOL)insertBlank delegate:(id<PLFormElementDelegate>)delegate;

+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title items:(NSArray*)items index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger originalIndex;
@property (nonatomic, assign) NSInteger insertBlank;
@property (nonatomic, retain) NSArray *values;

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat itemGutter;

@end


@interface PLFormSelectField : PLStyleView <UIPickerViewDataSource, UIPickerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

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
