//
//  NSString+Category.m
//  GeihuiDemo
//
//  Created by peikua on 17/3/23.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import "NSString+Category.h"

#import <CommonCrypto/CommonHMAC.h>

#import "RegalurUtil.h"

@implementation NSString (Category)

- (id)jsonValueDecoded {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

- (NSString *)md5FromString
{
    if([self length] == 0){
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *md5String = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [md5String appendFormat:@"%02x",outputBuffer[count]];
    }
    return md5String;
}

- (BOOL)roughValidateMobile{
    if(!self.length)return NO;
     return [RegalurUtil isMatchString:self withRule:@"^[1][3,4,5,7,8][0-9]{9}$"];
}

- (BOOL)validateMobile{
    if(!self.length)return NO;
   return [RegalurUtil isMatchString:self withRule:@"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$"];
}

- (BOOL)validateEmail{
    return [RegalurUtil isMatchString:self withRule:@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

-(NSString *)urlAddCompnentForValue:(NSString *)value key:(NSString *)key{
    
    NSMutableString *string = [[NSMutableString alloc]initWithString:self];
    @try {
        NSRange range = [string rangeOfString:@"?"];
        if (range.location != NSNotFound) {//找到了
            //如果?是最后一个直接拼接参数
            if (string.length == (range.location + range.length)) {
                NSLog(@"最后一个是?");
                string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{//如果不是最后一个需要加&
                if([string hasSuffix:@"&"]){//如果最后一个是&,直接拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
                }else{//如果最后不是&,需要加&后拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
                }
            }
        }else{//没找到
            if([string hasSuffix:@"&"]){//如果最后一个是&,去掉&后拼接
                string = (NSMutableString *)[string substringToIndex:string.length-1];
            }
            string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"?%@=%@",key,value]];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    return string.copy;
}

@end
