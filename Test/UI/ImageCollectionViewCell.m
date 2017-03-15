//
//  ImageCollectionViewCell.m
//  Test
//
//  Created by Com on 23/02/2017.
//  Copyright © 2017 Com. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell : UICollectionViewCell

- (void)setCell:(ImageItem *)item {
	
	self.lblTitle.text = item.title;
	if (item.distance > 0) {
		self.lblDistance.text = [NSString stringWithFormat:@"%.1f km", round(10 * item.distance / 1000) / 10];
	}
	
	[self showLoadingIndicator:YES];
	self.imgView.image = nil;
	
	[[[NSURLSession sharedSession] dataTaskWithURL:item.url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		if (error) {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self showLoadingIndicator:NO];
				NSLog(@"%@", error.localizedDescription);
			});
			
			return;
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self showLoadingIndicator:NO];
			
			UIImage *img = [UIImage imageWithData:data];
			self.imgView.image = img;
		});
		
	}] resume];
}

- (void)showLoadingIndicator:(BOOL)bShow {
	if (bShow) {
		[self.loadingView startAnimating];
		self.loadingView.hidden = NO;
		
	} else {
		[self.loadingView stopAnimating];
		self.loadingView.hidden = YES;
	}
}

@end
