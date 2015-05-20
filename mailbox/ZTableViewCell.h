//
//  ZTableViewCell.h
//  mailbox
//
//  Created by zhuyanan on 15/5/19.
//  Copyright (c) 2015年 live. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

- (void)setEmail:(NSString *)emailStr;

@end
