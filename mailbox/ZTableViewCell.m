//
//  ZTableViewCell.m
//  mailbox
//
//  Created by zhuyanan on 15/5/19.
//  Copyright (c) 2015年 live. All rights reserved.
//

#import "ZTableViewCell.h"

@interface ZTableViewCell()
{
    UILabel *_emailLable;
    UIView *_seperatorView;
}
@end

@implementation ZTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    static NSString *cellID = @"emailID";
    
    ZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[ZTableViewCell alloc] initWithStyle:style reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupCustomWidget];
    }
    return self;
}

- (void)setupCustomWidget
{
    _emailLable = [[UILabel alloc] init];
    _emailLable.font = [UIFont systemFontOfSize:13];
    _emailLable.textColor = [UIColor purpleColor];
    [self.contentView addSubview:_emailLable];
    
    //分割线
    _seperatorView = [[UIView alloc] init];
    _seperatorView.backgroundColor = ZRandomColor;
    [self.contentView addSubview:_seperatorView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _emailLable.frame = CGRectMake(36, 0, self.width - 72, self.height);
    _seperatorView.frame = CGRectMake(0, self.height - 1, self.width, 1);
}

- (void)setEmail:(NSString *)emailStr
{
    _emailLable.text = emailStr;
}

@end
