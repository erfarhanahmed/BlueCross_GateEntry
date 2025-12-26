@AbapCatalog.sqlViewName: 'ZGEPOITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Pass - Purchase Order Item'
define view ZGE_PO_ITEM as select distinct from  I_PurchaseOrderItemAPI01 as POITEM

association [0..1] to ZGE_PRODUCT as ZPRD on POITEM.Material = ZPRD.Product

association [0..1] to ZGE_PLANT as ZPL on POITEM.Plant = ZPL.Plant

 association [0..1] to ZGE_PO_ITEM_SUM as TotalQty on  POITEM.PurchaseOrder     = TotalQty.PurchaseOrder
                                                    and POITEM.PurchaseOrderItem = TotalQty.PurchaseOrderItem


{
  key POITEM.PurchaseOrder                                                                                                                             as PurchaseOrder,
  key POITEM.PurchaseOrderItem                                                                                                                         as PurchaseOrderItem,
      POITEM.PurchaseOrderCategory                                                                                                                     as PurchaseOrderCategory,
      POITEM.PurchaseOrderItemText                                                                                                                     as PurchaseOrderItemText,
      POITEM.NetPriceQuantity                                                                                                                          as NetPriceQuantity,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      POITEM.OrderQuantity                                                                                                                              as OrderQuantity,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      POITEM.NetPriceAmount                                                                                                                             as NetPriceAmount,
      POITEM.DocumentCurrency                                                                                                                           as DocumentCurrency,
      POITEM.BaseUnit                                                                                                                                   as BaseUnit,
      POITEM.Plant,
      ZPL.PlantName,
      POITEM.PurchaseOrderQuantityUnit,
      POITEM.Material                                                                                                                                   as Material,
      ZPRD.ProductName                                                                                                                                  as ProductName,
      //ZPRD.ConsumptionTaxCtrlCode                                                                                                                      as ConsumptionTaxCtrlCode,
      POITEM.MaterialType                                                                                                                              as MaterialType,
      POITEM.MaterialGroup                                                                                                                             as MaterialGroup,
      POITEM.StorageLocation                                                                                                                           as StorageLocation,
      POITEM.PurchasingDocumentDeletionCode                                                                                                            as PurchasingDocumentDeletionCode,
      POITEM.IsCompletelyDelivered                                                                                                                     as IsCompletelyDelivered,
       case 
        when TotalQty.TotalQuantity is null or TotalQty.TotalQuantity = 0.000 
          then POITEM.OrderQuantity
        else POITEM.OrderQuantity - TotalQty.TotalQuantity
      end                                         as GRNPendingQTY,

      coalesce(TotalQty.TotalQuantity, 0)         as GRNReceivedQTY,
                                                                                                                         
      POITEM.OverdelivTolrtdLmtRatioInPct                                                                                                              as TollerencePercentage,
      // POITEM.OrderQuantity (POITEM.OverdelivTolrtdLmtRatioInPct * 0.01 )  as ToleranceQuantity
    //(cast(POITEM.OverdelivTolrtdLmtRatioInPct as abap.fltp) * cast(POITEM.OverdelivTolrtdLmtRatioInPct as abap.fltp)) / cast(100 as abap.fltp) as ToleranceQuantity
     //POITEM.OrderQuantity * POITEM.OverdelivTolrtdLmtRatioInPct as ToleranceQuantity
     
     POITEM.OrderQuantity * POITEM.OverdelivTolrtdLmtRatioInPct  as ToleranceQuantity
     //POITEM.NetPriceAmount / POITEM.NetPriceQuantity  as GRValue
      //get_numeric_value(POITEM.NetPriceAmount) / get_numeric_value( POITEM.NetPriceQuantity ) as number_of_bookings  

}

where POITEM.IsCompletelyDelivered = '' and POITEM.PurchasingDocumentDeletionCode = ''
