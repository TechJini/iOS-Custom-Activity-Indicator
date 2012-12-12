#iOS-Custom-Activity-Indicator
=============================

## How to use?

<strong><a href="http://www.techjini.com/blog/different-type-custom-activity-indicator-spinner/">Creating custom activity indicator for iOS</a>
</strong>


<strong>Implementation of spinners</strong>

TJSppiner has ability to achieve or change colour, size pattern, image, rotation speed etc.

<strong>1. Implementation of line base spinners (similar as iOS Activity indicator).</strong>
A. You can change inner and outer radius of spinner
B. You can change number of line to be appear in the circle of the spinner.
C. You can change appearance of spinner using its property like colour, pattern, caps/stork, image etc...

<code> TJSpinner *spinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeActivityIndicator];
spinner.hidesWhenStopped = YES;
[spinner setColor:[UIColor blackColor]];
[spinner setInnerRadius:15];
[spinner setOuterRadius:35];
[spinner setStrokeWidth:6];
[spinner setNumberOfStrokes:8];
[spinner setPatternLineCap:kCGLineCapButt];
[spinner setPatternStyle:TJActivityIndicatorPatternStyleDot];
[spinner release];
</code>

<strong>2. Implementation of BeachBall spinners (similar as iMAC desktop beach ball).</strong>
A. You can change radius (size) of the beach ball.

<code>
TJSpinner *beachBallSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJSpinnerTypeBeachBall];
beachBallSpinner.hidesWhenStopped = YES;
[beachBallSpinner setRadius:20];
[beachBallSpinner release];
</code>

<strong>3. Implementation of Circular spinners (similar as web).</strong>
A. You can change radius (size) of the Circular spinners.

<code>TJSpinner *circularSpinner = [[TJSpinner alloc] initWithSpinnerType:kTJCircularSpinner];
circularSpinner.hidesWhenStopped = YES;
circularSpinner.radius = 10;
circularSpinner.pathColor = [UIColor whiteColor];
circularSpinner.fillColor = [UIColor redColor];
circularSpinner.thickness = 7;
[circularSpinner release];</code>


## Sample output

<strong><a href="http://youtu.be/0B3rsdhniBI">iOS Custom Activity indicator or spinner</a></strong>
