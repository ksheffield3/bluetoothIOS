//
//  PeriphScan.m
//  PluginApp
//
//  Created by Kelley Sheffield on 10/29/13.
//  Copyright (c) 2013 Kelley Sheffield. All rights reserved.
//

#import "PeriphScan.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface PeriphScan()
<
CBPeripheralManagerDelegate,
UIAlertViewDelegate>

@property(nonatomic, strong) CBPeripheralManager *peripheral;
@property(nonatomic, strong) CBMutableCharacteristic *characteristic;
@property(nonatomic, assign) BOOL serviceRequiresRegistration;
@property(nonatomic, strong) CBMutableService *service;
@property(nonatomic, strong) NSData *pendingData;



@end


@implementation PeriphScan

+(BOOL) isBluetoothSupported
{
    if (NSClassFromString(@"CBPeripheralManager") == nil)
    {
        return NO;
    }
    
    return YES;
}

-(id)init
{
    return[self initWithDelegate:nil];
}

-(id)initWithDelegate:(id<CBPeripheralDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.peripheral = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
        self.delegate = delegate;
        
    }
    return self;
}

#pragma mark -

-(void)enableService
{
    if(self.service)
    {
        [self.peripheral removeService:self.service];
    }
    
    self.service = [[CBMutableService alloc]initWithType:self.serviceUUID primary:YES];
    
    self.characteristic = [[CBMutableCharacteristic alloc]initWithType:self.characteristicUUID properties:CBCharacteristicPropertyNotify value:nil permissions:0];
    
    self.service.characteristics = [NSArray arrayWithObject:self.characteristic];
    
    [self.peripheral addService:self.service];
    NSLog(@"Enabled service");
}

-(void)disableService
{
    [self.peripheral removeService:self.service];
    self.service = nil;
    [self stopAdvertising];
    NSLog(@"Disabled service");
}

-(void)startAdvertising
{
    if(self.peripheral.isAdvertising)
    {
        [self.peripheral stopAdvertising];
    }
    
    NSDictionary *advertisement = @{CBAdvertisementDataServiceUUIDsKey : @[self.serviceUUID],
                                    CBAdvertisementDataLocalNameKey: self.serviceName
                                    };
    [self.peripheral startAdvertising:advertisement];
}


-(void)stopAdvertising
{
    [self.peripheral stopAdvertising];
    NSLog(@"Stopped advertising");
}

-(BOOL)isAdvertising
{
    return [self.peripheral isAdvertising];
}

#pragma mark -

-(void)sendToSubscribers: (NSData *)data
{
    if (self.peripheral.state != CBPeripheralManagerStatePoweredOn)
    {
        NSLog(@"sendToSubscribers: periph not ready for sending state: %d", self.peripheral.state);
        return;
    }
    
    BOOL success = [self.peripheral updateValue:data forCharacteristic:self.characteristic onSubscribedCentrals:nil];
    
    if (!success)
    {
        NSLog(@"Failed to send data");
        return;
    }
}

-(void)applicationDidEnterBackground
{
    
}

-(void)applicationWillEnterForeground
{
    NSLog(@"applicationWillEnterForeground.");
}

#pragma mark - CBPeripheralManagerDelegate 

-(void)peripheralManager: (CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    [self startAdvertising];
}

-(void) peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    switch (peripheral.state)
    {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"ON");
            [self enableService];
            break;
        case CBPeripheralManagerStatePoweredOff:
        {
            NSLog(@"OFF");
            [self disableService];
            self.serviceRequiresRegistration = YES;
            break;
        }
        case CBPeripheralManagerStateResetting:
        {
            NSLog(@"Resetting");
            self.serviceRequiresRegistration = YES;
            break;
        }
        case CBPeripheralManagerStateUnauthorized:
        {
            NSLog(@"Deauthorized");
            [self disableService];
            self.serviceRequiresRegistration = YES;
            break;
        }
        case CBPeripheralManagerStateUnknown:
            NSLog(@"Unknown");
            break;
        default:
            break;
    }
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"didSubscribe: %@", characteristic.UUID);
    NSLog(@"didSubscribe: -Central: %@", central.identifier);
   // [self.delegate periphServer:self centralDidSubscribe:central];
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"didUnsubscribe: %@", central.identifier);
  //  [self.delegate periphServer:self centralDidUnsubscribe:central];
}

-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    if(error)
    {
        NSLog(@"didStartAdvertising: Error: %@", error);
        return;
    }
    
    NSLog(@"didStartAdvertisisng");
}
-(void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    NSLog(@"isReadyToUpdateSubscribers");
    if(self.pendingData)
    {
        NSData *data = [self.pendingData copy];
        self.pendingData = nil;
        [self sendToSubscribers:data];
    }
}








@end
































