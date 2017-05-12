//
//  ViewController.m
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/12/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"ViewWillAppear has fired");
    NSString *planJSON = @"http://input.fitplanapp.com/fitplan-server/v2/plans?locale=en";
    
    // Build the request and send it async
    NSURL *msgURL = [NSURL URLWithString:planJSON];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *messageTask = [session dataTaskWithURL:msgURL completionHandler:^
                                     (NSData *data, NSURLResponse * response, NSError * error)
        {
            // Parse our JSON response into an array
            NSError *parseError = nil;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                        error:&parseError];
            
            if (!parseError) {
                NSLog(@"json array is %@", jsonArray);
            } else {
                NSString *err = [parseError localizedDescription];
                NSLog(@"Encountered an error parsing: @", err);
            }
        }];
    [messageTask resume];
}

@end
