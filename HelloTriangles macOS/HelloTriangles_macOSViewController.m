//
//  ViewController.m
//  HelloTriangles macOS
//
//  Created by Kavana Anand on 08/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import "HelloTriangles_macOSViewController.h"
#import <MetalKit/MetalKit.h>
#import "HelloTrianglesRenderer.h"

@implementation HelloTriangles_macOSViewController {
    MTKView *metalKitView;
    HelloTrianglesRenderer *renderer;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    metalKitView = [[MTKView alloc] initWithFrame:[self.view frame] device:MTLCreateSystemDefaultDevice()];
    self.view = metalKitView;
    
    if (metalKitView == nil) {
        NSLog(@"Metal is not supported in this device");
        return;
    }
    
    renderer = [[HelloTrianglesRenderer alloc]initWithMetalKitView:metalKitView];
    
    if(!renderer) {
        NSLog(@"Renderer failed initialization");
        return;
    }
    
    [renderer mtkView:metalKitView drawableSizeWillChange:metalKitView.drawableSize];

    metalKitView.delegate = renderer;
    metalKitView.preferredFramesPerSecond = 60;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
