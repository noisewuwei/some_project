//
//  RenderViewController.m
//  licode_demo
//
//  Created by zuler on 2023/4/3.
//

#import "RenderViewController.h"
#import "RenderViewController+Private.h"
#import <MetalKit/MetalKit.h>
#import "HobenShaderType.h"
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, HobenRenderingResizingMode) {
    HobenRenderingResizingModeScale = 0,
    HobenRenderingResizingModeAspect,
    HobenRenderingResizingModeAspectFill,
};

@interface RenderViewController ()<MTKViewDelegate>{
    int width;
    int height;
    bool canRender;
    
    int offsetx;
    int offsety;
    int renderWidth;
    int renderHeight;
    
    int touchOffsetX;
    int touchOffsetY;
    int touchWidth;
    int touchHeight;
    
    int originViewWidth;
    int originViewYHeight;
    
    int orientationStatus;
    
    int maxOffsetX;
    int minOffsetX;
    int maxOffsetY;
    int minOffsetY;
    
    int maxTouchOffsetX;
    int minTouchOffsetX;
    int maxTouchOffsetY;
    int minTouchOffsetY;
        
    bool canCallBackTouchEvent;
    
    bool isLockScreen;
    
    UIPinchGestureRecognizer *pinchGestureRecognizer_;
    UIPanGestureRecognizer *panGestureRecognizer_;
}

@property (nonatomic, strong) MTKView *mtkView;

@property (nonatomic, strong) id <MTLRenderPipelineState> pipelineState;

@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;

@property (nonatomic, strong) id <MTLBuffer> vertices;

@property (nonatomic, assign) NSUInteger numVertices;

@property (nonatomic, strong) id <MTLTexture> textureY;
@property (nonatomic, strong) id <MTLTexture> textureCbCr;
@property (nonatomic, strong) id <MTLTexture> textureU;
@property (nonatomic, strong) id <MTLTexture> textureV;

@property (nonatomic, strong) id <MTLTexture> texture;

@property (nonatomic, assign) vector_uint2 viewportSize;

@property (nonatomic, weak) id <MTLDevice> device;

@property (nonatomic, strong) id <MTLBuffer> convertMatrix;

@property (nonatomic,assign) CGFloat totalScale;
@property (nonatomic,assign) CGFloat totalTransX;
@property (nonatomic,assign) CGFloat totalTransY;

@property (nonatomic, assign) CVMetalTextureCacheRef textureCache;
 
@property (nonatomic, strong) id <MTLBuffer> desktopVertices;
@property (nonatomic, strong) id <MTLBuffer> desktopAlphaVertices;

@end

@implementation RenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pinchGestureRecognizer_ = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];

    panGestureRecognizer_ = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    
    originViewWidth = self.view.frame.size.width;
    originViewYHeight = self.view.frame.size.height;
    
    self.totalScale = 1.0;
    
    orientationStatus = 0;
    
    canRender = false;
    canCallBackTouchEvent = false;
    
    [self setupMTKView];
    
    [self setupCommandQueue];
        
    [self setupPineline];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationDischanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)orientationDischanged:(NSNotification *)notification{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        orientationStatus = 1;
        [self.mtkView setFrame:CGRectMake(0, 0, originViewYHeight, originViewWidth)];
    }else if(orientation == UIDeviceOrientationPortrait){
        orientationStatus = 0;
        [self.mtkView setFrame:CGRectMake(0, 0, originViewWidth, originViewYHeight)];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self callBackTouchEvent:event type:TouchType_Start];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self callBackTouchEvent:event type:TouchType_Move];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self callBackTouchEvent:event type:TouchType_End];
}

- (void)callBackTouchEvent:(UIEvent *)event type:(TouchType)type{
    for (int i=0; i<event.allTouches.count; i++){
        UITouch *touch = event.allTouches.allObjects[i];
        CGPoint point = [touch locationInView:self.view];
        int x = (int)point.x-touchOffsetX;
        int y = (int)point.y-touchOffsetY;
        float finalx = (float)x/(float)touchWidth;
        float finaly = (float)y/(float)touchHeight;
        int valid = (finalx <= 1 && finaly <= 1 && finalx > 0 && finaly > 0) ? 1 : 0;
        Touch_Info info;
        info.type = type;
        info.numtouches = 1;
        info.x = finalx;
        info.y = finaly;
        info.idx = i;
        info.force = 1*255;
        info.valid = valid;
        if (self.touchinfo_callback && canCallBackTouchEvent && isLockScreen) {
            self.touchinfo_callback(info);
        }
    }
}

- (void)setLockScreen:(bool)value{
    isLockScreen = value;
    if (!value) {
        [self.mtkView addGestureRecognizer:pinchGestureRecognizer_];
        [self.mtkView addGestureRecognizer:panGestureRecognizer_];
    }else{
        [self.mtkView removeGestureRecognizer:pinchGestureRecognizer_];
        [self.mtkView removeGestureRecognizer:panGestureRecognizer_];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}

- (void)addBufferData:(Byte*)data width:(int)w heigth:(int)h{
    
    [self setupMatrix:w height:h];
    
    width = w;
    height = h;
    canRender = true;
    canCallBackTouchEvent = true;
    
    int vWidth = self.viewportSize.x;
    int vHeight = self.viewportSize.y;
    int vfwidth = self.mtkView.frame.size.width;
    int vfheight = self.mtkView.frame.size.height;
    
    CGFloat scale = self.totalScale;
    CGFloat transX = self.totalTransX;
    CGFloat transY = self.totalTransY;
    
    if (orientationStatus == 0) {
        renderWidth = vWidth*scale;
        renderHeight = renderWidth/((CGFloat)w/(CGFloat)h);
        
        maxOffsetX = 0;
        minOffsetX = (signed)vWidth-(signed)renderWidth;
        
        maxOffsetY = (vHeight - (vWidth/((CGFloat)w/(CGFloat)h)))/2;
        minOffsetY = ((maxOffsetY + (vWidth/((CGFloat)w/(CGFloat)h))) - renderHeight);
        
        offsetx = (vWidth-renderWidth)/2+transX*3;
        if(offsetx >= maxOffsetX){
            offsetx = maxOffsetX;
        }else if(offsetx <= minOffsetX){
            offsetx = minOffsetX;
        }
        offsety = (vHeight-renderHeight)/2+transY*3;
        if (offsety >= maxOffsetY) {
            offsety = maxOffsetY;
        }else if(offsety <= minOffsetY){
            offsety = minOffsetY;
        }
        
        touchWidth = vfwidth*scale;
        touchHeight = touchWidth/((CGFloat)w/(CGFloat)h);
        
        maxTouchOffsetX = 0;
        minTouchOffsetX = (signed)vfwidth-(signed)touchWidth;
        
        maxTouchOffsetY = (vfheight - (vfwidth/((CGFloat)w/(CGFloat)h)))/2;
        minTouchOffsetY = ((maxTouchOffsetY + (vfwidth/((CGFloat)w/(CGFloat)h))) - touchHeight);
        
        touchOffsetX = (vfwidth-touchWidth)/2+transX;
        if (touchOffsetX >= maxTouchOffsetX) {
            touchOffsetX = maxTouchOffsetX;
        }else if(touchOffsetX <= minTouchOffsetX){
            touchOffsetX = minTouchOffsetX;
        }
        touchOffsetY = (vfheight-touchHeight)/2+transY;
        if (touchOffsetY >= maxTouchOffsetY) {
            touchOffsetY = maxTouchOffsetY;
        }else if(touchOffsetY <= minTouchOffsetY){
            touchOffsetY = minTouchOffsetY;
        }
    }else if (orientationStatus == 1){
        renderHeight = vHeight*scale;
        renderWidth = (renderHeight/((CGFloat)h/(CGFloat)w));
        
        maxOffsetX = (vWidth - (vHeight/((CGFloat)h/(CGFloat)w)))/2;
        minOffsetX = ((maxOffsetX + (vHeight/((CGFloat)h/(CGFloat)w))) - renderWidth);
        
        maxOffsetY = 0;
        minOffsetY = (signed)vHeight-(signed)renderHeight;
        
        offsetx = (vWidth-renderWidth)/2+transX*3;
        if(offsetx >= maxOffsetX){
            offsetx = maxOffsetX;
        }else if(offsetx <= minOffsetX){
            offsetx = minOffsetX;
        }
        offsety = (vHeight-renderHeight)/2+transY*3;
        if (offsety >= maxOffsetY) {
            offsety = maxOffsetY;
        }else if(offsety <= minOffsetY){
            offsety = minOffsetY;
        }
        
        touchHeight = vfheight*scale;
        touchWidth = touchHeight/((CGFloat)h/(CGFloat)w);
        
        maxTouchOffsetX = (vfwidth - (vfheight/((CGFloat)h/(CGFloat)w)))/2;
        minTouchOffsetX = ((maxTouchOffsetX + (vfheight/((CGFloat)h/(CGFloat)w))) - touchWidth);
        
        maxTouchOffsetY = 0;
        minTouchOffsetY = (signed)vfheight-(signed)touchHeight;
        
        touchOffsetX = (vfwidth-touchWidth)/2+transX;
        if (touchOffsetX >= maxTouchOffsetX) {
            touchOffsetX = maxTouchOffsetX;
        }else if(touchOffsetX <= minTouchOffsetX){
            touchOffsetX = minTouchOffsetX;
        }
        touchOffsetY = (vfheight-touchHeight)/2+transY;
        if (touchOffsetY >= maxTouchOffsetY) {
            touchOffsetY = maxTouchOffsetY;
        }else if(touchOffsetY <= minTouchOffsetY){
            touchOffsetY = minTouchOffsetY;
        }
    }
    
    CVPixelBufferRef pixel_buffer = reinterpret_cast<CVPixelBufferRef>(data);
    [self updateTexturesWithPixelBuffer:pixel_buffer];
//    {
//        MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
//        textureDescriptor.pixelFormat = MTLPixelFormatR8Unorm;
//        textureDescriptor.width = width;
//        textureDescriptor.height = height;
//        textureDescriptor.usage = MTLTextureUsageShaderRead | MTLTextureUsageShaderWrite | MTLTextureUsageRenderTarget;
//        self.textureY = [self.device newTextureWithDescriptor:textureDescriptor];
//        MTLRegion region = MTLRegionMake2D(0, 0, width, height);
//        if (data){
//            [self.textureY replaceRegion:region mipmapLevel:0 withBytes:data bytesPerRow:width];
//        }
//    }
//
//    {
//        MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
//        textureDescriptor.pixelFormat = MTLPixelFormatR8Unorm;
//        textureDescriptor.width = width/2;
//        textureDescriptor.height = height/2;
//        textureDescriptor.usage = MTLTextureUsageShaderRead | MTLTextureUsageShaderWrite | MTLTextureUsageRenderTarget;
//        self.textureU = [self.device newTextureWithDescriptor:textureDescriptor];
//        Byte* u = data+width*height;
//        MTLRegion region = MTLRegionMake2D(0, 0, width/2, height/2);
//        if(data){
//            [self.textureU replaceRegion:region mipmapLevel:0 withBytes:u bytesPerRow:width/2];
//        }
//    }
//
//    {
//        MTLTextureDescriptor *textureDescriptor = [[MTLTextureDescriptor alloc] init];
//        textureDescriptor.pixelFormat = MTLPixelFormatR8Unorm;
//        textureDescriptor.width = width/2;
//        textureDescriptor.height = height/2;
//        self.textureV = [self.device newTextureWithDescriptor:textureDescriptor];
//        Byte* v = data+width*height*5/4;
//        MTLRegion region = MTLRegionMake2D(0, 0, width/2, height/2);
//        if(data){
//            [self.textureV replaceRegion:region mipmapLevel:0 withBytes:v bytesPerRow:width/2];
//        }
//    }
}

- (void)updateTexturesWithPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    size_t widthY = CVPixelBufferGetWidthOfPlane(pixelBuffer, 0);
    size_t heightY = CVPixelBufferGetHeightOfPlane(pixelBuffer, 0);
    size_t widthCbCr = CVPixelBufferGetWidthOfPlane(pixelBuffer, 1);
    size_t heightCbCr = CVPixelBufferGetHeightOfPlane(pixelBuffer, 1);
    CVMetalTextureRef texture = NULL; // CoreVideo的Metal纹理
    id<MTLTexture> lumaTexture = nil;
    id<MTLTexture> chromaTexture = nil;

    // Create Y texture
    {
        MTLPixelFormat pixelFormat = MTLPixelFormatR8Unorm; // 这里的颜色格式不是RGBA
        CVReturn status = CVMetalTextureCacheCreateTextureFromImage(NULL, self.textureCache, pixelBuffer, NULL, pixelFormat, widthY, heightY, 0, &texture);
        if(status == kCVReturnSuccess)
        {
            lumaTexture = CVMetalTextureGetTexture(texture); // 转成Metal用的纹理
            CVBufferRelease(texture);
        }
    }

    // Create CbCr texture
    {
        MTLPixelFormat pixelFormat = MTLPixelFormatRG8Unorm; // 2-8bit的格式
        CVReturn status = CVMetalTextureCacheCreateTextureFromImage(NULL, self.textureCache, pixelBuffer, NULL, pixelFormat, widthCbCr, heightCbCr, 1, &texture);
        if(status == kCVReturnSuccess)
        {
            chromaTexture = CVMetalTextureGetTexture(texture); // 转成Metal用的纹理
            CVBufferRelease(texture);
        }
    }
    
    if (lumaTexture != nil && chromaTexture != nil) {
        self.textureY = lumaTexture;
        self.textureCbCr = chromaTexture;
    }
}

- (void)setupMTKView {
    // 初始化MTKView
    self.mtkView = [[MTKView alloc] init];
    self.mtkView.delegate = self;
    self.device = self.mtkView.device = MTLCreateSystemDefaultDevice();
    self.mtkView.frame = self.view.bounds;
    
    [self.view addSubview:self.mtkView];
    
    CVMetalTextureCacheCreate(NULL, NULL, self.device, NULL, &_textureCache);
}
// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if (!isLockScreen) {
        if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            self.totalScale *= pinchGestureRecognizer.scale;
            if (self.totalScale < 1){
                self.totalScale = 1;
                return;
            }
            pinchGestureRecognizer.scale = 1;
        }
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (!isLockScreen) {
        UIView *view = panGestureRecognizer.view;
        if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            CGPoint translation = [panGestureRecognizer translationInView:view.superview];
            if((offsetx == maxOffsetX && translation.x < 0) || (offsetx == minOffsetX && translation.x > 0) || (offsetx != maxOffsetX && offsetx != minOffsetX)){
                self.totalTransX += translation.x;
            }

            if ((offsety == maxOffsetY && translation.y < 0) || (offsety == minOffsetY && translation.y > 0) || (offsety != maxOffsetY && offsety != minOffsetY)) {
                self.totalTransY += translation.y;
            }
            [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        }
    }
}

- (void)setupPineline {
    // 初始化pipelineState
    NSError *error = nil;
    NSString * shaderSource = [self shaderSource];
    id<MTLLibrary> library = [_device newLibraryWithSource:shaderSource options:nil error:&error];
    if (library == nil) {
        NSLog(@"Error: failed to create Metal library: %@", error);
        return;
    }
    
    id<MTLFunction> vertexFunction = [library newFunctionWithName:@"vertexShader"];
    id<MTLFunction> fragmentFunction = [library newFunctionWithName:@"yuvfragmentShader"];

    MTLRenderPipelineDescriptor *pipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    pipelineDescriptor.label = @"MyPipeline";
    pipelineDescriptor.vertexFunction = vertexFunction;
    pipelineDescriptor.fragmentFunction = fragmentFunction;
    pipelineDescriptor.colorAttachments[0].pixelFormat = self.mtkView.colorPixelFormat;

    self.pipelineState = [self.device newRenderPipelineStateWithDescriptor:pipelineDescriptor error:&error];
    if (!self.pipelineState) {
        NSLog(@"Failed to create pipeline state: %@", error);
    }
}

//- (void)setupMatrix { // 设置好转换的矩阵
//    matrix_float3x3 kColorConversion601FullRangeMatrix = (matrix_float3x3){
//        (simd_float3){1.0,    1.0,    1.0},
//        (simd_float3){0.0,    -0.343, 1.765},
//        (simd_float3){1.4,    -0.711, 0.0},
//    };
//
//    vector_float3 kColorConversion601FullRangeOffset = (vector_float3){ -(16.0/255.0), -0.5, -0.5}; // 这个是偏移
//
//    LYConvertMatrix matrix;
//    // 设置参数
//    matrix.matrix = kColorConversion601FullRangeMatrix;
//    matrix.offset = kColorConversion601FullRangeOffset;
//
//    self.convertMatrix = [self.device newBufferWithBytes:&matrix
//                                                          length:sizeof(LYConvertMatrix)
//                                                         options:MTLResourceStorageModeShared];
//}

- (void)setupMatrix:(size_t)width_ height:(size_t)height_ { // 设置好转换的矩阵
    matrix_float3x3 kColorConversion601FullRangeMatrix = (matrix_float3x3){
        (simd_float3){1.164383f,    1.164383f,    1.164383f},
        (simd_float3){0.000000f,    -0.2133f,     2.1125f},
        (simd_float3){1.7969f,      -0.5342f,     0.00000f},
    };
    
    vector_float3 kColorConversion601FullRangeOffset = (vector_float3){ -(16.0/255.0), -0.501960f, -0.501960f}; // 这个是偏移
    
    LYConvertMatrix matrix;
    // 设置参数
    matrix.matrix = kColorConversion601FullRangeMatrix;
    matrix.offset = kColorConversion601FullRangeOffset;
    matrix.width = width_;
    matrix.height = height_;
    
    self.convertMatrix = [self.device newBufferWithBytes:&matrix
                                                          length:sizeof(LYConvertMatrix)
                                                         options:MTLResourceStorageModeShared];
}

- (void)setupCommandQueue {
    // 初始化commandQueue
    self.commandQueue = [_device newCommandQueue];
}

#pragma mark - MTKViewDelegate

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {
    // MTKView的大小改变
    self.viewportSize = (vector_uint2){size.width, size.height};
}

- (void)drawInMTKView:(MTKView *)view {
    if (!canRender){
        return;
    }
    // 用于向着色器传递数据
    id <MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    MTLRenderPassDescriptor *renderDesc = view.currentRenderPassDescriptor;
    if (!renderDesc) {
        [commandBuffer commit];
        return;
    }
//    renderDesc.colorAttachments[0].clearColor = MTLClearColorMake(0.5, 0.5, 0.5, 1);
    [self setupVertex:renderDesc];
    
    id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderDesc];
    [renderEncoder setViewport:(MTLViewport){offsetx,offsety,renderWidth,renderHeight, -1, 1}];
    // 映射.metal文件的方法
    [renderEncoder setRenderPipelineState:self.pipelineState];

    // 设置纹理数据
    [renderEncoder setFragmentTexture:self.textureY atIndex:0];
    [renderEncoder setFragmentTexture:self.textureCbCr atIndex:1];
//    [renderEncoder setFragmentTexture:self.textureV atIndex:2];
    [renderEncoder setFragmentBuffer:self.convertMatrix offset:0 atIndex:0];
    
//    [renderEncoder setVertexBuffer:self.vertices offset:0 atIndex:0]; //设置顶点数据
    [renderEncoder setVertexBuffer:self.desktopVertices offset:0 atIndex:0]; //设置顶点数据
    [renderEncoder setVertexBuffer:self.desktopAlphaVertices offset:0 atIndex:1]; //设置顶点数据
    [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:self.numVertices]; //开始绘制
    // 开始绘制
//    [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:4];
    // 结束渲染
    [renderEncoder endEncoding];
    // 提交
    [commandBuffer presentDrawable:view.currentDrawable];
    [commandBuffer commit];
}

- (void)setupVertex:(MTLRenderPassDescriptor *)renderPassDescriptor {
    
    if (self.desktopVertices) {
        return;
    }
    
    CGSize drawableSize = CGSizeMake(renderPassDescriptor.colorAttachments[0].texture.width, renderPassDescriptor.colorAttachments[0].texture.height);
    CGRect bounds = CGRectMake(0, 0, drawableSize.width, drawableSize.height);
    
    CGRect insetRect = AVMakeRectWithAspectRatioInsideRect(CGSizeMake(width, height), bounds);
    
    float widthScaling = 1.0;
    float heightScaling = 1.0;
    HobenRenderingResizingMode fillMode = HobenRenderingResizingModeScale;
    switch (fillMode) {
        case HobenRenderingResizingModeScale: {
            widthScaling = 1.0;
            heightScaling = 1.0;
        };
            break;
        case HobenRenderingResizingModeAspect:
        {
            widthScaling = insetRect.size.width / drawableSize.width;
            heightScaling = insetRect.size.height / drawableSize.height;
        };
            break;
        case HobenRenderingResizingModeAspectFill:
        {
            widthScaling = drawableSize.height / insetRect.size.height;
            heightScaling = drawableSize.width / insetRect.size.width;
        };
            break;
    }
    
    // 顶点顺序z字形，绘制出矩形
    HobenVertex vertices[] = {
        // 顶点坐标 x, y, z, w  --- 纹理坐标 x, y
        { {-widthScaling,  heightScaling, 0.0, 1.0}, {0.0, 0.0} },
        { { widthScaling,  heightScaling, 0.0, 1.0}, {1.0, 0.0} },
        { {-widthScaling, -heightScaling, 0.0, 1.0}, {0.0, 1.0} },
        { { widthScaling, -heightScaling, 0.0, 1.0}, {1.0, 1.0} },
    };
    
    self.desktopVertices = [self.device newBufferWithBytes:vertices length:sizeof(vertices) options:MTLResourceStorageModeShared];
    self.numVertices = sizeof(vertices) / sizeof(HobenVertex);
    
    HobenVertex alphaVertices[] = {
        // 顶点坐标 x, y, z, w  --- 纹理坐标 x, y
        { {-widthScaling,  heightScaling, 0.0, 1.0}, {0.0, 0.0} },
        { { widthScaling,  heightScaling, 0.0, 1.0}, {1, 0.0} },
        { {-widthScaling, -heightScaling, 0.0, 1.0}, {0.0, 1.0} },
        { { widthScaling, -heightScaling, 0.0, 1.0}, {1, 1.0} },
    };
    self.desktopAlphaVertices = [self.device newBufferWithBytes:alphaVertices length:sizeof(alphaVertices) options:MTLResourceStorageModeShared];
}


//- (void)setupVertex:(MTLRenderPassDescriptor *)renderPassDescriptor {
//
//    if (self.vertices) {
//        return;
//    }
//    float heightScaling = 1.0;
//    float widthScaling = 1.0;
//    CGSize drawableSize = CGSizeMake(renderPassDescriptor.colorAttachments[0].texture.width, renderPassDescriptor.colorAttachments[0].texture.height);
//    CGRect bounds = CGRectMake(0, 0, drawableSize.width, drawableSize.height);
//    CGRect insetRect = AVMakeRectWithAspectRatioInsideRect(CGSizeMake(width, height), bounds);
//
//    HobenRenderingResizingMode fillMode = HobenRenderingResizingModeScale;
//
//    switch (fillMode) {
//        case HobenRenderingResizingModeScale: {
//            widthScaling = 1.0;
//            heightScaling = 1.0;
//        };
//            break;
//        case HobenRenderingResizingModeAspect:
//        {
//            widthScaling = insetRect.size.width / drawableSize.width;
//            heightScaling = insetRect.size.height / drawableSize.height;
//        };
//            break;
//        case HobenRenderingResizingModeAspectFill:
//        {
//            widthScaling = drawableSize.height / insetRect.size.height;
//            heightScaling = drawableSize.width / insetRect.size.width;
//        };
//            break;
//    }
//
//    HobenVertex vertices[] = {
//        // 顶点坐标 x, y, z, w  --- 纹理坐标 x, y
//        { {-widthScaling,  heightScaling, 0.0, 1.0}, {0.0, 0.0} },
//        { { widthScaling,  heightScaling, 0.0, 1.0}, {1.0, 0.0} },
//        { {-widthScaling, -heightScaling, 0.0, 1.0}, {0.0, 1.0} },
//        { { widthScaling, -heightScaling, 0.0, 1.0}, {1.0, 1.0} },
//    };
//
//    self.vertices = [_device newBufferWithBytes:vertices length:sizeof(vertices) options:MTLResourceStorageModeShared];
//    self.numVertices = sizeof(vertices) / sizeof(HobenVertex);
//}

- (NSString *)shaderSource {
    NSString *shaderSource = @""
    "#include <metal_stdlib>\n"
    "#include <simd/simd.h>\n"
    "using namespace metal;\n"
    "// 顶点坐标（xzyw四维）、纹理坐标（xy两维）\n"
    "typedef struct {\n"
    "    vector_float4 position;\n"
    "    vector_float2 textureCoordinate;\n"
    "} MHobenVertex;\n"
    "\n"
    "typedef struct {\n"
    "    matrix_float3x3 matrix;\n"
    "    vector_float3 offset;\n"
    "    float width;\n"
    "    float height;\n"
    "} LYConvertMatrix;\n"
    "\n"
    "typedef struct {\n"
    "    float width;\n"
    "    float height;\n"
    "} MTextureSize;\n"
    "typedef struct {\n"
    "   float4 vertexPosition [[ position ]];   // 顶点坐标\n"
    "   float2 textureCoorRgb;                  // 取RGB值的纹理坐标\n"
    "   float2 textureCoorAlpha;                // 取Alpha值的纹理坐标\n"
    "} RasterizerData;\n"
    "\n"
    "// 顶点着色器 \n"
    "vertex RasterizerData vertexShader(uint vertexId [[ vertex_id ]],\n"
    "                                   constant MHobenVertex *rgbVertexArray [[ buffer(0) ]],\n"
    "                                   constant MHobenVertex *alphaVertexArray [[ buffer(1) ]]) {\n"
    "    RasterizerData out;\n"
    "    out.vertexPosition = rgbVertexArray[vertexId].position;\n"
    "    out.textureCoorRgb = rgbVertexArray[vertexId].textureCoordinate;\n"
    "    out.textureCoorAlpha = alphaVertexArray[vertexId].textureCoordinate;\n"
    "    return out;\n"
    "}\n"
    "// mouse片段着色器 \n"
    "fragment float4 fragmentShader(RasterizerData input [[ stage_in ]],\n"
    "                               texture2d <float> colorTexture [[ texture(0) ]]) {\n"
    "   constexpr sampler textureSampler (mag_filter::linear, min_filter::linear);\n"
    "   float3 rgbColorSample = colorTexture.sample(textureSampler, input.textureCoorRgb).rgb;\n"
    "   float alphaColorSample = colorTexture.sample(textureSampler, input.textureCoorAlpha).a;\n"
    "   return float4(rgbColorSample, alphaColorSample);\n"
    "}\n"
    "// rgb片段着色器 \n"
    "fragment float4 vfrgbfragmentShader(RasterizerData input [[ stage_in ]],\n"
    "                               constant MTextureSize *texture_size [[ buffer(0) ]],\n"
    "                               texture2d <float> colorTexture [[ texture(0) ]]) {\n"
    "   constexpr sampler textureSampler (mag_filter::linear, min_filter::linear);\n"
    "   float dy;\n"
    "   float dx;\n"
    "   float width = texture_size->width;\n"
    "   float height = texture_size->height;\n"
    "   dx = 1.0f / width *2.0;\n"
    "   dy = 1.0f / height *2.0;\n"
    "//  上  \n"
    "   float2 tc = input.textureCoorRgb + float2(0,-dy);\n"
    "   float3 color = colorTexture.sample(textureSampler,tc).rgb * 0.2f;\n"
    "//  下  \n"
    "   tc = input.textureCoorRgb + float2(0,dy);\n"
    "   color += colorTexture.sample(textureSampler,tc).rgb * 0.2f;\n"
    "//  左  \n"
    "   tc = input.textureCoorRgb + float2(-dx,0);\n"
    "   color += colorTexture.sample(textureSampler,tc).rgb * 0.2f;\n"
    "//  右 \n"
    "   tc = input.textureCoorRgb + float2(dx,0);\n"
    "   color += colorTexture.sample(textureSampler,tc).rgb * 0.2f;\n"
    "//  中  \n"
    "   tc = input.textureCoorRgb + float2(0,0);\n"
    "   float3 color_cur = colorTexture.sample(textureSampler,tc).rgb;\n"
    "   color += color_cur * 0.2f;\n"
    "   float3 rgbColorSample = color_cur.rgb + (color_cur - color) * 0.3f;\n"
    "   float alphaColorSample = colorTexture.sample(textureSampler, input.textureCoorAlpha).a;\n"
    "   return float4(rgbColorSample, alphaColorSample);\n"
    "}\n"
    "// yuv片段着色器 \n"
    "fragment float4 yuvfragmentShader(RasterizerData input [[ stage_in ]],\n"
    "                               texture2d <float> colorTextureY [[ texture(0) ]],\n"
    "                               texture2d <float> colorTextureU [[ texture(1) ]],\n"
    "                               texture2d <float> colorTextureV [[ texture(2) ]],\n"
    "                      constant LYConvertMatrix *convertMatrix [[ buffer(0) ]]) {\n"
    "   constexpr sampler textureSampler (mag_filter::linear, min_filter::linear);\n"
    "   float dy;\n"
    "   float dx;\n"
    "   float width = convertMatrix->width;\n"
    "   float height = convertMatrix->height;\n"
    "   dx = 1.0f / width *2.0;\n"
    "   dy = 1.0f / height *2.0;\n"
    "//  上  \n"
    "   float2 tc = input.textureCoorRgb + float2(0,-dy);\n"
     "   float color = colorTextureY.sample(textureSampler,tc).r * 0.2f;\n"
    "//  下  \n"
    "   tc = input.textureCoorRgb + float2(0,dy);\n"
    "   color += colorTextureY.sample(textureSampler,tc).r * 0.2f;\n"
    "//  左  \n"
    "   tc = input.textureCoorRgb + float2(-dx,0);\n"
    "   color += colorTextureY.sample(textureSampler,tc).r * 0.2f;\n"
    "//  右 \n"
    "   tc = input.textureCoorRgb + float2(dx,0);\n"
    "   color += colorTextureY.sample(textureSampler,tc).r * 0.2f;\n"
    "//  中  \n"
    "   tc = input.textureCoorRgb + float2(0,0);\n"
    "   float color_cur = colorTextureY.sample(textureSampler,tc).r;\n"
    "   color += color_cur * 0.2f;\n"
    "   float y = color_cur + (color_cur - color) * 0.5f;\n"
    "//  i420 sample  \n"
    //"   float u = colorTextureU.sample(textureSampler, input.textureCoorRgb).r;\n"
    //"   float v = colorTextureV.sample(textureSampler, input.textureCoorRgb).r;\n"
    //"   float3 yuv = float3(y,u,v);\n"
    "//  nv12 sample  \n"
    "   float2 uv = colorTextureU.sample(textureSampler, input.textureCoorRgb).rg;\n"
    "   float3 yuv = float3(y,uv);\n"
    "   float3 rgb = convertMatrix->matrix * (yuv + convertMatrix->offset);;\n"
    "   return float4(rgb, 1.0);\n"
    "}\n";
    return shaderSource;
}

//- (NSString *)shaderSource {
//    NSString *shaderSource = @""
//    "#include <metal_stdlib>\n"
//    "#include <simd/simd.h>\n"
//    "using namespace metal;\n"
//    "// 顶点坐标（xzyw四维）、纹理坐标（xy两维）\n"
//    "typedef struct {\n"
//    "    vector_float4 position;\n"
//    "    vector_float2 textureCoordinate;\n"
//    "} MHobenVertex;\n"
//    "\n"
//    "typedef struct {\n"
//    "   matrix_float3x3 matrix;\n"
//    "   vector_float3 offset;\n"
//    "} MLYConvertMatrix;\n"
//    "\n"
//    "typedef struct {\n"
//    "  float4 vertexPosition [[ position ]];\n"
//    "  float2 textureCoor;\n"
//    "} RasterizerData;\n"
//    "// 顶点着色器 \n"
//    "vertex RasterizerData vertexShader(uint vertexId [[ vertex_id ]],\n"
//    "                                   constant MHobenVertex *vertexArray [[ buffer(0) ]]) {\n"
//    "    RasterizerData out;\n"
//    "    out.vertexPosition = vertexArray[vertexId].position;\n"
//    "    out.textureCoor = vertexArray[vertexId].textureCoordinate;\n"
//    "    return out;\n"
//    "}\n"
//    "\n"
//    "// 片段着色器 \n"
//    "fragment float4 fragmentShader(RasterizerData input [[ stage_in ]],\n"
//    "                               texture2d <float> colorTexture [[ texture(0) ]]) {\n"
//    "   constexpr sampler textureSampler (mag_filter::linear, min_filter::linear);\n"
//    "   float4 colorSample = colorTexture.sample(textureSampler, input.textureCoor);\n"
//    "   return float4(colorSample);\n"
//    "}\n"
//    "\n"
//    "fragment float4 yuvfragmentShader(RasterizerData input [[ stage_in ]],\n"
//    "                          texture2d <float> colorTextureY [[ texture(0) ]],\n"
//    "                           texture2d <float> colorTextureU [[ texture(1) ]],\n"
//    "                           texture2d <float> colorTextureV [[ texture(2) ]],\n"
//    "                  constant MLYConvertMatrix *convertMatrix [[ buffer(0) ]]) {\n"
//    "  constexpr sampler textureSampler (mag_filter::linear, min_filter::linear);\n"
//    "  float y = colorTextureY.sample(textureSampler, input.textureCoor).r;\n"
//    "  float u = colorTextureU.sample(textureSampler, input.textureCoor).r;\n"
//    "  float v = colorTextureV.sample(textureSampler, input.textureCoor).r;\n"
//    "  float3 yuv = float3(y,u,v);\n"
//    "  float3 rgb = convertMatrix->matrix * (yuv + convertMatrix->offset);\n"
//    "  return float4(rgb, 1.0);\n"
//    "};\n";
//    return shaderSource;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
