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
}
@property NSArray *resultArrray;
@end

@implementation GCYDetailViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withResutArray:(NSArray *)resultArray{
    NSLog(@"init");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        CELL_HIGHT = 60;
        CELL_WIDTH = 100;
        LEFT_HEAD_WIDTH = 120;
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
    NSLog(@"viewdidload");
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
        [self addResultToView:self.scrollView indexPath:index];
    }


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewwillappear");

}
-(void) handlerMethod:(NSNotification *)note {
    /* Deal with rotation of your UI here */
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) ) {
        //横向
               
    } else if (UIDeviceOrientationIsPortrait(deviceOrientation) ) {
        NSLog(@"xiejie yemian shoudao tongzhi");
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


- (void)addResultToView:(UIView *)view indexPath:(int)row {
    float sum = 0;
    float temp = 0;
    for(int i = 0 ;i<7;i++){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*CELL_WIDTH, row*CELL_HIGHT, CELL_WIDTH, CELL_HIGHT)];
        [label setNumberOfLines:0];
        temp = [[[self.resultArrray objectAtIndex:row] objectAtIndex:i] floatValue];
        sum +=temp;
        label.text = [NSString stringWithFormat:@"%.3f",temp];
        label.textAlignment = NSTextAlignmentCenter;
        [[label layer] setBorderColor:[[UIColor blackColor] CGColor]];
        [[label layer] setBorderWidth:1.0];
        [view addSubview:label];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(7*CELL_WIDTH, row*CELL_HIGHT, CELL_WIDTH, CELL_HIGHT)];
    [label setNumberOfLines:0];
    label.text = [NSString stringWithFormat:@"%.3f",sum];
    label.textAlignment = NSTextAlignmentCenter;
    [[label layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[label layer] setBorderWidth:1.0];
    [view addSubview:label];
}



-(UILabel *)makeGordeGrayLabel:(NSString *)text withRect:(CGRect)rect{
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    [label setNumberOfLines:0];
    label.text = text;
    label.backgroundColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [[label layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[label layer] setBorderWidth:1.0];
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
        if (indexPath.row == 0){
            
            [self addLabelToView:cell withText:@"投资估算编制或审核" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
        }
        else if (indexPath.row == 1){
            [self addLabelToView:cell withText:@"设计概算编制或审核" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
           
        }else if (indexPath.row == 2){
            [self addLabelToView:cell withText:@"工程预算编制或审核" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
            
        }else if (indexPath.row == 3){
            [self addLabelToView:cell withText:@"招标工程量清单编制或审核" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
            
        }else if (indexPath.row == 4){
            [self addLabelToView:cell withText:@"工程量清单计价文件编制或审核" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
           
        }else if (indexPath.row == 5){
            [self addLabelToView:cell withText:@"工程结算编制" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
           
        }else if (indexPath.row == 6){
            [self addLabelToView:cell withText:@"竣工决算编审" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
          
        }else if (indexPath.row == 7){
            [self addLabelToView:cell withText:@"基本费" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
           
        }else if (indexPath.row == 8){
            [self addLabelToView:cell withText:@"施工阶段全过程造价控制" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
            
        }else if (indexPath.row == 9){
            [self addLabelToView:cell withText:@"工程造价争议鉴证" withRect:CGRectMake(0, 0, LEFT_HEAD_WIDTH, CELL_HIGHT)];
           
        }
    }else{
        if(indexPath.row == 0){
            
            [self addTransFormLabelToView:cell withText:@"x≤200" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }else if (indexPath.row == 1){
            [self addTransFormLabelToView:cell withText:@"200<x≤500" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }else if(indexPath.row == 2){
            [self addTransFormLabelToView:cell withText:@"500<x≤2000" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }else if (indexPath.row == 3){
            [self addTransFormLabelToView:cell withText:@"2000<x≤5000" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }else if (indexPath.row == 4){
            [self addTransFormLabelToView:cell withText:@"5000<x≤10000" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }else if (indexPath.row == 5){
            [self addTransFormLabelToView:cell withText:@"10000 <x≤ 50000" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }else if (indexPath.row == 6){
            [self addTransFormLabelToView:cell withText:@"x>50000" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }else if (indexPath.row == 7){
            [self addTransFormLabelToView:cell withText:@"小计" withRect:CGRectMake(0, 0, CELL_WIDTH, CELL_HIGHT)];
        }

    }
    //self.scrollView.contentSize = self.tableView.frame.size;
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
