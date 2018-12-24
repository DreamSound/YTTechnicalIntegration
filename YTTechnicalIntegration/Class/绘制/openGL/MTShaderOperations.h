//
//  MTShaderOperations.h
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/3/20.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
@interface MTShaderOperations : NSObject

+ (GLuint)compileShaders:(NSString *)shaderVertex shaderFragment:(NSString *)shaderFragment;

@end
