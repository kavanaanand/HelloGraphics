//
//  HelloTrianglesRenderer.h
//  HelloTriangles macOS
//
//  Created by Kavana Anand on 08/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetalKit/MetalKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelloTrianglesRenderer : NSObject<MTKViewDelegate>

- (nonnull instancetype)initWithMetalKitView:(MTKView *)metalKitView;

@end

NS_ASSUME_NONNULL_END
