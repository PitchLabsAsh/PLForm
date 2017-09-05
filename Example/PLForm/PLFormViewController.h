//
//  PLFormViewController.h
//  PLForm
//
//  Created by Ash Thwaites on 11/03/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLFormViewController : UIViewController

@property (nonatomic, strong) NSArray *formModel;
@property (nonatomic, assign) BOOL prePopulate;
@property (nonatomic, assign) NSTextAlignment alignment;  // default is NSLeftTextAlignment

@end
