//
//  PLPinDot.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PLPinDotStateUnselected,
    PLPinDotStateHighlighted,
    PLPinDotStateSelected,
} PLPinDotState;


@interface PLFormPinDot : UIView

@property (nonatomic, assign) PLPinDotState state;

@property (nonatomic,strong) UIColor *unselectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *highlightedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *unselectedBorderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *selectedBorderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *highlightedBorderColor UI_APPEARANCE_SELECTOR;

-(void)setState:(PLPinDotState)state animated:(BOOL)animated;

@end
