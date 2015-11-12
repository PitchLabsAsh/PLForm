//
//  PLFormElement.m
//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormElement.h"

@implementation PLFormElement

+ (instancetype)elementWithID:(NSInteger)elementID delegate:(id<PLFormElementDelegate>)delegate
{
    PLFormElement *element = [[self class] new];
    element.elementID = elementID;
    element.delegate = delegate;
    return element;
}

// subclass's must implement this
-(NSString*)valueAsString
{
    return nil;
}

@end
