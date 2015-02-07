//
//  ViewController.m
//  JLFSQMapView
//
//  Created by Jose Luis Rodriguez on 07/01/15.
//  Copyright (c) 2015 jlrodv. All rights reserved.
//

#define MAP_HEIGHT 200
#define INFOCELL_HEIGHT 80


#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

{
    BOOL mapOpened;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    
    self.tableView.delegate=self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    
    if(indexPath.row ==0){
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"mapCell"];
    
        cell.backgroundColor = [UIColor clearColor];
    }
    
    else{
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
        
        UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
        cellLabel.text = [NSString stringWithFormat:@"Row %d" , (int)indexPath.row];
    
        
        if(mapOpened)
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        else
            [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }

    return cell;

}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        if (!mapOpened)
            return MAP_HEIGHT;
        else
            return self.view.frame.size.height-INFOCELL_HEIGHT;
    }

    return INFOCELL_HEIGHT;
}


#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
    
        [self openMap];
     
        return;
    }
    
    NSLog(@"%d cell pressed", (int)indexPath.row);

    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(scrollView.contentOffset.y<0){
    
        self.mapHeight.constant = MAP_HEIGHT - scrollView.contentOffset.y;
        
        [self updateViewConstraints];
        
        if(scrollView.contentOffset.y<=-90&&!mapOpened){
            
            [self.tableView setScrollEnabled:NO];
            [self.tableView setContentOffset:CGPointMake(0, 0)];
            [self openMap];

            
        }
    }

}


#pragma mark - Map Methods

-(void)openMap{
    
    [self.tableView setScrollEnabled:NO];
    mapOpened = YES;
    [self.view sendSubviewToBack:self.tableView];
    [self.tableView reloadData];
    self.mapHeight.constant=self.view.frame.size.height-INFOCELL_HEIGHT;

    [UIView animateWithDuration:0.2 animations:^{
        
        [self updateViewConstraints];
        
    }];
    
}


-(void)closeMap{

    [self.tableView setScrollEnabled:YES];
    mapOpened =NO;
    [self.view sendSubviewToBack:self.mapView];
    [self.view sendSubviewToBack:self.gesturesView];
    [self.tableView reloadData];
    self.mapHeight.constant = MAP_HEIGHT;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self updateViewConstraints];
        
    }];
    
}

#pragma mark Gesture Recognizers

- (IBAction)closeMapSwipe:(UISwipeGestureRecognizer *)sender {
    
    if(mapOpened)
        
        [self closeMap];
    
    
    
}

- (IBAction)closeMapTouch:(UITapGestureRecognizer *)sender {
    
    if(mapOpened)
        [self closeMap];
    
}

@end
