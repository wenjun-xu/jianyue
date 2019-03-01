//
//  ConverListViewController.h
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/17.
//  Copyright © 2019 徐庆标. All rights reserved.
//

#import "EaseConversationListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConverListViewController : EaseConversationListViewController
@property (strong, nonatomic) NSMutableArray *conversationsArray;

- (void)refresh;
- (void)refreshDataSource;

- (void)isConnect:(BOOL)isConnect;
- (void)networkChanged:(EMConnectionState)connectionState;
@end

NS_ASSUME_NONNULL_END
