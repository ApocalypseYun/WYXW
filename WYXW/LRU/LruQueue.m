//
//  LruQueue.m
//  WYXW
//
//  Created by 刘冠中 on 2018/4/24.
//  Copyright © 2018年 刘冠中. All rights reserved.
//

#import "LruQueue.h"

@implementation LruQueue

+(NSString*)add:(NSString *)stradd{
    ++count;
    if(count>30){
        return [LruQueue del];
    }
    LruQueue *add=[LruQueue new];
    add.str = stradd;
    if(count==1)
    {
        last = add;
        add.up=nil;
        add.next=nil;
    }
    else{
        add.next=first;
        add.next.up=add;
    }
    add.up=nil;
    first = add;
    return stradd;
    
}

+(NSString*) del{
    
    LruQueue *tmp = last;
    last = tmp.up;
    tmp.up.next=nil;
    return tmp.str;
}

+(void)change:(NSString*) strchange{
    
    LruQueue *tmp = first;
    //find
    while(![tmp.str isEqualToString:strchange]){
        tmp=tmp.next;
    }
    
    tmp.up.next=tmp.next;
    tmp.next.up=tmp.up;
    
    tmp.up=nil;
    tmp.next=first;
    tmp.next.up=tmp;
    first=tmp;
    
}

@end
