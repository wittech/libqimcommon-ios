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

#import "GeneratedMessageBuilder.h"

#import "GeneratedMessage.h"
#import "Message.h"
#import "MessageBuilder.h"
#import "UnknownFieldSet.h"
#import "UnknownFieldSetBuilder.h"


@interface PBGeneratedMessage2 ()
@property (strong) PBUnknownFieldSet2* unknownFields;
@end


@implementation PBGeneratedMessageBuilder

/**
 * Get the message being built.  We don't just pass this to the
 * constructor because it becomes null when build() is called.
 */
- (PBGeneratedMessage2*) internalGetResult {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (void) checkInitialized {
  PBGeneratedMessage2* result = self.internalGetResult;
  if (result != nil && !result.isInitialized) {
    @throw [NSException exceptionWithName:@"UninitializedMessage" reason:@"" userInfo:nil];
  }
}


- (PBUnknownFieldSet2*) unknownFields {
  return self.internalGetResult.unknownFields;
}


- (id<PBMessageBuilder>) setUnknownFields:(PBUnknownFieldSet2*) unknownFields {
  self.internalGetResult.unknownFields = unknownFields;
  return self;
}


- (id<PBMessageBuilder>) mergeUnknownFields:(PBUnknownFieldSet2*) unknownFields {
  PBGeneratedMessage2* result = self.internalGetResult;
  result.unknownFields =
  [[[PBUnknownFieldSet2 builderWithUnknownFields:result.unknownFields]
    mergeUnknownFields:unknownFields] build];
  return self;
}


- (BOOL) isInitialized {
  return self.internalGetResult.isInitialized;
}


/**
 * Called by subclasses to parse an unknown field.
 * @return {@code YES} unless the tag is an end-group tag.
 */
- (BOOL) parseUnknownField:(PBCodedInputStream2*) input
             unknownFields:(PBUnknownFieldSetBuilder2*) unknownFields
         extensionRegistry:(PBExtensionRegistry2*) extensionRegistry
                       tag:(SInt32) tag {
  return [unknownFields mergeFieldFrom:tag input:input];
}


- (void) checkInitializedParsed {
  PBGeneratedMessage2* result = self.internalGetResult;
  if (result != nil && !result.isInitialized) {
    @throw [NSException exceptionWithName:@"InvalidProtocolBuffer" reason:@"" userInfo:nil];
  }
}

@end
