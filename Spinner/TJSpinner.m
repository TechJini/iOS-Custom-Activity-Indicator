//
//  TJSpinner.m
//  Spinner
//
//  Created by Aparna Bhat on 22/08/12.
//  Copyright (c) 2012 TechJini Solutions Pvt. Ltd. All rights reserved.
//

#import "TJSpinner.h"

//Constants defined for different types of spinners
NSString *const kTJSpinnerTypeActivityIndicator = @"TJActivityIndicator";
NSString *const kTJSpinnerTypeCircular = @"TJCircularSpinner";
NSString *const kTJSpinnerTypeBeachBall = @"TJBeachBallSpinner";

//Constant for setting beach ball spinner shadow effect
#define k_SHADOW_OFFSET 0.65
#define k_CIRCE_EDGE_WIDTH 2.00

/*************************************************************************************************************************************************/

#pragma mark -
#pragma mark -
#pragma mark TJActivityIndicator 

@interface TJActivityIndicator : TJSpinner
{
    NSUInteger _strokeIndex;
}
@end


@implementation TJActivityIndicator


#pragma mark -
#pragma mark Private Methods

- (void)setOuterRadius:(CGFloat)outerRadius
{
    
    super.outerRadius = outerRadius;
    CGRect viewRect = self.frame;
    
    
    CGFloat newHeight = self.outerRadius*2.00+self.strokeWidth*2.00;
    CGFloat newWidth = newHeight;
    CGRect newFrameRect = self.frame;
    
    if (newHeight>viewRect.size.height) 
    {
        newFrameRect.size.height = newHeight;
    }
    if (newWidth>viewRect.size.width) 
    {
        newFrameRect.size.width = newWidth;
    }
    self.frame = newFrameRect;
    
    [self setNeedsDisplay];
}


- (void) setPatternLineCap:(CGLineCap)patternLineCap
{
    super.patternLineCap = patternLineCap;
    if (patternLineCap == kCGLineCapRound) 
    {
        CGRect viewRect = self.frame;
        
        CGFloat newHeight = self.outerRadius*2.00+self.strokeWidth*2.00;
        CGFloat newWidth = newHeight;
        CGRect newFrameRect = self.frame;
        
        if (newHeight>viewRect.size.height) 
        {
            newFrameRect.size.height = newHeight;
        }
        if (newWidth>viewRect.size.width) 
        {
            newFrameRect.size.width = newWidth;
        }
        self.frame = newFrameRect;
        [self setNeedsDisplay];
        
    }
}

- (void) setStrokeWidth:(NSUInteger)strokeWidth
{
    super.strokeWidth = strokeWidth;
    
    if (self.patternLineCap == kCGLineCapRound) 
    {
        CGRect viewRect = self.frame;
        
        CGFloat newHeight = self.outerRadius*2.00+self.strokeWidth*2.00;
        CGFloat newWidth = newHeight;
        CGRect newFrameRect = self.frame;
        
        if (newHeight>viewRect.size.height) 
        {
            newFrameRect.size.height = newHeight;
        }
        if (newWidth>viewRect.size.width) 
        {
            newFrameRect.size.width = newWidth;
        }
        self.frame = newFrameRect;
        [self setNeedsDisplay];
        
    }
    
}


- (UIColor*) colorForStep:(NSInteger)stepIndex
{
    CGFloat alpha = 1.0 - (stepIndex % self.numberOfStrokes) * (1.0 / self.numberOfStrokes);
        
    CGColorRef colorRef = CGColorCreateCopyWithAlpha(self.color.CGColor, alpha);
    
    UIColor *color = [UIColor colorWithCGColor:colorRef];
    CGColorRelease(colorRef);
    
    return color;
}


- (void) drawStrokeToPoint:(CGPoint)point context:(CGContextRef)context
{
    CGContextSetLineCap(context, self.patternLineCap);
    CGContextAddLineToPoint(context, point.x, point.y);
    CGContextStrokePath(context);
}

- (void) drawPetalsWithAngle:(CGFloat)angle startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint context:(CGContextRef)context
{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2.00, self.frame.size.height/2.00);
    NSLog(@"Draw the petals with width %d",self.strokeWidth);
    CGFloat curveLeftAngle = angle - (((self.strokeWidth*2)- (self.strokeWidth/2.00)) * M_PI / 180);
    CGFloat cpx1 = (self.innerRadius+self.outerRadius)/2.00 * cos(curveLeftAngle) + centerPoint.x+(endPoint.x-startPoint.x)/2.00;
    CGFloat cpy1 = (self.innerRadius+self.outerRadius)/2.00 * sin(curveLeftAngle) + centerPoint.y+(endPoint.y-startPoint.y)/2.00;
    
    CGFloat curveRightAngle = angle+ (((self.strokeWidth*2)- (self.strokeWidth/2.00)) * M_PI / 180);
    CGFloat cpx2 = (self.innerRadius+self.outerRadius)/2.00 * cos(curveRightAngle) + centerPoint.x+(endPoint.x-startPoint.x)/2.00;
    CGFloat cpy2 = (self.innerRadius+self.outerRadius)/2.00 * sin(curveRightAngle) + centerPoint.y+(endPoint.y-startPoint.y)/2.00;
    
    
    CGContextAddQuadCurveToPoint(context,cpx1,cpy1, endPoint.x, endPoint.y);
    CGContextAddQuadCurveToPoint(context,cpx2,cpy2, startPoint.x, startPoint.y);
    
    CGContextDrawPath(context, kCGPathFill);
}

- (void) drawBoxWithAngle:(CGFloat)angle context:(CGContextRef)context
{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2.00, self.frame.size.height/2.00);
    CGFloat anglePerStep = 360.00/self.numberOfStrokes;
//    CGFloat startAngle = RADIANS_TO_DEGREES(angle);
    CGFloat startAngle = angle;

    CGFloat endAngle = startAngle+anglePerStep-5;
    CGPoint innerArcStartPoint= CGPointMake(self.innerRadius * cos(DEGREES_TO_RADIANS(startAngle)) + centerPoint.x, self.innerRadius * sin(DEGREES_TO_RADIANS(startAngle)) + centerPoint.y);
    
    
    CGPoint outerArcEndPoint = CGPointMake(self.outerRadius * cos(DEGREES_TO_RADIANS(endAngle)) + centerPoint.x, self.outerRadius * sin(DEGREES_TO_RADIANS(endAngle)) + centerPoint.y);
    
    CGContextAddArc(context, centerPoint.x, centerPoint.y, self.innerRadius, DEGREES_TO_RADIANS(startAngle),DEGREES_TO_RADIANS(endAngle), 0);
    
    CGContextAddLineToPoint(context, outerArcEndPoint.x, outerArcEndPoint.y);
    
    CGContextAddArc(context, centerPoint.x, centerPoint.y, self.outerRadius, DEGREES_TO_RADIANS(endAngle),DEGREES_TO_RADIANS(startAngle), 1);
    
    CGContextAddLineToPoint(context, innerArcStartPoint.x, innerArcStartPoint.y);
    CGContextDrawPath(context, kCGPathFill);
    

}

- (UIImage *)image:(UIImage *)img withColor:(UIColor *)color
{
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
//     CGContextTranslateCTM(context, 0, img.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImg;
}


- (UIImage *)rotate:(UIImage *)image radians:(CGFloat)angle
{
    
        UIImage *rotatedImage;
       CGFloat imageHeight = image.size.height;
       CGFloat imageWidth = image.size.width;

        
        // Get image width, height of the bounding rectangle
        CGRect boundingRect = [self getBoundingRectAfterRotation: CGRectMake(0, 0, imageWidth, imageHeight) byAngle:-angle];
        
        // Create a graphics context the size of the bounding rectangle
        UIGraphicsBeginImageContext(boundingRect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Rotate and translate the context
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformTranslate(transform, boundingRect.size.width/2, boundingRect.size.height/2);

        transform = CGAffineTransformRotate(transform, -angle);

        transform = CGAffineTransformScale(transform, 1.0, -1.0);

        
        CGContextConcatCTM(context, transform);
        
        // Draw the image into the context
    
    CGContextDrawImage(context, CGRectMake(-imageWidth/2, -imageHeight/2, imageWidth, imageHeight),image.CGImage);

        
        // Get an image from the context
        rotatedImage = [UIImage imageWithCGImage: CGBitmapContextCreateImage(context)];
        
        // Clean up
        UIGraphicsEndImageContext();
        return rotatedImage;
}


- (CGRect) getBoundingRectAfterRotation: (CGRect) rectangle byAngle: (CGFloat) angleOfRotation {
    // Calculate the width and height of the bounding rectangle using basic trig
    CGFloat newWidth = rectangle.size.width * fabs(cosf(angleOfRotation)) + rectangle.size.height * fabs(sinf(angleOfRotation));
    CGFloat newHeight = rectangle.size.height * fabs(cosf(angleOfRotation)) + rectangle.size.width * fabs(sinf(angleOfRotation));
    
    // Calculate the position of the origin
    CGFloat newX = rectangle.origin.x + ((rectangle.size.width - newWidth) / 2);
    CGFloat newY = rectangle.origin.y + ((rectangle.size.height - newHeight) / 2);
    
    // Return the rectangle
    return CGRectMake(newX, newY, newWidth, newHeight);
}


#pragma mark -
#pragma mark Timer Fire Method

- (void) timerFired:(NSTimer *)timer
{
    //In timer fire method we need to change the opacity of the each stroke
    if (_strokeIndex > self.numberOfStrokes) 
    {
        _strokeIndex = 0;
    }
    
    [self setNeedsDisplay];
    _strokeIndex++;
    
}



#pragma mark -
#pragma mark Object Life Cycle Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.color = [UIColor grayColor];
        _isAnimating = NO;
        self.innerRadius = 6.00; //Default value
        _strokeIndex = 0;
        _animationTimer = nil;
        self.numberOfStrokes = 12;
        self.strokeWidth = 2.00;
        self.patternStyle = TJActivityIndicatorPatternStyleSolid;
        self.segmentImage = nil;
        self.outerRadius = 9.00;
        self.patternLineCap = kCGLineCapRound;
        _speed = 1.0/self.numberOfStrokes;
        
        
    }
    return self;
    
}


- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)dealloc
{
    [_animationTimer release];
    [super dealloc];
}

#pragma mark -
#pragma Animation Methods
- (void)startAnimating
{
    [super startAnimating];
    _strokeIndex = 1;
    [_animationTimer invalidate];
    _animationTimer = [[NSTimer timerWithTimeInterval:_speed target:self selector:@selector(timerFired:) userInfo:nil repeats:YES]retain];
    [[NSRunLoop currentRunLoop]addTimer:_animationTimer forMode:NSDefaultRunLoopMode ];
}

- (void)stopAnimating
{
    //Invalidate the timer to stop the animation
    [super stopAnimating];
    [_animationTimer invalidate];
    [_animationTimer release];
    _animationTimer = nil;
    _strokeIndex = 0;
    [self setNeedsDisplay];
}


#pragma mark -
#pragma mark View drawing Method
- (void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.strokeWidth);
    float dash[4];


    for (int i=0; i<self.numberOfStrokes; i++) 
    {
        
        double angleInDeg = 180 - (i * 360.0 / self.numberOfStrokes);
        
        //Convert the angle from degree to radians as all the CG functions require in this format
        double angle = DEGREES_TO_RADIANS(angleInDeg);

        //Center point of the view
        
        
        //Calculate the start point
        CGFloat x1 = self.innerRadius * cos(angle) + centerPoint.x;
        CGFloat y1 = self.innerRadius * sin(angle) + centerPoint.y;
        
        //Calculate the end point
        CGFloat x2 = self.outerRadius * cos(angle) + centerPoint.x;
        CGFloat y2 = self.outerRadius * sin(angle) + centerPoint.y;
        
        
        //Draw the fins of the activity indicator based on the pattern style
        CGContextMoveToPoint(context, x1, y1);
        UIColor *color = [self colorForStep:_strokeIndex+i];
        
        if (nil == self.segmentImage) 
        {
            //Draw line as fins
            [color set];
            switch (self.patternStyle) 
            {
                case TJActivityIndicatorPatternStyleSolid:
                    CGContextSetLineDash(context,0,0,0);
                    [self drawStrokeToPoint:CGPointMake(x2, y2) context:context];
                    break;
                    
                case TJActivityIndicatorPatternStyleDash:
                    dash[0] = self.strokeWidth*3;
                    dash [1] = self.strokeWidth;
                    CGContextSetLineDash(context,0,dash,2);
                    [self drawStrokeToPoint:CGPointMake(x2, y2) context:context];
                    break;
                    
                case TJActivityIndicatorPatternStyleDot:
                    dash[0] = self.strokeWidth; 
                    dash[1] = self.strokeWidth;
                    CGContextSetLineDash(context,0,dash,2);
                    [self drawStrokeToPoint:CGPointMake(x2, y2) context:context];
                    break;
                    
                case TJActivityIndicatorPatternStyleDashDot:
                    dash[0] =  self.strokeWidth*3;
                    dash [1] = self.strokeWidth;
                    dash[2] = self.strokeWidth; 
                    dash[3] = self.strokeWidth;
                    CGContextSetLineDash(context,0,dash,4);
                    [self drawStrokeToPoint:CGPointMake(x2, y2) context:context];
                    break;
                    
                case TJActivityIndicatorPatternStylePetal:
                    [self drawPetalsWithAngle:angle startPoint:CGPointMake(x1, y1) endPoint:CGPointMake(x2, y2) context:context];
                    break;
                    
                case TJActivityIndicatorPatternStyleBox:
                    [self drawBoxWithAngle:angleInDeg-360.00/self.numberOfStrokes context:context];
                    
                default:
                    break;
            }
            
        }
        else 
        {
            //Set the image for the segment
//            UIImage *segmentImage = [self rotate:[self image:self.segmentImage withColor:color] radians:angle-(90* M_PI / 180)];
            UIImage *segmentImage = [self rotate:[self image:self.segmentImage withColor:color] radians:angle+(90* M_PI / 180)];

            CGSize segmentImgaeSize = segmentImage.size;
            CGFloat newPointX = (self.innerRadius+segmentImgaeSize.width/2.00) * cos(angle) + centerPoint.x;
            CGFloat newPointY = (self.innerRadius+segmentImgaeSize.height/2.00) * sin(angle) + centerPoint.y;
            CGRect rect = CGRectMake((newPointX-segmentImgaeSize.width/2.00),(newPointY-segmentImgaeSize.height/2.00), segmentImgaeSize.width, segmentImgaeSize.height);
            CGContextDrawImage(context, rect, segmentImage.CGImage);
            
        }
        
    }
    
}

@end


/*************************************************************************************************************************************************/

#pragma mark -
#pragma mark -
#pragma mark TJCircularSpinner
@interface TJCircularSpinner : TJSpinner
{
    CGFloat _angle;
    CGFloat _rotationAngle;
}

@end



@implementation TJCircularSpinner
#pragma mark -
#pragma mark Timer Fire methods
- (void) timerFired:(NSTimer *)timer
{    

    _angle = _angle+_rotationAngle;
    if (_angle>360) 
    {
        _angle = 00.00;
    }
    [self setNeedsDisplay];

}

#pragma mark -
#pragma mark View LifeCycle Methods


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        self.pathColor = [UIColor whiteColor];
        self.fillColor = [UIColor colorWithRed:17/255.00 green:181/255.00 blue:255.00/255.00 alpha:1.0];//Sky blue color
        _rotationAngle = 3.00; //Angle to rotate
        _angle = 180.00;
        self.radius = 5;
        self.thickness = 3.00;
        _speed = 1.00/(360/_rotationAngle);
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}


- (void)dealloc
{
    [_animationTimer release];
    [super dealloc];
}

#pragma mark -
#pragma mark View Drawing Method

- (void)drawRect:(CGRect)rect
{    

    CGFloat startAngle;
    //    CGFloat endAngle;

    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGContextRef context = UIGraphicsGetCurrentContext();

    //Draw the arc only once if it is not drawn
    CGPoint arcCenter = centerPoint;//CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    CGFloat arcRadius = self.radius+(self.thickness/2.00);
    UIBezierPath *arc = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:arcRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:NO];
    CGPathRef shape = CGPathCreateCopyByStrokingPath(arc.CGPath, NULL, self.thickness, kCGLineCapRound, kCGLineJoinRound, 0.0f);

    CGContextBeginPath(context);
    CGContextAddPath(context, shape);
    CGContextSetFillColorWithColor(context, self.pathColor.CGColor);
    CGContextFillPath(context);

    CGPathRelease(shape);




    startAngle = _angle;
    CGFloat currentAngle = startAngle;
    CGFloat newAlphaValue = 0.0f;
    CGFloat numberOfSteps = 360.00/_rotationAngle;
    for(float i=0;i<numberOfSteps;i++)
    {
        newAlphaValue = (newAlphaValue+(1.0/numberOfSteps));
        if (newAlphaValue>1.0) 
        {
            newAlphaValue = 0.0f;
        }
        
        CGFloat arcEndAngle = currentAngle+_rotationAngle;
        CGFloat arStartAngle = currentAngle;
        
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, self.radius+(self.thickness/2.0), DEGREES_TO_RADIANS(arStartAngle), DEGREES_TO_RADIANS(arcEndAngle), 0);
        CGContextSetLineWidth(context, self.thickness);
        UIColor *newColor = nil;
        CGColorRef colorRef = CGColorCreateCopyWithAlpha(self.fillColor.CGColor, newAlphaValue);
        newColor = [UIColor colorWithCGColor:colorRef];
        CGColorRelease(colorRef);
        
        
        CGContextSetStrokeColorWithColor(context,newColor.CGColor);
        //        CGContextSetLineCap(context, kCGLineCapRound);
        if(i==numberOfSteps-1)
        {
            CGContextSetLineCap(context, kCGLineCapRound);
        }
        CGContextStrokePath(context);
        
        CGContextSetFillColorWithColor(context, newColor.CGColor);
        CGContextFillPath(context);
        
        currentAngle = currentAngle+_rotationAngle;
    }

}



#pragma mark - Spinner animation methods
- (void)startAnimating
{
    //    NSLog(@"Start radial spinner animation");
    [super startAnimating];
    _angle = 180;
    [_animationTimer invalidate];

    _animationTimer = [[NSTimer timerWithTimeInterval:_speed target:self selector:@selector(timerFired:) userInfo:nil repeats:YES]retain];
    [[NSRunLoop currentRunLoop]addTimer:_animationTimer forMode:NSDefaultRunLoopMode ];

}
- (void)stopAnimating
{
    //    NSLog(@"Stop radial spinner animation");
    [super stopAnimating];
    //Invalidate the timer to stop the animation
    [_animationTimer invalidate];
    [_animationTimer release];
    _animationTimer = nil;
    _angle = 180;
    [self setNeedsDisplay];

}

- (void) setRadius:(CGFloat)radius
{
    super.radius = radius;

    CGRect newFrameRect = self.frame;
    CGFloat newHeight = self.radius*2.00+self.thickness*2.00;
    CGFloat newWidth = newHeight;

    if (self.frame.size.height<newHeight) 
    {
        newFrameRect.size.height = newHeight;
    }
    if (self.frame.size.height<newWidth) 
    {
        newFrameRect.size.width = newWidth;
        
    }

    self.frame = newFrameRect;
    [self setNeedsDisplay];

}

- (void) setThickness:(CGFloat)thickness
{
    super.thickness = thickness;

    CGRect newFrameRect = self.frame;
    CGFloat newHeight = self.radius*2.00+self.thickness*2.00;
    CGFloat newWidth = newHeight;

    if (self.frame.size.height<newHeight) 
    {
        newFrameRect.size.height = newHeight;
    }
    if (self.frame.size.height<newWidth) 
    {
        newFrameRect.size.width = newWidth;
        
    }
    self.frame = newFrameRect;

    [self setNeedsDisplay];

}

@end

/*************************************************************************************************************************************************/


#pragma mark -
#pragma mark -
#pragma mark TJBeachBallSpinner
@interface TJBeachBallSpinner : TJSpinner
{
    NSUInteger _segmentIndex;
    CGFloat _angle;
    NSUInteger _segmets;
    NSMutableArray *_segmentColors;
    
}

@end


@implementation TJBeachBallSpinner



#pragma mark -
#pragma mark Private methods
- (void) drawSegmentForIndex:(int)index startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle context:(CGContextRef)context
{

    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    int colorIndex = index;

    if (colorIndex>=_segmets) 
    {
        colorIndex = colorIndex - _segmets;
    }

    //UIColor *color = [self colorForSegment:_segmentIndex+index*(-1)];
    UIColor *color = [_segmentColors objectAtIndex:colorIndex];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,centerPoint.x, centerPoint.y);
    CGPathAddArc(path, NULL,centerPoint.x, centerPoint.y, self.radius,startAngle, endAngle, 0);

    CGContextAddPath(context, path);
    [color setFill];    
    CGContextFillPath(context);

    CGPathRelease(path);

}



- (void)drawFansInContext:(CGContextRef)context
{
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    CGFloat startAngle = _angle;

    int fanCount = 10;

    CGFloat anglePerFan = 360.00/fanCount;
    CGFloat endAngle = anglePerFan + startAngle; 

    CGFloat arcRadius = self.radius/2.0;
    CGFloat arcAngle = 360.00/fanCount;


    for (int i=0; i<fanCount; i++)
    {
        
        //For every alternate iterations we need to draw arcs, to draw the shape like fan
        if ((i%2)==0) 
        {
            
            
            CGFloat startAngleInRad = DEGREES_TO_RADIANS(startAngle);
            CGFloat endAngleInRad = DEGREES_TO_RADIANS(endAngle);
            
            CGFloat startPointX = self.radius * cos(startAngleInRad) + centerPoint.x;
            CGFloat startPointY = self.radius * sin(startAngleInRad) + centerPoint.y;
            
            CGFloat endPointX = self.radius * cos(endAngleInRad) + centerPoint.x;
            CGFloat endPointY = self.radius * sin(endAngleInRad) + centerPoint.y;
            
            
            
            CGFloat startArcAngle = startAngleInRad+DEGREES_TO_RADIANS(arcAngle);
            CGFloat arcStartPointX = arcRadius * cos(startArcAngle) + centerPoint.x;
            CGFloat arcStartPointY = arcRadius * sin(startArcAngle) + centerPoint.y;
            
            CGFloat endArcAngle = endAngleInRad+DEGREES_TO_RADIANS(arcAngle);
            CGFloat arcEndPointX = arcRadius * cos(endArcAngle) + centerPoint.x;
            CGFloat arcEndPointY = arcRadius * sin(endArcAngle) + centerPoint.y;
            
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL,centerPoint.x, centerPoint.y);
            CGPathAddQuadCurveToPoint(path, NULL, arcStartPointX, arcStartPointY, startPointX, startPointY);
            CGPathAddArc(path, NULL,centerPoint.x, centerPoint.y, self.radius,startAngleInRad, endAngleInRad, 0);
            
            CGPathMoveToPoint(path, NULL,centerPoint.x, centerPoint.y);
            CGPathAddQuadCurveToPoint(path, NULL, arcEndPointX, arcEndPointY, endPointX, endPointY);
            
            
            CGContextAddPath(context, path);
            [[UIColor colorWithWhite:0.2 alpha:0.3] setFill]; 
            
            
            
            CGContextFillPath(context);
            CGPathRelease(path);
            
            
        }
        startAngle = startAngle+anglePerFan;
        endAngle = endAngle +anglePerFan;
        
        
    }
}

- (void) drawGlossyEffectInContext:(CGContextRef)context
{
    //Calculate the center points
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

   //White color is used to reflect the glossy effect. Only alpha value need to be changed around the corners.
    CGFloat colors [] = {1.0, 1.0, 1.0, 0.0, 
                        1.0,1.0, 1.0, 0.4
                        };
    //Specify the gloss locations.
    CGFloat glossLocations[] = {0,1};
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, glossLocations,2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;

    CGContextSaveGState(context);
    //Draw the area to be covered with glossy effect
    CGContextAddArc(context, centerPoint.x, centerPoint.y, self.radius-1, DEGREES_TO_RADIANS(190), DEGREES_TO_RADIANS(350), 0);

    CGContextClip(context);

    CGFloat startRadius = self.radius - (self.radius/2.0);
    CGFloat endRadius = self.radius - 1;
    
    //Draw the radial gradient
    CGContextDrawRadialGradient(context, gradient, centerPoint, startRadius, centerPoint, endRadius, kCGGradientDrawsBeforeStartLocation);
    
    //Release the gradient and clor
    CGGradientRelease(gradient), gradient = NULL;
    CGContextRestoreGState(context);

}

- (void) drawEdgeCirceInContext:(CGContextRef)context
{
    //Draw a circle to surround the rainbow circle. This is to give smooth effect to the circle edges.
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGContextAddArc(context, centerPoint.x, centerPoint.y, self.radius, DEGREES_TO_RADIANS(0), DEGREES_TO_RADIANS(360), 0);
    [[UIColor colorWithWhite:0.0 alpha:0.1] set];
    CGContextSetLineWidth(context, k_CIRCE_EDGE_WIDTH);
    CGContextStrokePath(context);

}

- (void) drawShadowEffectInContext:(CGContextRef)context
{

   //Draw the shadow effect to the rainbow circles
    CGSize          shadowOffset = CGSizeMake (0,  self.radius -(k_SHADOW_OFFSET *self.radius));
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    CGContextSaveGState(context);
    CGContextSetShadowWithColor (context, shadowOffset, 5, [UIColor grayColor].CGColor);
    CGContextSetRGBFillColor (context, 0, 1, 0, 1);
    CGContextAddArc(context, centerPoint.x, centerPoint.y, self.radius, DEGREES_TO_RADIANS(0), DEGREES_TO_RADIANS(360), 1);
    [[UIColor whiteColor] set];
    CGContextFillPath(context);  
    CGContextRestoreGState(context);

}

- (NSArray *) defaultColors
{
   //We create the rainbow colors
    float INCREMENT = 1.00/_segmets;
    NSMutableArray *colors = [NSMutableArray array];
    for (float hue = 1.0; hue > 0.00; hue -= INCREMENT) 
    {
        UIColor *color = [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:1.0];
        [colors addObject:color];
    }
    return colors;

}

- (UIColor*) colorForSegment:(NSUInteger)segmentIndex
{
    CGFloat segmentValue = _segmets;
    CGFloat colorValue = 1.0 - (segmentIndex % _segmets) * (1.0 / segmentValue);

    UIColor *color = [UIColor colorWithHue:colorValue saturation:1 brightness:0.8 alpha:1.0];
    return color;
}

#pragma mark -
#pragma mark Timer Fire Method

- (void) timerFired:(NSTimer *)timer
{
    //In timer fire method we need to change the opacity of the each stroke

    [self setNeedsDisplay];
    _angle = _angle+5;
    if (_angle>=360)
    {
        _angle = 0.0;
    }
}

#pragma mark -
#pragma mark View LifeCycle Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        _segmets = 360;
        _angle = 0.00;
        _segmentColors = [[NSMutableArray alloc]initWithArray:[self defaultColors]];
        self.radius = 11.0;
        _speed = 0.05;
    }
    return self;
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}


- (void)dealloc
{
    [_segmentColors release];
    [_animationTimer release];
    [super dealloc];
}


#pragma mark -
#pragma mark View Drawing Method
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    double startAngle;
    double angleForStep = 360.00/_segmets;
    double angle = 180.00;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawShadowEffectInContext:context];
    for (int index=0; index<_segmets; index++) 
    {
        startAngle = angle;
        angle = angle + angleForStep;
        
        //Draw the segment with known start angle and end angle
        [self drawSegmentForIndex:index startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(angle) context:context];
    }
    [self drawFansInContext:context];
    [self drawGlossyEffectInContext:context];
    [self drawEdgeCirceInContext:context];

}

#pragma mark - Spinner animation methods
- (void)startAnimating
{
    //    NSLog(@"Start beach ball spinner animation");
    [super startAnimating];
    [_animationTimer invalidate];
    _animationTimer = [[NSTimer timerWithTimeInterval:_speed target:self selector:@selector(timerFired:) userInfo:nil repeats:YES]retain];
    [[NSRunLoop currentRunLoop]addTimer:_animationTimer forMode:NSDefaultRunLoopMode ];

}
- (void)stopAnimating
{
    //    NSLog(@"Stop beach ball spinner animation");
    //Invalidate the timer to stop the animation
    [super stopAnimating];
    [_animationTimer invalidate];
    [_animationTimer release];
    _animationTimer = nil;

}

- (void)setRadius:(CGFloat)radius
{
    super.radius = radius;


    CGRect newFrameRect = self.frame;
    CGFloat newHeight = self.radius*2.00+k_CIRCE_EDGE_WIDTH*2.0+self.radius;

    CGFloat newWidth = radius*2.00+k_CIRCE_EDGE_WIDTH*2.0+(self.radius * k_SHADOW_OFFSET);

    if (self.frame.size.height<newHeight) 
    {
        newFrameRect.size.height = newHeight;
    }
    if (self.frame.size.height<newWidth) 
    {
        newFrameRect.size.width = newWidth;
        
    }
    self.frame = newFrameRect;

    [self setNeedsDisplay];
}

@end


/**************************************************************************************************************************************************/

#pragma mark -
#pragma mark -
#pragma mark TJSpinner

@implementation TJSpinner

//Synthesizer common for all types of spinners
@synthesize hidesWhenStopped = _hidesWhenStopped;
@synthesize isAnimating = _isAnimating;
@synthesize speed = _speed;

//Synthesizer specific to kTJSpinnerTypeActivityIndicator
@synthesize color = _color;
@synthesize innerRadius = _innerRadius;
@synthesize outerRadius = _outerRadius;
@synthesize numberOfStrokes = _numberOfStrokes;
@synthesize strokeWidth = _strokeWidth;
@synthesize patternStyle = _patternStyle;
@synthesize segmentImage = _segmentImage;
@synthesize patternLineCap = _patternLineCap;

//Synthesizer specific to kTJSpinnerTypeCircular
@synthesize fillColor = _fillColor;
@synthesize pathColor = _pathColor;
@synthesize thickness = _thickness;


//Synthesizer specific to kTJSpinnerTypeBeachBall
@synthesize radius = _radius;

#pragma mark -
#pragma mark Initialization Methods




- (TJSpinner *)initWithSpinnerType:(NSString *) spinnerType
{
    self = [super init];
    if (self) 
    {
        self = [[NSClassFromString(spinnerType) alloc]init];
        self.hidden = _hidesWhenStopped;
    }
    return self;
}


+ (TJSpinner *) spinnerWithType:(NSString *) spinnerType
{
    return [[[[self class] alloc] initWithSpinnerType:spinnerType] autorelease];
}


- (void) dealloc
{
    [_color release];
    [_fillColor release];
    [_pathColor release];
    [_segmentImage release];
    [super dealloc];
}


#pragma mark -
#pragma mark Animation Methods
- (void) startAnimating
{
//    NSLog(@"Start Animation");
    self.hidden = NO;
    _isAnimating = YES;
}

- (void) stopAnimating
{
//    NSLog(@"Stop Animation");
    self.hidden = _hidesWhenStopped;
    _isAnimating = NO;
}

- (void)setHidesWhenStopped:(BOOL)hidesWhenAnimationStopped
{
    _hidesWhenStopped = hidesWhenAnimationStopped;
    self.hidden = hidesWhenAnimationStopped;
    [self setNeedsDisplay];
}


@end
