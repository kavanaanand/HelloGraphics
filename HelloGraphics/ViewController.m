//
//  ViewController.m
//  HelloGraphics
//
//  Created by Kavana Anand on 03/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import "ViewController.h"
#import "HelloGraphicsRenderer.h"
#import <MetalKit/MetalKit.h>

@interface ViewController ()

@end

@implementation ViewController {
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
