//
//  PLExtras-UIView.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLExtras-UIView.h"

@implementation UIView (PLExtras)

- (BOOL)hasConstraintsForView:(UIView*)view;
{
    for (NSLayoutConstraint *constraint in self.constraints)
    {
        if ((constraint.firstItem == view) ||
            (constraint.secondItem == view))
        {
            return YES;
        }
    }
    return NO;
}

@end
