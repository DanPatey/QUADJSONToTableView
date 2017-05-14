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
@property (weak, nonatomic) IBOutlet UILabel *Description;
@property (weak, nonatomic) IBOutlet UILabel *Days;
@end

@implementation DetailViewController
@synthesize courseID;

NSArray *jsonDetailResponse;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *requestURL = [NSString stringWithFormat:@"http://input.fitplanapp.com/fitplan-server/v2/plan/details?planId=%@", courseID];
    NetworkingHelper *networkHelper = [[NetworkingHelper alloc] init];
    [networkHelper getJSONResponse:requestURL success:^(NSDictionary *responseDict) {
        jsonDetailResponse = [responseDict valueForKey:@"result"];
        NSLog(@"%@", jsonDetailResponse);
        
        // Break our raw response into a dictionary for easy parsing
        // THIS IS CAUSING A CRASH BECAUSE OF OBJECT AT INDEX
        NSDictionary *message = (NSDictionary *)[jsonDetailResponse objectAtIndex:0];
//        NSString *nameLabel = [NSString stringWithFormat:@"%@", [message objectForKey:@"name"]];
//        NSString *descriptionLabel = [NSString stringWithFormat:@"%@", [message objectForKey:@"description"]];
//        NSString *daysLabel = [NSString stringWithFormat:@"%@", [message objectForKey:@"daysPerWeek"]];
        
//        _Name.text = nameLabel;
//        _Description.text = descriptionLabel;
//        _Days.text = daysLabel;

    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
//    [self.view setNeedsDisplay];
}

@end
