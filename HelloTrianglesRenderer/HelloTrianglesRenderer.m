//
//  HelloTrianglesRenderer.m
//  HelloTriangles macOS
//
//  Created by Kavana Anand on 08/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import "HelloTrianglesRenderer.h"
#import "HelloTrianglesShaderTypes.h"

@implementation HelloTrianglesRenderer {
    id<MTLDevice> device;
    id<MTLCommandQueue> commandQueue;
    id<MTLRenderPipelineState> renderPipelineState;
    id<MTLBuffer> vertexBuffer;
    NSUInteger totalVerticesCount;
    vector_uint2 viewPortSize;
}

- (nonnull instancetype)initWithMetalKitView:(MTKView *)metalKitView {
    self = [super init];
    
    if(self) {

        device = [metalKitView device];
        
        id<MTLLibrary> library = [device newDefaultLibrary];
        id<MTLFunction> vertex_function = [library newFunctionWithName:@"vertex_shader"];
        id<MTLFunction> fragment_function = [library newFunctionWithName:@"fragment_shader"];
        
        MTLRenderPipelineDescriptor *renderPipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        renderPipelineDescriptor.label = @"HelloTrianglesRenderPipelineDescriptor";
        renderPipelineDescriptor.vertexFunction = vertex_function;
        renderPipelineDescriptor.fragmentFunction = fragment_function;
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = metalKitView.colorPixelFormat;

        
        NSError *error = NULL;

        renderPipelineState = [device newRenderPipelineStateWithDescriptor:renderPipelineDescriptor error:&error];
        
        if (!renderPipelineState)
        {
            NSLog(@"Failed to created pipeline state, error %@", error);
            return nil;
        }
        
        // Generate Vertex Data
        const HelloTrianglesVertex shapeVertices[] = {
        
             {{0,100}, {0, 0, 1, 1}},
             {{-100,0}, {0, 1, 0, 1}},
             {{100,0}, {1, 0, 0, 1}},
            
             {{0,-100}, {0, 0, 1, 1}},
             {{-100,0}, {0, 1, 0, 1}},
             {{100,0}, {1, 0, 0, 1}},
        };
        
        const NSUInteger NUM_COLUMNS = 3;
        const NSUInteger NUM_ROWS = 3;
        const NSUInteger NUM_VERTICES_PER_SHAPE = sizeof(shapeVertices) / sizeof(HelloTrianglesVertex);
        const float SHAPE_SPACING = 300.0;
        
        NSUInteger vertexDataSize = NUM_COLUMNS * NUM_ROWS * sizeof(shapeVertices);
        NSMutableData *vertexData = [[NSMutableData alloc] initWithLength:vertexDataSize];
        
        HelloTrianglesVertex* shapes = [vertexData mutableBytes];

        for (NSUInteger row = 0; row < NUM_ROWS; row++) {
            for (NSUInteger column = 0; column < NUM_COLUMNS; column++) {
                
                memcpy(shapes, &shapeVertices, sizeof(shapeVertices));
                
                vector_float2 startingOrigin;
                startingOrigin.x = (float)column * SHAPE_SPACING;
                startingOrigin.y = -((float)row) * SHAPE_SPACING;
                
                
                for (NSUInteger vertexIndex = 0; vertexIndex < NUM_VERTICES_PER_SHAPE; vertexIndex++) {
                        shapes[vertexIndex].position += startingOrigin;
                }
                
                shapes += NUM_VERTICES_PER_SHAPE;
            }
        }
        
        // Create a New MTLBuffer
        vertexBuffer = [device newBufferWithLength:vertexData.length options:MTLResourceStorageModeShared];
        
        // Copy vertex data to the buffer
        memcpy(vertexBuffer.contents, vertexData.bytes, vertexData.length);
        
        totalVerticesCount = NUM_VERTICES_PER_SHAPE * NUM_COLUMNS * NUM_ROWS;
        
        commandQueue = [device newCommandQueue];
    }
    
    return self;
}


- (void)drawInMTKView:(nonnull MTKView *)view {

    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    commandBuffer.label = @"HelloTrianglesCommandBuffer";
    
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    if(renderPassDescriptor != nil) {
        id<MTLRenderCommandEncoder> renderCommandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderCommandEncoder setRenderPipelineState:renderPipelineState];
        renderCommandEncoder.label = @"HelloTrianglesRenderCommandEncoder";
        
        [renderCommandEncoder setVertexBytes:&viewPortSize length:sizeof(vertexBuffer) atIndex:HelloTrianglesVertexInputIndexViewPortSize];
        [renderCommandEncoder setVertexBuffer:vertexBuffer offset:0 atIndex:HelloTrianglesVertexInputIndexVertices];
        
        [renderCommandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:totalVerticesCount];
        
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
