//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Sep 17 2017 16:24:48).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <Foundation/Foundation.h>
//
//#import "NSCoding-Protocol.h"
//#import "NSCopying-Protocol.h"

//@class NSString;

@interface SCSearchStreamingEncryptionInfo : NSObject <NSCopying, NSCoding>
{
    NSString *_key;
    NSString *_iv;
}

@property(readonly, copy, nonatomic) NSString *iv; // @synthesize iv=_iv;
@property(readonly, copy, nonatomic) NSString *key; // @synthesize key=_key;
//- (void).cxx_destruct;
- (_Bool)isEqual:(id)arg1;
- (unsigned long long)hash;
- (void)encodeWithCoder:(id)arg1;
- (id)description;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (id)initWithKey:(id)arg1 iv:(id)arg2;
- (id)initWithCoder:(id)arg1;

@end

