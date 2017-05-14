//
//  ViewController.m
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/12/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import "ViewController.h"
#import "NetworkingHelper.h"

@interface ViewController ()
@end

@implementation ViewController

NSArray *jsonResponse;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NetworkingHelper *networkHelper = [[NetworkingHelper alloc] init];
    [networkHelper getJSONResponse:@"http://input.fitplanapp.com/fitplan-server/v2/plans?locale=en" success:^(NSDictionary *responseDict) {
        jsonResponse = [responseDict valueForKey:@"result"];
        NSLog(@"%@", jsonResponse);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"ERROR: Unable to parse JSON");
    }];
}

#pragma mark - tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MsgCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *message = (NSDictionary *)[jsonResponse objectAtIndex:indexPath.row];
    
    NSString *byLabel = [NSString stringWithFormat:@"%@ %@", [message objectForKey:@"athleteFirstName"], [message objectForKey:@"athleteLastName"]];
    
    cell.textLabel.text = [message objectForKey:@"name"];
    cell.detailTextLabel.text = byLabel;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [jsonResponse count];
}

#pragma mark - detailViewSegues

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
//        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
//        NSDictionary *message = (NSDictionary *)[jsonResponse objectAtIndex:path.row];
//        NSString *courseID = [NSString stringWithFormat:@"%@", [message objectForKey:@"id"]];
    }
}

@end
