//
//  ViewController.m
//  HelloGraphics macOS
//
//  Created by Kavana Anand on 4/3/19.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import "HelloGraphics_macOSViewController.h"
#import "HelloGraphicsRenderer.h"
#import <Metal/Metal.h>

@implementation HelloGraphics_macOSViewController {
    MTKView *metalKitView;
    HelloGraphicsRenderer *renderer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    metalKitView = [[MTKView alloc]initWithFrame:[self.view frame] device:MTLCreateSystemDefaultDevice()];
    self.view = metalKitView;
   
    if (!metalKitView.device) {
        NSLog(@"Metal is not supported in this device");
        return;
    }
    
    renderer = [[HelloGraphicsRenderer alloc]initWithMetalKitView:metalKitView];
    
    if(!renderer) {
        NSLog(@"Renderer failed initialization");
        return;
    }
    
    metalKitView.delegate = renderer;
    
    metalKitView.preferredFramesPerSecond = 60;
}

@end
