//
//  AdvertiseDeviceViewController.h
//  PluginApp
//
//  Created by Kelley Sheffield on 10/30/13.
//  Copyright (c) 2013 Kelley Sheffield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeriphScan.h"



@interface AdvertiseDeviceViewController : UIViewController

@property (nonatomic, retain) PeriphScan *peripheral;

@property (weak, nonatomic) IBOutlet UILabel *theServiceName;
@property (weak, nonatomic) IBOutlet UILabel *charName;
@property (weak, nonatomic) IBOutlet UILabel *servUUID;
//@property (weak, nonatomic) IBOutlet //UINavigationItem *exitAdvertising;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *scanningProgress;

@property (nonatomic) BOOL exitAdState;
@property (weak, nonatomic) IBOutlet UINavigationItem *exitAdvertising;
@property (weak, nonatomic) IBOutlet UIButton *returnFromServices;

 @end
