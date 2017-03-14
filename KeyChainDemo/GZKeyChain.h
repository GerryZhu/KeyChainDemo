//
//  GZKeyChain.h
//  KeyChainDemo
//
//  Created by elion on 17/3/14.
//  Copyright © 2017年 elion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface GZKeyChain : NSObject


/**
 保存或更新 用户名、密码
 */
+ (void)saveUserName:(NSString *)userName pwd:(NSString *)pwd;

+ (void)saveUserName:(NSString *)userName pwd:(NSString *)pwd service:(NSString *)service;

/**
 加载所有 用户名、密码 信息 。    key：用户名， value：密码
 */
+ (NSDictionary *)loadAccountInfo;

+ (NSDictionary *)loadAccountInfoWithService:(NSString *)service;

/**
 加载某一用户的密码
 */
+ (NSString *)loadPwdForUserName:(NSString *)userName;

+ (NSString *)loadPwdForUserName:(NSString *)userName service:(NSString *)service;

/**
 移除所有账号信息
 */
+ (void)removeAll;

+ (void)removeAllWithService:(NSString *)service;

/**
 移除某一账号的密码信息
 */
+ (void)removeForUserName:(NSString *)userName;

+ (void)removeForUserName:(NSString *)userName service:(NSString *)service;

@end
