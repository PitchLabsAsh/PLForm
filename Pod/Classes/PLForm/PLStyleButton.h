//
//  PLStyleButton.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLStyleButton : UIButton

@property (nonatomic) IBInspectable UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) IBInspectable CGFloat borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic) IBInspectable CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

-(void)setup;

@end
