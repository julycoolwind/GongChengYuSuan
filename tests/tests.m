//
//  tests.m
//  tests
//
//  Created by linx on 13-5-17.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import "tests.h"
#import "GCYSCalculator.h"

@implementation tests

- (void)setUp
{
    [super setUp];
    
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];

}

- (void)testExample
{
    calculator = [[GCYSCalculator alloc] init];
    [calculator initialize];
    STAssertEquals(14.469999f, [calculator calculat:60000 indexCodeIs:0],@"计算60000总价的所有收费合计出错");
    //STFail(@"Unit tests are not implemented yet in tests");
}

@end
