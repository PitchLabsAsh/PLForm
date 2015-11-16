//
//  PLExtras-UIView.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (PLExtras)

- (BOOL)hasConstraintsForView:(UIView*)view;
- (void)removeConstraintsForView:(UIView*)view;

@end

