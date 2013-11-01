//
//  ViewController.m
//  PluginApp
//
//  Created by Kelley Sheffield on 10/28/13.
//  Copyright (c) 2013 Kelley Sheffield. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AdvertiseDeviceViewController.h"
#import "PeriphScan.h"
#import "CentralScan.h"

@interface ViewController () 
@property PeriphScan *periphState;
@property CentralScan *central;

@end

@implementation ViewController
@synthesize  periphState;
@synthesize adControl;
@synthesize central;
- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
   // AdvertiseDeviceViewController *adControl = [[AdvertiseDeviceViewController alloc] init];
    
   
   
    
    	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [central init];
    //paste your viewDidLoad codes
    [self.adControl.peripheral startAdvertising];
    NSLog(@"Back home");
}


- (void)addItemViewController:(AdvertiseDeviceViewController *)controller didFinishEnteringItem:(NSString *)item
{
    NSLog(@"This was returned from ViewControllerB %@",item);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startAdvertising
{

     
   // [self.appDel startSearching];
}





-(BOOL)isReady
{
    if(self.isReadyVar)
    {
        return YES;
    }
    else
        return NO;
}

- (IBAction)advertisePeriph:(id)sender {
}
@end
