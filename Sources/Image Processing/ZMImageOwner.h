// 
// 


@import Foundation;
@import CoreGraphics;
#import "ZMIImageProperties.h"

typedef NS_ENUM(NSUInteger, ZMImageFormat) {
    ZMImageFormatInvalid = 0,
    ZMImageFormatPreview,
    ZMImageFormatMedium,
    ZMImageFormatOriginal,
    ZMImageFormatProfile
};

extern ZMImageFormat ImageFormatFromString(NSString * _Nonnull string);
extern NSString * _Nonnull StringFromImageFormat(ZMImageFormat format);


@protocol ZMImageOwner <NSObject>

/// The image formats that this @c ZMImageOwner wants preprocessed. Order of formats determines order in which data is preprocessed
- (nonnull NSOrderedSet *)requiredImageFormats;

- (nullable NSData *)originalImageData;

@end

