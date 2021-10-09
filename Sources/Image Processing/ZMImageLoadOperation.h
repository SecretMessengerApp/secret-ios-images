// 
// 


@import Foundation;
@import CoreGraphics;

#import <WireImages/ZMIImageProperties.h>

@interface ZMImageLoadOperation : NSOperation

- (instancetype)initWithImageData:(NSData *)imageData;
- (instancetype)initWithImageFileURL:(NSURL *)fileURL;

@property (nonatomic, readonly) CGImageRef CGImage;
@property (nonatomic, readonly, copy) NSDictionary *sourceImageProperties;

@property (nonatomic, readonly) int tiffOrientation;
@property (nonatomic, readonly) ZMIImageProperties *computedImageProperties;
@property (nonatomic, readonly, copy) NSData *originalImageData;

@property (nonatomic, readonly, copy) NSString *inputDescription;

@end
