//
//  GCYSCalculatorCell.h
//  GongChengYuSuan
//
//  Created by linx on 13-5-15.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCYSCalculatorCell : NSObject{
    NSArray *calculatorStrateges;
}
-(float)calculat:(float)base preResult:(float)preresult insertResultIn:(NSArray *) resultArray;
-(void)initWithNextCell:(GCYSCalculatorCell *)nextcell low:(int)low hight:(int)hight strategeIndex:(int)strategeIndex factorIndex:(int)fzctorIndex;
@end
