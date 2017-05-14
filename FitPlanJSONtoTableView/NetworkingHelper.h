//
//  NetworkingHelper.h
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/13/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingHelper : NSObject

- (void)getJSONResponse:(NSString *)urlStr success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError *error))failure;

@end
