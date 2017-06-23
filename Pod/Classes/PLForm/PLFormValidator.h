
// PLFormValidator is heavily based on PLFormValidator but integrated into PLForm rather than
// using the original method of subclassing UITextFIeld
// so most of the basic conditions and validators are lifted straight out of US2FormValidator

// copywrite from original US2 form validator

//  Copyright (C) 2012 ustwo™
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//


// Conditions
#import "PLCondition.h"
#import "PLConditionAlphabetic.h"
#import "PLConditionAlphanumeric.h"
#import "PLConditionCollection.h"
#import "PLConditionEmail.h"
#import "PLConditionNumeric.h"
#import "PLConditionRange.h"
#import "PLConditionPresent.h"
#import "PLConditionOr.h"
#import "PLConditionAnd.h"
#import "PLConditionNot.h"
#import "PLConditionMatchElement.h"
#import "PLConditionAccept.h"
#import "PLConditionPhoneNumber.h"


// Validators
#import "PLValidator.h"
#import "PLValidatorAlphabetic.h"
#import "PLValidatorAlphanumeric.h"
#import "PLValidatorEmail.h"
#import "PLValidatorNumeric.h"
#import "PLValidatorRange.h"
#import "PLValidatorComposite.h"
#import "PLValidatorPresent.h"
#import "PLValidatorMatchElement.h"
#import "PLValidatorAccept.h"
#import "PLValidatorPhoneNumber.h"
