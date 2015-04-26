
@import Foundation;

@class DSMessage;

typedef NSString DSMessageCode;
typedef NSString DSMessageDomain;

BOOL DSMessageDomainsEqual(DSMessageDomain *domain1, DSMessageDomain *domain2);
BOOL DSMessageCodesEqual(DSMessageCode *code1, DSMessageCode *code2);

#define DSAlertsGeneralDomain @"DSAlertsGeneralDomain"
#define DSAlertsGeneralCode @"DSAlertsGeneralCode"

typedef void (^ds_completion_handler)(BOOL success, DSMessage *message);
typedef void (^ds_results_completion)(BOOL success, DSMessage *message, id result);

#define NO_RESULTS nil
#define NO_MESSAGE nil
#define FAILED_WITH_MESSAGE NO
#define SUCCEED_WITH_MESSAGE YES
