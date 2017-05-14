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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jsonArray = [[NSArray alloc] init];
    NetworkingHelper *networkHelper = [[NetworkingHelper alloc] init];
    [networkHelper makeJSONRequest];
    [self.tableView reloadData];
}

#pragma mark - tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MsgCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *message = (NSDictionary *)[_jsonArray objectAtIndex:indexPath.row];
    
    NSString *byLabel = [NSString stringWithFormat:@"%@ %@", [message objectForKey:@"athleteFirstName"], [message objectForKey:@"athleteLastName"]];
    
    cell.textLabel.text = [message objectForKey:@"name"];
    cell.detailTextLabel.text = byLabel;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_jsonArray count];
}

#pragma mark - detailViewSegues

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
//        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
//        NSDictionary *message = (NSDictionary *)[_jsonArray objectAtIndex:path.row];
//        NSString *courseID = [NSString stringWithFormat:@"%@", [message objectForKey:@"id"]];
    }
}

@end
