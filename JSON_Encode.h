#import <Foundation/Foundation.h>

@interface JSON_Encode : NSObject{
    /**
    @discussion URL of your web location
     */
    NSString *url;
    /**
     @discussion Stream of data returned by the server
     */
    NSData *mData;
    /**
     @discussion Stream of data serialized in JSON format
     */
    NSDictionary *jsonResponse;

}

@end
