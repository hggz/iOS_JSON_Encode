#import "JSON_Encode.h"
#import "Base64"

@implementation JSON_Encode

-(void)login{
    url=@"http://<location>";
    NSString *userName=@"<username>";
    NSString *password=@"<password>";
    
    /**
    @discussion Make an NSURL object out of your url string
     */
    NSURL *url = [NSURL URLWithString:url];
    
    /**
    @discussion Create an NSError object to serve as your json error
     */
    NSError *jsonError = nil;
    /**
    @discussion Create your login string in the format of basic web page authentication
     */
    NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@",userName,password];
    /**
    @discussion encode the login string using the Base64 format. In this case I use the Base64 encoder on my github
     */
    NSString *encodedLoginData= [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *authHeader = [@"Basic "stringByAppendingFormat:@"%@",encodedLoginData];
    /**
    @discussion create your URL request
     */
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:3];
    /**
    @discusison create json data to send
     */
    NSDictionary *user_info = [NSDictionary dictionaryWithObjectsAndKeys:@"<object>",@"key",@"<object2>",@"key", nil];
    /**
    @discussion Create an NSURLResponse object to retrieve server info
     */
    NSURLResponse *response;
    /**
    @discussion Parse json data using built in NSData objects to hold the data, and retrieve it in json format using NSJSONSerialization
     */
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user_info options:NSJSONWritingPrettyPrinted error:&jsonError];
    
    NSString *jsonString = [NSString stringWithCString:[jsonData bytes] length:[jsonData length]];
    NSLog(jsonString);
    
    /**
     @discussion Set up your URL request to use the base64 authentication and to act as json
     */
#pragma mark JSONRequest Parameters
    [request addValue:authHeader forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:jsonString forHTTPHeaderField:@"Query-string"];
    [request setHTTPBody:jsonData];
    
    /**
    @discussion Send the URL request in a background thread
     */
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
     {
         if ([data length] >0 && error == nil)
         {
             
             NSError *myError = nil;
             mData=data;

             /**
            @discussion the result string containing all your data returned from the server!
              */
             NSString *result = [NSString stringWithCString:[mData bytes] length:[mData length]];
             
             NSLog(result);
             
             /**
            @discussion Serialize the json data into your NSDictionary and obtain the objects from there!
              */
             jsonResponse = [NSJSONSerialization JSONObjectWithData:mData options:NSJSONReadingMutableLeaves error:&myError];
             
             
             
             
         }
         else if ([data length] == 0 && error == nil)
         {
             // Nothing was downloaded
             
             
         }
         else if (error != nil){
             // Specific Error occured
             
         }
         
     }];
}


@end
