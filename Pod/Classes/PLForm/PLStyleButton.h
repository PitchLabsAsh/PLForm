//
//  PLStyleButton.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE

@interface PLStyleButton : UIButton

@property (nonatomic) /*IBInspectable*/ UIColor *borderColor;
@property (nonatomic) /*IBInspectable*/ CGFloat borderWidth;
@property (nonatomic) /*IBInspectable*/ CGFloat cornerRadius;

-(void)setup;

@end
