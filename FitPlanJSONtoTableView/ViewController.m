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
    self.jsonArray = [[NSArray alloc] init];
    [self makeJSONRequest];
}

- (void)makeJSONRequest {
    NSString *planJSON = @"http://input.fitplanapp.com/fitplan-server/v2/plans?locale=en";
    
    // Build the request and send it async
    NSURL *msgURL = [NSURL URLWithString:planJSON];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *messageTask = [session dataTaskWithURL:msgURL completionHandler:^
                                     (NSData *data, NSURLResponse * response, NSError * error)
        {
            // Parse our JSON response into an dictionary
            NSError *parseError = nil;
            NSDictionary *rawResponse = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                        error:&parseError];
//            if (!parseError) {
//                NSLog(@"JSON Response: %@", _jsonArray);
//            } else {
//                NSString *err = [parseError localizedDescription];
//                NSLog(@"Encountered an error parsing: @", err);
//            }
            
            // Pop out results
            _jsonArray = [rawResponse valueForKey:@"result"];
            [self.tableView reloadData];
        }];
    [messageTask resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MsgCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *message = (NSDictionary *)[_jsonArray objectAtIndex:indexPath.row];
    
    NSString *byLabel = [NSString stringWithFormat:@"%@ %@", [message objectForKey:@"athleteFirstName"], [message objectForKey:@"athleteLastName"]];
    NSLog(@"%@", byLabel);
    
    cell.textLabel.text = [message objectForKey:@"name"];
    cell.detailTextLabel.text = byLabel;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_jsonArray count];
}

@end
