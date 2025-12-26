@AbapCatalog.sqlViewName: 'ZGEPOHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Pass - Puchase Order Header'
define view ZGE_PO_HEAD as select distinct from I_PurchaseOrderAPI01 as POHEAD
 association [0..1] to ZGE_SUPPLIER as ZSUP                 on POHEAD.Supplier = ZSUP.Supplier
 association [0..1] to ZGE_CUSTOMER as ZCUST                on POHEAD.Customer = ZCUST.Customer
 association [0..1] to I_PurchaseOrderItemAPI01       as IPL      on  POHEAD.PurchaseOrder = IPL.PurchaseOrder
association [0..1] to I_PurchaseOrderAPI01       as rl      on  POHEAD.PurchaseOrder = rl.PurchaseOrder
{
    
    key POHEAD.PurchaseOrder ,
        POHEAD.PurchaseOrderType, 
        POHEAD.PurchaseOrderDate,
        POHEAD.Supplier,
        POHEAD.Customer,
        POHEAD.CreationDate,
        POHEAD.CreatedByUser,
        POHEAD.LastChangeDateTime,
        POHEAD.Language,
        ZSUP.SupplierName,
        ZSUP.SupplierAccountGroup,
        ZCUST.CustomerName,
        ZCUST.CustomerAccountGroup,
        IPL.IsCompletelyDelivered ,
        rl.ReleaseIsNotCompleted
        
}

where IPL.IsCompletelyDelivered = ' '
      and rl.ReleaseIsNotCompleted = ' ' 
