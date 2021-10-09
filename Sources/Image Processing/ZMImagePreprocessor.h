// 
// 


@import Foundation;
@import CoreGraphics;

@interface ZMImagePreprocessor : NSObject

+ (NSOperationQueue *)createSuitableImagePreprocessingQueue;

@end

@interface ZMImagePreprocessor (ImageSize)

+ (CGSize)sizeOfPrerotatedImageAtURL:(NSURL *)fileURL;
+ (CGSize)sizeOfPrerotatedImageWithData:(NSData *)data;
+ (CGSize)imageSizeFromProperties:(NSDictionary *)properties;

@end
