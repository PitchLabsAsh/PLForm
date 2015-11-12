//  PLForm
//
//  Created by Ash Thwaites on 11/12/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PLCondition.h"


#pragma mark - Condition collection protocol

@class PLConditionCollection;

@protocol PLConditionCollectionProtocol <NSObject>

@required

- (void)addCondition:(id <PLConditionProtocol>)condition;
- (void)removeCondition:(id <PLConditionProtocol>)condition;
- (void)removeConditionAtIndex:(NSUInteger)index;
- (PLCondition *)conditionAtIndex:(NSUInteger)index;

- (void)removeAllConditions;

@end


#pragma mark - Condition collection interface


@interface PLConditionCollection : NSObject <PLConditionCollectionProtocol,
                                              NSFastEnumeration>
{
    NSMutableArray *_array;
}

- (void)addCondition:(id <PLConditionProtocol>)condition;
- (void)removeCondition:(id <PLConditionProtocol>)condition;
- (void)removeConditionAtIndex:(NSUInteger)index;
- (PLCondition *)conditionAtIndex:(NSUInteger)index;

- (void) removeAllConditions;

@property (nonatomic, assign, readonly) NSUInteger count;


@end
