#import "FSAudioController.h"
#import "FSAudioStream.h"
#import <React/RCTBridgeModule.h>

@interface AudioStreamingHeaders : NSObject <RCTBridgeModule, FSAudioControllerDelegate, FSAudioStreamDelegate>

@property(nonatomic, strong) FSAudioStream *audioStream;
@property(nonatomic, readwrite) BOOL isPlaying;
@property (nonatomic, readwrite) BOOL showNowPlayingInfo;
@property (nonatomic, readwrite) NSString *lastUrlString;
@property (nonatomic, retain) NSString *currentSong;

- (void)play;
- (void)pause;
- (void)configure: (NSString *) authToken;

@end
