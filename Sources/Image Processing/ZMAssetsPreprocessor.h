// 
// 


@import Foundation;

#import <WireImages/ZMImageOwner.h>
#import <WireImages/ZMImageDownsampleOperation.h>

@protocol ZMAssetsPreprocessorDelegate;


@protocol ZMAssetsPreprocessor <NSObject>

@property (nonatomic, weak, nullable) id<ZMAssetsPreprocessorDelegate> delegate;

- (NSArray<NSOperation *> * __nullable)operationsForPreprocessingImageOwner:(id<ZMImageOwner> __nonnull)imageOwner;

@end



@protocol ZMAssetsPreprocessorDelegate <NSObject>

- (void)completedDownsampleOperation:(id<ZMImageDownsampleOperationProtocol> __nonnull)operation
                          imageOwner:(id<ZMImageOwner> __nonnull)imageOwner;

- (void)failedPreprocessingImageOwner:(id<ZMImageOwner> __nonnull)imageOwner;
- (void)didCompleteProcessingImageOwner:(id<ZMImageOwner> __nonnull)imageOwner;

- (NSOperation * __nullable)preprocessingCompleteOperationForImageOwner:(id<ZMImageOwner> __nonnull)imageOwner;

@end



@interface ZMAssetsPreprocessor : NSObject <ZMAssetsPreprocessor>

- (nonnull instancetype)initWithDelegate:(id<ZMAssetsPreprocessorDelegate> __nullable)delegate;

@property (nonatomic, weak, nullable) id<ZMAssetsPreprocessorDelegate> delegate;

@end
