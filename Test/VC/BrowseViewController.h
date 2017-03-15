//
//  BrowseViewController.h
//  Test
//
//  Created by Com on 23/02/2017.
//  Copyright © 2017 Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrowseViewModel.h"


typedef enum : NSUInteger {
	byTitle,
	byDistance,
} SortType;



@interface BrowseViewController : UIViewController
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UIGestureRecognizerDelegate
>
{
	BrowseViewModel *viewModel;
	SortType sortType;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSort;

@end
