//
//  PLStyleSettings.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLStyleSettings.h"

@implementation PLStyleSettings

+ (PLStyleSettings *)sharedInstance
{
    static dispatch_once_t once;
    static PLStyleSettings *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[PLStyleSettings alloc] init];
    });
    return sharedInstance;
}

// we should consider inheriting from base model.. this way we could configure default style from plist

- (id)init {
    self = [super init];
    if (self) {
        //        _mainColor = [UIColor colorWithHexString:@"#c1c6ca"];
        _h1Font = [UIFont fontWithName:@"Avenir-Roman" size:14];
        _h2Font = [UIFont fontWithName:@"Avenir-Roman" size:12];
        _h3Font = [UIFont fontWithName:@"Avenir-Light" size:12];
        
        _seperatorColor = [UIColor lightGrayColor];                  // 234,235,237
        _selectedColor = [UIColor blueColor];                   // 71,236,240
        _unselectedColor = [UIColor darkGrayColor];                 // 193,198,202
        _highlightedColor = [UIColor lightGrayColor];                 // 193,198,202
    }
    return self;
}

@end
