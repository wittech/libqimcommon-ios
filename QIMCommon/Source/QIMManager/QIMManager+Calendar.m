//
//  QIMManager+Calendar.m
//  QIMCommon
//
//  Created by 李露 on 2018/9/6.
//  Copyright © 2018年 QIMKit. All rights reserved.
//

#import "QIMManager+Calendar.h"

@implementation QIMManager (Calendar)

- (NSArray *)selectTripByYearMonth:(NSString *)date {
    return [[IMDataManager sharedInstance] qimDB_SelectTripByYearMonth:date];
}

- (void)getRemoteUserTripList {
    NSString *destUrl = [NSString stringWithFormat:@"%@/scheduling/get_update_list.qunar", [[QIMNavConfigManager sharedInstance] newerHttpUrl]];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    NSString *requestHeaders = [NSString stringWithFormat:@"q_ckey=%@", [[QIMManager sharedInstance] thirdpartKeywithValue]];
    [cookieProperties setObject:requestHeaders forKey:@"Cookie"];
    [cookieProperties setObject:@"application/json;" forKey:@"Content-type"];
    QIMVerboseLog(@"获取该用户会议列表q_ckey : %@", requestHeaders);
    
    NSMutableDictionary *bodyProperties = [NSMutableDictionary dictionary];
    long long version = [[[IMDataManager sharedInstance] qimDB_getConfigInfoWithConfigKey:[self transformClientConfigKeyWithType:QIMClientConfigTypeKLocalTripUpdateTime] WithSubKey:[[QIMManager sharedInstance] getLastJid] WithDeleteFlag:NO] longLongValue];
    
    [bodyProperties setQIMSafeObject:[NSString stringWithFormat:@"%lld", version] forKey:@"updateTime"];
    [bodyProperties setQIMSafeObject:[[QIMManager sharedInstance] getLastJid] forKey:@"userName"];
    
    QIMVerboseLog(@"获取该用户会议列表Body : %@", [[QIMJSONSerializer sharedInstance] serializeObject:bodyProperties]);
    QIMHTTPRequest *request = [[QIMHTTPRequest alloc] initWithURL:[NSURL URLWithString:destUrl]];
    [request setHTTPMethod:QIMHTTPMethodPOST];
    [request setHTTPBody:[[QIMJSONSerializer sharedInstance] serializeObject:bodyProperties error:nil]];
    request.HTTPRequestHeaders = cookieProperties;
    __weak __typeof(self) weakSelf = self;
    [QIMHTTPClient sendRequest:request complete:^(QIMHTTPResponse *response) {
        if (response.code == 200) {
            __typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            NSData *responseData = [response data];
            NSDictionary *result = [[QIMJSONSerializer sharedInstance] deserializeObject:responseData error:nil];
            if ([[result objectForKey:@"ret"] boolValue]) {
                NSDictionary *tripsData = [result objectForKey:@"data"];
                NSArray *tripsList = [tripsData objectForKey:@"trips"];
                [[IMDataManager sharedInstance] qimDB_bulkInsertTrips:tripsList];

                NSString *updateTime = [tripsData objectForKey:@"updateTime"];
                NSString *jid = [[QIMManager sharedInstance] getLastJid];
                NSArray *configArray = @[@{@"subkey":jid?jid:@"", @"configinfo":updateTime}];
                [[IMDataManager sharedInstance] qimDB_bulkInsertConfigArrayWithConfigKey:[self transformClientConfigKeyWithType:QIMClientConfigTypeKLocalTripUpdateTime] WithConfigVersion:0 ConfigArray:configArray];
            }
        }
    } failure:^(NSError *error) {
        QIMErrorLog(@"获取该用户会议列表失败 : Error : %@", error);
    }];
}

- (void)createTrip:(NSDictionary *)param callBack:(QIMKitCreateTripBlock)callback {
    NSString *destUrl = [NSString stringWithFormat:@"%@/scheduling/reserve_scheduling.qunar", [[QIMNavConfigManager sharedInstance] newerHttpUrl]];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    NSString *requestHeaders = [NSString stringWithFormat:@"q_ckey=%@", [[QIMManager sharedInstance] thirdpartKeywithValue]];
    [cookieProperties setObject:requestHeaders forKey:@"Cookie"];
    [cookieProperties setObject:@"application/json;" forKey:@"Content-type"];
    QIMVerboseLog(@"新建行程或更新已有行程q_ckey : %@", requestHeaders);
    QIMVerboseLog(@"新建行程或更新已有行程Body : %@", [[QIMJSONSerializer sharedInstance] serializeObject:param]);

    QIMHTTPRequest *request = [[QIMHTTPRequest alloc] initWithURL:[NSURL URLWithString:destUrl]];
    [request setHTTPMethod:QIMHTTPMethodPOST];
    [request setHTTPBody:[[QIMJSONSerializer sharedInstance] serializeObject:param error:nil]];
    request.HTTPRequestHeaders = cookieProperties;
    __weak __typeof(self) weakSelf = self;
    [QIMHTTPClient sendRequest:request complete:^(QIMHTTPResponse *response) {
        if (response.code == 200) {
            __typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            NSData *responseData = [response data];
            NSDictionary *result = [[QIMJSONSerializer sharedInstance] deserializeObject:responseData error:nil];
            if ([[result objectForKey:@"ret"] boolValue]) {
                NSDictionary *tripsData = [result objectForKey:@"data"];
                
                NSArray *tripsList = [tripsData objectForKey:@"trips"];
                [[IMDataManager sharedInstance] qimDB_bulkInsertTrips:tripsList];
                
                NSString *updateTime = [tripsData objectForKey:@"updateTime"];
                NSString *jid = [[QIMManager sharedInstance] getLastJid];
                NSArray *configArray = @[@{@"subkey":jid?jid:@"", @"configinfo":updateTime}];
                [[IMDataManager sharedInstance] qimDB_bulkInsertConfigArrayWithConfigKey:[self transformClientConfigKeyWithType:QIMClientConfigTypeKLocalTripUpdateTime] WithConfigVersion:0 ConfigArray:configArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (callback) {
                        callback(YES);
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (callback) {
                        callback(YES);
                    }
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (callback) {
                    callback(YES);
                }
            });
        }
    } failure:^(NSError *error) {
        QIMErrorLog(@"新建行程或更新已有行程失败 : Error : %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback(YES);
            }
        });
    }];
}

- (void)getTripAreaAvailableRoom:(NSDictionary *)dateDic callBack:(QIMKitGetTripAreaAvailableRoomBlock)callback {
    NSString *destUrl = [NSString stringWithFormat:@"%@/scheduling/room_list.qunar",  [[QIMNavConfigManager sharedInstance] newerHttpUrl]];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    NSString *requestHeaders = [NSString stringWithFormat:@"q_ckey=%@", [[QIMManager sharedInstance] thirdpartKeywithValue]];
    [cookieProperties setObject:requestHeaders forKey:@"Cookie"];
    [cookieProperties setObject:@"application/json;" forKey:@"Content-type"];
    QIMVerboseLog(@"根据时间和区域id查询可预定会议室q_ckey : %@", requestHeaders);
    QIMVerboseLog(@"根据时间和区域id查询可预定会议室 Body : %@", [[QIMJSONSerializer sharedInstance] serializeObject:dateDic]);
    QIMHTTPRequest *request = [[QIMHTTPRequest alloc] initWithURL:[NSURL URLWithString:destUrl]];
    [request setHTTPMethod:QIMHTTPMethodPOST];
    [request setHTTPBody:[[QIMJSONSerializer sharedInstance] serializeObject:dateDic error:nil]];
    request.HTTPRequestHeaders = cookieProperties;
    __weak __typeof(self) weakSelf = self;
    [QIMHTTPClient sendRequest:request complete:^(QIMHTTPResponse *response) {
        if (response.code == 200) {
            __typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            NSData *responseData = [response data];
            NSDictionary *result = [[QIMJSONSerializer sharedInstance] deserializeObject:responseData error:nil];
            if ([[result objectForKey:@"ret"] boolValue]) {
                NSArray *availableRoomData = [result objectForKey:@"data"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (callback) {
                        callback(availableRoomData);
                    }
                });
            }
        }
    } failure:^(NSError *error) {
        QIMErrorLog(@"根据时间和区域id查询可预定会议室失败 : Error : %@", error);
    }];
}

- (void)tripMemberCheck:(NSDictionary *)params callback:(QIMKitGetTripMemberCheckBlock)callback {
    NSString *destUrl = [NSString stringWithFormat:@"%@/scheduling/get_scheduling_conflict.qunar", [[QIMNavConfigManager sharedInstance] newerHttpUrl]];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    NSString *requestHeaders = [NSString stringWithFormat:@"q_ckey=%@", [[QIMManager sharedInstance] thirdpartKeywithValue]];
    [cookieProperties setObject:requestHeaders forKey:@"Cookie"];
    [cookieProperties setObject:@"application/json;" forKey:@"Content-type"];
    QIMVerboseLog(@"检查用户该时间段是否有冲突行程q_ckey : %@", requestHeaders);
    
    QIMHTTPRequest *request = [[QIMHTTPRequest alloc] initWithURL:[NSURL URLWithString:destUrl]];
    [request setHTTPMethod:QIMHTTPMethodPOST];
    [request setHTTPBody:[[QIMJSONSerializer sharedInstance] serializeObject:params error:nil]];
    request.HTTPRequestHeaders = cookieProperties;
    
    QIMVerboseLog(@"检查用户该时间段是否有冲突行程Body : %@", [[QIMJSONSerializer sharedInstance] serializeObject:params]);
    __weak __typeof(self) weakSelf = self;
    [QIMHTTPClient sendRequest:request complete:^(QIMHTTPResponse *response) {
        if (response.code == 200) {
            __typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            NSData *responseData = [response data];
            NSDictionary *result = [[QIMJSONSerializer sharedInstance] deserializeObject:responseData error:nil];
            if ([[result objectForKey:@"ret"] boolValue]) {
                NSDictionary *resultData = [result objectForKey:@"data"];
                BOOL isConform = [[resultData objectForKey:@"isConform"] boolValue];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (callback) {
                        callback(isConform);
                    }
                });
            }
        }
    } failure:^(NSError *error) {
        QIMErrorLog(@"检查用户该时间段是否有冲突行程失败 : Error : %@", error);
    }];
}

- (NSArray *)getLocalAreaList {
    return [[IMDataManager sharedInstance] qimDB_getLocalArea];
}

- (void)getRemoteAreaList {
    NSString *destUrl = [NSString stringWithFormat:@"%@/scheduling/area_list.qunar", [[QIMNavConfigManager sharedInstance] newerHttpUrl]];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    NSString *requestHeaders = [NSString stringWithFormat:@"q_ckey=%@", [[QIMManager sharedInstance] thirdpartKeywithValue]];
    [cookieProperties setObject:requestHeaders forKey:@"Cookie"];
    [cookieProperties setObject:@"application/json;" forKey:@"Content-type"];
    QIMVerboseLog(@"获取远端支持的行程区域q_ckey : %@", requestHeaders);
    
    QIMHTTPRequest *request = [[QIMHTTPRequest alloc] initWithURL:[NSURL URLWithString:destUrl]];
    request.useCookiePersistence = NO;
    request.HTTPRequestHeaders = cookieProperties;
    __weak __typeof(self) weakSelf = self;
    [QIMHTTPClient sendRequest:request complete:^(QIMHTTPResponse *response) {
        if (response.code == 200) {
            __typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            NSData *responseData = [response data];
            NSDictionary *result = [[QIMJSONSerializer sharedInstance] deserializeObject:responseData error:nil];
            if ([[result objectForKey:@"ret"] boolValue]) {
                NSDictionary *areaData = [result objectForKey:@"data"];
                NSArray *areaList = [areaData objectForKey:@"list"];
                [[IMDataManager sharedInstance] qimDB_bulkInsertArea:areaList];
            }
        }
    } failure:^(NSError *error) {
        QIMErrorLog(@"获取远端支持的行程区域失败 : Error : %@", error);
    }];
}

@end
