//
//  TrackViewController.m
//  iBeacons Demo
//
//  Created by M Newill on 27/09/2013.
//  Copyright (c) 2013 Mobient. All rights reserved.
//

#import "TrackViewController.h"
#import "BeaconInfoTableViewCell.h"

@interface TrackViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray* beaconArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TrackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self initRegion];
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)initRegion {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"23542266-18D1-4FE4-B4A1-23F8195B9D39"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"com.devfright.myRegion"];
//    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
//    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"MacBeacon"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource: @"BeaconList" ofType:@"plist"];
//    NSArray *beacons = [[NSArray alloc] initWithContentsOfFile:path];
//    for (NSDictionary *tempBeacon in beacons) {
//        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:[tempBeacon valueForKey:@"UUID"]];
//        CLBeaconMajorValue major = 1;//(NSString*)[tempBeacon valueForKey:@"Major"];
//        CLBeaconMinorValue minor = 1;//(NSString*)[tempBeacon valueForKey:@"Minor"];
//        NSString *uniqueID = [[NSString alloc] initWithString:[tempBeacon valueForKey:@"Identifier"]];
//        
//        if ((uuid != nil)){
//            CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:uniqueID];
//
//            [beaconRegion setNotifyEntryStateOnDisplay:YES];
//            [beaconRegion setNotifyOnEntry:YES];
//            [beaconRegion setNotifyOnExit:YES];
//
//            NSSet *monitoredRegions = [self.locationManager monitoredRegions];
////            if (![monitoredRegions containsObject:beaconRegion]) {
//                [self.locationManager startMonitoringForRegion:beaconRegion];
////            }
//            [self.locationManager startRangingBeaconsInRegion:beaconRegion];
//        }
//    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Beacon Found");
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Left Region");
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    self.beaconFoundLabel.text = @"No";
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
    self.beaconFoundLabel.text = @"Yes";
    self.proximityUUIDLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", beacon.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", beacon.minor];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    if (beacon.proximity == CLProximityUnknown) {
        self.distanceLabel.text = @"Unknown Proximity";
    } else if (beacon.proximity == CLProximityImmediate) {
        self.distanceLabel.text = @"Immediate";
    } else if (beacon.proximity == CLProximityNear) {
        self.distanceLabel.text = @"Near";
    } else if (beacon.proximity == CLProximityFar) {
        self.distanceLabel.text = @"Far";
    }
    self.rssiLabel.text = [NSString stringWithFormat:@"%i", beacon.rssi];
    _beaconArray = nil;
    _beaconArray = [NSMutableArray arrayWithArray:beacons];
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRows = [self.beaconArray count];
    return numRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    BeaconInfoTableViewCell *cell = nil;
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    
    CLBeacon *beacon = [self.beaconArray objectAtIndex:indexPath.row];
    
    cell.proximity.text = beacon.proximityUUID.UUIDString;
    cell.major.text = [NSString stringWithFormat:@"%@", beacon.major];
    cell.minor.text = [NSString stringWithFormat:@"%@", beacon.minor];
    cell.accuracy.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    if (beacon.proximity == CLProximityUnknown) {
        self.distanceLabel.text = @"Unknown Proximity";
    } else if (beacon.proximity == CLProximityImmediate) {
        self.distanceLabel.text = @"Immediate";
    } else if (beacon.proximity == CLProximityNear) {
        self.distanceLabel.text = @"Near";
    } else if (beacon.proximity == CLProximityFar) {
        self.distanceLabel.text = @"Far";
    }
    
//    NSDictionary *beaconInfo = self.beaconArray[indexPath.row];
//    cell.proximity = beaconInfo[@"proximity"];
//    cell.major = beaconInfo[@"major"];
//    cell.minor = beaconInfo[@"minor"];
//    cell.accuracy = beaconInfo[@"accuracy"];
//    cell.distance = beaconInfo[@"distance"];
    
    return cell;
}

@end
