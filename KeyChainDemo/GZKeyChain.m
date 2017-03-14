//
//  GZKeyChain.m
//  KeyChainDemo
//
//  Created by elion on 17/3/14.
//  Copyright © 2017年 elion. All rights reserved.
//

#import "GZKeyChain.h"

@implementation GZKeyChain

+ (NSString *)defaultService
{
    return [[NSBundle mainBundle] bundleIdentifier] ? : @"";
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service 
{
    if (!service) service = self.defaultService;
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

#pragma mark 写入
+ (void)saveUserName:(NSString *)userName pwd:(NSString *)pwd
{
    [self saveUserName:userName pwd:pwd service:nil];
}

+ (void)saveUserName:(NSString *)userName pwd:(NSString *)pwd service:(NSString *)service
{
    if (![userName isKindOfClass:[NSString class]]) return;
    if (!userName || !pwd) return;
    
    NSMutableDictionary *query = [self getKeychainQuery:service];
    NSDictionary *results = [self loadAccountInfoWithService:service];
    SecItemDelete((CFDictionaryRef)query);
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:results ?:@{}];
    [dataDic setObject:pwd forKey:userName];
    [query setObject:[NSKeyedArchiver archivedDataWithRootObject:dataDic] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)query, NULL);
}


#pragma mark 读取
+ (NSDictionary *)loadAccountInfo
{
    return [self loadAccountInfoWithService:nil];
}

+ (NSDictionary *)loadAccountInfoWithService:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];

    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}


+ (NSString *)loadPwdForUserName:(NSString *)userName
{
    return [self loadPwdForUserName:userName service:nil];
}

+ (NSString *)loadPwdForUserName:(NSString *)userName service:(NSString *)service
{
    if (!userName) return nil;
    NSDictionary *results = [self loadAccountInfoWithService:service];
    if (![results isKindOfClass:[NSDictionary class]]) return nil;
    return [results objectForKey:userName];
}

#pragma mark 删除
+ (void)removeAll
{
    [self removeAllWithService:nil];
}

+ (void)removeAllWithService:(NSString *)service 
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (void)removeForUserName:(NSString *)userName
{
    [self removeForUserName:userName service:nil];
}

+ (void)removeForUserName:(NSString *)userName service:(NSString *)service
{
    NSDictionary *results = [self loadAccountInfoWithService:service];
    if (!results) return;
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:results];
    [dataDic removeObjectForKey:userName];
    NSMutableDictionary *query = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)query);
    [query setObject:[NSKeyedArchiver archivedDataWithRootObject:dataDic] forKey:(id)kSecValueData];
    SecItemAdd((CFDictionaryRef)query, NULL);
}



@end
