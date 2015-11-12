//
//  PLStyleSettings.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface PLStyleSettings : NSObject

+ (PLStyleSettings *)sharedInstance;

@property (strong, readwrite) UIFont *h1Font;
@property (strong, readwrite) UIFont *h2Font;
@property (strong, readwrite) UIFont *h3Font;

@property (strong, readwrite) UIColor *seperatorColor;

// something that can be clicked
@property (strong, readwrite) UIColor *selectedColor;
@property (strong, readwrite) UIColor *highlightedColor;
@property (strong, readwrite) UIColor *unselectedColor;
@property (strong, readwrite) UIColor *backgroundColor;

@end
