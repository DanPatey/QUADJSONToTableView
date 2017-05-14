//
//  NetworkingHelper.m
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/13/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import "NetworkingHelper.h"

@implementation NetworkingHelper

- (void)makeJSONRequest {
    NSString *planJSON = @"http://input.fitplanapp.com/fitplan-server/v2/plans?locale=en";
    
    // Build the request and send it async
    NSURL *msgURL = [NSURL URLWithString:planJSON];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *messageTask = [session dataTaskWithURL:msgURL completionHandler:^
                                     (NSData *data, NSURLResponse * response, NSError * error) {
         // Parse our JSON response into an dictionary
         NSError *parseError = nil;
         NSDictionary *rawResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:&parseError];
         if (!parseError) {
             NSLog(@"JSON Response: %@", rawResponse);
         } else {
             NSString *err = [parseError localizedDescription];
             NSLog(@"Encountered an error parsing: %@", err);
         }
         
         // Pop out results
         NSDictionary *jsonResponse = [rawResponse valueForKey:@"result"];
     }];
    [messageTask resume];
}

@end
