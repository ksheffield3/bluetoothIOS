//
//  AdvertiseDeviceViewController.m
//  PluginApp
//
//  Created by Kelley Sheffield on 10/30/13.
//  Copyright (c) 2013 Kelley Sheffield. All rights reserved.
//
#import "ViewController.h"
#import "AppDelegate.h"
#import "PeriphScan.h"
#import "AdvertiseDeviceViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "CBUUID+StringExtraction.h"


@interface AdvertiseDeviceViewController ()<CBPeripheralDelegate>
@end

@implementation AdvertiseDeviceViewController
@synthesize  theServiceName;
@synthesize charName;
@synthesize servUUID;
@synthesize exitAdvertising;
@synthesize exitAdState;
@synthesize peripheral;


- (void)viewDidLoad
{
    [super viewDidLoad];
    peripheral = [[PeriphScan alloc] initWithDelegate: self];    peripheral.serviceName = @"Test";
    self.theServiceName.text = [NSString stringWithFormat:@"%@", self.peripheral.serviceName];
    peripheral.serviceUUID = [CBUUID UUIDWithString:@"7e57"];
    NSString* servUUIDstring = [[CBUUID UUIDWithString:@"7e57"] representativeString ];
    //servUUIDstring = [NSUUID UUIDString:self.peripheral.serviceUUID];
    self.servUUID.text = [NSString stringWithFormat:@"%@", servUUIDstring];
    peripheral.characteristicUUID = [CBUUID UUIDWithString:@"b71e"];
    NSString* charUUIDstring = [[CBUUID UUIDWithString:@"b71e"] representativeString ];
    self.charName.text = [NSString stringWithFormat:@"%@", charUUIDstring];
    [peripheral startAdvertising];
    
    if(CBPeripheralStateConnected)
    {
        [self.scanningProgress stopAnimating];
    }
  
}


- (IBAction)tapped:(id)sender
{
    [self performSegueWithIdentifier:@"serviceUnwind" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"serviceUnwind"])
    {
       ViewController *vc = [segue destinationViewController];
        [peripheral stopAdvertising];
    }
}


-(void)peripheralServer:(PeriphScan *)peripheral centralDidSubscribe:(CBCentral *)centeral
{
    [self.peripheral sendToSubscribers:[@"Hello" dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
