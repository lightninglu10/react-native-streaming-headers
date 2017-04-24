#import "AudioStreamingHeaders.h"
#import <React/RCTLog.h>

@implementation AudioStreamingHeaders

RCT_EXPORT_MODULE()

// Set to main thread only
- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

// Initialize AudioStreamingHeaders
- (AudioStreamingHeaders *)init
{
   self = [super init];

   if (self) {
        self.audioStream = []
        [self.audioStream setDelegate:self];
        self.lastUrlString = @"";
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
      
        NSLog(@"AudioPlayer initialized");
   }
   
   return self;
}

-(void) tick:(NSTimer*)timer
{
   if (!self.audioStream) {
      return;
   }

   if (self.audioStream.url != nil && self.audioStream.state == kFsAudioStreamPlaying) {
        NSNumber *progress = [NSNumber numberWithFloat:self.audioStream.currentTimePlayed];
        NSNumber *duration = [NSNumber numberWithFloat:self.audioStream.duration];
        NSString *url = [NSString stringWithString:self.audioStream.url];
      
        [self.bridge.eventDispatcher sendDeviceEventWithName:@"AudioBridgeEvent" body:@{
                                                                                 @"status": @"STREAMING",
                                                                                 @"progress": progress,
                                                                                 @"duration": duration,
                                                                                 @"url": url,
                                                                                 }];
   }
}

- (void) dealloc
{
   [self unregisterAudioInterruptionNotifications];
   [self unregisterRemoteControlEvents];
   [self.audioStream setDelegate:nil];
}


-(void) configure:(NSString *)authToken
{
    if (self) {
        FSStreamConfiguration *config = [[FSStreamConfiguration alloc] init];
        config.predefinedHttpHeaderValues = @{@"Authorization" : @"Bearer " + @authToken}
        self.audioStream = [[FSAudioStream alloc] initWithConfiguration:config];
    }

    return self;
}

RCT_EXPORT_METHOD(play)
{

}

RCT_EXPORT_METHOD(playFromURL:(NSURL *)url)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}

RCT_EXPORT_METHOD(stop)
{

}

RCT_EXPORT_METHOD(pause)
{

}

@end