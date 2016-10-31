//
//  ViewController.h
//  iPhoneClient
//
//  Created by 杨剑 on 16/10/18.
//  Copyright © 2016年 贱贱. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <CoreFoundation/CoreFoundation.h>

//解析服务
#import "JJBonjour.h"
//查找服务
#import "JJBonjourBrowser.h"




@interface ViewController : UIViewController<NSStreamDelegate>
{

    int flag;



}


@property (nonatomic,strong)NSInputStream *inputStream;

@property (nonatomic,strong)NSOutputStream *outputStream;


@property (nonatomic,strong)JJBonjour *client;







@property (weak,nonatomic)IBOutlet UILabel *message;

@property (weak, nonatomic) IBOutlet UITextField *sendmessage;


- (IBAction)sendData:(UIButton *)sender;
- (IBAction)receiveData:(UIButton *)sender;









@end















