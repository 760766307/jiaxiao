//
//  JJBonjour.m
//  iPhoneClient
//
//  Created by 杨剑 on 16/10/19.
//  Copyright © 2016年 贱贱. All rights reserved.
//

#import "JJBonjour.h"

@implementation JJBonjour
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _service = [[NSNetService alloc] initWithDomain:@"local." type:@"_tonyipp._tcp." name:@"tony"];
        
        _service.delegate = self;
        
        [_service resolveWithTimeout:1.f];
        
        _services = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}



- (void)netServiceWillResolve:(NSNetService *)sender{
    NSLog(@"netServiceWillResolve");
    
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender{
    [_services addObject:sender];


}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary<NSString *,NSNumber *> *)errorDict{
    NSLog(@"didNotResolve%@",errorDict);


}

































@end
































