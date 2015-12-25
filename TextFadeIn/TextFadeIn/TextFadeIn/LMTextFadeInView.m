//
//  LMTextFadeInView.m
//  TextFadeIn
//
//  Created by by on 15/12/24.
//  Copyright © 2015年 dlm. All rights reserved.
//

#import "LMTextFadeInView.h"
#import <CoreText/CoreText.h>

#define textLayer ((LMTextFadeInLayer *)self.layer)

@interface LMTextFadeInLayer : CATextLayer

@property (nonatomic, strong) NSString *text;

@end

@interface LMTextFadeInLayer (){
    NSInteger count;
}

@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) NSMutableAttributedString *attributedString;

@end
@implementation LMTextFadeInLayer

- (instancetype)init{
    self = [super init];
    if (self){
        self.wrapped = YES;
    }
    return self;
}

-(void)setText:(NSString *)text
{
    if (!text) return;
    [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _text = text;
    _attributedString = [[NSMutableAttributedString alloc] initWithString:_text];
    
    count = 1;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(frameUpdate:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)frameUpdate:(id)sender
{
    [self.attributedString removeAttribute:(NSString *)kCTForegroundColorAttributeName range:NSMakeRange(0, self.text.length)];
    
    BOOL shouldRemoveDisplayLink = YES;
    if (count == self.text.length - 1) {
        shouldRemoveDisplayLink = NO;
    }
    
    UIColor *letterColor = [UIColor colorWithWhite:0 alpha:1];
    [self.attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                  value:(id)letterColor.CGColor
                                  range:NSMakeRange(0, count)];
    [self.attributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                  value:(id)[UIColor colorWithWhite:0 alpha:0].CGColor
                                  range:NSMakeRange(count, self.text.length - count)];
    count++;
    NSLog(@"count ===> %d",count);
    if (!shouldRemoveDisplayLink){
        count = 1;
        [_displayLink invalidate];
        [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _displayLink = nil;
    }
    
    CTFontRef helveticaBold = CTFontCreateWithName(CFSTR("HelveticaNeue-Light"), 12.0, NULL);
    [self.attributedString addAttribute:(NSString *)kCTFontAttributeName
                                  value:(__bridge id)helveticaBold
                                  range:NSMakeRange(0, self.text.length)];
    self.string = (id)self.attributedString;
}

@synthesize text = _text;
@end

@interface LMTextFadeInView ()

@end

@implementation LMTextFadeInView

+ (Class)layerClass
{
    return [LMTextFadeInLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    textLayer.text = text;
}

@end

