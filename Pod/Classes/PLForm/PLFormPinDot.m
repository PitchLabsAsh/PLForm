//
//  BBPinDot.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormPinDot.h"
#import "PLStyleSettings.h"

@implementation PLFormPinDot

-(void)setup
{
    self.layer.cornerRadius = self.bounds.size.width / 2.0f;
    self.layer.borderWidth = 1.0f;
    self.backgroundColor = [UIColor whiteColor];
    
    self.state = BBPinDotStateUnselected;
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


-(void)setState:(BBPinDotState)state
{
    [self setState:state animated:NO];
}

-(void)setState:(BBPinDotState)state animated:(BOOL)animated
{
    _state = state;
    
    void (^stateBlock)() = ^{
        switch (_state) {
                
            case BBPinDotStateUnselected:
                self.layer.borderColor = [[PLStyleSettings sharedInstance] unselectedColor].CGColor;
                self.backgroundColor = [UIColor clearColor];
                break;
            case BBPinDotStateHighlighted:
                self.layer.borderColor = [[PLStyleSettings sharedInstance] highlightedColor].CGColor;
                self.backgroundColor = [UIColor clearColor];
                break;
            case BBPinDotStateSelected:
                self.layer.borderColor = [[PLStyleSettings sharedInstance] selectedColor].CGColor;
                self.backgroundColor = [UIColor whiteColor];
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
