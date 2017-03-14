//
//  ViewController.m
//  KeyChainDemo
//
//  Created by elion on 17/3/14.
//  Copyright © 2017年 elion. All rights reserved.
//

#import "ViewController.h"
#import "GZKeyChain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //保存或更新
    [GZKeyChain saveUserName:@"张三" pwd:@"asdfghjkl"];
    [GZKeyChain saveUserName:@"lisi" pwd:@"asrtyui"];
    [GZKeyChain saveUserName:@"张三" pwd:@"rtghnm,loi"];//会覆盖先前密码
    
    //查询所有用户的账号密码
    NSDictionary *dic = [GZKeyChain loadAccountInfo];
    NSLog(@"dic = %@",dic);
    
    //查询某一用户的账号密码
    NSString *pwd = [GZKeyChain loadPwdForUserName:@"lisi"];
    NSLog(@"userPwd = %@",pwd);
    
    //删除某一用户的账号密码
    [GZKeyChain removeForUserName:@"张三"];
    NSLog(@"dic1 = %@",[GZKeyChain loadAccountInfo]);
    
    //删除所有用户的账号密码
    [GZKeyChain removeAll];
    NSLog(@"dic2 = %@",[GZKeyChain loadAccountInfo]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
