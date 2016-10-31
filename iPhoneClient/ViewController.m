//
//  ViewController.m
//  iPhoneClient
//
//  Created by 杨剑 on 16/10/18.
//  Copyright © 2016年 贱贱. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()







void CFStreamCreatePairWithSocketToHost(
    CFAllocatorRef alloc,
    CFStringRef host,
    UInt32 port,
    CFReadStreamRef *readStream,
    CFWriteStreamRef *writeStream

                                        
);



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _client = [[JJBonjour alloc] init];
}



- (void)initNetworkCommunication{

    CFReadStreamRef readStream;
    
    CFWriteStreamRef writeStream;
    
//    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"169.254.250.218", PORT, &readStream, &writeStream);

    _inputStream = (__bridge_transfer NSInputStream *)readStream;
    
    _outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    [_outputStream open];
    

    
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:1];
    
}

//单击发送按钮
- (IBAction)sendData:(UIButton *)sender{
    [self.view endEditing:1];
    flag = 0;
//    [self initNetworkCommunication];
    [self openStream];


    
}

//单击接收按钮
- (IBAction)receiveData:(UIButton *)sender{
    [self.view endEditing:1];
    flag = 1;
//    [self initNetworkCommunication];
    [self openStream];
}

- (void)close{
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _inputStream.delegate = nil;
    
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _outputStream.delegate = nil;
    
}

//- (void)closeStream{
//    [_inputStream close];
//    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    _inputStream.delegate = nil;
//    
//    [_outputStream close];
//    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    _outputStream.delegate = nil;
//    
//}



- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{

    NSString *event;
    switch (eventCode) {
        case NSStreamEventNone:
            event = @"NSStreamEventNone";
            break;
            
        case NSStreamEventOpenCompleted:
            event = @"NSStreamEventOpenCompleted";
            break;
        case NSStreamEventHasBytesAvailable:
            event = @"NSStreamEventHasBytesAvailable";
            
            if (flag == 1 &&aStream == _inputStream) {
                NSMutableData *input = [[NSMutableData alloc] init];
                uint8_t buffer[1024];
                long len;
                while ([_inputStream hasBytesAvailable]) {
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        [input appendBytes:buffer length:len];
                    }
                }
                NSString *resultstring = [[NSString alloc] initWithData:input encoding:NSUTF8StringEncoding];
                NSLog(@"接收:%@",resultstring);
                _message.text = resultstring;
            }
            break;
        case NSStreamEventHasSpaceAvailable:
            event = @"NSStreamEventNone";
            
            if (flag == 0 &&aStream == _outputStream) {
                //输出
                
//                UInt8 buff[] = "Hello Server!!!";
                
                
//                NSString *string = [NSString stringWithFormat:@"%@",string]

                
                
                
                //Unicode：把世界上所有的符号都纳入其中，包括英文、日本、中文等等，现在能容纳100多万个符号。这样效率上就不好，于是UTF-8出现了，它可以根据不同的符号自动选择编码的长短。
                
                //NSString *str = @"杨剑str我是杨剑;\n=2100YANGjian( !@#$%^&*()<>?,./:\";'{}|[]\%22)";
//                 = [_sendmessage.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                
                
                
                
                NSString *asc = [_sendmessage.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                
                //NSString *unasc = [asc stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                NSLog(@"%@,%@",asc,unasc);
                

                UInt8 buff[1024];
                memcpy(buff, [asc UTF8String], asc.length + 1);
                
                printf("\n\n%s --- %u \n\n",buff,_sendmessage.text.length);
                NSLog(@"%@",_sendmessage.text);
                
                [_outputStream write:buff maxLength:strlen((const char *)buff) +1];
                [_outputStream close];
            }
            
            break;
        case NSStreamEventErrorOccurred:
            event = @"NSStreamEventErrorOccurred";
            NSLog(@"Error:%d:%@",(int)[[aStream streamError] code],[[aStream streamError] localizedDescription]);
            [self close];
            break;
        case NSStreamEventEndEncountered:
            event = @"NSStreamEventEndEncountered";
            NSLog(@"Error:%d:%@",(int)[[aStream streamError] code],[[aStream streamError] localizedDescription]);
            break;
        default:
            [self close];
            break;
            
            
            
    }

    NSLog(@"%@",event);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (void)openStream{

    for (NSNetService *service in _client.services) {
        if ([@"tony" isEqualToString:service.name]) {
            if (![service getInputStream:&_inputStream outputStream:&_outputStream]) {
                NSLog(@"连接服务器失败");
                return;
            }
            break;
        }
    }
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    [_outputStream open];



}






















@end




















































