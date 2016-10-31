//
//  JJBonjourBrowser.m
//  iPhoneClient
//
//  Created by 杨剑 on 16/10/19.
//  Copyright © 2016年 贱贱. All rights reserved.
//

#import "JJBonjourBrowser.h"

@implementation JJBonjourBrowser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _services = [[NSMutableArray alloc] init];
        _serviceBrowser = [[NSNetServiceBrowser alloc] init];
        _serviceBrowser.delegate = self;
        [_serviceBrowser searchForServicesOfType:@"_tonyipp.tcp." inDomain:@"local."];
        
    }
    return self;
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing{

    NSLog(@"didFindDomain");

}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveDomain:(NSString *)domainString moreComing:(BOOL)moreComing{

    NSLog(@"didRemoveDomain");


}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing{
    NSLog(@"didfindservice");
    NSLog(@"didFindService:%@lenght:%d",service.name,(int)[service.name length]);
    
    [_services addObject:service];
    
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing{
    NSLog(@"didRemoveService");
    [_services removeObject:service];
}


- (void)netServiceBrowser:(NSNetServiceBrowser *)browser didNotSearch:(NSDictionary<NSString *,NSNumber *> *)errorDict{


    NSLog(@"didNotSearch");

}

- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)browser{

    NSLog(@"netServiceBrowserWillSearch");

}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)browser{

    NSLog(@"netServiceBrowserDidStopSearch");

}












@end

















