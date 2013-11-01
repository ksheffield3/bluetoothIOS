//
//  PeriphScan.h
//  PluginApp
//
//  Created by Kelley Sheffield on 10/29/13.
//  Copyright (c) 2013 Kelley Sheffield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol CBPeripheralDelegate;
//@protocol PeriphServerDelegate;

@interface PeriphScan : NSObject


@property(nonatomic, assign)id<CBPeripheralDelegate> delegate;

@property(nonatomic, strong) NSString *serviceName;
@property(nonatomic) CBUUID *serviceUUID;
@property(nonatomic) CBUUID *characteristicUUID;

//@property(nonatomic) BOOL isConnected;


-(id)initWithDelegate:(id<CBPeripheralDelegate>) delegate;
-(void)sendToSubscribers:(NSData *)data;
-(void)applicationDidEnterBackground;
-(void)applicationWillEnterForeground;
-(void)startAdvertising;
-(void)stopAdvertising;
//-(BOOL)isConnected;
-(BOOL)isAdvertising;


@end

@protocol CBPeripheralDelegate <NSObject>
//@protocol CBPeripheralDelegate <NSObject>

-(void)periphServer:(PeriphScan *)peripheral centralDidSubscribe:(CBCentral *)central;
-(void)periphServer:(PeriphScan *)peripheral centralDidUnsubscribe:(CBCentral *)central;

@end
