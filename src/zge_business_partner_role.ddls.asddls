@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGE_BUSINESS_PARTNER_ROLE as select from agr_users
{
key agr_name as AgrName,
key uname as UserID,
key from_dat as FromDat,
key to_dat as ToDat,
exclude as Exclude,
change_dat as ChangeDat,
change_tim as ChangeTim,
change_tst as ChangeTst,
org_flag as OrgFlag,
col_flag as ColFlag   
}
 
where agr_name ='ZBR_RL'
