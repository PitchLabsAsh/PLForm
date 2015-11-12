//
//  BBPinDot.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BBPinDotStateUnselected,
    BBPinDotStateHighlighted,
    BBPinDotStateSelected,
} BBPinDotState;


@interface PLFormPinDot : UIView

@property (nonatomic, assign) BBPinDotState state;

-(void)setState:(BBPinDotState)state animated:(BOOL)animated;

@end
