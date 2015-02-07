//
//  ViewController.h
//  JLFSQMapView
//
//  Created by Jose Luis Rodriguez on 07/01/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapHeight;
@property (weak, nonatomic) IBOutlet UIView *gesturesView;

- (IBAction)closeMapSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)closeMapTouch:(UITapGestureRecognizer *)sender;

@end

