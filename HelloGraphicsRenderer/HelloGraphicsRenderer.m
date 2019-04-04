//
//  HelloGraphicsRenderer.m
//  HelloGraphics
//
//  Created by Kavana Anand on 03/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import "HelloGraphicsRenderer.h"
#import <MetalKit/MetalKit.h>
#import <Metal/Metal.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelloGraphicsRenderer () 

@end

@implementation HelloGraphicsRenderer {
    id<MTLDevice> device;
    id<MTLCommandQueue> commandQueue;
}


typedef struct {
    float red, green, blue, alpha;
} Color;

/// Gradually cycles through different colors on each invocation.  Generally you would just pick
///   a single clear color, set it once and forget, but since that would make this sample
///   very boring we'll just return a different clear color each frame :)
- (Color)makeFancyColor
{
    static BOOL       growing = YES;
    static NSUInteger primaryChannel = 0;
    static float      colorChannels[] = {1.0, 0.0, 0.0, 1.0};

    const float DynamicColorRate = 0.015;

    if(growing)
    {
        NSUInteger dynamicChannelIndex = (primaryChannel+1)%3;
        colorChannels[dynamicChannelIndex] += DynamicColorRate;
        if(colorChannels[dynamicChannelIndex] >= 1.0)
        {
            growing = NO;
            primaryChannel = dynamicChannelIndex;
        }
    }
    else
    {
        NSUInteger dynamicChannelIndex = (primaryChannel+2)%3;
        colorChannels[dynamicChannelIndex] -= DynamicColorRate;
        if(colorChannels[dynamicChannelIndex] <= 0.0)
        {
            growing = YES;
        }
    }

    Color color;

    color.red   = colorChannels[0];
    color.green = colorChannels[1];
    color.blue  = colorChannels[2];
    color.alpha = colorChannels[3];

    return color;
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)metalKitView {
    self = [super init];
    if (self) {
        device = metalKitView.device;
        commandQueue = [device newCommandQueue];
    }
    return self;
}

- (void)drawInMTKView:(nonnull MTKView *)view {

    Color color = [self makeFancyColor];
    view.clearColor = MTLClearColorMake(color.red, color.green, color.blue, color.alpha);

    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    commandBuffer.label = @"HelloGraphicsCommand";
    
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    if(renderPassDescriptor != nil) {
        
        id<MTLRenderCommandEncoder> renderCommandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderCommandEncoder.label = @"HelloGraphicsRenderCommandEncoder";
        
        NSLog(@"here");
        
        [renderCommandEncoder endEncoding];
        
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    
    [commandBuffer commit];
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}

@end

NS_ASSUME_NONNULL_END
