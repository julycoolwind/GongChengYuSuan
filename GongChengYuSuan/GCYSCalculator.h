//
//  GCYSCalculator.h
//  GongChengYuSuan
//
//  Created by linx on 13-5-15.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCYSCalculator : NSObject{
    NSArray *calculatorStrateges;
}
@property (strong,nonatomic) NSMutableArray *Cells;
-(void)initialize;
-(float)calculat:(float)base indexCodeIs:(int)index;
@end
