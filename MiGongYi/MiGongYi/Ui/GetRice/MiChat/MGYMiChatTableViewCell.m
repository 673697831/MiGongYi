//
//  MGYMiChatTableViewCell.m
//  MiGongYi
//
//  Created by megil on 9/30/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYMiChatTableViewCell.h"
#import "Masonry.h"

@interface MGYMiChatTableViewCell ()

@property(nonatomic, weak) UIScrollView *cellScrollView;
@property(nonatomic, weak) MGYMiChatLabelView *lableView;
//@property(nonatomic, weak) UIView *phoneView;
@property(nonatomic, assign) MGYMiChatCellState cellState;

@end

@implementation MGYMiChatTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initializer];
    }
    return self;
}

- (void)initializer
{
    MGYMiChatLabelView *lableView = [MGYMiChatLabelView new];
    [self addSubview:lableView];
    self.lableView = lableView;
    
    UIScrollView *cellScrollView = [UIScrollView new];
    cellScrollView.alwaysBounceVertical = YES;
    cellScrollView.pagingEnabled = YES;
    cellScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * 2, self.bounds.size.height);
    cellScrollView.contentOffset = CGPointMake(0, 0);
    cellScrollView.delegate = self;
    cellScrollView.scrollEnabled = NO;
    cellScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:cellScrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewPressed:)];
    [cellScrollView addGestureRecognizer:tapGestureRecognizer];
    self.cellScrollView = cellScrollView;
    
    self.cellState = MGYMiChatStateCellLeft;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setup];
}

- (void)setup
{
    [self.cellScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.edges.equalTo(self);
        make.height.mas_equalTo(59);
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(self);
    }];
    
    [self.lableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        //make.height.equalTo(self);
        make.height.mas_equalTo(59);
        make.width.equalTo(self).with.multipliedBy(2.0);
    }];

}

- (void)scrollViewPressed:(id)sender {
    if (!self.cellScrollView.scrollEnabled) {
        [self.cellDelegate openABPeoplePicker:self.indexPath];
        return;
    }
    
    
    CGPoint point = [sender locationInView:self];
    if (self.cellState == MGYMiChatStateCellRight) {
        point.x = point.x + CGRectGetWidth(self.bounds);
    }
    MGYMiChatPos chatPos = [self.lableView getTouchView:point];
    
    if (chatPos != MGYMiChatPosNextImageView && self.cellState == MGYMiChatStateCellLeft) {
        [self.cellDelegate callPeople:self.indexPath];
        return;
    }
    
    if (chatPos == MGYMiChatPosWarningImageView) {
        return;
    }
    
    if (chatPos == MGYMiChatPosNextImageView) {
        [self.cellScrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
        self.cellState = MGYMiChatStateCellRight;
        return;
    }
    
    if (chatPos == MGYMiChatPosSubView1) {
        [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.cellState = MGYMiChatStateCellLeft;
        return;
    }
    
    if (chatPos == MGYMiChatPossubView3) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"你点击了删除", @"你点击了删除")
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alter show];
        self.cellScrollView.scrollEnabled = NO;
        [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.cellState = MGYMiChatStateCellLeft;
        [self.cellDelegate deletePeople:self.indexPath];
        return;
    }
    
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame = self.lableView.frame;
    frame.origin.x =  -scrollView.contentOffset.x;
    self.lableView.frame = frame;

    if (self.cellState == MGYMiChatStateCellRight) {
        [self.cellDelegate resetOtherCellPosition:self.indexPath];
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (targetContentOffset -> x == self.bounds.size.width) {
        [self.cellDelegate resetOtherCellPosition:self.indexPath];
        self.cellState = MGYMiChatStateCellRight;
    }else if(targetContentOffset -> x == 0)
    {
        self.cellState = MGYMiChatStateCellLeft;
    }
}

#pragma mark - 显示数据
//- (void)scrollEnabled:(BOOL)enabled
//{
//    self.cellScrollView.scrollEnabled = enabled;
//}

- (void)resetPosition
{
    [self.cellScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.cellState = MGYMiChatStateCellLeft;
}

- (void)reset:(NSIndexPath *)indexPath
       record:(MGYMiChatRecord *)record
{
    self.indexPath = indexPath;
    [self.lableView reset:record type:indexPath.row];
    self.cellScrollView.scrollEnabled = record.totalTimes > 0 ? YES:NO;
    if (self.phoneView) {
        [self.phoneView removeFromSuperview];
        self.phoneView = nil;
    }
}


@end
