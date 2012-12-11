//
//  TJSpinnerViewController.m
//  Spinner
//
//  Created by Aparna Bhat on 10/08/12.
//  Copyright (c) 2012 TechJini Solutions Pvt. Ltd. All rights reserved.
//

#import "TJSpinnerViewController.h"
#import "TJSpinner.h"

NSString *const kUIActivityIndicatorView = @"UIActivityIndicatorView";
NSString *const kTJActivityIndicator = @"TJActivityIndicator";
NSString *const kTJCircularSpinner = @"TJCircularSpinner";
NSString *const kTJBeachBallSpinner = @"TJBeachBallSpinner";

//Constants for Animation button titles
NSString *const kStartAnimation = @"Start";
NSString *const kStopAnimation = @"Stop";

@implementation TJSpinnerViewController

//@synthesize animateButton;
@synthesize spinnerTableView;



#pragma mark -
#pragma mark Object Life Cycle Management Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        spinnerDict = [[NSMutableDictionary alloc] init];
//        animateButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect]retain];
//        [animateButton addTarget:self action:@selector(clickedOnAnimation:) forControlEvents:UIControlEventTouchDown];
//        [animateButton setFrame:CGRectMake(0, 0, 60, 30)];
//        [animateButton setTitle:kStartAnimation forState:UIControlStateNormal];
    }
    return self;
}

- (void)dealloc
{
//    [animateButton release];
    [spinnerTableView release];
    [spinnerDict release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Spinners";
    [spinnerTableView setAllowsSelection:NO];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:animateButton];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:kStartAnimation style:UIBarButtonItemStyleDone target:self action:@selector(clickedOnAnimation:)]autorelease];
    [spinnerDict setValue:[self generateSpinnerOfType:kUIActivityIndicatorView] forKey:kUIActivityIndicatorView];
    [spinnerDict setValue:[self generateSpinnerOfType:kTJActivityIndicator] forKey:kTJActivityIndicator];
    [spinnerDict setValue:[self generateSpinnerOfType:kTJBeachBallSpinner] forKey:kTJBeachBallSpinner];
    [spinnerDict setValue:[self generateSpinnerOfType:kTJCircularSpinner] forKey:kTJCircularSpinner];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
//    [animateButton release];
//    animateButton = nil;
    
    
    [spinnerTableView release];
    spinnerTableView = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Private Methods


- (NSArray *)generateSpinnerOfType:(NSString*)spinnerClass
{
    NSMutableArray *spinnerArray = [NSMutableArray array];
    
    if ([spinnerClass isEqualToString:kUIActivityIndicatorView]) 
    {
//        NSLog(@"Generate UIActivityIndicatorView");
        
        //Generate 3 spinners
        //First Spinner
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.hidesWhenStopped = NO;
        [spinnerArray addObject:activityIndicator];
        [activityIndicator release];
        
        //Second Spinner
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.hidesWhenStopped = NO;
        [activityIndicator setColor:[UIColor redColor]];
        [spinnerArray addObject:activityIndicator];
        [activityIndicator release];
        
        //Third Spinner
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.hidesWhenStopped = YES;
        [activityIndicator setColor:[UIColor blueColor]];
        [spinnerArray addObject:activityIndicator];
        [activityIndicator release];

        
    }
    else if([spinnerClass isEqualToString:kTJActivityIndicator])
    {
//        NSLog(@"Generate TJActivityIndicator");
        
        //Generate 3 spinners
        //First Spinner
        TJSpinner *spinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeActivityIndicator];
//        TJSpinner *spinner = [[TJSpinner alloc] initWithFrame:self.view.frame];

        spinner.hidesWhenStopped = NO;
//        spinner.frame = self.view.frame;
        [spinner setFillColor:[UIColor redColor]];
        [spinnerArray addObject:spinner];
        [spinner release];

        
        
        
        //Second Spinner
         spinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeActivityIndicator];
        [spinner setColor:[UIColor colorWithRed:17/255.00 green:181/255.00 blue:255.00/255.00 alpha:1.0]];
        [spinner setStrokeWidth:20];
        [spinner setInnerRadius:8];
        [spinner setOuterRadius:30];
        [spinner setNumberOfStrokes:8];
        spinner.hidesWhenStopped = NO;
        [spinner setPatternStyle:TJActivityIndicatorPatternStylePetal];

        [spinnerArray addObject:spinner];
        [spinner release];
        
        //Third Spinner
        spinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeActivityIndicator];
        spinner.hidesWhenStopped = NO;
        [spinner setColor:[UIColor darkGrayColor]];
        [spinner setInnerRadius:10];
        [spinner setOuterRadius:20];
        [spinner setStrokeWidth:8];
        [spinner setNumberOfStrokes:8];
        [spinner setPatternLineCap:kCGLineCapButt];
//        [spinner setSegmentImage:[UIImage imageNamed:@"Stick.jpeg"]];
        [spinner setPatternStyle:TJActivityIndicatorPatternStyleBox];
        [spinnerArray addObject:spinner];
        [spinner release];
        

    }
    else if([spinnerClass isEqualToString:kTJBeachBallSpinner])
    {
//        NSLog(@"Generate TJBeachBallSpinner");
        //Generate 2 spinners
        //Generate first spinner
        TJSpinner *beachBallSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeBeachBall];
        beachBallSpinner.hidesWhenStopped = NO;
        [spinnerArray addObject:beachBallSpinner];
        [beachBallSpinner release];
        
        //Generate second spinner
        beachBallSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeBeachBall];
        beachBallSpinner.hidesWhenStopped = NO;
        [beachBallSpinner setRadius:20];
        [spinnerArray addObject:beachBallSpinner];
        [beachBallSpinner release];

        
        //Generate third spinner
        beachBallSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeBeachBall];
        beachBallSpinner.hidesWhenStopped = YES;
        [beachBallSpinner setRadius:25];
        [spinnerArray addObject:beachBallSpinner];
        [beachBallSpinner release];

    }
    else if([spinnerClass isEqualToString:kTJCircularSpinner])
    {
//        NSLog(@"Generate UIActivityIndicatorView");
        //Generate 2 spinners
        //Generate first spinner
        TJSpinner *circularSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJCircularSpinner];
        circularSpinner.hidesWhenStopped = NO;
        [spinnerArray addObject:circularSpinner];
        [circularSpinner release];
        
        //Generate second spinner
        circularSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJCircularSpinner];
        circularSpinner.hidesWhenStopped = NO;
        circularSpinner.radius = 10;
        circularSpinner.pathColor = [UIColor whiteColor];
        circularSpinner.fillColor = [UIColor redColor];
        circularSpinner.thickness = 7;
        [spinnerArray addObject:circularSpinner];
        [circularSpinner release];
        
        //Generate third spinner
        circularSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJCircularSpinner];
        circularSpinner.hidesWhenStopped = YES;
        circularSpinner.radius =7;
        circularSpinner.pathColor = [UIColor whiteColor];
        circularSpinner.fillColor = [UIColor darkGrayColor];
        circularSpinner.thickness = 4;
        [spinnerArray addObject:circularSpinner];
        [circularSpinner release];



    }
    return spinnerArray;

}


#pragma mark -
#pragma mark IBAction Method
- (IBAction)clickedOnAnimation:(id)sender
{
    
    NSMutableArray *allSpinners = [NSMutableArray array];
    NSArray *spinnersArray = [spinnerDict allValues];

    for (id spinners in spinnersArray) 
    {
        [allSpinners addObjectsFromArray:spinners];
    }

    
    if ([[sender title] isEqualToString:kStartAnimation]) 
    {
//        [sender setTitle:kStopAnimation forState:UIControlStateNormal];
        [sender setTitle:kStopAnimation];
        for (id spinner in allSpinners) 
        {
            [spinner startAnimating];
        }
    }
    else if([[sender title] isEqualToString:kStopAnimation])
    {
        
//        [sender setTitle:kStartAnimation forState:UIControlStateNormal];
        [sender setTitle:kStartAnimation];

        for (id spinner in allSpinners) 
        {
            [spinner stopAnimating];
        }
    }
}


#pragma mark -
#pragma mark UITableView DataSourceMethods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }  
    
    CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];

    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cellHeight);
    
    
    NSArray *subViews = [cell.contentView subviews];
    for (id view in subViews) 
    {
        [view removeFromSuperview];
    }
    
    NSArray *spinnerArray = nil;
    id spinnerView = nil;
    CGFloat spinnerViewWidth = cell.contentView.frame.size.width/3.0;
    switch ([indexPath section])
    {
        case 0:
            spinnerArray = [spinnerDict valueForKey:kUIActivityIndicatorView];
            
            break;
        case 1:
            spinnerArray = [spinnerDict valueForKey:kTJActivityIndicator];

            break;
        case 2:
            spinnerArray = [spinnerDict valueForKey:kTJCircularSpinner];

            break;
        case 3:
            spinnerArray = [spinnerDict valueForKey:kTJBeachBallSpinner];

            break;

            
        default:
            break;
    }
    for (int i=0; i<[spinnerArray count]; i++) 
    {
        spinnerView = [spinnerArray objectAtIndex:i];
        [spinnerView setBounds:CGRectMake(0,0 , [spinnerView frame].size.width, [spinnerView frame].size.height)];
        [spinnerView setCenter:CGPointMake((spinnerViewWidth/2.00)+i*spinnerViewWidth, cell.contentView.center.y)];
        [cell addSubview:spinnerView];
    }

    
    return cell;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = nil;
    switch (section) 
    {
        case 0:
            headerTitle = kUIActivityIndicatorView;
            break;
        case 1:
            headerTitle = kTJActivityIndicator;
            break;
        case 2:
            headerTitle = kTJCircularSpinner;
            break;
        case 3:
            headerTitle = kTJBeachBallSpinner;
            break;

            
        default:
            break;
    }
    return headerTitle;
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    switch ([indexPath section]) {
        case 0:
            //Default activity indicators
            height = 50;
            break;
        case 1:
            //TJActivityIndicator
            height = 100;
            break;
        case 2:
            //TJCircularSpinner
            height = 50;
            break;
        case 3:
            //TJBeachBallSpinner
            height = 80;
            break;


        default:
            break;
    }
    return height;
}


@end
