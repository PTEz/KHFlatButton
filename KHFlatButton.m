//
//  KHFlatButton.m
//
//  Created by Kyle Horn on 10/7/13.
//  Copyright (c) 2013 Kyle Horn. All rights reserved.
//

#import "KHFlatButton.h"
#import <QuartzCore/QuartzCore.h>

const float kDefaultRadius = 2.0;

@interface KHFlatButton()
@property (strong, nonatomic) UIColor *buttonColor;
@end

@implementation KHFlatButton

- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeFlat:self withBackgroundColor:backgroundColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor*)backgroundColor cornerRadius:(CGFloat)radius;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeFlat:self withBackgroundColor:backgroundColor];
        // If no radius is provided use default of 2.0
        radius = (radius) ? radius : kDefaultRadius;
        [self.layer setCornerRadius:radius];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)radius
{
    KHFlatButton *btn = [[KHFlatButton alloc]initWithFrame:frame withTitle:title backgroundColor:backgroundColor cornerRadius:radius];
    return btn;    
}

+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    KHFlatButton *btn = [[KHFlatButton alloc]initWithFrame:frame withTitle:title backgroundColor:backgroundColor cornerRadius:kDefaultRadius];
    return btn;
}

- (void)makeFlat:(KHFlatButton *)button withBackgroundColor:(UIColor*)backgroundColor
{
    self.buttonColor = backgroundColor;
    [self setBackgroundColor:backgroundColor];
    [self addTarget:self action:@selector(wasPressed) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(endedPress) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(endedPress) forControlEvents:UIControlEventTouchUpInside];
}

- (void)wasPressed
{
    UIColor *newColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0, white = 0.0;
    
    if([self.buttonColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.buttonColor getRed:&red green:&green blue:&blue alpha:&alpha];
        [self.buttonColor getWhite:&white alpha:&alpha];
        
        if(!(red + green + blue) && white){
            newColor = [UIColor colorWithWhite:white - 0.2 alpha:alpha];
        } else if(!(red + green + blue) && !white) {
            newColor = [UIColor colorWithWhite:white + 0.2 alpha:alpha];
        } else{
            newColor = [UIColor colorWithRed:red - 0.2 green:green - 0.2 blue:blue - 0.2 alpha:alpha];
        }
    } else if(CGColorGetNumberOfComponents(self.buttonColor.CGColor) == 2){
        CGFloat hue;
        CGFloat saturation;
        CGFloat brightness;
        [self.buttonColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        
        newColor = [UIColor colorWithHue:hue - 0.2 saturation:saturation - 0.2 brightness:brightness - 0.2 alpha:alpha];
    }
    
    self.backgroundColor = newColor;
    
}

- (void)endedPress
{
    self.backgroundColor = self.buttonColor;
}


@end
