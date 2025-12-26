@AbapCatalog.sqlViewName: 'ZGEPOITEMSUM'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For GRN POST QTY Calculation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{    
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


define view ZGE_PO_ITEM_SUM as select from I_PurchaseOrderHistoryAPI01 as ZPOGRP
{
    key ZPOGRP.PurchaseOrder,
    key ZPOGRP.PurchaseOrderItem,
    sum(
        case 
            when ZPOGRP.DebitCreditCode = 'S' then ZPOGRP.Quantity
            when ZPOGRP.DebitCreditCode = 'H' then -ZPOGRP.Quantity
            else 0
        end
    ) as TotalQuantity
}
where ZPOGRP.PurchasingHistoryCategory = 'E'
group by ZPOGRP.PurchaseOrder, ZPOGRP.PurchaseOrderItem
