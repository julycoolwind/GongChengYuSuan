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
@property float fact;
@property (strong,nonatomic)GCYSCalculatorCell *nextCell;

@end
@implementation GCYSCalculatorCell

-(void)initWithNextCell:(GCYSCalculatorCell *)nextcell low:(int)low hight:(int)hight fact:(float)fact{
    self.low = low;
    self.hight = hight;
    self.nextCell = nextcell;
    self.fact = fact;
}

-(float)calculat:(float)base preResult:(float)preresult{
    float result =0;
    if(self.hight == 0){
        preresult += (base - self.low)*self.fact;
        return preresult;
    }
    if(base<=self.hight){
        result = (base-self.low)*self.fact;
    }else if (base > self.hight){
        preresult += (self.hight-self.low)*self.fact;
        if(self.nextCell!=nil){
            result = [self.nextCell calculat:base preResult:preresult];
        }else{
            result = (base - self.low)*self.fact;
            result += preresult;
        }
    }
    
    return result;
}

@end
