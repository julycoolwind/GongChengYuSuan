//
//  GCYSViewController.h
//  GongChengYuSuan
//
//  Created by linx on 13-5-15.
//  Copyright (c) 2013年 linx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "GCYSCalculator.h"

@interface GCYSViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MFMailComposeViewControllerDelegate>{
    NSArray *resultArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *jine;
@property (strong, nonatomic) IBOutlet UILabel *sum;
@property (nonatomic, strong)UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic,strong)NSArray *arrayOfSections;
@property (nonatomic,strong)GCYSCalculator *calculator;
-(IBAction)backgroundTap:(id)sender;
@end
