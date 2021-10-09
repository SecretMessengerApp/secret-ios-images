// 
// 


@import Foundation;

#import <WireImages/ZMImageOwner.h>
#import <WireImages/ZMIImageProperties.h>

@class ZMImageLoadOperation;


typedef NS_ENUM (int16_t, ZMImageDownsampleType) {
    ZMImageDownsampleTypeInvalid,
    ZMImageDownsampleTypePreview,
    ZMImageDownsampleTypeMedium,
    ZMImageDownsampleTypeSmallProfile,
    ZMImageDownsampleTypeOriginal
};

@protocol ZMImageDownsampleOperationProtocol <NSObject>

@property (nonatomic, readonly, copy) NSData *downsampleImageData;
@property (nonatomic, readonly) ZMImageFormat format;
@property (nonatomic, readonly) ZMIImageProperties *properties;

@end


@interface ZMImageDownsampleOperation : NSOperation <ZMImageDownsampleOperationProtocol>

- (instancetype)initWithLoadOperation:(ZMImageLoadOperation *)loadOperation downsampleType:(ZMImageDownsampleType)downsampleType;
- (instancetype)initWithLoadOperation:(ZMImageLoadOperation *)loadOperation format:(ZMImageFormat)format;

+ (ZMImageDownsampleType)downsampleTypeForImageFormat:(ZMImageFormat)format;

@property (nonatomic, readonly, copy) NSData *downsampleImageData;
@property (nonatomic, readonly) ZMImageFormat format;
@property (nonatomic, readonly) ZMIImageProperties *properties;

@end
