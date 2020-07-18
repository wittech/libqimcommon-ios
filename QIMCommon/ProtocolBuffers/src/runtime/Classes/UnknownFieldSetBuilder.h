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

#import "MessageBuilder.h"

@class PBField2;
@class PBMutableField2;

@interface PBUnknownFieldSetBuilder2 : NSObject <PBMessageBuilder> {
@private
  NSMutableDictionary* fields;

  // Optimization:  We keep around a builder for the last field that was
  //   modified so that we can efficiently add to it multiple times in a
  //   row (important when parsing an unknown repeated field).
  SInt32 lastFieldNumber;

  PBMutableField2* lastField;
}

+ (PBUnknownFieldSetBuilder2*) createBuilder:(PBUnknownFieldSet2*) unknownFields;

- (PBUnknownFieldSet2*) build;
- (PBUnknownFieldSetBuilder2*) mergeUnknownFields:(PBUnknownFieldSet2*) other;

- (PBUnknownFieldSetBuilder2*) mergeFromCodedInputStream:(PBCodedInputStream2*) input;
- (PBUnknownFieldSetBuilder2*) mergeFromData:(NSData*) data;
- (PBUnknownFieldSetBuilder2*) mergeFromInputStream:(NSInputStream*) input;

- (PBUnknownFieldSetBuilder2*) mergeVarintField:(SInt32) number value:(SInt32) value;

- (BOOL) mergeFieldFrom:(SInt32) tag input:(PBCodedInputStream2*) input;

- (PBUnknownFieldSetBuilder2*) addField:(PBField2*) field forNumber:(SInt32) number;

- (PBUnknownFieldSetBuilder2*) clear;
- (PBUnknownFieldSetBuilder2*) mergeField:(PBField2*) field forNumber:(SInt32) number;

@end
