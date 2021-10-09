// 
// 


@import ImageIO;

#if TARGET_OS_IPHONE
@import MobileCoreServices;
#endif

@import WireImages;
@import WireTesting;



@interface ZMImageLoadOperationTests : ZMTBaseTest
@end



@implementation ZMImageLoadOperationTests

- (void)testThatItLoadsJPEGData;
{
    // given
    NSData *imageData = [self dataForResource:@"unsplash_medium_exif_2" extension:@"jpg"];
    ZMImageLoadOperation *sut = [[ZMImageLoadOperation alloc] initWithImageData:imageData];
    
    // when
    [sut start];
    XCTAssert([self waitOnMainLoopUntilBlock:^BOOL{
        return [sut isFinished];
    } timeout:1]);
    
    // then
    XCTAssertNotNil(sut);
    XCTAssertNotEqual(sut.CGImage, NULL);
    XCTAssertEqualObjects(sut.sourceImageProperties[(__bridge id) kCGImagePropertyTIFFDictionary][(__bridge id) kCGImagePropertyTIFFOrientation], @2);
    XCTAssertEqualObjects(sut.sourceImageProperties[(__bridge id) kCGImagePropertyOrientation], @2);
    XCTAssertEqualObjects(sut.sourceImageProperties[(__bridge id) kCGImagePropertyPixelHeight], @346);
    XCTAssertEqualObjects(sut.sourceImageProperties[(__bridge id) kCGImagePropertyPixelWidth], @531);
    AssertEqualData(sut.originalImageData, imageData);
    XCTAssertEqualObjects(sut.computedImageProperties.mimeType, (__bridge id)kUTTypeJPEG);
    XCTAssertEqual(sut.tiffOrientation, 2);
    AssertEqualSizes(sut.computedImageProperties.size, CGSizeMake(531, 346));
}

- (void)testThatItDoesNotLoadWhenCancelled
{
    // given
    NSData *imageData = [self dataForResource:@"unsplash_medium" extension:@"jpg"];
    XCTAssertNotNil(imageData);
    ZMImageLoadOperation *sut = [[ZMImageLoadOperation alloc] initWithImageData:imageData];
    [sut cancel];
    
    // when
    [sut start];
    XCTAssert([self waitOnMainLoopUntilBlock:^BOOL{
        return [sut isFinished];
    } timeout:1]);
    
    // then
    XCTAssertNotNil(sut);
    XCTAssertEqual(sut.CGImage, NULL);
    XCTAssertNil(sut.sourceImageProperties);
}

- (void)testThatItDoesNotCrashOnInvalidData
{
    // given
    NSData *imageData = [self dataForResource:@"Lorem Ipsum" extension:@"txt"];
    ZMImageLoadOperation *sut = [[ZMImageLoadOperation alloc] initWithImageData:imageData];
    
    // when
    [sut start];
    XCTAssert([self waitOnMainLoopUntilBlock:^BOOL{
        return [sut isFinished];
    } timeout:1]);
    
    // then
}

@end
