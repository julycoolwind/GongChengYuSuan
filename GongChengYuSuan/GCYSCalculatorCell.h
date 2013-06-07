//
//  GCYSCalculatorCell.h
//  GongChengYuSuan
//
//  Created by linx on 13-5-15.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCYSCalculatorCell : NSObject
-(float)calculat:(float)base preResult:(float)preresult;
-(void)initWithNextCell:(GCYSCalculatorCell *)nextcell low:(int)low hight:(int)hight fact:(float)fact;
@end
