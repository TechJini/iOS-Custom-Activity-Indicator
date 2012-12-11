//
//  TJSpinnerViewController.h
//  Spinner
//
//  Created by Aparna Bhat on 10/08/12.
//  Copyright (c) 2012 TechJini Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TJSpinnerViewController : UIViewController
{
    UITableView *spinnerTableView;
    NSDictionary *spinnerDict;
//    UIButton *animateButton;
    
}

//@property (nonatomic, retain) IBOutlet UIButton *animateButton;
@property (nonatomic, retain) IBOutlet UITableView *spinnerTableView;
- (IBAction)clickedOnAnimation:(id)sender;

@end
