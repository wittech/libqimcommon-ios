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

#import "Field.h"

@class PBUnknownFieldSet2;

@interface PBMutableField2 : PBField2

+ (PBMutableField2 *)field;

- (PBMutableField2 *)mergeFromField:(PBField2 *)other;

- (PBMutableField2 *)clear;
- (PBMutableField2 *)addVarint:(SInt64)value;
- (PBMutableField2 *)addFixed32:(SInt32)value;
- (PBMutableField2 *)addFixed64:(SInt64)value;
- (PBMutableField2 *)addLengthDelimited:(NSData *)value;
- (PBMutableField2 *)addGroup:(PBUnknownFieldSet2 *)value;

@end
