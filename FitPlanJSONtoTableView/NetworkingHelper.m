//
//  NetworkingHelper.m
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/13/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import "NetworkingHelper.h"

@implementation NetworkingHelper

- (void)getJSONResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError *error))failure {
    
    // Build the request and send it async
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^
                                     (NSData *data, NSURLResponse * response, NSError * error) {
                                         if (error) {
                                             failure(error);
                                         } else {
                                             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                             success(json);
                                         }
                                     }];
    [dataTask resume];
}

@end
