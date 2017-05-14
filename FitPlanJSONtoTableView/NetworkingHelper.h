//
//  NetworkingHelper.h
//  FitPlanJSONtoTableView
//
//  Created by Dan Patey on 5/13/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingHelper : NSObject

@property (strong, atomic) NSArray *jsonArray;

- (void)makeJSONRequest;

@end
