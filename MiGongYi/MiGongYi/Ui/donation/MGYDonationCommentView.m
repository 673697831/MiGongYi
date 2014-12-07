//
//  MGYDonationCommentView.m
//  MiGongYi
//
//  Created by megil on 12/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "MGYDonationCommentView.h"
#import "Masonry.h"
#import "UIColor+Expanded.h"
#import "UIImageView+WebCache.h"

@interface MGYDonationCommentView ()

@property (nonatomic, weak) UIImageView *photoImageView0;
@property (nonatomic, weak) UIImageView *photoImageView1;
@property (nonatomic, weak) UIImageView *photoImageView2;
@property (nonatomic, weak) UIImageView *photoImageView3;
@property (nonatomic, weak) UIImageView *photoImageView4;
@property (nonatomic, weak) UIImageView *photoImageView5;

@property (nonatomic, weak) UILabel *commentSubLabel0;
@property (nonatomic, weak) UILabel *commentSubLabel1;
@property (nonatomic, weak) UILabel *commentSubLabel2;
@property (nonatomic, weak) UILabel *commentSubLabel3;
@property (nonatomic, weak) UILabel *commentSubLabel4;
@property (nonatomic, weak) UILabel *commentSubLabel5;
//@property (nonatomic, weak) UITextView *textView0;
//@property (nonatomic, weak) UITextView *textView1;
//@property (nonatomic, weak) UITextView *textView2;
//@property (nonatomic, weak) UITextView *textView3;
//@property (nonatomic, weak) UITextView *textView4;
//@property (nonatomic, weak) UITextView *textView5;

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) BOOL saveOriginFrame;

@end

@implementation MGYDonationCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIView *containerView = [UIView new];
        [self addSubview:containerView];
        self.containerView = containerView;
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        for (int i = 0; i < 6; i ++) {
            UIImageView *photoImageView = [UIImageView new];
            //photoImageView.backgroundColor = [UIColor blackColor];
            [containerView addSubview:photoImageView];
            [self setValue:photoImageView forKey:[NSString stringWithFormat:@"photoImageView%d", i]];
            
//            UIWebView *commentWebView = [UIWebView new];
//            commentWebView.tintColor = [UIColor blueColor];
        
//            commentWebView.delegate = self;
//            [commentWebView setScalesPageToFit:NO];
//            commentWebView.scrollView.bounces = NO;
//            commentWebView.scrollView.scrollEnabled = NO;
//            commentWebView.scrollView.showsVerticalScrollIndicator = NO;
//            [self addSubview:commentWebView];
//            [self setValue:commentWebView forKey:[NSString stringWithFormat:@"commentWebView%d", i]];
            UILabel *commentSubLabel = [UILabel new];
            commentSubLabel.numberOfLines = 0;
            commentSubLabel.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
            commentSubLabel.font = [UIFont systemFontOfSize:9];
            commentSubLabel.textColor = [UIColor blackColor];
            [containerView addSubview:commentSubLabel];
            [self setValue:commentSubLabel forKey:[NSString stringWithFormat:@"commentSubLabel%d", i]];
            
//            UITextView *textView = [UITextView new];
//            textView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
//            textView.font = [UIFont systemFontOfSize:9];
//            textView.textColor = [UIColor blackColor];
//            [containerView addSubview:textView];
//            [self setValue:textView forKey:[NSString stringWithFormat:@"textView%d", i]];
            
            if (i) {
                
                UIImageView *lastPhotoImageView = [self valueForKey:[NSString stringWithFormat:@"photoImageView%d", i - 1]];
                
                [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(61/2.0);
                    make.height.mas_equalTo(30);
                    make.left.equalTo(self).with.offset(42/2);
                    make.top.equalTo(lastPhotoImageView.mas_bottom).with.offset(14);
                }];
            }else
            {
                [photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(61/2.0);
                    make.height.mas_equalTo(30);
                    make.left.equalTo(self).with.offset(42/2);
                    make.top.equalTo(self).with.offset(14);
                }];
            }
            
            [commentSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(463/2.0);
                make.height.equalTo(photoImageView);
                make.left.equalTo(photoImageView.mas_right).with.offset(13);
                make.top.equalTo(photoImageView);
            }];
        }
        //self.backgroundColor = [UIColor yellowColor];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)reset:(NSArray *)arrayComment
{
    self.containerView.frame = self.originFrame;
    for (int i = 0; i < arrayComment.count; i ++) {
        MGYPortocolInstantnewsComment *comment = arrayComment[i];
        UIImageView *photoImageView = [self valueForKey:[NSString stringWithFormat:@"photoImageView%d", i]];
        [photoImageView sd_setImageWithURL:[NSURL URLWithString:comment.avatar]];
//        UIWebView *commentWebView = [self valueForKey:[NSString stringWithFormat:@"commentWebView%d", i]];
//        [commentWebView loadHTMLString:comment.content baseURL:nil];
        //NSFont *font = [NSFont fontWithName:@"Palatino-Roman" size:14.0];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:9]
                                                                    forKey:NSFontAttributeName];
        UILabel *commentSubLabel = [self valueForKey:[NSString stringWithFormat:@"commentSubLabel%d", i]];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[comment.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:&attrsDictionary error:nil];
        commentSubLabel.attributedText = attrStr;
        if (!i) {
            //NSLog(@"%@",comment.content);
        }
        commentSubLabel.font = [UIFont systemFontOfSize:9];
        commentSubLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
    }
    if (arrayComment.count ==6) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self move];
        });
    }
    
}

- (void)move
{
    if (!self.saveOriginFrame) {
        self.originFrame = self.containerView.frame;
        self.saveOriginFrame = YES;
    }
    
    [UIView animateWithDuration:2
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y - 44;
                         self.containerView.frame = frame;
                     } completion:^(BOOL finished) {
                         //self.containerView.frame = originFrame;
                         if (self.commentViewDelegate) {
                             [self.commentViewDelegate finishMove];
                         }
                     }];
}

#pragma mark - UIWebView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f",9.0];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
