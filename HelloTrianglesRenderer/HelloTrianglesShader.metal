//
//  HelloTrianglesShader.metal
//  HelloTriangles macOS
//
//  Created by Kavana Anand on 08/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#import "HelloTrianglesShaderTypes.h"

typedef struct {
    float4 clipSpacePosition [[position]];
    float4 color;
} RasterizerData;

vertex RasterizerData vertex_shader(uint vertexID [[vertex_id]],
                                    constant HelloTrianglesVertex *vertices [[buffer(HelloTrianglesVertexInputIndexVertices)]],
                                    constant vector_uint2 *viewPortSizePtr [[buffer(HelloTrianglesVertexInputIndexViewPortSize)]]) {
    
    RasterizerData out_data;
    
    out_data.clipSpacePosition = float4(0.0,0.0,0.0,1.0);
    
    out_data.clipSpacePosition.xy = vertices[vertexID].position.xy / ((float2)(*viewPortSizePtr) / 2) ;
    
    out_data.color = vertices[vertexID].color;
    
    return out_data;
}

fragment float4 fragment_shader(RasterizerData in_data [[stage_in]]) {
    return in_data.color;
}

