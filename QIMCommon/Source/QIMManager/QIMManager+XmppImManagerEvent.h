//
//  QIMManager+XmppImManagerEvent.h
//  qunarChatIphone
//
//  Created by 李露 on 2018/4/2.
//

#import "QIMManager.h"

@interface QIMManager (XmppImManagerEvent)

- (void)registerEvent;

- (void)userMucListUpdate:(NSDictionary *)mucListDic;

@end
