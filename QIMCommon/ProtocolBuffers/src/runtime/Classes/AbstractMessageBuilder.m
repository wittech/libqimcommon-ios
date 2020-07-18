// Protocol Buffers for Objective C
//
// Copyright 2010 Booyah Inc.
// Copyright 2008 Cyrus Najmabadi
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "AbstractMessageBuilder.h"

#import "CodedInputStream.h"
#import "ExtensionRegistry.h"
#import "MessageBuilder.h"
#import "UnknownFieldSet.h"
#import "UnknownFieldSetBuilder.h"


@implementation PBAbstractMessageBuilder2

- (id<PBMessageBuilder>) clone {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<PBMessageBuilder>) clear {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<PBMessageBuilder>) mergeFromCodedInputStream:(PBCodedInputStream2*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry2 emptyRegistry]];
}


- (id<PBMessageBuilder>) mergeFromCodedInputStream:(PBCodedInputStream2*) input
                                  extensionRegistry:(PBExtensionRegistry2*) extensionRegistry {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<PBMessageBuilder>) mergeUnknownFields:(PBUnknownFieldSet2*) unknownFields {
  PBUnknownFieldSet2* merged =
  [[[PBUnknownFieldSet2 builderWithUnknownFields:self.unknownFields]
    mergeUnknownFields:unknownFields] build];

  [self setUnknownFields:merged];
  return self;
}


- (id<PBMessageBuilder>) mergeFromData:(NSData*) data {
  PBCodedInputStream2* input = [PBCodedInputStream2 streamWithData:data];
  [self mergeFromCodedInputStream:input];
  [input checkLastTagWas:0];
  return self;
}


- (id<PBMessageBuilder>) mergeFromData:(NSData*) data
                      extensionRegistry:(PBExtensionRegistry2*) extensionRegistry {
  PBCodedInputStream2* input = [PBCodedInputStream2 streamWithData:data];
  [self mergeFromCodedInputStream:input extensionRegistry:extensionRegistry];
  [input checkLastTagWas:0];
  return self;
}


- (id<PBMessageBuilder>) mergeFromInputStream:(NSInputStream*) input {
  PBCodedInputStream2* codedInput = [PBCodedInputStream2 streamWithInputStream:input];
  [self mergeFromCodedInputStream:codedInput];
  [codedInput checkLastTagWas:0];
  return self;
}


- (id<PBMessageBuilder>) mergeFromInputStream:(NSInputStream*) input
                             extensionRegistry:(PBExtensionRegistry2*) extensionRegistry {
  PBCodedInputStream2* codedInput = [PBCodedInputStream2 streamWithInputStream:input];
  [self mergeFromCodedInputStream:codedInput extensionRegistry:extensionRegistry];
  [codedInput checkLastTagWas:0];
  return self;
}


- (id<PBMessage>) build {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<PBMessage>) buildPartial {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (BOOL) isInitialized {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (instancetype) defaultInstance {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (PBUnknownFieldSet2*) unknownFields {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<PBMessageBuilder>) setUnknownFields:(PBUnknownFieldSet2*) unknownFields {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}

@end
