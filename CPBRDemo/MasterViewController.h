//
//  MasterViewController.h
//  CPBRDemo
//
//  Created by Rafael Winter on 29/01/13.
//  Copyright (c) 2013 Rafael Winter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *tweetList;

- (void)loadCPBR6Tweets;

@end
