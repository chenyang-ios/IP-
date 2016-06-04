//
//  ViewController.m
//  IP地址查询
//
//  Created by user2 on 16/5/17.
//  Copyright © 2016年 com.chenyang.www. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    
    UITextField *textfield;
    NSDictionary *dicRetData;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //ip地址查询
    
    textfield = [[UITextField  alloc]initWithFrame:CGRectMake(50, 200, 230, 50)];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.textColor = [UIColor blackColor];
    textfield.tag = 101;
    textfield.font = [UIFont systemFontOfSize:20];
    textfield.backgroundColor = [UIColor greenColor];
    textfield.userInteractionEnabled = YES;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [textfield addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textfield];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(285, 200, 50, 50);
    button.backgroundColor = [UIColor colorWithRed:0.2972 green:0.3759 blue:0.9659 alpha:1.0];
    [button setTitle:@"查询" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button  addTarget:self action:@selector(chaxun) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 280, 300, 50)];
    label.backgroundColor = [UIColor orangeColor];
    
    label.tag = 100;
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];

    
    
    
    
//测试数据117.89.35.58     123.52.128.0
    
    
    
}

-(void)valueChanged:(UITextField *)sender{
    
    
    dispatch_queue_t  mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        
        
        if (textfield.text ==nil) {
            
            UILabel *label = [self.view viewWithTag:100];
            label.text =nil;
            
        }else{
            
            
            UILabel *label = [self.view viewWithTag:100];
            label.text = [NSString  stringWithFormat:@"%@%@%@%@",dicRetData[@"country"],dicRetData[@"province"],dicRetData[@"city"],dicRetData[@"district"]];

            
        }
        
        
        
        
        
        
    });
    

    
    
}
-(void)chaxun{
    
    
    NSString *string = [NSString stringWithFormat:@"http://apis.baidu.com/apistore/iplookupservice/iplookup?ip=%@",textfield.text];
    
    NSURL *url = [NSURL URLWithString:string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //添加请求头
    [request addValue:@"c0bc864213ba7eb479738dfd5127d94d" forHTTPHeaderField:@"apikey"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"解析好的数据%@",dic);
        //数据字典
        dicRetData = dic[@"retData"];
        //取出字典中的元素(carrier city country district ip province)
//      [self performSelectorOnMainThread:@selector(addLabel) withObject:dicRetData waitUntilDone:YES];
//        
        
        
    }];
 //dicRetData[@"city"],dicRetData[@"country"],dicRetData[@"district"],dicRetData[@"province"]
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
