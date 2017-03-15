//
//  BrowseViewModel.h
//  Test
//
//  Created by Com on 23/02/2017.
//  Copyright © 2017 Com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface ImageItem : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic) NSURL *url;
@property (nonatomic) CLLocationDistance distance;

+ (ImageItem *)newItem:(NSDictionary *)dict;

@end


// MARK: -

@interface BrowseViewModel : NSObject
<
CLLocationManagerDelegate
>
{
	CLLocationManager *locationManager;
}

@property (nonatomic) NSMutableArray *arrayImages;
@property (nonatomic) CLLocation *curLocation;

@end
