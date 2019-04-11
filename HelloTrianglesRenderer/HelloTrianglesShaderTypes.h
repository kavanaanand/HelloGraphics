//
//  HelloTrianglesShaderTypes.h
//  HelloTriangles macOS
//
//  Created by Kavana Anand on 08/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#ifndef HelloTrianglesShaderTypes_h
#define HelloTrianglesShaderTypes_h

#import <simd/simd.h>

typedef enum HelloTrianglesVertexInputIndex{
    HelloTrianglesVertexInputIndexVertices = 0,
    HelloTrianglesVertexInputIndexViewPortSize = 1
} HelloTrianglesVertexInputIndex;

typedef struct {
    vector_float2 position;
    vector_float4 color;
} HelloTrianglesVertex;


#endif /* HelloTrianglesShaderTypes_h */
