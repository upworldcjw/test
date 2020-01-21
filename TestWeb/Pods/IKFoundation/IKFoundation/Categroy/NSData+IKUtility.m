//
//  NSData+IKUtility.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "NSData+IKUtility.h"
#import <zlib.h>
#import <dlfcn.h>

#pragma clang diagnostic ignored "-Wcast-qual"

static const int kIKFoundationGodzippaChunkSize = 1024;
static const int kIKFoundationGodzippaDefaultMemoryLevel = 8;
static const int kIKFoundationGodzippaDefaultWindowBits = 15;
static const int kIKFoundationGodzippaDefaultWindowBitsWithGZipHeader = 16 + kIKFoundationGodzippaDefaultWindowBits;

NSString * const IKFoundationGodzippaZlibErrorDomain = @"com.godzippa.zlib.error";

@implementation NSData (IKUtility)

static void *libzOpen()
{
    static void *libz;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        libz = dlopen("/usr/lib/libz.dylib", RTLD_LAZY);
    });
    return libz;
}

- (void)ik_enumerateComponentsSeparatedBy:(NSData *)delimiter
                               usingBlock:(void (^)(NSData *omponent, BOOL flag))block {
    // current location in data
    NSUInteger location = 0;
    
    while (YES) {
        // get a new component separated by delimiter
        NSRange range = NSMakeRange(location, self.length - location);
        NSRange rangeOfDelimiter =
        [self rangeOfData:delimiter options:0 range:range];
        
        // has reached the last component
        if (rangeOfDelimiter.location == NSNotFound) {
            break;
        }
        
        NSRange rangeOfNewComponent = NSMakeRange(
                                                  location, rangeOfDelimiter.location - location + delimiter.length);
        // get the data of every component
        NSData *everyComponent = [self subdataWithRange:rangeOfNewComponent];
        // invoke the block
        if (block) {
            block(everyComponent, NO);
        }
        // make the offset of location
        location = NSMaxRange(rangeOfNewComponent);
    }
    
    // reminding data
    NSData *reminder =
    [self subdataWithRange:NSMakeRange(location, self.length - location)];
    // handle reminding data
    if (block) {
        block(reminder, YES);
    }
}

- (NSData *)ik_dataByGZipCompressingWithError:(NSError * __autoreleasing *)error {
    return [self ik_dataByGZipCompressingAtLevel:Z_DEFAULT_COMPRESSION windowSize:kIKFoundationGodzippaDefaultWindowBitsWithGZipHeader memoryLevel:kIKFoundationGodzippaDefaultMemoryLevel strategy:Z_DEFAULT_STRATEGY error:error];
}

- (NSData *)ik_dataByGZipCompressingAtLevel:(int)level
                                 windowSize:(int)windowBits
                                memoryLevel:(int)memLevel
                                   strategy:(int)strategy
                                      error:(NSError * __autoreleasing *)error
{
    if ([self length] == 0) {
        return self;
    }
    
    z_stream zStream;
    bzero(&zStream, sizeof(z_stream));
    
    zStream.zalloc = Z_NULL;
    zStream.zfree = Z_NULL;
    zStream.opaque = Z_NULL;
    zStream.next_in = (Bytef *)[self bytes];
    zStream.avail_in = (unsigned int)[self length];
    zStream.total_out = 0;
    
    OSStatus status;
    if ((status = deflateInit2(&zStream, level, Z_DEFLATED, windowBits, memLevel, strategy)) != Z_OK) {
        if (error) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Failed deflateInit", nil) forKey:NSLocalizedDescriptionKey];
            *error = [[NSError alloc] initWithDomain:IKFoundationGodzippaZlibErrorDomain code:status userInfo:userInfo];
        }
        
        return nil;
    }
    
    NSMutableData *compressedData = [NSMutableData dataWithLength:kIKFoundationGodzippaChunkSize];
    
    do {
        if ((status == Z_BUF_ERROR) || (zStream.total_out == [compressedData length])) {
            [compressedData increaseLengthBy:kIKFoundationGodzippaChunkSize];
        }
        
        zStream.next_out = (Bytef*)[compressedData mutableBytes] + zStream.total_out;
        zStream.avail_out = (unsigned int)([compressedData length] - zStream.total_out);
        
        status = deflate(&zStream, Z_FINISH);
    } while ((status == Z_OK) || (status == Z_BUF_ERROR));
    
    deflateEnd(&zStream);
    
    if ((status != Z_OK) && (status != Z_STREAM_END)) {
        if (error) {
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Error deflating payload", nil) forKey:NSLocalizedDescriptionKey];
            *error = [[NSError alloc] initWithDomain:IKFoundationGodzippaZlibErrorDomain code:status userInfo:userInfo];
        }
        
        return nil;
    }
    
    [compressedData setLength:zStream.total_out];
    
    return compressedData;
}

- (NSData *)ik_gunzippedData {
    if (self.length == 0 || ![self isGzippedData])
    {
        return self;
    }
    
    void *libz = libzOpen();
    int (*inflateInit2_)(z_streamp, int, const char *, int) =
    (int (*)(z_streamp, int, const char *, int))dlsym(libz, "inflateInit2_");
    int (*inflate)(z_streamp, int) = (int (*)(z_streamp, int))dlsym(libz, "inflate");
    int (*inflateEnd)(z_streamp) = (int (*)(z_streamp))dlsym(libz, "inflateEnd");
    
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.avail_in = (uint)self.length;
    stream.next_in = (Bytef *)self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;
    
    NSMutableData *output = nil;
    if (inflateInit2(&stream, 47) == Z_OK)
    {
        int status = Z_OK;
        output = [NSMutableData dataWithCapacity:self.length * 2];
        while (status == Z_OK)
        {
            if (stream.total_out >= output.length)
            {
                output.length += self.length / 2;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            status = inflate (&stream, Z_SYNC_FLUSH);
        }
        if (inflateEnd(&stream) == Z_OK)
        {
            if (status == Z_STREAM_END)
            {
                output.length = stream.total_out;
            }
        }
    }
    
    return output;
}

- (BOOL)isGzippedData
{
    const UInt8 *bytes = (const UInt8 *)self.bytes;
    return (self.length >= 2 && bytes[0] == 0x1f && bytes[1] == 0x8b);
}

@end
