//
//  CentralScan.h
//  PluginApp
//
//  Created by Kelley Sheffield on 10/31/13.
//  Copyright (c) 2013 Kelley Sheffield. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol CentralDelegate <NSObject>
- (void) discoveryDidRefresh;
- (void) discoveryStatePoweredOff;
@end



/****************************************************************************/
/*							Discovery class									*/
/****************************************************************************/
@interface CentralScan : NSObject

+ (id) sharedInstance;


@property (nonatomic, assign) id<CentralDelegate>           discoveryDelegate;

- (void) startScanningForUUIDString:(NSString *)uuidString;
- (void) stopScanning;

- (void) connectPeripheral:(CBPeripheral*)peripheral;
- (void) disconnectPeripheral:(CBPeripheral*)peripheral;



@property (retain, nonatomic) NSMutableArray    *foundPeripherals;
@property (retain, nonatomic) NSMutableArray	*connectedServices;	// Array of LeTemperatureAlarmService


@end


