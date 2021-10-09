
import Foundation
import XCTest
import WireTesting
import ImageIO
@testable import WireImages

class NSDataMetadataTests: XCTestCase {
    func testThatItThrowsForEmptyData() {
        // GIVEN
        let data = Data()
        // WHEN
        var errorReceived: Error? = .none
        do {
            let _ = try data.wr_removingImageMetadata()
        }
        catch let error {
            errorReceived = error
        }
        
        // THEN
        XCTAssertEqual(errorReceived as! MetadataError, MetadataError.unknownFormat)
    }
    
    func testThatItThrowsForNonImageData() {
        // GIVEN
        let data = self.data(forResource:"Lorem Ipsum", extension:"txt")!
        // WHEN
        var errorReceived: Error? = .none
        do {
            let _ = try data.wr_removingImageMetadata()
        }
        catch let error {
            errorReceived = error
        }
        
        // THEN
        XCTAssertEqual(errorReceived as! MetadataError, MetadataError.unknownFormat)
    }
    
    func testThatItReadsMetadataForImageTypes() {
        // GIVEN
        [self.data(forResource:"ceiling_rotated_1", extension:"jpg")!,
        self.data(forResource:"unsplash_medium_exif_4", extension:"jpg")!,
        self.data(forResource:"ceiling_rotated_3", extension:"tiff")!].forEach { data in
            // WHEN
            let metadata = try! data.wr_metadata()
            
            // THEN
            XCTAssertNotNil(metadata[String(kCGImagePropertyTIFFDictionary)])
        }
    }

    func testThatGIFsAreExcludedFromMetadataRemoval() {
        let data = self.data(forResource:"unsplash_big_gif", extension:"gif")!

        let originalMetadata = try! data.wr_metadata()

        let converted = try! data.wr_removingImageMetadata()
        let convertedMetadata = try! converted.wr_metadata()

        XCTAssertEqual(originalMetadata as NSDictionary, convertedMetadata as NSDictionary)

        XCTAssertGreaterThanOrEqual(data.count, converted.count)
    }

    func testThatItPassThroughtImagesWithoutMetadataForImageTypes() {
        // GIVEN
        [self.data(forResource:"unsplash_big_gif", extension:"gif")!,
         self.data(forResource:"unsplash_owl_1_MB", extension:"png")!].forEach { data in
            // WHEN
            var originalMetadata = try! data.wr_metadata()
            originalMetadata[kCGImagePropertyProfileName as String] = nil
            let converted = try! data.wr_removingImageMetadata()
            var convertedMetadata = try! converted.wr_metadata()
            convertedMetadata[kCGImagePropertyProfileName as String] = nil
            
            // THEN
            XCTAssertEqual(originalMetadata as NSDictionary, convertedMetadata as NSDictionary)
        }
    }
    
    func testThatItRemovesLocationMetadataForImageTypes() {
        // GIVEN
        [self.data(forResource:"ceiling_rotated_1", extension:"jpg")!,
        self.data(forResource:"unsplash_medium_exif_4", extension:"jpg")!,
        self.data(forResource:"ceiling_rotated_2", extension:"png")!,
        self.data(forResource:"ceiling_rotated_3", extension:"tiff")!].forEach { data in
            // WHEN
            let metadata = try! data.wr_removingImageMetadata().wr_metadata()
            
            // THEN
            XCTAssertNil(metadata[String(kCGImagePropertyGPSDictionary)])
            if let TIFFData = metadata[String(kCGImagePropertyTIFFDictionary)] as? [String: Any] {
                XCTAssertNil(TIFFData["Latitude"])
            }
        }
    }
    
    // Other metadata:
    // - Camera manufacturer
    // - Creation date
    // - Aperture
    // - Etc.
    func testThatItRemovesOtherMetadataForImageTypes() {
        // GIVEN
        [self.data(forResource:"ceiling_rotated_1", extension:"jpg")!,
         self.data(forResource:"unsplash_medium_exif_4", extension:"jpg")!,
         self.data(forResource:"ceiling_rotated_2", extension:"png")!,
         self.data(forResource:"ceiling_rotated_3", extension:"tiff")!].forEach { data in
            // WHEN
            let metadata = try! data.wr_removingImageMetadata().wr_metadata()
            
            // THEN
            XCTAssertNil(metadata[String(kCGImagePropertyMakerAppleDictionary)])
            if let EXIFData = metadata[String(kCGImagePropertyExifDictionary)] as? [String: Any] {
                XCTAssertNil(EXIFData[String(kCGImagePropertyExifMakerNote)])
                XCTAssertNil(EXIFData[String(kCGImagePropertyExifDateTimeOriginal)])
                XCTAssertNil(EXIFData[String(kCGImagePropertyExifDateTimeDigitized)])
            }
            if let TIFFData = metadata[String(kCGImagePropertyTIFFDictionary)] as? [String: Any] {
                XCTAssertNil(TIFFData[String(kCGImagePropertyTIFFMake)])
                XCTAssertNil(TIFFData[String(kCGImagePropertyTIFFModel)])
                XCTAssertNil(TIFFData[String(kCGImagePropertyTIFFDateTime)])
            }
        }
    }
    
    func testThatItKeepsOrientationMetadataForImageTypes() {
        // GIVEN
        [//self.data(forResource:"ceiling_rotated_1", extension:"jpg")!,
         self.data(forResource:"unsplash_medium_exif_4", extension:"jpg")!].forEach { data in
            // WHEN
            let originalMetadata = try! data.wr_metadata()
            XCTAssertNotNil(originalMetadata[String(kCGImagePropertyOrientation)])
            
            let metadata = try! data.wr_removingImageMetadata().wr_metadata()
            
            // THEN
            XCTAssertNotNil(metadata[String(kCGImagePropertyOrientation)])
        }
    }
}
