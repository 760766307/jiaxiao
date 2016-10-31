//
//  JJBonjourBrowser.h
//  iPhoneClient
//
//  Created by 杨剑 on 16/10/19.
//  Copyright © 2016年 贱贱. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

@interface JJBonjourBrowser : NSObject<NSNetServiceBrowserDelegate>
{
    int port;
}


@property (nonatomic,strong)NSMutableArray *services;
@property (nonatomic,strong)NSNetServiceBrowser *serviceBrowser;



@end
