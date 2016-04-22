//
//  DSViewController.m
//  DSLibAlerts
//
//  Created by Alexander Belyavskiy on 04/26/2015.
//  Copyright (c) 2014 Alexander Belyavskiy. All rights reserved.
//

#import "DSViewController.h"
@import DSLibAlerts;

@interface DSViewController ()

@end

@implementation DSViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  DSMessage *customMessage = [DSMessage messageWithTitle:@"Hello" message:@"Error"];
  DSMessage *customMessage2 = [DSMessage messageWithTitle:@"Hello2" message:@"Error2"];

  [[DSAlertsHandler sharedInstance] showSimpleMessageAlert:customMessage];
  [[DSAlertsHandler sharedInstance] showSimpleMessageAlert:customMessage2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
