//
//  GCYSViewController.m
//  GongChengYuSuan
//
//  Created by linx on 13-5-15.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import "GCYSViewController.h"
#import "GCYDetailViewController.h"
#import "GCYSAppDelegate.h"
@interface GCYSViewController ()

@end

@implementation GCYSViewController

#pragma mark -生命周期
- (void)viewDidLoad
{
    //测试git
    [super viewDidLoad]; 
    self.calculator = [[GCYSCalculator alloc] init];
    [self.calculator initialize];
    [self fillArrayOfSections];
    self.jine = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 25.0f)];
    self.jine.placeholder = @"输入项目的总金额";
    [self.jine setKeyboardType:UIKeyboardTypeDecimalPad];
    [self.jine setBorderStyle:UITextBorderStyleRoundedRect];
    self.jine.delegate = self;
    [self.jine addTarget:self action:@selector(jineChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.sum = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 25.0f)];
        //FIXME:持续出没jine时不应当出现菜单
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(handleTaps:)];
    [self.tableView addGestureRecognizer:self.tapGestureRecognizer];
    
    [self initResultArray];
    self.title = @"预算费用速算器";
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提意见" style:UIBarButtonItemStyleDone target:self action:@selector(sendMail)];
}

-(void)sendMail{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        [self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用别的方式将您的饿意见发到julycoolwind@hotmail.com这个地址。"];
        return;
    }
    if (![mailClass canSendMail]) {
        [self alertWithMessage:@"未设置邮件账户,您可以设置邮件账户之后再发送。或者通过别的方式将您的饿意见发到julycoolwind@hotmail.com这个地址。"];
        return;
    }
    [self displayMailPicker];
}

-(void)alertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"对工程预算手机软件的建议"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"julycoolwind@hotmail.com"];
    [mailPicker setToRecipients: toRecipients];
    
    NSString *emailBody = @"<font color='red'>eMail</font> 正文";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self presentModalViewController: mailPicker animated:YES];
}

-(void)initResultArray{
    resultArray = [[NSArray alloc] initWithArray:
                   [NSArray arrayWithObjects:
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    [NSMutableArray arrayWithObjects:@0.00,@0.00,@0.00,@0.00,@0.00,@0.00,@0.00, nil],
                    nil]];

}

-(void) handlerMethod:(NSNotification *)note {
    /* Deal with rotation of your UI here */
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) ) {
        NSLog(@"MIAN 转为纵横向 开始");
        //横向
        GCYSAppDelegate *delegate = (GCYSAppDelegate *)[[UIApplication sharedApplication] delegate];
        GCYDetailViewController *detailView = [[GCYDetailViewController alloc] initWithNibName:@"GCYDetailViewController" bundle:nil withResutArray:resultArray];
        [delegate.navController pushViewController:detailView animated:YES];
        
    } else if (UIDeviceOrientationIsPortrait(deviceOrientation) ) {
        //纵向
        NSLog(@"zongxiang");
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //检测屏幕方向变化的通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(handlerMethod:)
                               name:@"UIDeviceOrientationDidChangeNotification"
                             object:nil];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
//加入这个方法，横屏的时候才会有变化
- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for all supported orientations
    return YES;
}

#pragma mark -控件事件
-(void)jineChanged:(UITextField *)paramSender{
    [self doRefrashSum];
}

-(float)inputJine{
    float result = 0;
    if ([self.jine.text length]>0) {
        result = [self.jine.text floatValue];
    }
    return result;
}

- (float)doCalculator {
    //这个注释用于测试git
    //UITableViewCell * ownerCell = (UITableViewCell *)paramSender.superview;
    //TODO:遍历section2中的cell根据switch的状态计算结果。
    NSInteger counter = 0;
    float sum = 0;
    for (counter = 0; counter<10; counter++) {
        NSIndexPath *theCurrentCellPaht = [NSIndexPath indexPathForRow:counter inSection:1];
        UITableViewCell *currentCell = [self.tableView cellForRowAtIndexPath:theCurrentCellPaht];
        if([(UISwitch *)currentCell.accessoryView isOn]){
            sum += [self.calculator calculat:[self inputJine] indexCodeIs:counter insertResultIn:resultArray];
        }
    }
    return sum;
}

- (void)doRefrashSum {
    self.sum.text = [NSString stringWithFormat:@"%.3f",[self doCalculator]];
}

-(void)switchIsChanged:(UISwitch *)paramSender{
    [self initResultArray];
    [self doRefrashSum];
}

#pragma mark -初始化工作
-(void)fillArrayOfSections{
    NSArray *section1 = [[NSArray alloc] initWithObjects:@"项目总金额:", nil];
    NSArray *section2 = [[NSArray alloc] initWithObjects:@"投资估算编制或审核",@"设计概算编制或审核",@"工程预算编制或审核",@"招标工程量清单编制或审核",@"工程量清单计价文件编制或审核",@"工程结算编制",@"竣工决算编审",@"基本费",@"施工阶段全过程造价控制",@"工程造价争议鉴证" ,nil];
    NSArray *section3 = [[NSArray alloc] initWithObjects:@"结算结果:", nil];
    self.arrayOfSections = [[NSArray alloc] initWithObjects:section1,section2,section3, nil];
}


#pragma mark -处理键盘相关的事件
-(void)handleKeyboardWillShow:(NSNotification *)paramNotification{
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject =
    [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    [UIView beginAnimations:@"changeTableViewContentInset"
                    context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CGRect intersectionOfKeyboardRectAndWindowRect =
    CGRectIntersection(window.frame, keyboardEndRect);
    CGFloat bottomInset = intersectionOfKeyboardRectAndWindowRect.size.height;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f,
                                                     0.0f,
                                                     bottomInset,
                                                     0.0f);
}

- (void) handleKeyboardWillHide:(NSNotification *)paramNotification{
    if (UIEdgeInsetsEqualToEdgeInsets(self.tableView.contentInset,
                                      UIEdgeInsetsZero)){
        /* Our table view's content inset is intact so no need to reset it */
        return;
    }
    NSDictionary *userInfo = [paramNotification userInfo];
    NSValue *animationCurveObject =
    [userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *animationDurationObject =
    [userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *keyboardEndRectObject =
    [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSUInteger animationCurve = 0;
    double animationDuration = 0.0f;
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    [animationCurveObject getValue:&animationCurve];
    [animationDurationObject getValue:&animationDuration];
    [keyboardEndRectObject getValue:&keyboardEndRect];
    [UIView beginAnimations:@"changeTableViewContentInset"
                    context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    self.tableView.contentInset = UIEdgeInsetsZero;
    [UIView commitAnimations];
}

- (void) handleTaps:(UITapGestureRecognizer*)paramSender{
    [self.jine resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"in touchesBegan");
    [self.jine resignFirstResponder];
}

-(IBAction)backgroundTap:(id)sender/////实现输出完成时点击相应的文本字段部分软键盘退出
{
    //[sender resignFirstResponder];//结束当前第一响应状态：此方法的调用可以满足下边两条语句的功能，但这样没有下边两条的更安全
    [self.jine resignFirstResponder];//结束name的第一响应状态
    //[numberField resignFirstResponder];//结束number的第一响应状态
}

#pragma mark -TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger result = 0;
    if(self.tableView == tableView){
        switch (section) {
            case 0:
                result = 1;
                break;
            case 1:
                result = 10;
                break;
            case 2:
                result = 1;
                break;
            default:
                break;
        }
    }
    return result;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *result = nil;
    if ([tableView isEqual:self.tableView]&&(section==0||section==2)) {
        result = @"单位万元";
    }
    return result;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *result = nil;
    
    if ([tableView isEqual:self.tableView]) {
        //TODO:使用二维数组来进行tableViewCell的创建工作
        static NSString *TableViewCellIdentifier = @"MyCells";
        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        if (result == nil) {
            result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
        }
        result.textLabel.text = [[self.arrayOfSections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        result.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        result.textLabel.numberOfLines = 0;
        if(indexPath.section ==0 && indexPath.row == 0){
            result.accessoryView = self.jine;

        }
        if (indexPath.section == 1) {
            UISwitch *calculateSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 25.0f)];
            [calculateSwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
            result.accessoryView = calculateSwitch;
        }
        if(indexPath.section == 2){
            result.accessoryView = self.sum;
        }
    }
    return result;
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissModalViewControllerAnimated:YES];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"感谢您的反馈。";
            [self alertWithMessage:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
}


@end
