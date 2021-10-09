// 
// 


@import CoreGraphics;
@import ImageIO;
@import WireSystem;

#import "ZMAssetMetaDataEncoder.h"
#import "ZMImageOwner.h"

#if TARGET_OS_IPHONE
@import MobileCoreServices;
#endif

@implementation ZMAssetMetaDataEncoder


+ (NSString *)contentTypeForImageData:(NSData *)imageData
{
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef) imageData, NULL);

    CFStringRef imageType = CGImageSourceGetType(imageSource);
    NSString *mediaType = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(imageType, kUTTagClassMIMEType));
    
    CFBridgingRelease(imageSource);
    
    return mediaType;
}

@end
