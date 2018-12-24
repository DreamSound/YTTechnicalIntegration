//
//  OpenGLView.m
//  YTTechnicalIntegration
//
//  Created by hiteam on 2018/2/27.
//  Copyright © 2018年 hiteam. All rights reserved.
//

#import "OpenGLView.h"
#import "MTShaderOperations.h"

@implementation OpenGLView{
    EAGLContext *_context;
    CAEAGLLayer *_EALayer;
    GLuint _colorBufferRender;
    GLuint _frameBuffer;
    GLuint _positionSlot;
    GLuint _textureSlot;
    GLuint _textureCoordsSlot;
    GLuint _textureID;
    CGRect _frameCAEAGLLayer;
    GLuint _program;
    GLuint _colorSlot;
    GLuint _projectionUniform;
}

typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

const Vertex Vertices[] = {
    {{0.5, -0.5, 0}, {1, 0, 0, 1}},
    {{0.5, 0.5, 0}, {0, 1, 0, 1}},
    {{-0.5, 0.5, 0}, {0, 0, 1, 1}},
    {{-0.5, -0.5, 0}, {0, 0, 0, 1}}
};

const GLubyte Indices[] = {
    0, 1, 2,
    2, 3, 0
};

+ (id)shareGlview{
    static OpenGLView *glview;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glview = [[OpenGLView alloc] init];
    });
    return glview;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupLayer];
        [self setupContext];
        [self setupVBOs];
        [self setBuffer];
        [self setShader];
        
        [self render];
    }
    return self;
}


+ (Class)layerClass{
    return [CAEAGLLayer class];
}

- (void)setupVBOs {
    
    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    GLuint indexBuffer;
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
}

- (void)setupLayer{
    _EALayer = (CAEAGLLayer*)self.layer;
    _EALayer.frame = self.frame;
    _EALayer.opaque = YES;
    _EALayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
}

- (void)setupContext{
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:_context];
}

- (void)setBuffer{
    glGenRenderbuffers(1, &_colorBufferRender);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorBufferRender);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_EALayer];
    
    glGenFramebuffers(1, &_frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER,
                              GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER,
                              _colorBufferRender);
}

- (void)setShader{
    
    _program = [MTShaderOperations compileShaders:@"Vertex"
                                   shaderFragment:@"Fragment"];
    glUseProgram(_program);
    _positionSlot = glGetAttribLocation(_program, "Position");
    
    //绑定着色器中的参数
    _colorSlot = glGetAttribLocation(_program, "SourceColor");
    _projectionUniform = glGetUniformLocation(_program, "Projection");
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);
}

- (void)render {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    // 1
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    
    // 2
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) *3));
    
    // 3
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}



@end
