//
//  FileUtil.m
//  DPool
//
//  Created by dengchenglin on 2018/9/11.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (void)clearWebCaches{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self removeApplicationLibraryDirectoryWithDirectory:@"Caches"];
    [self removeApplicationLibraryDirectoryWithDirectory:@"WebKit"];
    // Empty the cookie jar...
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    [self removeApplicationLibraryDirectoryWithDirectory:@"Cookies"];

}

+ (void)removeApplicationLibraryDirectoryWithDirectory:(NSString *)dirName {
    NSString *dir = [[[[NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) lastObject]stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:dirName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        [[NSFileManager defaultManager] removeItemAtPath:dir error:nil];
    }
}



@end
