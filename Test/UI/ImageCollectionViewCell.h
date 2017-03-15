//
//  ImageCollectionViewCell.h
//  Test
//
//  Created by Com on 23/02/2017.
//  Copyright © 2017 Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowseViewModel.h"

static NSString* ImageCollectionViewCellID = @"ImageCollectionViewCell";


@interface ImageCollectionViewCell : UICollectionViewCell
{
	
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;

- (void)setCell:(ImageItem *)item;

@end
