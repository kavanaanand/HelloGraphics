//
//  ViewController.m
//  HelloTraingle macOS
//
//  Created by Kavana Anand on 4/6/19.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import "HelloTriangle_macOSViewController.h"
#import "HelloTriangleRenderer.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>

@implementation HelloTriangle_macOSViewController {
    MTKView *metalKitView;
    HelloTriangleRenderer *renderer;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    metalKitView = [[MTKView alloc]initWithFrame:[self.view frame] device:MTLCreateSystemDefaultDevice()];
    self.view = metalKitView;
    
    if (!metalKitView.device) {
        NSLog(@"Metal is not supported in this device");
        return;
    }
    
    renderer = [[HelloTriangleRenderer alloc] initWithMetalKitView:metalKitView];
    
    if(!renderer) {
        NSLog(@"Renderer failed initialization");
        return;
    }
    
    [renderer mtkView:metalKitView drawableSizeWillChange:metalKitView.drawableSize];
    
    metalKitView.delegate = renderer;
    metalKitView.preferredFramesPerSecond = 60;
}


@end
