//
//  RKNetworkHelper.h
//  Refactoring
//
//  Created by 111 on 2019/6/19.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *AFN封装的网络请求类
 *
 *
 */
NS_ASSUME_NONNULL_BEGIN

@interface XMNetworkHelper : NSObject

+ (instancetype)sharedNetworkHelper;

/**
 GET请求接口
 @param url 请求接口
 @param parameters 接口传入参数内容
 @param progress 网络请求进度
 @param success 成功Block回调
 @param failure 失败Block回调
 */
- (void)GETUrl:(NSString *)url
    parameters:(id)parameters
      progress:(void(^)(NSProgress *downloadProgress))progress
       success:(void(^)(id responseObject))success
       failure:(void(^)(NSError *error))failure;

/**
 @param url 请求接口
 @param parameters 接口传入参数内容
 @param progress 网络请求进度
 @param success 成功Block回调
 @param failure 失败Block回调
 */
- (void)POSTUrl:(NSString *)url
     parameters:(id)parameters
       progress:(void(^)(NSProgress *downloadProgress))progress
        success:(void(^)(id responseObject))success
        failure:(void(^)(NSError *error))failure;

/**
 *上传单张图片
 @param urlStr 请求接口
 @param parameters 接口传入参数内容
 @param photoData 图片数组
 @param progress 网络请求进度
 @param success 成功Block回调
 @param failure 失败Block回调
 */
- (void)uploadOneFileWithUrlStr:(NSString *)urlStr
                     parameters:(NSDictionary *)parameters
                      photoData:(UIImage *)photoData
                      photoName:(NSString *)photoName
                       progress:(void(^)(NSProgress *progress))progress
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure;

/**
 *上传多张图片
 @param url 请求接口
 @param parameters 接口传入参数内容
 @param photoArray 图片数组
 @param progress 网络请求进度
 @param success 成功Block回调
 @param failure 失败Block回调
 */
- (void)uploadMultipleFileWithUrl:(NSString *)url
                       parameters:(NSDictionary *)parameters
                       photoArray:(NSArray *)photoArray
                         progress:(void(^)(NSProgress *uploadProgress))progress
                          success:(void(^)(id responseObject))success
                          failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
