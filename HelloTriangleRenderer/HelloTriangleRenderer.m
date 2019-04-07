//
//  HelloTriangleRenderer.m
//  HelloGraphics
//
//  Created by Kavana Anand on 4/5/19.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import "HelloTriangleRenderer.h"
#import <simd/vector_types.h>
#import <MetalKit/MetalKit.h>
#import "HelloTriangleShaderTypes.h"

@implementation HelloTriangleRenderer {
    id<MTLDevice> device;
    id<MTLRenderPipelineState> renderPipelineState;
    id<MTLCommandQueue> commandQueue;
    vector_uint2 viewPortSize;
}

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)metalKitView {

    self = [super init];
    if (self) {
        NSError *error = NULL;

        device = metalKitView.device;
        
        id<MTLLibrary> defaultLibrary = [device newDefaultLibrary];
        id<MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName:@"vertex_shader"];
        id<MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName:@"fragment_shader"];

        MTLRenderPipelineDescriptor *renderPipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        renderPipelineDescriptor.label = @"HelloTriangleRenderPipelineDescriptor";
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = metalKitView.colorPixelFormat;
        renderPipelineDescriptor.vertexFunction = vertexFunction;
        renderPipelineDescriptor.fragmentFunction = fragmentFunction;

        renderPipelineState = [device newRenderPipelineStateWithDescriptor:renderPipelineDescriptor error:&error];
        
        if (!renderPipelineState)
        {
            NSLog(@"Failed to created pipeline state, error %@", error);
            return nil;
        }

        commandQueue = [device newCommandQueue];
    }
    return self;
}

- (void)drawInMTKView:(nonnull MTKView *)view {
    
    static const HelloTraingleVertex vertices[] = {
      {{-500, -500}, {1.0,0.0,0.0,1.0}},
      {{500, -500}, {0.0,1.0,0.0,1.0}},
      {{0, 500}, {0.0,0.0,1.0,1.0}},
    };
    
    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    commandBuffer.label = @"HelloTraingleCommandBuffer";
    
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    if(renderPassDescriptor != nil) {
        id<MTLRenderCommandEncoder> renderCommandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderCommandEncoder setRenderPipelineState:renderPipelineState];
        
        [renderCommandEncoder setVertexBytes:vertices length:sizeof(vertices) atIndex:HelloTriangleVertexInputIndexVertices];
        [renderCommandEncoder setVertexBytes:&viewPortSize length:sizeof(viewPortSize) atIndex:HelloTriangleVertexInputIndexViewportSize];
        
        [renderCommandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:3];
        
        [renderCommandEncoder endEncoding];
        
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    
    [commandBuffer commit];
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    viewPortSize.x = size.width;
    viewPortSize.y = size.height;
}

@end
