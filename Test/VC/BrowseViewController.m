//
//  BrowseViewController.m
//  Test
//
//  Created by Com on 23/02/2017.
//  Copyright © 2017 Com. All rights reserved.
//

#import "BrowseViewController.h"
#import "ImageCollectionViewCell.h"
#import "DetailViewController.h"

@interface BrowseViewController ()

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	sortType = byTitle;
	viewModel = [[BrowseViewModel alloc] init];
	
	// for gesture
	UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
	gesture.minimumPressDuration = .3;
	gesture.delaysTouchesBegan = YES;
	gesture.delegate = self;
	[self.collectionView addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"segueDetail"]) {
		DetailViewController *vc = (DetailViewController *)segue.destinationViewController;
		ImageItem *dict = viewModel.arrayImages[[sender row]];
		vc.imageTitle = dict.title;
		vc.imageSrcURL = dict.url.absoluteString;
		vc.imageSrcLocalURL = dict.url.absoluteString;
	}
}

- (IBAction)onSort:(id)sender {
	if (sortType == byTitle) {
		[viewModel.arrayImages sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
			return [((ImageItem *)obj1).title compare:((ImageItem *)obj2).title];
		}];
		
		[self.btnSort setTitle:NSLocalizedString(@"By Title", @"")];
		sortType = byDistance;
	} else {
		[viewModel.arrayImages sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
			return ((ImageItem *)obj1).distance > ((ImageItem *)obj2).distance;
		}];
		
		[self.btnSort setTitle:NSLocalizedString(@"By Distance", @"")];
		sortType = byTitle;
	}
	
	[self.collectionView reloadData];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureReconizer{
	if (gestureReconizer.state == UIGestureRecognizerStateEnded) {
		return;
	}
	
	CGPoint pt = [gestureReconizer locationInView:self.collectionView];
	NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pt];
	
	if (!indexPath) { return; }
	
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"Are you sure remove?", @"") preferredStyle:UIAlertControllerStyleAlert];
	[alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"YES", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[viewModel.arrayImages removeObjectAtIndex:indexPath.row];
		[self.collectionView reloadData];
	}]];
	[alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"NO", "") style:UIAlertActionStyleCancel handler: nil]];
	
	[self presentViewController:alert animated:YES completion:nil];
}


// MARK: UIColelctionView delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return viewModel.arrayImages.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionViewCellID forIndexPath:indexPath];
	if (cell) {
		[cell setCell:viewModel.arrayImages[indexPath.row]];
	}
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"segueDetail" sender:indexPath];
}

@end
