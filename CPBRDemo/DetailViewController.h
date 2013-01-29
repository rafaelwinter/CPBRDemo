//
//  DetailViewController.h
//  CPBRDemo
//
//  Created by Rafael Winter on 29/01/13.
//  Copyright (c) 2013 Rafael Winter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
