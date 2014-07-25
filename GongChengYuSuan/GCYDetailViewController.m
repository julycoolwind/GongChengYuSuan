//
//  GCYDetailViewController.m
//  GongChengYuSuan
//
//  Created by linx on 13-6-12.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import "GCYDetailViewController.h"
#import "GCYSAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@interface GCYDetailViewController (){
    int CELL_HIGHT;
    int CELL_WIDTH;
    int LEFT_HEAD_WIDTH;
    CGPoint TOP_LEFT_POINT;
    NSArray *LEFT_HEAD_ARRAY;
    NSArray *TOP_HEAD_ARRAY;
    CGRect LEFT_HEAD_CELL_FRAM;
    CGRect TOP_HEAD_CELL_FRAM;
}
@property NSArray *resultArrray;
@end

@implementation GCYDetailViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withResutArray:(NSArray *)resultArray{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        CELL_HIGHT = 60;
        CELL_WIDTH = 100;
        LEFT_HEAD_WIDTH = 120;
        TOP_LEFT_POINT = CGPointMake(0, 0);
        LEFT_HEAD_ARRAY = [NSArray arrayWithObjects:@"投资估算编制或审核", @"设计概算编制或审核",@"工程预算编制或审核",@"招标工程量清单编制或审核",@"工程量清单计价文件编制或审核",@"工程结算编制",@"竣工决算编审",@"基本费",@"施工阶段全过程造价控制",@"工程造价争议鉴证",nil];
        TOP_HEAD_ARRAY = [NSArray arrayWithObjects:@"x≤200",@"200<x≤500",@"500<x≤2000",@"2000<x≤5000",@"5000<x≤10000",@"10000 <x≤ 50000",@"x>50000",@"小计", nil];
        LEFT_HEAD_CELL_FRAM = CGRectMake(TOP_LEFT_POINT.x, TOP_LEFT_POINT.y, LEFT_HEAD_WIDTH, CELL_HIGHT);
        TOP_HEAD_CELL_FRAM = CGRectMake(TOP_LEFT_POINT.x, TOP_LEFT_POINT.y, CELL_WIDTH, CELL_HIGHT);
        [self.navigationItem setHidesBackButton:YES];
        self.resultArrray = resultArray;
        self.title = @"详细结果表";
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //检测屏幕方向变化的通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(handlerMethod:)
                               name:@"UIDeviceOrientationDidChangeNotification"
                             object:nil];
    [self.navigationController setNavigationBarHidden:YES];
    
    CGRect rx = [ UIScreen mainScreen ].bounds;
    
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, CELL_HIGHT, LEFT_HEAD_WIDTH, rx.size.width-CELL_HIGHT-20)];
    self.leftTable.dataSource = self;
    self.leftTable.delegate = self;
    [self.view addSubview:self.leftTable];
    
    CGRect topRect = CGRectMake(LEFT_HEAD_WIDTH, 0, rx.size.height-LEFT_HEAD_WIDTH, CELL_HIGHT);
    self.topTable = [[UITableView alloc] initWithFrame:topRect];
    self.topTable.dataSource = self;
    self.topTable.delegate = self;
    self.topTable.transform = CGAffineTransformMakeRotation(M_PI/-2);
    self.topTable.frame = topRect;
    [self.view addSubview:self.topTable];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(LEFT_HEAD_WIDTH, CELL_HIGHT, rx.size.height-LEFT_HEAD_WIDTH, rx.size.width-CELL_HIGHT-20)];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(CELL_WIDTH*8, CELL_HIGHT*10);
    self.scrollView.bounces = NO;
    [self addLabelToView:self.view withText:@"咨询项目名称" withRect:CGRectMake(0,0,LEFT_HEAD_WIDTH,CELL_HIGHT)];
    for (int index = 0; index<10; index++) {
        [self addResultToView:self.scrollView ofRow:index];
    }


}

-(void) handlerMethod:(NSNotification *)note {
    /* Deal with rotation of your UI here */
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) ) {
        //横向
               
    } else if (UIDeviceOrientationIsPortrait(deviceOrientation) ) {
        //纵向
        GCYSAppDelegate *delegate = (GCYSAppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate.navController popToRootViewControllerAnimated:YES];

        
    }
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for all supported orientations
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.leftTable){
        return 10;
    }
    return 8;
}


- (void)addResultToView:(UIView *)view ofRow:(int)row {
    float sum = 0;
    float temp = 0;
    int index = 0;
    while (index < TOP_HEAD_ARRAY.count-1 ) {
        temp = [[[self.resultArrray objectAtIndex:row] objectAtIndex:index] floatValue];
        UILabel *label = [self makeBorderLabel:[NSString stringWithFormat:@"%.3f",temp] withRect:CGRectMake(index*CELL_WIDTH, row*CELL_HIGHT, CELL_WIDTH, CELL_HIGHT)];
        [view addSubview:label];
        sum +=temp;
        index++;
    }
   
    UILabel *label = [self makeBorderLabel:[NSString stringWithFormat:@"%.3f",sum] withRect:CGRectMake(index*CELL_WIDTH, row*CELL_HIGHT, CELL_WIDTH, CELL_HIGHT)];
    [view addSubview:label];
}

//制作代边框的label
-(UILabel *)makeBorderLabel:(NSString *)text withRect:(CGRect)rect{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    [label setNumberOfLines:0];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [[label layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[label layer] setBorderWidth:1.0];
    return label;

}

//制作灰色的label
-(UILabel *)makeGordeGrayLabel:(NSString *)text withRect:(CGRect)rect{
    UILabel *label = [self makeBorderLabel:text withRect:rect];
    label.backgroundColor = [UIColor grayColor];
    return label;

}

- (void)addLabelToView:(UIView *)view withText:(NSString *) text withRect:(CGRect)rect {
    
    [view addSubview:[self makeGordeGrayLabel:text withRect:rect]];
}

- (void)addTransFormLabelToView:(UIView *)view withText:(NSString *) text withRect:(CGRect)rect {
    UILabel *label = [self makeGordeGrayLabel:text withRect:rect];
    CGRect trmp =  rect;
    label.transform = CGAffineTransformMakeRotation(M_PI/2);
    trmp.size.width = rect.size.height;
    trmp.size.height = rect.size.width;
    label.frame  = trmp;
    [view addSubview:label];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell"];
    if(tableView == self.leftTable){
        [self addLabelToView:cell withText:[LEFT_HEAD_ARRAY objectAtIndex:indexPath.row] withRect:LEFT_HEAD_CELL_FRAM];
    }else{
        
        [self addTransFormLabelToView:cell withText:[TOP_HEAD_ARRAY objectAtIndex:indexPath.row] withRect:TOP_HEAD_CELL_FRAM];

    }
    return cell;
}
#pragma  mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView  == self.leftTable){
    return CELL_HIGHT;
    }else{
        return CELL_WIDTH;
    }
}
- (void)viewDidUnload {
    //故意不释放leftTable 和topTable看看如何检查内存泄露
    [self setScrollView:nil];
    [super viewDidUnload];
}
#pragma mark scrollViewDeletegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = 0;
    self.leftTable.contentOffset = offset;
    offset.y = self.scrollView.contentOffset.x;
    offset.x = 0;
    self.topTable.contentOffset = offset;
}
@end
