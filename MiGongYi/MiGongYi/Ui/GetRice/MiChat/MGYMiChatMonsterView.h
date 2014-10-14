//
//  MGYMiChatMonsterView.h
//  MiGongYi
//
//  Created by megil on 10/14/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGYMiChatMonsterTableViewCell.h"

@interface MGYMiChatMonsterView : UIView

- (void)resetMonsterState:(NSArray *)array;
- (void)resetMonSterStateById:(NSInteger)index
                       statue:(MGYMiChatMonsterState)state;
- (void)setFinished:(BOOL)isFinished;
@end
