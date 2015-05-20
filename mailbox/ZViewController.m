//
//  ZViewController.m
//  mailbox
//
//  Created by zhuyanan on 15/5/15.
//  Copyright (c) 2015年 live. All rights reserved.
//
#define MARK @"@"
#import "ZViewController.h"
#import "ZTableViewCell.h"

@interface ZViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, weak) UITextField *accountTextField;
@property(nonatomic, weak) UITextField *passwordTextField;
@property(nonatomic, weak) UITableView *menuTableView;
@property(nonatomic, strong) NSMutableArray *emailArray;//邮箱后缀

@end

@implementation ZViewController

- (NSMutableArray *)emailArray
{
    if (_emailArray == nil)
    {
        _emailArray = [NSMutableArray arrayWithObjects:@"sohu.com", @"3g.sina.cn", @"sina.com", @"sina.cn", @"163.com", @"126.com", @"qq.com", @"hotmail.com", @"gmail.com", @"yahoo.com", @"tom.com", @"sogou.com", @"vip.sina.com", @"189.com", @"vip.qq.com", @"vip.163.com", nil];
    }
    
    return _emailArray;
}

- (NSMutableArray *)baseEmailArray
{
    return [NSMutableArray arrayWithObjects:@"sohu.com", @"3g.sina.cn", @"sina.com", @"sina.cn", @"163.com", @"126.com", @"qq.com", @"hotmail.com", @"gmail.com", @"yahoo.com", @"tom.com", @"sogou.com", @"vip.sina.com", @"189.com", @"vip.qq.com", @"vip.163.com", nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *accountTextField = [[UITextField alloc] init];
    accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    accountTextField.placeholder = @"请输入账号邮箱";
    accountTextField.font = [UIFont systemFontOfSize:13];
    accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    accountView.backgroundColor = [UIColor blueColor];
    accountTextField.leftView = accountView;
    accountTextField.leftViewMode = UITextFieldViewModeAlways;
    self.accountTextField = accountTextField;
    accountTextField.frame = CGRectMake(0,100,self.view.frame.size.width,30);
    [self.view addSubview:accountTextField];
    self.accountTextField.delegate = self;
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:13];
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    passwordView.backgroundColor = [UIColor redColor];
    passwordTextField.leftView = passwordView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField = passwordTextField;
    passwordTextField.frame = CGRectMake(0,135,self.view.frame.size.width,30);
    [self.view addSubview:passwordTextField];
    
    // 下拉列表
    UITableView *menuTableView= [[UITableView alloc] initWithFrame:CGRectMake(0,130,self.view.frame.size.width,120)];
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    menuTableView.backgroundColor = [UIColor blackColor];
    self.menuTableView = menuTableView;
    menuTableView.dataSource=self;
    menuTableView.delegate=self;
    menuTableView.hidden = YES;
    [self.view addSubview:menuTableView];
}
 

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    self.menuTableView.hidden = YES;
    [self.passwordTextField becomeFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.menuTableView.hidden = YES;
    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    ZLog(@"%@",textField.text);
    ZLog(@"%@",NSStringFromRange(range));
    ZLog(@"%@",string);
    
    if (!range.length)
    {
        // 1、text在添加
        
        if (![textField.text containsString:MARK])
        {
            // 1.1、 当前textField.text不包含@
            
            if ([string isEqualToString:MARK])
            {
                // 1.1.1、输入string是@
                NSString *fullEmail;
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSString *email in [self baseEmailArray])
                {
                    fullEmail = [textField.text stringByAppendingString:[NSString stringWithFormat:@"%@%@",string,email]];
                    [tempArray addObject:fullEmail];
                }
                self.emailArray = tempArray;
                [self.menuTableView reloadData];
                self.menuTableView.hidden = NO;
            }
        }
        else
        {
            // 1.2、当前textField.text包含@
            if([string isEqualToString:MARK])
            {
                // 1.2.1、输入string是@
                self.menuTableView.hidden = YES;
                ZLog(@"格式不对");
            }
            else
            {
                // 1.2.2、输入string不是@开始匹配
                BOOL hide = YES;
                NSString *matchStr = [textField.text stringByAppendingString:string];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSString *fullEmail in self.emailArray)
                {
                    if ((matchStr.length <= fullEmail.length) && [matchStr isEqualToString:[fullEmail substringWithRange:NSMakeRange(0, matchStr.length)]])
                    {
                        [tempArray insertObject:fullEmail atIndex:0];
                        hide = NO;
                    }
                    else
                    {
                        [tempArray addObject:fullEmail];
                    }
                }
                self.emailArray = tempArray;
                [self.menuTableView reloadData];
                self.menuTableView.hidden = hide;
            }
        }
    }
    else
    {
        // 2、text在删除
        int i = 0;
        for (int j = 0; j < textField.text.length; j++)
        {
            // 2.1、判断当前textField.text包含@的个数
            if ([[textField.text substringWithRange:NSMakeRange(j, 1)] isEqualToString:MARK])
            {
                i++;
            }
        }
        
        if (i > 2)
        {
            // 2.2、格式不对不显示email菜单
            self.menuTableView.hidden = YES;
        }
        else if (i == 2)
        {
            // 2.3、
            if ([textField.text hasSuffix:MARK])
            {
                // 2.3.1、要删除的是@，开始匹配
                BOOL hide = YES;
                NSString *matchStr = [textField.text substringToIndex:(textField.text.length - 1)];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSString *fullEmail in self.emailArray)
                {
                    if ((matchStr.length <= fullEmail.length) && [matchStr isEqualToString:[fullEmail substringWithRange:NSMakeRange(0, matchStr.length)]])
                    {
                        [tempArray insertObject:fullEmail atIndex:0];
                        hide = NO;
                    }
                    else
                    {
                        [tempArray addObject:fullEmail];
                    }
                }
                self.emailArray = tempArray;
                [self.menuTableView reloadData];
                self.menuTableView.hidden = hide;
            }
            else
            {
                // 2.3.2、格式不对不显示email菜单
                self.menuTableView.hidden = YES;
            }
        }
        else if (i == 1)
        {
            // 2.4、
            if ([textField.text hasSuffix:MARK])
            {
                // 2.4.1、要删除的是@，不显示email菜单
                self.menuTableView.hidden = YES;
            }
            else
            {
                // 2.4.2、要删除的不是@，开始匹配
                BOOL hide = YES;
                NSString *matchStr = [textField.text substringToIndex:(textField.text.length - 1)];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSString *fullEmail in self.emailArray)
                {
                    if ((matchStr.length <= fullEmail.length) && [matchStr isEqualToString:[fullEmail substringWithRange:NSMakeRange(0, matchStr.length)]])
                    {
                        [tempArray insertObject:fullEmail atIndex:0];
                        hide = NO;
                    }
                    else
                    {
                        [tempArray addObject:fullEmail];
                    }
                }
                self.emailArray = tempArray;
                [self.menuTableView reloadData];
                self.menuTableView.hidden = hide;
            }
        }
        else
        {
            // 2.5、当前textField.text不包含@
            self.menuTableView.hidden = YES;
        }
        
    }
    return YES;
}


#pragma mark dataSource method and delegate method
 
- (NSInteger)tableView:(UITableView*)table numberOfRowsInSection:(NSInteger)section
{
    return self.emailArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    ZTableViewCell *cell = [ZTableViewCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    [cell setEmail:self.emailArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 30;
}
 
//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表,隐藏键盘
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 将完整email填入输入框
    self.accountTextField.text = self.emailArray[indexPath.row];
    self.menuTableView.hidden = YES;
    [self.passwordTextField becomeFirstResponder];
}

 

@end