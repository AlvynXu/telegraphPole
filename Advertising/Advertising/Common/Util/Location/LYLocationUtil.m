//
//  LYLocationUtil.m
//  LYLocation
//
//  Created by admin on 2018/7/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "LYLocationUtil.h"
#import <UIKit/UIKit.h>


@interface LYLocationUtil()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManger;
@property (copy, nonatomic) LYLocationResuleBlock locationResultBlock;
@property (copy, nonatomic) LYLocationResuleBlock locateOnceResultBlock;

@end

static NSString *local_Key_city = @"local_Key_city";

static NSString *local_Key_paraent = @"local_Key_paraent";

@implementation LYLocationUtil

+ (NSString *)getLocalCity
{
    return [kUserDefaults objectForKey:local_Key_city];
}

+ (NSString *)getLocalParaent
{
    return [kUserDefaults objectForKey:local_Key_paraent];
}

+ (void)setLocalCity:(NSString *)value
{
    [kUserDefaults setObject:value forKey:local_Key_city];
    [kUserDefaults synchronize];
}

+ (void)setLocalParaent:(NSString *)value
{
    [kUserDefaults setObject:value forKey:local_Key_paraent];
    [kUserDefaults synchronize];
}

+ (instancetype)sharedLocationUtil
{
    static LYLocationUtil *sharedLocationUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationUtil = [[LYLocationUtil alloc] init];
    });
    
    return sharedLocationUtil;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.locationManger = [[CLLocationManager alloc] init];
        self.locationManger.delegate = self;
        self.locationManger.distanceFilter = kCLDistanceFilterNone;
//        self.locationManger.distanceFilter = 1;
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManger.pausesLocationUpdatesAutomatically = NO;
        if (@available(iOS 8.0, *))
        {
            //请求一直定位
            [self.locationManger requestAlwaysAuthorization];
            //请求使用中定位
            [self.locationManger requestWhenInUseAuthorization];
        }
        if (@available(iOS 9.0, *))
        {
            self.locationManger.allowsBackgroundLocationUpdates = YES;
        }
        if (@available(iOS 11.0, *))
        {
            self.locationManger.showsBackgroundLocationIndicator = YES;
        }
    }
    
    return self;
}

#pragma mark - func

+ (void)startUpdateLocationAlwaysWith:(LYLocationResuleBlock)locationResultBlock
{
    [[self sharedLocationUtil] startUpdateLocationAlwaysWith:locationResultBlock];
}

- (void)startUpdateLocationAlwaysWith:(LYLocationResuleBlock)locationResultBlock
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"定位权限未开");
        return;
    }
    
    self.locationResultBlock = locationResultBlock;
    [self.locationManger startUpdatingLocation];
}

+ (void)startLocateOnceWith:(LYLocationResuleBlock)locateOnceResultBlock hudView:(UIView *)view
{
    [[self sharedLocationUtil] startLocateOnceWith:locateOnceResultBlock hudView:view];
}

- (void)startLocateOnceWith:(LYLocationResuleBlock)locateOnceResultBlock hudView:(UIView *)view
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"定位权限未开");
        if (view) {
//            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        return;
    }
    
    if (@available(iOS 9.0, *))
    {
        self.locateOnceResultBlock = locateOnceResultBlock;
        [self.locationManger requestLocation];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{    
    !self.locationResultBlock ? : self.locationResultBlock(manager, locations);
    !self.locateOnceResultBlock ? : self.locateOnceResultBlock(manager, locations);
    self.locateOnceResultBlock = nil;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            
            break;
        }
        // 访问受限
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
            }else
            {
                NSLog(@"定位关闭，不可用, 请在设置中打开定位服务选项");
            }
//            NSLog(@"被拒");
            break;
        }
        // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获取前后台定位授权");
            //获取当前位置
            CLLocation * location = manager.location;
            //获取坐标
            CLLocationCoordinate2D corrdinate = location.coordinate;
            // 地址的编码通过经纬度得到具体的地址
            CLGeocoder *gecoder = [[CLGeocoder alloc] init];
            [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                
                if(error){
                    // 地址编码解析错误
                    NSLog(@"地址编码解析错误: %@", error);
                    // 编码解析错误 默认 浙江省杭州市
                    NSString *localCity = @"杭州市";
                    NSString *localParent = @"浙江省";
                    [LYLocationUtil setLocalCity:localCity];
                    [LYLocationUtil setLocalParaent:localParent];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"city_local_notivation" object:nil userInfo:@{@"local":localCity, @"parent":localParent}];
                    
                }else{
                    CLPlacemark *placemark = [placemarks firstObject];
                    // 获取定位
                    NSString *localCity = placemark.addressDictionary[@"City"];
                    NSString *localParent = placemark.addressDictionary[@"State"];
                    [LYLocationUtil setLocalCity:localCity];
                    [LYLocationUtil setLocalParaent:localParent];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"city_local_notivation" object:nil userInfo:@{@"local":localCity, @"parent":localParent}];
                }
            }];
            break;
        }
        // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            
            //获取当前位置
            CLLocation * location = manager.location;
            //获取坐标
            CLLocationCoordinate2D corrdinate = location.coordinate;
            // 地址的编码通过经纬度得到具体的地址
            CLGeocoder *gecoder = [[CLGeocoder alloc] init];
            [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                
                if(error){
                    // 地址编码解析错误  错误默认浙江省杭州市
                    NSLog(@"地址编码解析错误: %@", error);
                    // 编码解析错误 默认 浙江省杭州市
                    NSString *localCity = @"杭州市";
                    NSString *localParent = @"浙江省";
                    [LYLocationUtil setLocalCity:localCity];
                    [LYLocationUtil setLocalParaent:localParent];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"city_local_notivation" object:nil userInfo:@{@"local":localCity, @"parent":localParent}];
                    
                }else{
                    CLPlacemark *placemark = [placemarks firstObject];
                    // 获取定位
                    NSString *localCity = placemark.addressDictionary[@"City"];
                    NSString *localParent = placemark.addressDictionary[@"State"];
                    [LYLocationUtil setLocalCity:localCity];
                    [LYLocationUtil setLocalParaent:localParent];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"city_local_notivation" object:nil userInfo:@{@"local":localCity, @"parent":localParent}];
                }
            }];
            break;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"error:%@", error);
}

+ (BOOL)checkLocaltionIsDenied
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
        //定位功能可用
//        NSLog(@"---------===  %@", [self getLocalCity]);
//        if ([[self getLocalCity] isEmpty]) {
//            NSLog(@"***************  城市为空");
//            [self startLocateOnceWith:^(CLLocationManager *locationManager, NSArray<CLLocation *> *updateLocations) {
//                //获取当前位置
//                CLLocation * location = locationManager.location;
//                //获取坐标
//                CLLocationCoordinate2D corrdinate = location.coordinate;
//                // 地址的编码通过经纬度得到具体的地址
//                CLGeocoder *gecoder = [[CLGeocoder alloc] init];
//                [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//
//                    if(error){
//                        // 地址编码解析错误
//                        NSLog(@"地址编码解析错误: %@", error);
//                    }else{
//                         CLPlacemark *placemark = [placemarks firstObject];
//                        // 获取定位
//                        NSString *localCity = placemark.addressDictionary[@"City"];
//                        NSString *localParent = placemark.addressDictionary[@"State"];
//                        [LYLocationUtil setLocalCity:localCity];
//                        [LYLocationUtil setLocalParaent:localParent];
//                         [[NSNotificationCenter defaultCenter] postNotificationName:@"city_local_notivation" object:nil userInfo:@{@"local":localCity, @"parent":localParent}];
//                    }
//                }];
//            } hudView:nil];
//        }
        
        return NO;
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        
        QKAlertView *alertV = [[QKAlertView alloc] initWithTitle:@"提示" message:@"请去手机设置打开定位权限" buttonTitles:@"去开启", nil];
        alertV.messageLblFont = kSysFont(14);
        [alertV showWithCompletion:^(NSInteger index, NSString *msg) {
           
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        //定位不能用
        return YES;
    }else{
        return NO;
    }
}

@end
