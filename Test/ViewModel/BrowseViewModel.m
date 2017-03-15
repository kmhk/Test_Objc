//
//  BrowseViewModel.m
//  Test
//
//  Created by Com on 23/02/2017.
//  Copyright © 2017 Com. All rights reserved.
//

#import "BrowseViewModel.h"

@implementation ImageItem

- (id)init {
	self = [super init];
	if (self) {
		
	}
	
	return self;
}

+ (ImageItem *)newItem:(NSDictionary *)dict {
	ImageItem *item = [[ImageItem alloc] init];
	
	item.title = dict[@"title"];
	item.latitude = [dict[@"latitude"] doubleValue];
	item.longitude = [dict[@"longitude"] doubleValue];
	item.url = [NSURL URLWithString:dict[@"Url"]];
	
	return item;
}

@end



// MARK: -
@implementation BrowseViewModel

- (id)init {
	self = [super init];
	if (self) {
		[self locationManage];
		[self readJson];
	}
	
	return self;
}

- (void)readJson {
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"data" withExtension:@"json"];
	NSData *data = [NSData dataWithContentsOfURL:url];
	
	if (!data) {
		return;
	}
	
	NSError *e = nil;
	NSArray *tmpArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
	
	if (!self.arrayImages) {
		self.arrayImages = [[NSMutableArray alloc] init];
	}
	[self.arrayImages removeAllObjects];
	
	for (NSDictionary *dict in tmpArray) {
		ImageItem *item = [ImageItem newItem:dict];
		[self.arrayImages addObject:item];
	}
}

- (void)locationManage {
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager requestAlwaysAuthorization];
	[locationManager startUpdatingLocation];
}

- (void)getDistance {
	for (int i = 0; i < self.arrayImages.count; i ++) {
		ImageItem *item = self.arrayImages[i];
		item.distance = [self.curLocation distanceFromLocation:[[CLLocation alloc] initWithLatitude:item.latitude longitude:item.longitude]];
	}
}


// MARK:
//- (void)locationManager:(CLLocationManager *)manager
//	 didUpdateLocations:(NSArray<CLLocation *> *)locations{
//	if (!self.curLocation) {
//		self.curLocation = locations.firstObject;
//		[self readJson];
//	}
//}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	if (!self.curLocation) {
		self.curLocation = newLocation;
		
		[self getDistance];
	}
}

@end
