//
//  PLPinDot.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormPinDot.h"

@implementation PLFormPinDot

-(void)setup
{
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
    self.layer.borderWidth = 1.0f;    
    
    _unselectedColor = [UIColor blackColor];
    _highlightedColor = [UIColor darkGrayColor];
    _selectedColor = [UIColor whiteColor];
    _unselectedBorderColor = [UIColor blackColor];
    _highlightedBorderColor = [UIColor darkGrayColor];
    _selectedBorderColor = [UIColor whiteColor];
    
    self.state = PLPinDotStateUnselected;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
}


-(void)setState:(PLPinDotState)state
{
    [self setState:state animated:NO];
}

-(void)setState:(PLPinDotState)state animated:(BOOL)animated
{
    _state = state;
    
    void (^stateBlock)() = ^{
        switch (_state) {
                
            case PLPinDotStateUnselected:
                self.layer.borderColor = self.unselectedBorderColor.CGColor;
                self.backgroundColor = self.unselectedColor;
                break;
            case PLPinDotStateHighlighted:
                self.layer.borderColor = self.highlightedBorderColor.CGColor;
                self.backgroundColor = self.highlightedColor;
                break;
            case PLPinDotStateSelected:
                self.layer.borderColor = self.selectedBorderColor.CGColor;
                self.backgroundColor = self.selectedColor;
                break;
            default:
                break;
        }
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:stateBlock
                         completion:nil];
    }
    else
    {
        stateBlock();
    }
}

@end
