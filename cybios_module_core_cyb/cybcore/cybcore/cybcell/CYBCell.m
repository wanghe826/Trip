//
//  CYBCell
//
//
//  Created by jbas on 15/4/24.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CYBCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIButton+Block.h"
#import "JSBadgeView.h"


@interface CYBCell ()
@property (strong, nonatomic) IBOutlet UIButton *leftTitleButton;
@property (strong, nonatomic) IBOutlet UIButton *rightValueButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftspaceConstraint;
@property (strong, nonatomic) IBOutlet UILabel *rightValueSubLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightValueSubConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftTitleSubConstraint;
@property (strong, nonatomic) IBOutlet UILabel *leftTitleSubLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftTitleBtnTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightValueBtnTopConstraint;
//左边titleButton距top的位置
@property (strong, nonatomic) NSLayoutConstraint *leftTitleBtnVerticalCenterConstraint;
//右边valueButton距top的位置
@property (strong, nonatomic) NSLayoutConstraint *rightValueBtnVerticalCenterConstraint;

//CellImage上显示的badge
@property(strong,nonatomic) JSBadgeView *badgeView;

@end

NSString * const XLFormRowDescriptorTypeCYBCell = @"XLFormRowDescriptorTypeCYBCell";
static NSUInteger KCellStyle;

static const CGFloat KDefaultCellHeight = 44;           //默认的Cell高度
static const CGFloat KDefaultImgWidth = 60;             //默认Cell图片的宽度+与右边文字的间距
static const CGFloat KDefaultTitleTrailingSpace = 8;    //SubTitle与右边框的间隙
static const CGFloat KDefaultTitleLeadingSpace = 20;    //SubTitle与左边框的间隙
static const CGFloat KDefaultFontSize=14.0;             //默认的SubText的字体大小

static const CGFloat KDefaultTitleLength=60.0;          //默认左边SubTitle的最小宽度
static const CGFloat KDefaultValueLength=80.0;          //默认右边SubValue的最小宽度
static const CGFloat KDefaultTitleMaxLength=380.0;      //默认左边title的最大宽度
static const CGFloat KDefaultValueMaxLength=380.0;      //默认左边title的最大宽度

static const CGFloat KDefaultTitle2ValueWidth=10.0;     //左边SubTitle与右边SubValue的间距
static const CGFloat KDefulatButtonHeight=30.0;         //默认左边Title按钮的高度
static CGFloat _screenWidth;
static UIFont  *_KDefaultFont;
static NSDictionary *_KFontAttributes;

static const NSStringDrawingOptions KCCEllDrawingOptions = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine;

@implementation CYBCell

+(void)load{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([CYBCell class]) forKey:XLFormRowDescriptorTypeCYBCell];
}

-(void)configure{
    if ((_cellModel.cellStyle & CYBCellStyleXLFormCell) == CYBCellStyleXLFormCell) {
        [super configure];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
}

+(CGFloat)getCellHeightWithCybModel:(CYBCellModel *)cybCellModel{
    CGFloat valueSubTextWidth=0.0;
    CGFloat titleSubTextWidth=0.0;
    
    if (!_screenWidth) {
        _screenWidth=[UIScreen mainScreen].bounds.size.width;
    }
    if (!cybCellModel) {
        return KDefaultCellHeight;
    }
    if (cybCellModel.titleSubText.length==0 && cybCellModel.valueSubText.length==0) {
        return KDefaultCellHeight;
    }
    
    if (cybCellModel.titleSubText.length>0) {
        titleSubTextWidth=[self calcWidth:cybCellModel.titleSubText];
        
        if (titleSubTextWidth<KDefaultTitleLength) {
            titleSubTextWidth=KDefaultTitleLength;
        }else if(titleSubTextWidth>KDefaultTitleMaxLength){
            titleSubTextWidth=KDefaultTitleMaxLength;
        }
    }
    
    if (cybCellModel.valueSubText.length>0) {
        valueSubTextWidth=[self calcWidth:cybCellModel.valueSubText];
        if (valueSubTextWidth<KDefaultValueLength) {
            valueSubTextWidth=KDefaultValueLength;
        }else if(valueSubTextWidth>KDefaultValueMaxLength){
            valueSubTextWidth=KDefaultValueMaxLength;
        }
    }
    
    CGFloat cellContentWidth; //能显示内容的长度
    if (cybCellModel.valueSubText.length==0) {
        cellContentWidth =_screenWidth-KDefaultTitleLeadingSpace-KDefaultTitle2ValueWidth;
    }else{
        cellContentWidth=_screenWidth-KDefaultTitleTrailingSpace-KDefaultTitle2ValueWidth-KDefaultTitleLeadingSpace;
    }
    
   // if ((titleSubTextWidth+valueSubTextWidth)>cellContentWidth) {
        if (valueSubTextWidth<=KDefaultValueLength) {
            titleSubTextWidth=cellContentWidth-valueSubTextWidth;
        }else{
            valueSubTextWidth=cellContentWidth-titleSubTextWidth;
            NSLog(@"valueSubTextWidth:%f=cellContentWidth:%f-titleSubTextWidth:%f;",valueSubTextWidth,cellContentWidth,titleSubTextWidth);
            if (valueSubTextWidth<KDefaultValueLength) {
                valueSubTextWidth=KDefaultValueLength;
            }
            titleSubTextWidth=cellContentWidth-valueSubTextWidth;
        }
    //}
    CGFloat cellHeightValue = [self heightForWidth:valueSubTextWidth text:cybCellModel.valueSubText];
    
    CGFloat cellHeightTitle = [self heightForWidth:titleSubTextWidth text:cybCellModel.titleSubText];
    CGFloat cellHeight=MAX(cellHeightTitle, cellHeightValue);
    cellHeight=cellHeight+KDefulatButtonHeight; //加上默认的按钮高度

    return cellHeight;
 }

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    CYBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cybCellIdentifier"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CYBCell class]) owner:nil options:nil] lastObject];
    }
    cell.leftTitleDescLines=1;  //默认设置成不换行显示
    cell.rightValueDescLines=1; //默认设置成不换行显示
    return cell;
}

//设置左边Title与右边Value值
-(void)setCellModel:(CYBCellModel *)cellModel{
    _cellModel=cellModel;

    if (!_leftTitleBtnVerticalCenterConstraint) {
        _leftTitleBtnVerticalCenterConstraint=[NSLayoutConstraint constraintWithItem:_leftTitleButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    }

    if (!_rightValueBtnVerticalCenterConstraint) {
        _rightValueBtnVerticalCenterConstraint=[NSLayoutConstraint constraintWithItem:_rightValueButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    }
    
    [_leftTitleButton setTitle:_cellModel.title forState:UIControlStateNormal];
    _leftTitleSubLabel.text=_cellModel.titleSubText;
    //设置右边文字属性值
    [_rightValueButton setTitle:_cellModel.value forState:UIControlStateNormal];
    
    _rightValueSubLabel.text=_cellModel.valueSubText;
    
    KCellStyle = _cellModel.cellStyle;
    switch (KCellStyle) {
        case CYBCellStyleLeftTitle | CYBCellStyleRightValue:
        case CYBCellStyleLeftTitle | CYBCellStyleRightValue | CYBCellStyleXLFormCell:
            [self addConstraint:_leftTitleBtnVerticalCenterConstraint];
            [self addConstraint:_rightValueBtnVerticalCenterConstraint];
            _leftTitleSubConstraint.constant = 0;
            _rightValueSubConstraint.constant = 0;
            break;
        case CYBCellStyleLeftTitle | CYBCellStyleLeftSubTitle:
        case CYBCellStyleLeftTitle | CYBCellStyleLeftSubTitle | CYBCellStyleXLFormCell:
            [self removeConstraint:_leftTitleBtnVerticalCenterConstraint];
            [self addConstraint:_rightValueBtnVerticalCenterConstraint];
            _leftTitleSubConstraint.constant = KDefaultTitleLength;
            _rightValueSubConstraint.constant = 0;
            break;
        case CYBCellStyleLeftTitle | CYBCellStyleLeftSubTitle | CYBCellStyleRightValue:
        case CYBCellStyleLeftTitle | CYBCellStyleLeftSubTitle | CYBCellStyleRightValue | CYBCellStyleXLFormCell:
            [self removeConstraint:_leftTitleBtnVerticalCenterConstraint];
            [self addConstraint:_rightValueBtnVerticalCenterConstraint];
            _leftTitleSubConstraint.constant = KDefaultTitleLength;
            _rightValueSubConstraint.constant = 0;
            break;
        case CYBCellStyleLeftTitle | CYBCellStyleRightValue | CYBCellStyleRightSubValue:
        case CYBCellStyleLeftTitle | CYBCellStyleRightValue | CYBCellStyleRightSubValue | CYBCellStyleXLFormCell:
            [self addConstraint:_leftTitleBtnVerticalCenterConstraint];
            [self removeConstraint:_rightValueBtnVerticalCenterConstraint];
            _leftTitleSubConstraint.constant = 0;
            if(_cellModel.valueSubText.length > 7){//表示有7个字符以上
                _rightValueSubLabel.textAlignment = NSTextAlignmentLeft;
                _rightValueSubConstraint.constant = KDefaultValueLength;
            }else{
                _rightValueSubLabel.textAlignment = NSTextAlignmentRight;
                _rightValueSubConstraint.constant = KDefaultValueLength;
            }
            break;
        case CYBCellStyleLeftTitle | CYBCellStyleLeftSubTitle | CYBCellStyleRightValue | CYBCellStyleRightSubValue:
        case CYBCellStyleLeftTitle | CYBCellStyleLeftSubTitle | CYBCellStyleRightValue | CYBCellStyleRightSubValue | CYBCellStyleXLFormCell:
            [self removeConstraint:_leftTitleBtnVerticalCenterConstraint];
            [self removeConstraint:_rightValueBtnVerticalCenterConstraint];
            _leftTitleSubConstraint.constant = KDefaultTitleLength;
            if(_cellModel.valueSubText.length > 7){//表示有7个字符以上
                _rightValueSubLabel.textAlignment = NSTextAlignmentLeft;
                _rightValueSubConstraint.constant = KDefaultValueLength;
            }else{
                _rightValueSubLabel.textAlignment = NSTextAlignmentRight;
                _rightValueSubConstraint.constant = KDefaultValueLength;
            }
            break;
        default:
            break;
    }

    if ((KCellStyle & CYBCellStyleXLFormCell) == CYBCellStyleXLFormCell) {
        if (_cellModel.didClickCell) {
            _leftTitleButton.userInteractionEnabled=NO;
            _rightValueButton.userInteractionEnabled=NO;
        }else{
            _leftTitleButton.userInteractionEnabled=YES;
            _rightValueButton.userInteractionEnabled=YES;
        }
        
        if (_cellModel.didClickLeftBtn) {
            _leftTitleButton.userInteractionEnabled=YES;
        }else{
            _leftTitleButton.userInteractionEnabled=NO;
        }
        
        if (_cellModel.didClickRightBtn) {
            _rightValueButton.userInteractionEnabled=YES;
        }else{
            _rightValueButton.userInteractionEnabled=NO;
        }
    }

   // 设置图片属性值
    [self setLocalImageOrUrlImage];
    
//    //设置按钮无点无效，把对按钮的点击事件传到上层Cell上
//    _leftTitleButton.userInteractionEnabled=NO;
//    _rightValueButton.userInteractionEnabled=NO;
//    _leftTitleSubLabel.numberOfLines=0;
//    _rightValueSubLabel.numberOfLines=0;
}

//设置图片信息
-(void)setLocalImageOrUrlImage{
    if (_cellModel.cellImagePath) {  //设置Cell的图片
        if ([_cellModel.cellImagePath hasPrefix:@"http"]) { //表示是网络图片
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:_cellModel.cellImagePath]];
        }else{
            [self.imageView setImage:[UIImage imageNamed:_cellModel.cellImagePath]];
        }
        _leftspaceConstraint.constant=KDefaultImgWidth;
    }else{
        [self.imageView setImage:nil];
        _leftspaceConstraint.constant=KDefaultTitleLeadingSpace;
    }
    if (_cellModel.titleImagePath) { //设置标题中的图片
        if ([_cellModel.titleImagePath hasPrefix:@"http"]) { //表示是网络图片
            [_leftTitleButton sd_setImageWithURL:[NSURL URLWithString:_cellModel.titleImagePath] forState:UIControlStateNormal];
        }else{
            [_leftTitleButton setImage:[UIImage imageNamed:_cellModel.titleImagePath] forState:UIControlStateNormal];
        }
    }else{
        [_leftTitleButton setImage:nil forState:UIControlStateNormal];
    }
    if (_cellModel.valueImagePath) { //设置Value中的图片
        if ([_cellModel.valueImagePath hasPrefix:@"http"]) { //表示是网络图片
            [_rightValueButton sd_setImageWithURL:[NSURL URLWithString:_cellModel.valueImagePath] forState:UIControlStateNormal];
        }else{
            [_rightValueButton setImage:[UIImage imageNamed:_cellModel.valueImagePath] forState:UIControlStateNormal];
        }
    }else{
        [_rightValueButton setImage:nil forState:UIControlStateNormal];
    }
    //设置图片的BadgeView
    [self setBadgeView];
}

-(void)setBadgeView{
    if (_cellModel.cellImageBadgeText.length==0) {
        if (_badgeView) {
            _badgeView.hidden=YES;
        }
        return;
    }
    _badgeView = [[JSBadgeView alloc] initWithParentView:self.imageView alignment:JSBadgeViewAlignmentTopRight];
    _badgeView.badgePositionAdjustment=CGPointMake(-8, 4);
    _badgeView.hidden=NO;
    _badgeView.badgeText=_cellModel.cellImageBadgeText;
}

//计算内容宽度
+(CGFloat)calcWidth:(NSString *)content{
    if (!_KDefaultFont) {
        _KDefaultFont=[UIFont systemFontOfSize:KDefaultFontSize];
    }
    if (!_KFontAttributes) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        _KFontAttributes = @{NSFontAttributeName:_KDefaultFont , NSParagraphStyleAttributeName:paragraphStyle.copy};
    }
    if (!_screenWidth) {
        _screenWidth=[UIScreen mainScreen].bounds.size.width;
    }
    CGSize labelSize = [content boundingRectWithSize:CGSizeMake(_screenWidth, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:_KFontAttributes context:nil].size;
  //  labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize.width;
}

//计算内容高度
+ (CGFloat)heightForWidth:(CGFloat)width text:(id)text{
    if (!_KDefaultFont) {
        _KDefaultFont=[UIFont systemFontOfSize:KDefaultFontSize];
    }
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:KCCEllDrawingOptions attributes:@{NSFontAttributeName: _KDefaultFont} context:nil].size.height;
    return ceilf(height);
}

-(void)setLeftTitleDescLines:(int)leftTitleDescLines{
    _leftTitleDescLines=leftTitleDescLines;
    _leftTitleSubLabel.numberOfLines=_leftTitleDescLines;
}

-(void)setRightValueDescLines:(int)rightValueDescLines{
    _rightValueDescLines=rightValueDescLines;
    _rightValueSubLabel.numberOfLines=_rightValueDescLines;
}

-(void)setDelegate:(id<CYBCellDidClickDelegate>)delegate{
    _delegate=delegate;
    if ([_delegate respondsToSelector:@selector(didClickLeftTitleBtn:)]) {
        _leftTitleButton.userInteractionEnabled=YES;
    }
    if ([_delegate respondsToSelector:@selector(didClickRightValueBtn:)]) {
        _rightValueButton.userInteractionEnabled=YES;
    }
}

- (IBAction)leftBtnActionClick:(id)sender {
    if ((_cellModel.cellStyle & CYBCellStyleXLFormCell) == CYBCellStyleXLFormCell) {
        if (_cellModel.didClickLeftBtn) {
            _cellModel.didClickLeftBtn();
        }else{
            _leftTitleButton.userInteractionEnabled=NO;
        }
    } else{
        if ([_delegate respondsToSelector:@selector(didClickLeftTitleBtn:)]) {
            [_delegate didClickLeftTitleBtn:_cellModel];
        }else{
            _leftTitleButton.userInteractionEnabled=NO;
        }
    }
}

- (IBAction)rightBtnActionClick:(id)sender {
    if ((_cellModel.cellStyle & CYBCellStyleXLFormCell) == CYBCellStyleXLFormCell) {
        if (_cellModel.didClickRightBtn) {
            _cellModel.didClickRightBtn();
        }else{
            _rightValueButton.userInteractionEnabled=NO;
        }
    } else{
        if ([_delegate respondsToSelector:@selector(didClickRightValueBtn:)]) {
            [_delegate didClickRightValueBtn:_cellModel];
        }else{
            _rightValueButton.userInteractionEnabled=NO;
        }
    }

}

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    if ((KCellStyle & CYBCellStyleXLFormCell) == CYBCellStyleXLFormCell) {
        return 48.0f;
    } else return 0.0f;
}

-(void)setRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    if ((KCellStyle & CYBCellStyleXLFormCell) == CYBCellStyleXLFormCell) {
        self.cellModel=rowDescriptor.value;
    }
}

-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller{
    if ((KCellStyle & CYBCellStyleXLFormCell) == CYBCellStyleXLFormCell) {
        if (_cellModel.didClickCell) {
            _cellModel.didClickCell();
        }
    }
}

@end
