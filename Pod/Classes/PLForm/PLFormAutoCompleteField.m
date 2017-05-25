//
//  PLFormAutoCompleteField.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLFormAutoCompleteField.h"
#import "PLExtras-UIView.h"

@import PureLayout;

@implementation PLAutoCompleteCell

-(id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        float sortaPixel = 1.0/[UIScreen mainScreen].scale;
        _separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sortaPixel, self.frame.size.height)];        
        _separatorView.userInteractionEnabled = NO;
        [_separatorView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_separatorView];
        
        // add the label, and the constraints to center it and margins to either side
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
        
        [_label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:4];
        [_label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:4];
        [_label autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
    }
    return self;
}

// attributes
-(void)setFont:(UIFont *)font
{
    _label.font = font;
}

-(UIFont*)font
{
    return _label.font;
}

-(void)setTextColor:(UIColor *)color
{
    _label.textColor = color;
}

-(UIColor *)textColor
{
    return _label.textColor;
}


@end


@implementation PLFormAutoCompleteFieldElement

+ (id)selectElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText values:(NSArray*)values delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormAutoCompleteFieldElement *element = [super elementWithID:elementID delegate:delegate];
    element.placeholderText = placeholderText;
    element.values = values;
    element.index = -1;
    element.originalIndex = -1;
    return element;
}

+ (id)selectElementWithID:(NSInteger)elementID placeholderText:(NSString *)placeholderText values:(NSArray*)values index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormAutoCompleteFieldElement *element = [self selectElementWithID:elementID placeholderText:placeholderText values:values delegate:delegate];
    element.index = index;
    element.originalIndex = index;
    return element;
}

-(NSString*)valueAsString
{
    
    NSString *string = self.value;
    
    if ( self.indexRequired)
    {
        string = nil;
        if ((self.index >=0) && (self.index < self.values.count))
        {
            string = self.values[self.index];
        }
    }

    return string;
}

@end


@interface PLFormAutoCompleteField () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;
    NSArray *autoCompleteSuggestions;
}

@property (nonatomic, readwrite) UITextField *textfield;
@property (nonatomic, readwrite) UICollectionView *collectionView;

@end


@implementation PLFormAutoCompleteField

@synthesize placeholderColor = _placeholderColor;

-(void)setup
{
    [super setup];
    
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    [_textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    _textfield.delegate = self;
    [self addSubview:_textfield];
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 44) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[PLAutoCompleteCell class] forCellWithReuseIdentifier:@"PLAutoCompleteCell"];
    _collectionView.backgroundColor = [UIColor lightGrayColor];

//    _collectionView.backgroundColor = [PLStyleSettings sharedInstance].unselectedColor;
    _textfield.inputAccessoryView = _collectionView;
    
    _contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);    
}


-(void)dealloc
{
    [self resignFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return [_textfield canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textfield becomeFirstResponder];
}

- (BOOL)canResignFirstResponder
{
    return [_textfield canResignFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textfield resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_textfield isFirstResponder];
}

// attributes
-(void)setFont:(UIFont *)font
{
    _textfield.font = font;
}

-(UIFont*)font
{
    return _textfield.font;
}

-(void)setTextColor:(UIColor *)color
{
    _textfield.textColor = color;
}

-(UIColor *)textColor
{
    return _textfield.textColor;
}

-(void)setPlaceholderColor:(UIColor *)color
{
    _placeholderColor = color;
    _textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textfield.placeholder attributes:@{NSForegroundColorAttributeName:_placeholderColor}];
}

-(UIColor*)placeholderColor
{
    return _placeholderColor;
}


- (void)setPlaceholder:(NSString *)placeholder
{
    if (_placeholderColor)
    {
        _textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textfield.placeholder attributes:@{NSForegroundColorAttributeName:_placeholderColor}];
    }
    else
    {
        [_textfield setPlaceholder:placeholder];
    }
}

- (NSString*)placeholder
{
    return _textfield.placeholder;
}

-(void)setText:(NSString *)text
{
    _textfield.text = text;
}

-(NSString*)text
{
    return _textfield.text;
}


-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_textfield];
    [self setNeedsUpdateConstraints];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    [self removeInsetConstraints];
}

- (void)updateConstraints
{
    if (![self hasConstraintsForView:_textfield] && self.superview)
    {
        [_textfield autoPinEdgesToSuperviewEdgesWithInsets:_contentInsets];
    }
    [super updateConstraints];
}


-(void)updateWithElement:(PLFormAutoCompleteFieldElement*)element
{
    self.element = element;
    self.placeholder = element.placeholderText;
    self.text = element.value;
    
    _textfield.text = [element valueAsString];
    _textfield.keyboardType = UIKeyboardTypeDefault;
    _textfield.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    _textfield.clearsOnBeginEditing = element.clearsOnBeginEditing;
    
    [self updateSuggestions];
    [_collectionView reloadData];
}



-(void)updateSuggestions
{
    NSPredicate *suggestPredicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@", _textfield.text];
    autoCompleteSuggestions = [self.element.values filteredArrayUsingPredicate:suggestPredicate];
    
    if ((_textfield.text.length == 0) && self.element.displayAllWhenBlank)
        autoCompleteSuggestions = self.element.values;
}

-(void)updateIndex
{
    NSPredicate *matchPredicate = [NSPredicate predicateWithFormat:@"self ==[c] %@", _textfield.text];
    self.element.index = [self.element.values  indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
        return [matchPredicate evaluateWithObject:obj];
    }];
    
    if (self.element.index == NSNotFound)//check this condition for the max integer value
    {
        self.element.index = -1;
    }
    self.element.value = _textfield.text;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.element.clearsOnBeginEditing)
    {
        [self textFieldDidChange];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange {
    // for now dont bother with another thread, or operstiaon queue
    [self updateSuggestions];
    [self updateIndex];
    [_collectionView reloadData];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // call the delegate to inform of value changed
    if ([self.element.delegate respondsToSelector:@selector(formElementDidEndEditing:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidEndEditing:self.element];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
{
    if (((self.element.index >=0) && (self.element.index < self.element.values.count)) || (_textfield.text.length == 0)  || self.element.index < 0)
        return YES;
    return NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (autoCompleteSuggestions)
        return autoCompleteSuggestions.count;
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLAutoCompleteCell *cell = (PLAutoCompleteCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PLAutoCompleteCell" forIndexPath:indexPath];
    cell.label.text = autoCompleteSuggestions[indexPath.row];
    cell.label.font = self.textfield.font;
    cell.separatorView.hidden = (indexPath.row==0);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // we know the font we are using, so calc the width of the font
    NSString *suggestion = autoCompleteSuggestions[indexPath.row];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.textfield.font, NSFontAttributeName, nil];
    CGSize suggestionSize = [suggestion sizeWithAttributes:attributes];
    return CGSizeMake(suggestionSize.width + 10, 44);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    _textfield.text = autoCompleteSuggestions[indexPath.row];
    [self updateIndex];
    if (self.element.index <0)
    {
        // wtf ?
        self.element.index = [self.element.values  indexOfObject:autoCompleteSuggestions[indexPath.row]];
    }

    [_textfield resignFirstResponder];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}

- (void)setAlignment:(NSTextAlignment)alignment {
    _alignment = alignment;
    self.textfield.textAlignment = alignment;
}


@end
