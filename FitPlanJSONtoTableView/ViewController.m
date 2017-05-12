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
            // Parse our JSON response into an array
            NSError *parseError = nil;
            _jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                        error:&parseError];
            if (!parseError) {
                NSLog(@"JSON Response: %@", _jsonArray);
            } else {
                NSString *err = [parseError localizedDescription];
                NSLog(@"Encountered an error parsing: @", err);
            }
        }];
    [messageTask resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Loaded cellForRowAtIndexPath");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MsgCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *message = (NSDictionary *)[[_jsonArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    NSString *byLabel = [NSString stringWithFormat:@"%@ %@", [message objectForKey:@"athleteFirstName"], [message objectForKey:@"athleteLastName"]];
    NSLog(@"%@", byLabel);
    
    cell.textLabel.text = [message objectForKey:@"name"];
//    cell.textLabel.text = @"This Is TextLabel";
    cell.detailTextLabel.text = byLabel;
//    cell.detailTextLabel.text = @"This is DetailText";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection fired");
    return [_jsonArray count];
}

@end
