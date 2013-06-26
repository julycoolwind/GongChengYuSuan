//
//  GCYSCalculatorCell.m
//  GongChengYuSuan
//
//  Created by linx on 13-5-15.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import "GCYSCalculatorCell.h"
@interface GCYSCalculatorCell()
@property int low;
@property int hight;
@property int strategeIndex;
@property int factorIndex;
@property (strong,nonatomic)GCYSCalculatorCell *nextCell;

@end
@implementation GCYSCalculatorCell

-(void)initWithNextCell:(GCYSCalculatorCell *)nextcell low:(int)low hight:(int)hight strategeIndex:(int)strategeIndex factorIndex:(int)fzctorIndex{
    self.low = low;
    self.hight = hight;
    self.nextCell = nextcell;
    self.strategeIndex = strategeIndex;
    self.factorIndex = fzctorIndex;
    calculatorStrateges = [[NSArray alloc] initWithArray:
                           [NSArray arrayWithObjects:
                            [NSMutableArray arrayWithObjects:@0.001,@0.0009,@0.0008,@0.0006,@0.0004,@0.0002,@0.0001, nil],
                            [NSMutableArray arrayWithObjects:@0.002,@0.0018,@0.0016,@0.0015,@0.001,@0.0008,@0.0005, nil],
                            [NSMutableArray arrayWithObjects:@0.0035,@0.0032,@0.003,@0.0022,@0.002,@0.0018,@0.0015, nil],
                            [NSMutableArray arrayWithObjects:@0.0035,@0.0033,@0.003,@0.0025,@0.002,@0.0015,@0.001, nil],
                            [NSMutableArray arrayWithObjects:@0.002,@0.0018,@0.0016,@0.0015,@0.0014,@0.0012,@0.001, nil],
                            [NSMutableArray arrayWithObjects:@0.004,@0.0035,@0.003,@0.0028,@0.0025,@0.0023,@0.0018, nil],
                            [NSMutableArray arrayWithObjects:@0.002,@0.0015,@0.0012,@0.0011,@0.001,@0.0008,@0.0006, nil],
                            [NSMutableArray arrayWithObjects:@0.004,@0.0035,@0.003,@0.0025,@0.002,@0.0015,@0.001, nil],
                            [NSMutableArray arrayWithObjects:@0.012,@0.01,@0.008,@0.007,@0.006,@0.005,@0.0035, nil],
                            [NSMutableArray arrayWithObjects:@0.01,@0.009,@0.008,@0.007,@0.006,@0.005,@0.004, nil],
                            nil]];
}

-(float)floatFactorOfStratege:(int)strategeIndex at:(int)index{
    return [[[calculatorStrateges objectAtIndex:strategeIndex] objectAtIndex:index] floatValue];
}

-(float)calculat:(float)base preResult:(float)preresult insertResultIn:(NSArray *) resultArray{
    float result =0;
    if(self.hight == 0){
        result = (base - self.low)*[self floatFactorOfStratege:self.strategeIndex at:self.factorIndex];
        [(NSMutableArray *)[resultArray objectAtIndex:self.strategeIndex] replaceObjectAtIndex:self.factorIndex withObject:[NSNumber numberWithFloat:result]] ;
        preresult += result;
        return preresult;
    }
    if(base<=self.hight){
        result = (base-self.low)*[self floatFactorOfStratege:self.strategeIndex at:self.factorIndex];
        [(NSMutableArray *)[resultArray objectAtIndex:self.strategeIndex] replaceObjectAtIndex:self.factorIndex withObject:[NSNumber numberWithFloat:result]] ;
    }else if (base > self.hight){
        result = (self.hight-self.low)*[self floatFactorOfStratege:self.strategeIndex at:self.factorIndex];
        [(NSMutableArray *)[resultArray objectAtIndex:self.strategeIndex] replaceObjectAtIndex:self.factorIndex withObject:[NSNumber numberWithFloat:result]] ;
        preresult += result;
        if(self.nextCell!=nil){
            result = [self.nextCell calculat:base preResult:preresult insertResultIn:resultArray];
        }else{
            result = (base - self.low)*[self floatFactorOfStratege:self.strategeIndex at:self.factorIndex];
            [(NSMutableArray *)[resultArray objectAtIndex:self.strategeIndex] replaceObjectAtIndex:self.factorIndex withObject:[NSNumber numberWithFloat:result]] ;
            result += preresult;
        }
    }
    
    return result;
}

@end
