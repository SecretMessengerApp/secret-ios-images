// 
// 


#import "ZMImageOwner.h"

ZMImageFormat ImageFormatFromString(NSString *string)
{
    if ([string isEqualToString:@"preview"]) {
        return ZMImageFormatPreview;
    }
    if ([string isEqualToString:@"medium"]) {
        return ZMImageFormatMedium;
    }
    if ([string isEqualToString:@"smallProfile"]) {
        return ZMImageFormatProfile;
    }
    if([string isEqualToString:@"original"]) {
        return ZMImageFormatOriginal;
    }
    return ZMImageFormatInvalid;
}

NSString * StringFromImageFormat(ZMImageFormat format)
{
    switch (format) {
        case ZMImageFormatProfile:
            return @"smallProfile";

        case ZMImageFormatMedium:
            return @"medium";

        case ZMImageFormatPreview:
            return @"preview";

        case ZMImageFormatInvalid:
            return @"invalid";
            
        case ZMImageFormatOriginal:
            return @"original";
    }
}
