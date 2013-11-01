//
//  ViewController.h
//  PluginApp
//
//  Created by Kelley Sheffield on 10/28/13.
//  Copyright (c) 2013 Kelley Sheffield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertiseDeviceViewController.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *AdService;
@property (nonatomic, assign)  BOOL isReadyVar;
@property (nonatomic, copy) AdvertiseDeviceViewController *adControl;
@property (weak, nonatomic) IBOutlet UILabel *theServiceName;


- (IBAction)startAdvertising;
-(BOOL)isReady;




@end
