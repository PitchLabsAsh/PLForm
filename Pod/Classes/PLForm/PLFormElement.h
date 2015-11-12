//
//  PLFormElement.h
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class PLFormElement;

@protocol PLFormElementDelegate <UITextFieldDelegate, UITextViewDelegate>

@optional
- (void)formElementDidChangeValue:(PLFormElement *)formElement;
- (void)formElementDidEndEditing:(PLFormElement *)formElement;

@end


@interface PLFormElement : NSObject

// Designated initializer
+ (instancetype)elementWithID:(NSInteger)elementID delegate:(id<PLFormElementDelegate>)delegate;

// leave the validator as id so we are not dependant on the validator headers
@property (nonatomic, retain) id validator;
@property (nonatomic, assign) id<PLFormElementDelegate> delegate;
@property (nonatomic, assign) NSInteger elementID;

-(NSString*)valueAsString;

@end

