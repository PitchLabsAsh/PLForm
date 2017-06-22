//
//  PLFormPhoneField.h
//  Pods
//
//  Created by Ash Thwaites on 22/06/2017.
//
//

#import <PLForm/PLForm.h>

@interface PLFormPhoneFieldElement : PLFormElement

+ (instancetype)phoneFieldElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString*)value delegate:(id<PLFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* placeholderText;
@property (nonatomic, copy) NSString* originalValue;

@end


@interface PLFormPhoneField : PLStyleView <UITextFieldDelegate>

@property (nonatomic, readonly) UITextField *numberTextfield;
@property (nonatomic, readonly) UITextField *regionTextfield;
@property (nonatomic, readonly) UIPickerView *pickerView;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *placeholder;

@property (nonatomic) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;

// placeholde font can get overridden, so set font first then placeholder font
// TODO add a specific placeholder label rather than relying on the textfield placeholder
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *placeholderFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

-(void)removeInsetConstraints;
-(void)textFieldDidChange;
-(void)updateWithElement:(PLFormPhoneFieldElement*)element;

@end
