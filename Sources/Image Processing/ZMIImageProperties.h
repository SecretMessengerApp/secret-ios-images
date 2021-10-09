// 
// 


@import CoreGraphics;
@import Foundation;

@interface ZMIImageProperties : NSObject

@property (nonatomic, readonly) CGSize size;
@property (nonatomic, readonly) NSUInteger length;
@property (nonatomic, readonly, copy) NSString *mimeType;

+ (instancetype)imagePropertiesWithSize:(CGSize)size length:(NSUInteger)length mimeType:(NSString *)type;

@end
