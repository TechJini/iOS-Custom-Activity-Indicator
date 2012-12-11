//
//  CALine.m
//  CoreAnimationStuff
//
//  Created by Aparna Bhat on 10/08/12.
//  Copyright (c) 2012 TechJini Solutions Pvt. Ltd. All rights reserved.
//

#import "CALine.h"

@implementation CALine

#pragma mark -
#pragma Synthesizer Methods

@synthesize color = _color;
@synthesize startPoint = _startPoint;
@synthesize endPoint = _endPoint;


#pragma mark -
#pragma mark - Object Life Cycle Methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [_color release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
