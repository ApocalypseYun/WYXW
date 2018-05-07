//
//  LruQueue.h
//  WYXW
//
//  Created by 刘冠中 on 2018/4/24.
//  Copyright © 2018年 刘冠中. All rights reserved.
//

#import <Foundation/Foundation.h>


static int count = 0;
static id first;
static id last;

@interface LruQueue : NSObject

extern int count;
extern id first;
extern id last;
@property (weak,nonatomic) NSString* str;
@property (weak,nonatomic) LruQueue* up;
@property (weak,nonatomic) LruQueue* next;

+(NSString*) add:(NSString*) stradd;
+(NSString*) del;
+(void) change:(NSString*) strchange;

@end
