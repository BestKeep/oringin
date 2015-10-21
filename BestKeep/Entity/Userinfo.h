//
//  Userinfo.h
//  MobileUU
//
//  Created by 王義傑 on 14-5-30.
//  Copyright (c) 2014年 Shanghai Pecker Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Userinfo : NSObject

+(void)setSelectRightMenu:(NSInteger)selected;

+(NSInteger)getSelectRightMenu;

+(void)setSelectMenu:(NSInteger)selected;

+(NSInteger)getSelectMenu;

+ (id) sharedInstance;

+(void)setCellPhone:(NSString *)cellPhone;

+(NSString *)getCellPhone;

+(void)setPWD:(NSString *)pwd;

+(NSString *)getPWD;

+(void)setLOGO:(NSString *)logo;

+(NSString *)getLOGO;

+(void)setIdentity:(NSString *)identity;//身份

+(NSString *)getIdentity;

+(void)setUserid:(NSString *)userid;

+(NSString *)getUserid;

+(void)setGold:(NSString *)usergold;

+(NSString *)getGold;

+(void)setCompanyname:(NSString *)companyname;

+(NSString *)getCompanyname;

+(void)setLoginSatuts:(NSString *)status;

+(NSString *)getLoginSatuts;

+(void)setProjectid:(NSString *)pid;

+(NSString *)getProjectid;

+(void)setMobileitem:(NSString*)mobileitem;

+(NSString *)getMobileitem;

+(void)setUserName:(NSString*)username;//昵称

+(NSString *)getUserName;

+(void)setUserqq:(NSString*)qq;

+(NSString *)getUserqq;

+(void)setUsersex:(NSString*)sex;

+(NSString*)getUsersex;

+(void)setUseremail:(NSString*)email;

+(NSString*)getUseremail;

+(void)setUseraddress:(NSString*)address;

+(NSString*)getUseraddress;

+(void)setUserjob:(NSString*)job;

+(NSString*)getUserjob;

+(void)setSubjection:(NSString*)subject;


+(NSString*)getLishu;

+(void)setUserDevicetoken:(NSString*)token;//令牌

+(NSString*)getUserDevicetoken;

+(void)setUserprovince:(NSString *)province;//省

+(NSString*)getsetUserprovince;

+(void)setUsercity:(NSString *)city;//市

+(NSString*)getsetUsercity;

+(void)setUsercounty:(NSString *)county;//乡镇

+(NSString*)getsetUsercounty;

+(void)setUseraddress1:(NSString *)address1;//街道

+(NSString*)getsetUseraddress1;

+(void)setUserCellPhoneVersionnum:(NSString *)versionnum;

+(NSString*)getUserCellPhoneVersionnum;

+(void)setUserCellPhonePlatform:(NSString *)platform;

+(NSString*)getUserCellPhonePlatform;

+(void)setUserCellPhoneUDID:(NSString *)udid;

+(NSString*)getUserCellPhoneUDID;

+(void)setPushnotifiaction:(NSString *)message;

+(NSString*)getPushnotifiaction;

+(void)setUserAlipayaccount:(NSString*)account;

+(NSString*)getUserAlipayaccount;

+(void)setUserAlipayname:(NSString*)name;

+(NSString*)getUserAlipayname;

+(void)setUserCautionmoney:(NSString*)money;

+(NSString*)getUserCautionmoney;

+(void)setUserStockgold:(NSString *)stockgold;

+(NSString*)getUserStockgold;

+(void)setUserWorkState:(NSString *)workstate;

+(NSString*)getUserWorkState;

+(void)setUserType:(NSString *)usertype;

+(NSString*)getUserType;

+(void)setUserTGT:(NSString *)tgt;

+(NSString*)getUserTGT;

+(void)setST:(NSString*)st;

+(NSString*)getST;

+(void)setUseridentifier:(NSArray*)infoidentiarray;//用户身份

+(NSArray*)getUseridentifier;

+(NSString*)getUserdoingMissionAmount;

+(void)setUserIMmessageAmount:(NSString*)amount;//im未读消息数量


+(void)setUserRealauth:(NSString*)auth;//是否通过实名认证

+(NSString*)getUserRealauth;


+(void)setUserInfoArray:(NSArray*)infoarray;

+(NSArray*)getUserInfoArray;


+(void)setUserHeadUrl:(NSString*)head;//用户头像URL

+(NSString *)getUserHeadUrl;


+(NSString *)getUserFinfishedMissionAmount;


+(void)setUserMob_bind:(NSString*)mobBind;//手机绑定

+(NSString *)getUserMob_bind;



+(void)setUserPay_bind:(NSString*)paybBind;//是否绑定支付宝

+(NSString *)getUserPay_bind;


+(void)setRed_count:(NSString*)redcount;//红包数量

+(NSString *)getRed_count;


+(void)setUserRed_money:(NSString*)redmoney;//红包金钱

+(NSString *)getRed_money;


+(void)setVisitor_code:(NSString*)visitor_code;//推广码

+(NSString *)getVisitor_code;

+(void)setStock_open:(NSString*)open;//推广码

+(NSString *)getStock_open;

+(void)setAuthName:(NSString *)Auth_Name;

+(NSString *)getAuth_Name;

+(void)setAuthIdNumber:(NSString *)Auth_IdNumber;


///////
+(void)setbacktag:(NSString*)str;
+(NSString*)getbacktag;





@end
