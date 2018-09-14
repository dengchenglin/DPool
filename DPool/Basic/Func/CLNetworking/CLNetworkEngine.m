//
//  HLNetworkEngine.m
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//

#import "CLNetworkEngine.h"
#import "CLURLRequest.h"
#import "CLNetworkConfig.h"
#import "CLNetworkDefines.h"
#import <AFNetworking/AFNetworking.h>

@interface CLNetworkEngine ()

@property (nonatomic, strong) NSMutableDictionary *sessionManagerCache;

@property (nonatomic, strong) NSMutableDictionary *sessionTaskCache;

@end

@implementation CLNetworkEngine

+ (CLNetworkEngine *)sharedEngine {
    static CLNetworkEngine *networkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkEngine = [[self alloc] init];
    });
    return networkEngine;
}

- (NSMutableDictionary<NSString *,AFURLSessionManager *> *)sessionManagerCache{
    if(!_sessionManagerCache){
        _sessionManagerCache = [NSMutableDictionary dictionary];
    }
    return _sessionManagerCache;
}

- (NSMutableDictionary *)sessionTaskCache{
    if(_sessionTaskCache){
        _sessionTaskCache = [NSMutableDictionary dictionary];
    }
    return _sessionTaskCache;
}


- (void)sendRequest:(__kindof CLRequest * _Nonnull)request
          config:(CLNetworkConfig * _Nonnull)config
       progressCallBack:(CLProgressBlock _Nullable)progressCallBack
           callBack:(CLCallbackBlock _Nullable)callBack{
    if(!request)return;
    if(!config)return;
    
    //url
    NSString *baseUrl = request.baseUrl ?: config.request.baseUrl;
    NSAssert(baseUrl != nil,
             @"request baseURL 和 config.baseurl 两者必须有一个有值");
    NSURL *url = [NSURL URLWithString:baseUrl];
    if(!url.host){
        NSLog(@"requrstUrl 无效");
    }

    NSString *requestUrl = baseUrl;
    
   //path
    if(request.path){
         requestUrl = [requestUrl stringByAppendingPathComponent:request.path];
    }
   

    //params
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(config.globalParams && request.useGlobalParams){
        [params setDictionary:config.globalParams];
    }
    if(request.params){
        [params setDictionary:request.params];
    }
    
    
    
    
    //callback
    void (^progressBlock)(NSProgress *progress)
    = ^(NSProgress *progress) {
        if (progress.totalUnitCount <= 0) return;
        dispatch_async_main(^{
            if (progressCallBack) {
                progressCallBack(progress);
            }
        });
    };
    
    void (^successBlock)(NSURLSessionDataTask *task, id responseObject)
    = ^(NSURLSessionDataTask * task, id resultObject) {
        
        if (callBack) {
            
            callBack(request, resultObject, nil);
        }
        
    };
    
    void (^failureBlock)(NSURLSessionDataTask * task, NSError * error)
    = ^(NSURLSessionDataTask * task, NSError * error) {
        
        if (callBack) {
            callBack(request, nil, error);
        }
    };
    
     //request
    if([request isKindOfClass:[CLURLRequest class]]){
        CLURLRequest *urlRequest = (CLURLRequest *)request;
        AFHTTPSessionManager *sessionManager = [self createSessionManager:request config:config baseURLString:baseUrl];
        NSURLSessionDataTask *dataTask = [self sendRequestUrl:requestUrl method:urlRequest.requestMethod session:sessionManager parmas:params progressBlock:progressBlock successBlock:successBlock failureBlock:failureBlock];
        [self.sessionTaskCache setValue:dataTask forKey:request.identifier];
    }
    
}



- (NSURLSessionDataTask *)sendRequestUrl:(NSString *)requestUrl method:(CLRequestMethodType)method  session:(AFHTTPSessionManager *)session parmas:(NSDictionary *)params progressBlock:(void (^)(NSProgress *progress))progressBlock successBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))successBlock failureBlock:(void (^)(NSURLSessionDataTask * task, NSError * error))failureBlock{
 
    NSURLSessionDataTask *dataTask;
    switch (method) {
        case GET:
        {
            dataTask =
            [session GET:requestUrl
              parameters:params
                progress:progressBlock
                 success:successBlock
                 failure:failureBlock];
        }
            break;
        case POST:
        {
            dataTask =
            [session POST:requestUrl
               parameters:params
                 progress:progressBlock
                  success:successBlock
                  failure:failureBlock];
        }
            break;
            
        default:
            break;
    }
    return dataTask;
}

- (AFHTTPSessionManager *)createSessionManager:(CLRequest *)request
                                        config:(CLNetworkConfig *)config
                                 baseURLString:(NSString *)baseUrlStr

{
    AFHTTPSessionManager *sessionManager = [self.sessionManagerCache objectForKey:baseUrlStr];
    if(!sessionManager){
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.HTTPMaximumConnectionsPerHost = config.request.httpMaximumConnectionsPerHost;
        sessionConfig.requestCachePolicy = request.cachePolicy ?: config.cachePolicy;
        sessionConfig.timeoutIntervalForRequest = request.timeoutInterval ?: config.request.requestTimeoutInterval;
        sessionConfig.URLCache = config.URLCache;
 
        
        sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfig];
        [self.sessionManagerCache setObject:sessionManager forKey:baseUrlStr];
    }
    AFHTTPRequestSerializer *requestSerializer;
    switch (config.requestSerializerType) {
        case RequestHTTP:
            requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case RequestJSON:
            requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case RequestPlist:
            requestSerializer = [AFPropertyListRequestSerializer serializer];
            break;
        default:
            requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    sessionManager.requestSerializer = requestSerializer;
    AFHTTPResponseSerializer *responseSerializer;
    switch (config.responseSerializerType) {
        case ResponseHTTP:
            responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case ResponseJSON:
            responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case ResponsePlist:
            responseSerializer = [AFPropertyListResponseSerializer serializer];
            break;
        case ResponseXML:
            responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
    }
    responseSerializer.acceptableContentTypes = config.accpetContentTypes;
    sessionManager.responseSerializer = responseSerializer;
    return sessionManager;
}


- (void)cancelRequest:(CLRequest *)request{
    if(!request)return;
    NSURLSessionTask *task = self.sessionTaskCache[request.identifier];
    if(task)[task cancel];
}

- (void)resumeRequest:(CLRequest *)request{
    if(!request)return;
    NSURLSessionTask *task = self.sessionTaskCache[request.identifier];
    if(task)[task resume];
}

- (void)pauseRequest:(CLRequest *)request{
    if(!request)return;
    NSURLSessionTask *task = self.sessionTaskCache[request.identifier];
    if(task)[task suspend];
}



@end
