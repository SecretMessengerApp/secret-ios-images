// 
// 


#import "ZMIImageProperties.h"

@interface ZMIImageProperties ()

@property (nonatomic) CGSize size;
@property (nonatomic) NSUInteger length;
@property (nonatomic, copy) NSString *mimeType;

@end

@implementation ZMIImageProperties

+ (instancetype)imagePropertiesWithSize:(CGSize)size length:(NSUInteger)length mimeType:(NSString *)type
{
    ZMIImageProperties *properties = [[ZMIImageProperties alloc] init];
    properties.length = length;
    properties.size = size;
    properties.mimeType = type;
    return properties;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{ length: %lu, type: %@, size:(%f , %f)}", (unsigned long)self.length, self.mimeType, self.size.width, self.size.height];
}

@end
