//
//  QJPersonalTableViewCell.m
//  Pepper
//
//  Created by 雷子 on 2023/1/31.
//

#import "QJPersonalTableViewCell.h"
@interface QJPersonalTableViewCell ()

@property (nonatomic, strong) UIView        *whiteView;
@property (nonatomic, strong) UIImageView   *rightImageView;

@end
@implementation QJPersonalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = BASECOLOR_GRAY_F5;
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_SIZE(15));
        make.right.equalTo(self.contentView).offset(-SCALE_SIZE(15));
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(SCALE_SIZE(54));
    }];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.whiteView);
        make.left.mas_equalTo(SCALE_SIZE(15));
        make.width.height.mas_equalTo(SCALE_SIZE(26));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.whiteView);
        make.left.equalTo(self.picImageView.mas_right).offset(SCALE_SIZE(34));
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCALE_SIZE(20));
        make.centerY.equalTo(self.whiteView);
        make.right.equalTo(self.whiteView.mas_right).offset(-SCALE_SIZE(12));
    }];
}



- (UIView *)whiteView {
    if(!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
        _whiteView.layer.cornerRadius = SCALE_SIZE(27);
        _whiteView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.16].CGColor;
        _whiteView.layer.shadowOpacity = 1;
        _whiteView.layer.shadowRadius = 6;
        [self.contentView addSubview:self.whiteView];
    }
    return _whiteView;
}

- (UIImageView *)picImageView {
    if(!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        [self.whiteView addSubview:_picImageView];
    }
    return _picImageView;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONTSIZE_MEDIUM(14);
        _titleLabel.textColor = [UIColor blackColor];
        [self.whiteView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView {
    if(!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"personal_right"];
        [self.whiteView addSubview:_rightImageView];
    }
    return _rightImageView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
