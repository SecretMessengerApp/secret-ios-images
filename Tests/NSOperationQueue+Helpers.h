// 
// 


#import <Foundation/Foundation.h>

@interface NSOperationQueue (Helpers)

+ (instancetype)serialQueueWithName:(NSString *)name;
- (void)waitUntilAllOperationsAreFinishedWithTimeout:(NSTimeInterval)timeout;

@end
