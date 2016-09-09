//
//  PLFormSelectField.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormSelectField.h"
#import "PLExtras-UIView.h"

@import PureLayout;

@implementation PLFormSelectFieldItemCell

-(id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {        
        
        // add the label, and the constraints to center it and margins to either side
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;

        float sortaPixel = 1.0/[UIScreen mainScreen].scale;
        _separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sortaPixel, self.frame.size.height)];
        _separatorView.userInteractionEnabled = NO;
        [_separatorView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_separatorView];
        
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_imageView,_label]];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 8;
        [self.contentView addSubview:_stackView];
        
        [_stackView autoCenterInSuperview];
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

@implementation PLFormSelectFieldItem

+ (id)selectItemWithTitle:(NSString *)title value:(NSString*)value image:(UIImage*)image;
{
    PLFormSelectFieldItem *item = [[self class] new];
    item.title = title;
    item.value = value;
    item.image = image;
    return item;
}

@end


@implementation PLFormSelectFieldElement

+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormSelectFieldElement *element = [super elementWithID:elementID delegate:delegate];
    element.title = title;
    element.values = values;
    element.index = -1;
    element.originalIndex = -1;
    return element;
}

+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormSelectFieldElement *element = [self selectElementWithID:elementID title:title values:values delegate:delegate];
    element.index = index;
    element.originalIndex = index;
    return element;
}

+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title values:(NSArray*)values index:(NSInteger)index insertBlank:(BOOL)insertBlank delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormSelectFieldElement *element = [super elementWithID:elementID delegate:delegate];
    element.title = title;
    element.values = values;
    element.index = -1;
    element.originalIndex = -1;
    element.insertBlank = insertBlank;
    return element;
}

+ (id)selectElementWithID:(NSInteger)elementID title:(NSString *)title items:(NSArray*)items index:(NSInteger)index delegate:(id<PLFormElementDelegate>)delegate;
{
    PLFormSelectFieldElement *element = [super elementWithID:elementID delegate:delegate];
    element.title = title;
    element.items = items;
    element.index = index;
    element.originalIndex = -1;
    return element;
}

-(NSString*)valueAsString
{
    if (self.items && (self.index >=0) && (self.index < self.items.count))
    {
        PLFormSelectFieldItem *item = self.items[self.index];
        return item.value;
    }
    if ((self.index >=0) && (self.index < self.values.count))
        return [self.values objectAtIndex:self.index];
    return nil;
}

@end


@interface PLFormSelectField () 
{
    UITapGestureRecognizer *insideTapGestureRecognizer;
    UITapGestureRecognizer *outsideTapGestureRecognizer;
}

@property (nonatomic, readwrite) UITextField *textfield;
@property (nonatomic, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) UILabel *valueLabel;
@property (nonatomic, readwrite) UIPickerView *pickerView;
@property (nonatomic, readwrite) UICollectionView *collectionView;

@end


@implementation PLFormSelectField

-(void)setup
{
    [super setup];
    
    // create the value label
    // create the value label
    _valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _valueLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_valueLabel];
    
    // create a title label
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    // hidden textfield to trigger the picker...
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.showsSelectionIndicator = YES;

    // create the alternative collection view we can use instead
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 224) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[PLFormSelectFieldItemCell class] forCellWithReuseIdentifier:@"PLFormSelectFieldItemCell"];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _textfield = [[UITextField alloc] initWithFrame:self.bounds];
    _textfield.hidden = YES;
    [self addSubview:_textfield];

    _contentInsets = UIEdgeInsetsMake(2, 10, 2, 10);
    
    insideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapInside:)];
    [self addGestureRecognizer:insideTapGestureRecognizer];
    outsideTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOutside:)];
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
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow removeGestureRecognizer:outsideTapGestureRecognizer];
    return [_textfield resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_textfield isFirstResponder];
}


// attributes
-(void)setFont:(UIFont *)font
{
    _titleLabel.font = font;
}

-(UIFont*)font
{
    return _titleLabel.font;
}

-(void)setTextColor:(UIColor *)color
{
    _titleLabel.textColor = color;
}

-(UIColor *)textColor
{
    return _titleLabel.textColor;
}

-(void)setValueFont:(UIFont *)font
{
    _valueLabel.font = font;
}

-(UIFont*)valueFont
{
    return _valueLabel.font;
}

-(void)setValueColor:(UIColor *)color
{
    _valueLabel.textColor = color;
}

-(UIColor *)valueColor
{
    return _valueLabel.textColor;
}

-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

-(NSString*)title
{
    return _titleLabel.text;
}


// handle constraints

-(void)removeInsetConstraints
{
    [self removeConstraintsForView:_titleLabel];
    [self removeConstraintsForView:_valueLabel];
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
        if (![self hasConstraintsForView:_valueLabel])
        {
            [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
            [_valueLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
            [_valueLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        }
        
        if (![self hasConstraintsForView:_titleLabel])
        {
            [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:_contentInsets.left];
            [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:_contentInsets.right];
            [_titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:0];
        }
    }
    
    [super updateConstraints];
}

-(void)dealloc
{
    [self resignFirstResponder];
}


-(void)updateWithElement:(PLFormSelectFieldElement*)element
{
    self.element = element;
    self.title = element.title;
    self.valueLabel.text = [element valueAsString];
    
    if (element.items)
    {
        // TODO: ensure the collectionview is pre-scrolled to show the currently selected item
        // possibly add some way to show its selected too
        [_textfield setInputView:_collectionView];
    }
    else
    {
        if ((element.index >=0) && (element.index < element.values.count))
        {
            NSInteger adjustedIndex = (element.insertBlank) ? element.index+1:element.index;
            [_pickerView selectRow:adjustedIndex inComponent:0 animated:NO];
        }
        [_textfield setInputView:_pickerView];
    }
}

- (void)onTapInside:(UIGestureRecognizer*)sender
{
    [_textfield becomeFirstResponder];
    UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
    [frontWindow addGestureRecognizer:outsideTapGestureRecognizer];
}

- (void)onTapOutside:(UIGestureRecognizer*)sender
{
    [_textfield resignFirstResponder];
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
    NSInteger adjustedRow = (_element.insertBlank) ? row-1:row;
    _valueLabel.text = (adjustedRow<0) ? nil : _element.values[adjustedRow];
    _element.index = adjustedRow;

    if ([_element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)_element.delegate formElementDidChangeValue:_element];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return (_element.insertBlank) ? _element.values.count+1:_element.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSInteger adjustedRow = (_element.insertBlank) ? row-1:row;
    return (adjustedRow<0) ? @"" : _element.values[adjustedRow];
}



#pragma mark -
#pragma mark Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.element.items.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLFormSelectFieldItemCell *cell = (PLFormSelectFieldItemCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PLFormSelectFieldItemCell" forIndexPath:indexPath];
    PLFormSelectFieldItem *item = self.element.items[indexPath.row];
    cell.label.text = item.title;
    cell.label.font = self.textfield.font;
    cell.imageView.image = item.image;
    cell.separatorView.hidden = (indexPath.row==0);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // we know the font we are using, so calc the width of the font
    CGFloat width = fmax(150,self.element.itemWidth);
    return CGSizeMake(width,224);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    PLFormSelectFieldItem *item = self.element.items[indexPath.row];
    
    _valueLabel.text = item.value;
    _element.index = indexPath.row;
    
    [_textfield resignFirstResponder];
    if ([self.element.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<PLFormElementDelegate>)self.element.delegate formElementDidChangeValue:self.element];
    }
}


@end
