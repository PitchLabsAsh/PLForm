//
//  PLStyleView.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>

// would be agood to add some categories to UIVIew, UILabel etc that support a style name field so we can set "h1Font" in interfacebuilder

//cdIB_DESIGNABLE

@interface PLStyleView : UIView

@property (nonatomic) /*IBInspectable*/ UIColor *borderColor;
@property (nonatomic) /*IBInspectable*/ CGFloat borderWidth;
@property (nonatomic) /*IBInspectable*/ CGFloat cornerRadius;

-(void)setup;

@end
