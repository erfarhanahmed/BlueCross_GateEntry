@AbapCatalog.sqlViewName: 'ZGECOMPANYADDSRB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Pass for Company address'
@OData.publish: true
@OData.entitySet.name: 'ZGE_COMPANY_ADD_SRB1'
@OData.entityType.name: 'ZGE_COMPANY_ADD_SRB1'
define view ZGE_COMPANY_ADD_SRB as select from I_CompanyCode
{
    key CompanyCode,
    CompanyCodeName as CompanyName,
    Company   
}
