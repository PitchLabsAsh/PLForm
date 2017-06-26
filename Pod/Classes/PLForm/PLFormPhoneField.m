//
//  PLFormPhoneField.m
//  Pods
//
//  Created by Ash Thwaites on 22/06/2017.
//
//

#import "PLFormPhoneField.h"
#import "PLExtras-UIView.h"

@import PureLayout;
@import libPhoneNumber_iOS;

@implementation PLFormPhoneFieldElement

+ (instancetype)phoneFieldElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText value:(NSString*)value delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormPhoneFieldElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.delegate = delegate;
    element.placeholderText = placeholderText;
    element.value = value;
    element.originalValue = value;
    
    NSLocale *locale = [NSLocale currentLocale];
    element.region = [locale objectForKey: NSLocaleCountryCode];
    return element;
}

-(NSString*)valueAsString
{
    NBPhoneNumberUtil *phoneUtil=[[NBPhoneNumberUtil alloc] init];
    NSError *error;
    NBPhoneNumber *myNumber = [phoneUtil parse:self.value defaultRegion:self.region error:&error];
    if (error == nil)
        return [phoneUtil format:myNumber numberFormat:NBEPhoneNumberFormatE164 error:&error];
    return nil;
}

@end


@implementation PLFormPhoneField
{
    NSMutableDictionary *placeholderAttributes;
    NBPhoneNumberUtil *phoneUtil;
    NSDictionary *regionMappings;
    NSArray *sortedRegionNames;
    
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;
}

-(void)setup
{
    [super setup];
    [self buildRegions];

    // hidden textfield to trigger the picker...
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;

    CGRect frame = self.bounds;
    frame.origin.x = 75;
    _numberTextfield = [[UITextField alloc] initWithFrame:frame];
    [_numberTextfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _numberTextfield.delegate = self;
    _numberTextfield.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_numberTextfield];
    
    frame.origin.x = 0;
    frame.size.width = 60;
    _regionTextfield = [[UITextField alloc] initWithFrame:frame];
    [_regionTextfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _regionTextfield.delegate = self;
    _regionTextfield.hidden = YES;
    _regionTextfield.inputView = _pickerView;
    
    [self addSubview:_regionTextfield];

    
    _regionLabel = [[UILabel alloc] initWithFrame:frame];
    [self addSubview:_regionLabel];
    
    _contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    placeholderAttributes = [NSMutableDictionary dictionaryWithCapacity:2];
    
    insideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapInside:)];
    [_regionLabel addGestureRecognizer:insideTapGestureRecognizer];
    [_regionLabel setUserInteractionEnabled:YES];
    outsideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOutside:)];
    
}

-(NSString*)descritionForRegion:(NSString*)region
{
    id countryDictionaryInstance = [NSDictionary dictionaryWithObject:region forKey:NSLocaleCountryCode];
    NSString *identifier = [NSLocale localeIdentifierFromComponents:countryDictionaryInstance];
    NSString *country = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
    if (country)
    {
        NSNumber *cc = [phoneUtil getCountryCodeForRegion:region];
        return [NSString stringWithFormat:@"%@ - +%@",country,cc.stringValue];
    }
    return nil;
}

-(void)buildRegions
{
    phoneUtil = [[NBPhoneNumberUtil alloc] init];

    // build the array of regions to select from
    NSArray *regions = [phoneUtil getSupportedRegions];
    NSMutableArray *regionNames = [NSMutableArray arrayWithCapacity:regions.count];
    NSMutableDictionary *regionMap = [NSMutableDictionary dictionaryWithCapacity:regions.count];
    for (NSString *region in regions)
    {
        NSString *regionDesc = [self descritionForRegion:region];
        if (regionDesc)
        {
            [regionNames addObject:regionDesc];
            regionMap[regionDesc] = region;
        }
    }
    regionMappings = regionMap;
    sortedRegionNames = [regionNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
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
    _regionLabel.font = font;
}

-(UIFont*)font
{
    return _numberTextfield.font;
}

-(void)setTextColor:(UIColor *)color
{
    _numberTextfield.textColor = color;
    _regionLabel.textColor = color;
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
    [self removeConstraintsForView:_regionLabel];
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
        // lets calcualte the width of a 4 digit phone prefix using the given font
        
        if (![self hasConstraintsForView:_numberTextfield])
        {
            UIEdgeInsets numberInsets = _contentInsets;
            numberInsets.left += 60;
            [_numberTextfield autoPinEdgesToSuperviewEdgesWithInsets:numberInsets];
        }
        
        if (![self hasConstraintsForView:_regionLabel])
        {
            [_regionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
            [_regionLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:_contentInsets.top];
            [_regionLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:_contentInsets.bottom];
            [_regionLabel autoSetDimension:ALDimensionWidth toSize:50];

//            [_regionLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_numberTextfield];
//            [_regionLabel al_alignAttribute:ALAttributeBaseline toView:_numberTextfield forAxis:ALAxisHorizontal];            
        }
    }
    [super updateConstraints];
}


-(void)updateWithElement:(PLFormPhoneFieldElement*)element
{
    self.element = element;
    self.placeholder = element.placeholderText;

    // if we have a value.. attempt to extract the region
    if (element.region == nil)
    {
        NSLocale *locale = [NSLocale currentLocale];
        element.region  = [locale objectForKey: NSLocaleCountryCode];
    }
    
    // otherwise..
    if (element.value == nil)
    {
        // select the default region
        NSString *regionDesc = [self descritionForRegion:element.region];
        if (regionDesc)
        {
            NSInteger idx = [sortedRegionNames indexOfObject:regionDesc];
            if (idx != NSNotFound)
            {
                [_pickerView selectRow:idx inComponent:0 animated:NO];
                [self pickerView:_pickerView didSelectRow:idx inComponent:0];
            }
        }
    }
    
    
    self.text = element.value;
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
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (void)onTapInside:(UIGestureRecognizer*)sender
{
    [_regionTextfield becomeFirstResponder];
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow addGestureRecognizer:outsideTapGestureRecognizer];
}

- (void)onTapOutside:(UIGestureRecognizer*)sender
{
    [_regionTextfield resignFirstResponder];
    [sender.view removeGestureRecognizer:outsideTapGestureRecognizer];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}


#pragma mark -
#pragma mark Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *regionName = sortedRegionNames[row];
    NSString *region = regionMappings[regionName];
    NSNumber *cc = [phoneUtil getCountryCodeForRegion:region];
    
    self.element.region = region;
    _regionLabel.text = [NSString stringWithFormat:@"+%@",cc.stringValue];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return sortedRegionNames.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return sortedRegionNames[row];
}




@end
