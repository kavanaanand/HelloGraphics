//
//  main.m
//  HelloGraphics
//
//  Created by Kavana Anand on 03/04/2019.
//  Copyright © 2019 Kavana Anand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
#if TARGET_OS_SIMULATOR
#error No simulator support for Metal API.  Must build for a device
#endif
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
