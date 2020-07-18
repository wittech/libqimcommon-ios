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
#import <Foundation/Foundation.h>
@class PBCodedOutputStream2;
@class PBField2;
@class PBUnknownFieldSetBuilder2;

@interface PBUnknownFieldSet2 : NSObject {
@private
  NSDictionary* fields;
}

@property (readonly, strong) NSDictionary* fields;

+ (PBUnknownFieldSet2*) defaultInstance;

+ (PBUnknownFieldSet2*) setWithFields:(NSMutableDictionary*) fields;
+ (PBUnknownFieldSet2*) parseFromData:(NSData*) data;

+ (PBUnknownFieldSetBuilder2*) builder;
+ (PBUnknownFieldSetBuilder2*) builderWithUnknownFields:(PBUnknownFieldSet2*) other;

- (void) writeAsMessageSetTo:(PBCodedOutputStream2*) output;
- (void) writeToCodedOutputStream:(PBCodedOutputStream2*) output;
- (NSData*) data;

- (SInt32) serializedSize;
- (SInt32) serializedSizeAsMessageSet;

- (BOOL) hasField:(SInt32) number;
- (PBField2*) getField:(SInt32) number;

- (void) writeDescriptionTo:(NSMutableString*) output
                 withIndent:(NSString*) indent;

- (void) storeInDictionary: (NSMutableDictionary *) dic;

@end
