//
//  HelloTraingleShader.metal
//  HelloTraingle macOS
//
//  Created by Kavana Anand on 4/7/19.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#import "HelloTriangleShaderTypes.h"

typedef struct {
    // The [[position]] attribute indicates that the value returned by vertex function is position in clip space co-ordinate sytem
    float4 clipSpacePosition [[position]];
    
    // As there is no attribute attached to color, the rasterizes interpolates it and sends to fragment function
    float4 color;
} RasterizerData;

// Vertex function
vertex RasterizerData vertex_shader(uint vertexID [[vertex_id]],
                                    constant HelloTraingleVertex *vertices [[buffer(HelloTriangleVertexInputIndexVertices)]],
                                    constant vector_uint2 *viewPortSizePtr [[buffer(HelloTriangleVertexInputIndexViewportSize)]]) {
    
    RasterizerData out_rasterizerData;
    out_rasterizerData.clipSpacePosition = vector_float4(0.0, 0.0, 0.0, 1.0);
    
    // clipspaceposition = pixelspaceposition / (viewportsize / 2.0)
    out_rasterizerData.clipSpacePosition.xy = vertices[vertexID].position.xy / ((vector_float2)(*viewPortSizePtr) / 2.0);
    
    // Sending color as is so rasterizer can interpolate before sending it to fragment funtion
    out_rasterizerData.color = vertices[vertexID].color;
    
    return out_rasterizerData;
}

// Fragment function
// The [[stage_in]] attribute qualifier indicates that this parameter comes from the rasterizer.
fragment float4 fragment_shader(RasterizerData in_rasterizerData [[stage_in]]) {
    // Returning the interpolated color received fromt the rasterizer
    return in_rasterizerData.color;
}



