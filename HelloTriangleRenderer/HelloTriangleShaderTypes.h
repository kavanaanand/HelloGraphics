//
//  HelloTriangleShaderTypes.h
//  HelloTraingle macOS
//
//  Created by Kavana Anand on 4/7/19.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#ifndef HelloTriangleShaderTypes_h
#define HelloTriangleShaderTypes_h

#import <simd/simd.h>

typedef enum HelloTriangleVertexInputIndex
{
    HelloTriangleVertexInputIndexVertices     = 0,
    HelloTriangleVertexInputIndexViewportSize = 1,
} HelloTriangleVertexInputIndex;

typedef struct {

vector_float2 position;

vector_float4 color;

} HelloTraingleVertex;

#endif /* HelloTriangleShaderTypes_h */
