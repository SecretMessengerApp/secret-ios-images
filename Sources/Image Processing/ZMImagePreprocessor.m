// 
// 


@import CoreGraphics;
@import ImageIO;
@import WireSystem;

#import "ZMImagePreprocessor.h"



@interface ZMImagePreprocessor ()

@end



@implementation ZMImagePreprocessor

+ (NSOperationQueue *)createSuitableImagePreprocessingQueue
{
    NSOperationQueue *imageProcessingQueue = [[NSOperationQueue alloc] init];
    imageProcessingQueue.name = @"ZMAssetPreproccessing";
#if TARGET_OS_IPHONE
    imageProcessingQueue.maxConcurrentOperationCount = 1;
#else
    imageProcessingQueue.maxConcurrentOperationCount = 3;
#endif
    return imageProcessingQueue;
}

@end



@implementation ZMImagePreprocessor (ImageSize)

+ (CGSize)sizeOfPrerotatedImageAtURL:(NSURL *)fileURL;
{
    CGImageSourceRef source = CGImageSourceCreateWithURL((__bridge CFURLRef) fileURL, (__bridge CFDictionaryRef) @{});
    CGSize result = [self sizeOfPrerotatedImageWithImageSource:source];
    if (source != NULL) {
        CFRelease(source);
    }
    return result;
}


+ (CGSize)sizeOfPrerotatedImageWithData:(NSData *)data;
{
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef) data, (__bridge CFDictionaryRef) @{});
    CGSize result = [self sizeOfPrerotatedImageWithImageSource:source];
    if (source != NULL) {
        CFRelease(source);
    }
    return result;
}

+ (CGSize)sizeOfPrerotatedImageWithImageSource:(CGImageSourceRef)source;
{
    CGSize result = CGSizeZero;

    if (source != NULL) {
        NSDictionary *properties = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, 0, NULL));
        result = [self imageSizeFromProperties:properties];
    }
    return result;
}

+ (CGSize)imageSizeFromProperties:(NSDictionary *)properties
{
    CGSize result = CGSizeZero;
    NSNumber *width = properties[(__bridge id) kCGImagePropertyPixelWidth];
    NSNumber *height = properties[(__bridge id) kCGImagePropertyPixelHeight];
    if (width != NULL) {
            result.width = width.intValue;
        }

    if (height != NULL) {
            result.height = height.intValue;
        }

    NSNumber *orientation = properties[(__bridge id) kCGImagePropertyOrientation];
    if (orientation != nil) {
        int const tiffOrientation = orientation.intValue;
        switch (tiffOrientation) {
            case 6:
            case 8:
            case 5:
            case 7:
                result = CGSizeMake(result.height, result.width);
                break;
            default:
                break;
        }
    }
    
    return result;
}

@end
