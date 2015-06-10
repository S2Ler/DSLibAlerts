
@import Foundation;

@class DSMessage;

typedef NSString DSMessageCode;
typedef NSString DSMessageDomain;

BOOL DSMessageDomainsEqual(DSMessageDomain *__nullable domain1, DSMessageDomain *__nullable domain2);
BOOL DSMessageCodesEqual(DSMessageCode *__nullable code1, DSMessageCode *__nullable code2);

#define DSAlertsGeneralDomain @"DSAlertsGeneralDomain"
#define DSAlertsGeneralCode @"DSAlertsGeneralCode"

typedef void (^ds_completion_handler)(BOOL success, DSMessage *__nullable message);
typedef void (^ds_results_completion)(BOOL success, DSMessage *__nullable message, id __nullable result);

#define NO_RESULTS nil
#define NO_MESSAGE nil
#define FAILED_WITH_MESSAGE NO
#define SUCCEED_WITH_MESSAGE YES
