//
//  TJSpinner.h
//  Spinner
//
//  Created by Aparna Bhat on 22/08/12.
//  Copyright (c) 2012 TechJini Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const kTJSpinnerTypeActivityIndicator;
extern NSString *const kTJSpinnerTypeCircular;
extern NSString *const kTJSpinnerTypeBeachBall;


//Diffrent patterns that can be set to  kTJSpinnerTypeActivityIndicator type spinner
typedef enum
{
    TJActivityIndicatorPatternStyleSolid,
    TJActivityIndicatorPatternStyleDash,
    TJActivityIndicatorPatternStyleDot,
    TJActivityIndicatorPatternStyleDashDot,
    TJActivityIndicatorPatternStylePetal,
    TJActivityIndicatorPatternStyleBox
    
} TJActivityIndicatorPatternStyle;



//This is an abstract class to create a spinner. You should use the appropriate subclass of TJSpinner to create the activity indicators of different types.
@interface TJSpinner : UIView
{
    NSTimer *_animationTimer;
    BOOL _isAnimating;
    BOOL _hidesWhenStopped;
    double _speed;
}

//Properties that applicable to all type of spinners
@property(nonatomic,readonly,assign) BOOL isAnimating;/*Indicates whether spinner is animating or not*/
@property(nonatomic, assign) BOOL hidesWhenStopped;/*Hides the spinner when spinner is not animating*/
@property(nonatomic,assign) double speed;/*Speed of the animation*/

//Property that is applicable to spinner type kTJSpinnerTypeBeachBall and kTJSpinnerTypeCircular. Setting the value on spinner type kTJSpinnerTypeActivityIndicator has no impact on the spinner.
@property(nonatomic,assign) CGFloat radius; /*Radius of the spinner. By deafult readius is set to 5 for kTJSpinnerTypeCircular and 11 for kTJSpinnerTypeBeachBall */


//Properties which are applicable to kTJSpinnerTypeActivityIndicator spinner type. Setting these attributes on other types of spinners have no impact on them.
@property(nonatomic,assign)CGFloat innerRadius;/* Default value as 6.0 will be taken if not spefified. Make sure that the inner radius is always lesser than the outer radius. */
@property(nonatomic,retain) UIColor* color; /* By default gray color is set */
@property(nonatomic,assign)CGFloat outerRadius;/* Default value as 9.0 will be taken if not spefified. Make sure that the outer radius is always greater than the inner radius. */
@property(nonatomic, assign) NSUInteger numberOfStrokes;/*By default 12 stokes are used*/
@property(nonatomic, assign) NSUInteger strokeWidth;/*2 is the default width of the eacg stoke*/
@property(nonatomic,assign) TJActivityIndicatorPatternStyle patternStyle;/*TJActivityIndicatorPatternStyleSolid is taken as the default value.*/
@property(nonatomic, assign) CGLineCap patternLineCap;/*kCGLineCapRound is taken as the default value.*/
@property(nonatomic, retain) UIImage *segmentImage;/*The image to be set as the activity indicator fin. By default no image is set. Hence the lines are set as fins. If image is set then this image is used as fins instead of lines. */


//This property used to customize the spinner created with specifying the type kTJSpinnerTypeCircular. If you set these properties to other types of spinners there will not be any impact on the spinners.
@property(nonatomic,retain) UIColor *fillColor;/*Color to be used to fill the circular path. By default white is used */
@property(nonatomic,retain) UIColor *pathColor;/*Color to be set to the circular path. By default sky blue is the color of the circular path*/
@property (nonatomic, assign)CGFloat thickness;/*By default thickness is set to 3.00*/


//Spinner initialization method. It is recommended to use this method to create the spinners of your choice.
- (TJSpinner *)initWithSpinnerType:(NSString *) spinnerType;
+ (TJSpinner *) spinnerWithType:(NSString *) spinnerType;


//Spinner animation methods
- (void)startAnimating;
- (void)stopAnimating;


@end
