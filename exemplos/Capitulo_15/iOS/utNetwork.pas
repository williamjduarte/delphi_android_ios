unit utNetwork;

interface

uses
  Macapi.ObjectiveC, Macapi.CoreFoundation, Macapi.Dispatch,
  iOSApi.CocoaTypes, iOSApi.Foundation, Posix.SysSocket;


const
  libSystemConfiguration =
    '/System/Library/Frameworks/SystemConfiguration.framework/SystemConfiguration';
  kSCNetworkFlagsConnectionAutomatic = 8;
  kSCNetworkFlagsConnectionRequired = 4;
  kSCNetworkFlagsInterventionRequired = 16;
  kSCNetworkFlagsIsDirect = 131072;
  kSCNetworkFlagsIsLocalAddress = 65536;
  kSCNetworkFlagsReachable = 2;
  kSCNetworkFlagsTransientConnection = 1;
  kSCNetworkReachabilityFlagsConnectionAutomatic = 8;
  kSCNetworkReachabilityFlagsConnectionOnDemand = 32;
  kSCNetworkReachabilityFlagsConnectionOnTraffic = 8;
  kSCNetworkReachabilityFlagsConnectionRequired = 4;
  kSCNetworkReachabilityFlagsInterventionRequired = 16;
  kSCNetworkReachabilityFlagsIsDirect = 131072;
  kSCNetworkReachabilityFlagsIsLocalAddress = 65536;
  kSCNetworkReachabilityFlagsReachable = 2;
  kSCNetworkReachabilityFlagsTransientConnection = 1;
  kSCNetworkReachabilityFlagsIsWWAN = $40000;

Type
  SCNetworkReachabilityFlags = UInt32;
  SCNetworkReachabilityRef = ^__SCNetworkReachability;
  __SCNetworkReachability = record
  end;
  SCNetworkReachabilityContext = record
    version: CFIndex;
    info: Pointer;
    retain: function(info: Pointer): Pointer;
    release: procedure(info: Pointer);
    copyDescription: function(info: Pointer): CFStringRef;
  end;
  SCNetworkReachabilityContextPtr = ^SCNetworkReachabilityContext;
  SCNetworkReachabilityCallback = procedure(target: SCNetworkReachabilityRef;
    flags: SCNetworkReachabilityFlags; info: Pointer);
  TReachability = class;
  Reachability = interface(NSObject)
    ['{B405394F-57B1-4FF1-83D9-8FBFA38FFD7B}']
    function startNotifier: LongBool; cdecl;
    procedure stopNotifier; cdecl;
    function isReachable: LongBool; cdecl;
    function isReachableViaWWAN: LongBool; cdecl;
    function isReachableViaWiFi: LongBool; cdecl;
    function isConnectionRequired: LongBool; cdecl;
    function connectionRequired: LongBool; cdecl;
    function isConnectionOnDemand: LongBool; cdecl;
    function isInterventionRequired: LongBool; cdecl;
    function currentReachabilityStatus: NSInteger; cdecl;
    function reachabilityFlags: SCNetworkReachabilityFlags; cdecl;
    function currentReachabilityString: NSString; cdecl;
    function currentReachabilityFlags: NSString; cdecl;
  end;
  ReachabilityClass = interface(NSObjectClass)
    ['{39EC0490-2787-4BB9-95EA-77BB885BFD01}']
    function reachabilityWithHostname(hostname: NSString): Pointer; cdecl;
    function reachabilityForInternetConnection: Pointer; cdecl;
    function reachabilityWithAddress: Pointer; cdecl;
    function reachabilityForLocalWiFi: Pointer; cdecl;
  end;
  TReachability = class(TOCGenericImport<ReachabilityClass, Reachability>)
  end;
function SCNetworkReachabilityCreateWithAddress(allocator: CFAllocatorRef;
  address: psockaddr): SCNetworkReachabilityRef; cdecl;
  external libSystemConfiguration name _PU +
  'SCNetworkReachabilityCreateWithAddress';
function SCNetworkReachabilityCreateWithAddressPair(allocator: CFAllocatorRef;
  localAddress: psockaddr; remoteAddress: psockaddr): SCNetworkReachabilityRef;
  cdecl; external libSystemConfiguration name _PU +
  'SCNetworkReachabilityCreateWithAddressPair';
function SCNetworkReachabilityCreateWithName(allocator: CFAllocatorRef;
  nodename: PChar): SCNetworkReachabilityRef; cdecl;
  external libSystemConfiguration name _PU +
  'SCNetworkReachabilityCreateWithName';
function SCNetworkReachabilityGetTypeID: CFTypeID; cdecl;
  external libSystemConfiguration name _PU + 'SCNetworkReachabilityGetTypeID';
function SCNetworkReachabilityGetFlags(target: SCNetworkReachabilityRef;
  var flags: SCNetworkReachabilityFlags): Boolean; cdecl;
  external libSystemConfiguration name _PU + 'SCNetworkReachabilityGetFlags';
function SCNetworkReachabilitySetCallback(target: SCNetworkReachabilityRef;
  callout: SCNetworkReachabilityCallback;
  var context: SCNetworkReachabilityContext): Boolean; cdecl;
  external libSystemConfiguration name _PU + 'SCNetworkReachabilitySetCallback';
function SCNetworkReachabilityScheduleWithRunLoop
  (target: SCNetworkReachabilityRef; runLoop: CFRunLoopRef;
  runLoopMode: CFStringRef): Boolean; cdecl;
  external libSystemConfiguration name _PU +
  'SCNetworkReachabilityScheduleWithRunLoop';
function SCNetworkReachabilityUnscheduleFromRunLoop
  (target: SCNetworkReachabilityRef; runLoop: CFRunLoopRef;
  runLoopMode: CFStringRef): Boolean; cdecl;
  external libSystemConfiguration name _PU +
  'SCNetworkReachabilityUnscheduleFromRunLoop';
function SCNetworkReachabilitySetDispatchQueue(target: SCNetworkReachabilityRef;
  queue: dispatch_queue_t): Boolean; cdecl;
  external libSystemConfiguration name _PU +
  'SCNetworkReachabilitySetDispatchQueue';
{$IFDEF CPUARM}
function FakeLoader: Reachability; cdecl;
  external 'libReachability.a' name 'OBJC_CLASS_$_Reachability';
{$ENDIF}

type
  TMobileNetworkStatus = class(TObject)
  public
    constructor Create;
    destructor Destroy; override;
    function isConnected: Boolean;
    function IsWiFiConnected: Boolean;
    function IsMobileConnected: Boolean;
  end;

implementation

function GetInternetReachability: Reachability;
begin
  Result := TReachability.Wrap
    (TReachability.OCClass.reachabilityForInternetConnection);
end;

constructor TMobileNetworkStatus.Create;
begin
end;

destructor TMobileNetworkStatus.Destroy;
begin
  inherited;
end;

function TMobileNetworkStatus.isConnected: Boolean;
begin
  Result := GetInternetReachability.isReachable;
end;

function TMobileNetworkStatus.IsMobileConnected: Boolean;
begin
  Result := GetInternetReachability.isReachableViaWWAN;
end;

function TMobileNetworkStatus.IsWiFiConnected: Boolean;
begin
  Result := GetInternetReachability.isReachableViaWiFi;
end;
initialization
{$IFDEF IOS}
{$IFDEF CPUARM}
if False then
  FakeLoader;
{$ENDIF}
{$ENDIF}
end.
