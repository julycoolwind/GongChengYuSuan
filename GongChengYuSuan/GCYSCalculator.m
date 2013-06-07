//
//  GCYSCalculator.m
//  GongChengYuSuan
//
//  Created by linx on 13-5-15.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import "GCYSCalculator.h"
#import "GCYSCalculatorCell.h"
@implementation GCYSCalculator
-(GCYSCalculatorCell *)createCellWith:(GCYSCalculatorCell *)nextCell low:(int)low hight:(int)hight fact:(float)fact{
    GCYSCalculatorCell *result = [[GCYSCalculatorCell alloc] init];
    [result initWithNextCell:nextCell low:low hight:hight fact:fact];
    return result;
}

-(id)init{
    self = [super init];
    calculatorStrateges = [[NSArray alloc] initWithArray:
                           [NSArray arrayWithObjects:
                                [NSArray arrayWithObjects:@0.001,@0.0009,@0.0008,@0.0006,@0.0004,@0.0002,@0.0001, nil],
                                [NSArray arrayWithObjects:@0.002,@0.0018,@0.0016,@0.0015,@0.001,@0.0008,@0.0005, nil],
                                [NSArray arrayWithObjects:@0.0035,@0.0032,@0.003,@0.0022,@0.002,@0.0018,@0.0015, nil],
                                [NSArray arrayWithObjects:@0.0035,@0.0033,@0.003,@0.0025,@0.002,@0.0015,@0.001, nil],
                                [NSArray arrayWithObjects:@0.002,@0.0018,@0.0016,@0.0015,@0.0014,@0.0012,@0.001, nil],
                                [NSArray arrayWithObjects:@0.004,@0.0035,@0.003,@0.0028,@0.0025,@0.0023,@0.0018, nil],
                                [NSArray arrayWithObjects:@0.002,@0.0015,@0.0012,@0.0011,@0.001,@0.0008,@0.0006, nil],
                                [NSArray arrayWithObjects:@0.004,@0.0035,@0.003,@0.0025,@0.002,@0.0015,@0.001, nil],
                                [NSArray arrayWithObjects:@0.012,@0.01,@0.008,@0.007,@0.006,@0.005,@0.0035, nil],
                                [NSArray arrayWithObjects:@0.01,@0.009,@0.008,@0.007,@0.006,@0.005,@0.004, nil],
                            nil]];
    return self;
}

-(float)floatFactorOfStratege:(int)strategeIndex at:(int)index{
    return [[[calculatorStrateges objectAtIndex:strategeIndex] objectAtIndex:index] floatValue];
}


-(void)initialize{
    self.Cells = [[NSMutableArray alloc] initWithCapacity:10];
    //把决定是否交给下一个Cell计算的职责放在calculator中，每个cell只负责自己逻辑的计算，就不用建那么多cell了。
    GCYSCalculatorCell *cell7 = nil;
    GCYSCalculatorCell *cell6 = nil;
    GCYSCalculatorCell *cell5 = nil;
    GCYSCalculatorCell *cell4 = nil;
    GCYSCalculatorCell *cell3 = nil;
    GCYSCalculatorCell *cell2 = nil;
    GCYSCalculatorCell *cell1 = nil;
    for (int index = 0; index<10; index++) {
        cell7 = [self createCellWith:nil low:50000 hight:0 fact:[self floatFactorOfStratege:index at:6]];
        cell6 = [self createCellWith:cell7 low:10000 hight:50000 fact:[self floatFactorOfStratege:index at:5]];
        cell5 = [self createCellWith:cell6 low:5000 hight:10000 fact:[self floatFactorOfStratege:index at:4]];
        cell4 = [self createCellWith:cell5 low:2000 hight:5000 fact:[self floatFactorOfStratege:index at:3]];
        cell3 = [self createCellWith:cell4 low:500 hight:2000 fact:[self floatFactorOfStratege:index at:2]];
        cell2 = [self createCellWith:cell3 low:200 hight:500 fact:[self floatFactorOfStratege:index at:1]];
        cell1 = [self createCellWith:cell2 low:0 hight:200 fact:[self floatFactorOfStratege:index at:0]];
        [self.Cells insertObject:cell1 atIndex:index];
    }
    
}
-(float)calculat:(float)base indexCodeIs:(int)index{
    return [[self.Cells objectAtIndex:index] calculat:base preResult:0];
    
}
@end
