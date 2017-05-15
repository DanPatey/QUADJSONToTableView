//
//  DetailViewController.m
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/13/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import "DetailViewController.h"
#import "NetworkingHelper.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UITextView *Description;
@property (weak, nonatomic) IBOutlet UILabel *Days;
@end

@implementation DetailViewController
@synthesize courseID;

NSString *nameLabel;
NSString *descriptionLabel;
NSString *daysLabel;

NSDictionary *jsonDetailResponse;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *requestURL = [NSString stringWithFormat:@"http://input.fitplanapp.com/fitplan-server/v2/plan/details?planId=%@", courseID];
    NetworkingHelper *networkHelper = [[NetworkingHelper alloc] init];
    [networkHelper getJSONResponse:requestURL success:^(NSDictionary *responseDict) {
        jsonDetailResponse = [responseDict valueForKey:@"result"];
//        NSLog(@"%@", jsonDetailResponse);
        
        nameLabel = [NSString stringWithFormat:@"%@", [jsonDetailResponse objectForKey:@"name"]];
        descriptionLabel = [NSString stringWithFormat:@"%@", [jsonDetailResponse objectForKey:@"description"]];
        daysLabel = [NSString stringWithFormat:@"%@", [jsonDetailResponse objectForKey:@"daysPerWeek"]];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            _Name.text = nameLabel;
            _Description.text = descriptionLabel;
            _Days.text = daysLabel;
        });
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
