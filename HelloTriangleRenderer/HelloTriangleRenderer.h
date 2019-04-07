//
//  HelloTriangleRenderer.h
//  HelloGraphics
//
//  Created by Kavana Anand on 4/5/19.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelloTriangleRenderer : NSObject <MTKViewDelegate>

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)metalKitView;

@end

NS_ASSUME_NONNULL_END
