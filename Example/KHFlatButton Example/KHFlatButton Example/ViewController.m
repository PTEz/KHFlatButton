//
//  ViewController.m
//  KHFlatButton Example
//
//  Created by Blaine Fahey on 10/9/13.
//  Copyright (c) 2013 Kyle Horn. All rights reserved.
//

#import "ViewController.h"
#import "KHFlatButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *green = [UIColor colorWithRed:0.1 green:0.7 blue:0.2 alpha:1.0];
	self.navigationItem.rightBarButtonItem = [KHFlatButton barButtonWithTitle:@"CHECK OUT" backgroundColor:green];
    
    UIColor *blue = [UIColor colorWithRed:0.1 green:0.2 blue:0.7 alpha:1.0];
	self.navigationItem.leftBarButtonItem = [KHFlatButton barButtonWithTitle:@"Cancel" backgroundColor:blue];
    
    self.customButton.cornerRadius = 10.0;
}

@end
