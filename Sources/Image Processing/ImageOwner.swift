//
// 


import Foundation

///Implementation of ZMImageOwner protocol. Used to store and access processed image data.
public class ImageOwner: NSObject, ZMImageOwner {
    
    var previewData: Data? = nil
    var mediumData: Data? = nil
    var imageData: Data?
    
    public let imageSize: CGSize
    public let nonce: UUID
    
    public init(data: Data, size: CGSize, nonce: UUID) {
        self.imageData = data
        self.imageSize = size
        self.nonce = nonce
    }
    
    public func setImageData(_ imageData: Data, for format: ZMImageFormat, properties: ZMIImageProperties?) {
        switch format {
        case .preview:
            previewData = imageData
        case .medium:
            mediumData = imageData
        default: break
        }
    }
    
    public func imageData(for format: ZMImageFormat) -> Data? {
        switch format {
        case .preview: return previewData
        case .medium: return mediumData
        default: return nil
        }
    }
    
    public func requiredImageFormats() -> NSOrderedSet {
        return NSOrderedSet(objects: ZMImageFormat.preview.rawValue, ZMImageFormat.medium.rawValue)
    }
    
    public func originalImageData() -> Data? {
        return self.imageData
    }
    
    public func originalImageSize() -> CGSize {
        return self.imageSize
    }
    
    public func isInline(for format: ZMImageFormat) -> Bool {
        switch format {
        case .preview: return true
        default: return false
        }
    }
    
    public func isPublic(for format: ZMImageFormat) -> Bool {
        return false
    }
    
    public func isUsingNativePush(for format: ZMImageFormat) -> Bool {
        return false
    }
    
    public func processingDidFinish() {
        imageData = nil
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
        if let object = object as? ImageOwner {
            return object.nonce == self.nonce && object.imageSize.equalTo(self.imageSize)
        }
        else {
            return false;
        }
    }
    
    override public var hash: Int {
            return (nonce as NSUUID).hash ^ imageSize.width.hashValue ^ imageSize.height.hashValue
    }
    
}
