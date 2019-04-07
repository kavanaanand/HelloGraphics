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

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)metalKitView {
    self = [super init];
    if (self) {
        device = metalKitView.device;
        commandQueue = [device newCommandQueue];
    }
    return self;
}

- (void)drawInMTKView:(nonnull MTKView *)view {

    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    commandBuffer.label = @"HelloGraphicsCommand";
    
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    if(renderPassDescriptor != nil) {
        
        id<MTLRenderCommandEncoder> renderCommandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderCommandEncoder.label = @"HelloGraphicsRenderCommandEncoder";
        
        [renderCommandEncoder endEncoding];
        
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    
    [commandBuffer commit];
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}

@end

NS_ASSUME_NONNULL_END
