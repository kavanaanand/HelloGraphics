//
//  HelloGraphicsRenderer.h
//  HelloGraphics
//
//  Created by Kavana Anand on 03/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetalKit/MetalKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelloGraphicsRenderer : NSObject <MTKViewDelegate>

- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)metalKitView;

@end

NS_ASSUME_NONNULL_END
