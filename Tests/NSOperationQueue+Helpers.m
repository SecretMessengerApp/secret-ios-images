// 
// 


@import WireTesting;
#import "NSOperationQueue+Helpers.h"

@implementation NSOperationQueue (Helpers)

+ (instancetype)serialQueueWithName:(NSString *)name;
{
    NSOperationQueue *queue = [[self alloc] init];
    queue.maxConcurrentOperationCount = 1;
    queue.name = name;
    return queue;
}

- (void)waitUntilAllOperationsAreFinishedWithTimeout:(NSTimeInterval)timeout;
{
    timeout = [ZMTBaseTest timeToUseForOriginalTime:timeout];
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self waitUntilAllOperationsAreFinished];
        dispatch_semaphore_signal(sem);
    });
    dispatch_time_t t = dispatch_walltime(DISPATCH_TIME_NOW, llround(timeout * NSEC_PER_SEC));
    if (dispatch_semaphore_wait(sem, t) != 0) {
        NSLog(@"Timed out while waiting for queue \"%@\". Call stack:\n%@",
              self.name, [NSThread callStackSymbols]);
        exit(-1);
    }
}

@end
