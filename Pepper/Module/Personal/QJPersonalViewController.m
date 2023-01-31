//
//  QJPersonalViewController.m
//  Pepper
//
//  Created by 雷子 on 2023/1/31.
//

#import "QJPersonalViewController.h"
#import "QJPersonalTableViewCell.h"

@interface QJPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation QJPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = BASECOLOR_GRAY_F5;
    [self.tableView setScrollEnabled:NO];
    [self.tableView registerClass:[QJPersonalTableViewCell class] forCellReuseIdentifier:@"PersonCell"];
    [self.dataSource addObject:@{@"title":@"关于我们",@"img":@"personal_we"}];
    [self.dataSource addObject:@{@"title":@"隐私协议",@"img":@"personal_ys"}];
    [self.dataSource addObject:@{@"title":@"使用条款",@"img":@"personal_sy"}];
    [self.dataSource addObject:@{@"title":@"分享应用",@"img":@"personal_share"}];
    
}

- (void)backButtonClick:(UIButton *)seender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    QJPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.dataSource[indexPath.row][@"title"];
    cell.picImageView.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"img"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE_SIZE(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCALE_SIZE(255);
}

//MARK: 头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, SCALE_SIZE(255))];
    headerView.backgroundColor = BASECOLOR_GRAY_F5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, SCALE_SIZE(237))];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"personal_bg"];
    imageView.layer.masksToBounds = YES;
    [headerView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的";
    titleLabel.font = FONTSIZE_BLOD(18);
    [headerView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.mas_equalTo(SCALE_SIZE(50));
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.left.mas_equalTo(SCALE_SIZE(5));
        make.width.mas_equalTo(SCALE_SIZE(30));
        make.height.mas_equalTo(SCALE_SIZE(30));
    }];
    
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.contentMode = UIViewContentModeScaleAspectFill;
    headImage.image = [UIImage imageNamed:@"navigation_head"];
    [headerView addSubview:headImage];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.width.height.mas_equalTo(SCALE_SIZE(100));
        make.top.mas_equalTo(SCALE_SIZE(105));
    }];
    
    return headerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
