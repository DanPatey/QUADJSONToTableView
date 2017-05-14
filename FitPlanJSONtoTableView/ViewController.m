//
//  ViewController.m
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/12/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "NetworkingHelper.h"

@interface ViewController ()
@end

@implementation ViewController

NSArray *jsonResponse;
NSString *localCourseID;

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

#pragma mark - tableView, rowSelection

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *jsonDictionary = (NSDictionary *)[jsonResponse objectAtIndex:indexPath.row];
    localCourseID = [NSString stringWithFormat:@"%@", [jsonDictionary objectForKey:@"id"]];
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

#pragma mark - segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        DetailViewController *destViewController = [segue destinationViewController];
        destViewController.courseID = localCourseID;
    }
}

@end
