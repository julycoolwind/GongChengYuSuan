//
//  GCYDetailViewController.h
//  GongChengYuSuan
//
//  Created by linx on 13-6-12.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCYDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) UITableView *leftTable;
@property (strong,nonatomic) UITableView *topTable;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withResutArray:(NSArray *)resultArray;
@end
