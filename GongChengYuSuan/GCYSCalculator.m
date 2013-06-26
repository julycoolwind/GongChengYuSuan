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
-(GCYSCalculatorCell *)createCellWith:(GCYSCalculatorCell *)nextCell low:(int)low hight:(int)hight strategeIndex:(int)strategeIndex factorIndex:(int)factorIndex{
    GCYSCalculatorCell *result = [[GCYSCalculatorCell alloc] init];
    [result initWithNextCell:nextCell low:low hight:hight strategeIndex:strategeIndex factorIndex:factorIndex];
    return result;
}

-(id)init{
    self = [super init];
    
    return self;
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
        cell7 = [self createCellWith:nil low:50000 hight:0 strategeIndex:index factorIndex:6];
        cell6 = [self createCellWith:cell7 low:10000 hight:50000 strategeIndex:index factorIndex:5];
        cell5 = [self createCellWith:cell6 low:5000 hight:10000 strategeIndex:index factorIndex:4];
        cell4 = [self createCellWith:cell5 low:2000 hight:5000 strategeIndex:index factorIndex:3];
        cell3 = [self createCellWith:cell4 low:500 hight:2000 strategeIndex:index factorIndex:2];
        cell2 = [self createCellWith:cell3 low:200 hight:500 strategeIndex:index factorIndex:1];
        cell1 = [self createCellWith:cell2 low:0 hight:200 strategeIndex:index factorIndex:0];
        [self.Cells insertObject:cell1 atIndex:index];
    }
    
}
-(float)calculat:(float)base indexCodeIs:(int)index insertResultIn:(NSArray *) resultArray{
    return [[self.Cells objectAtIndex:index] calculat:base preResult:0 insertResultIn:resultArray];
    
}
@end
