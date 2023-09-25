/// <summary>
/// Unknown TPP Shopify Permiss (ID 70000).
/// </summary>
permissionset 70000 "TPP Shopify Permiss"
{
    Assignable = true;
    Caption = 'Shopify Permiss', MaxLength = 30;
    Permissions =
        table "TPP Shopify Fulfillment Line" = X,
        tabledata "TPP Shopify Fulfillment Line" = RMID,
        table "TPP Shopify Fulfillment Header" = X,
        tabledata "TPP Shopify Fulfillment Header" = RMID,
        table "TPP Shopify Mapping Field Line" = X,
        tabledata "TPP Shopify Mapping Field Line" = RMID,
        table "TPP Shopify Refund Detail" = X,
        tabledata "TPP Shopify Refund Detail" = RMID,
        table "TPP Shopify Order Transaction" = X,
        tabledata "TPP Shopify Order Transaction" = RMID,
        table "TPP Shopify Order Line" = X,
        tabledata "TPP Shopify Order Line" = RMID,
        table "TPP Shopify Image" = X,
        tabledata "TPP Shopify Image" = RMID,
        table "TPP Shopify Options" = X,
        tabledata "TPP Shopify Options" = RMID,
        table "TPP Shopify Configuration" = X,
        tabledata "TPP Shopify Configuration" = RMID,
        table "TPP Shopify Variants" = X,
        tabledata "TPP Shopify Variants" = RMID,
        table "TPP Shopify Mapping Field Head" = X,
        tabledata "TPP Shopify Mapping Field Head" = RMID,
        table "TPP Shopify Product" = X,
        tabledata "TPP Shopify Product" = RMID,
        table "TPP Shopify Order" = X,
        tabledata "TPP Shopify Order" = RMID,
         table "TPP Shopify Pending RV" = X,
        tabledata "TPP Shopify Pending RV" = RMID,
        codeunit "TPP Shopify Function" = X,
        page "TPP Shopify Image Subform" = X,
        page "TPP Shopify Product Card" = X,
        page "TPP Shopify Product Lists" = X,
        page "TPP Shopify Fulfillment Card" = X,
        page "TPP Shopify Fulfillment Sub." = X,
        page "TPP Shopify Fulfillment Lists" = X,
        page "TPP Shopify Mapping Subform" = X,
        page "TPP Shopify Mapping Card" = X,
        page "TPP Shopify Mapping Lists" = X,
        page "TPP Shopify Control Field" = X,
        page "TPP Shopify Refund Detail List" = X,
        page "TPP Shopify Product Dialog" = X,
        page "TPP Shopify Get Orders Dialog" = X,
        page "TPP Shopify Order Transaction" = X,
        page "TPP Shopify Order Subform" = X,
        page "TPP Shopify Order Card" = X,
        page "TPP Shopify Options Sub." = X,
        page "TPP Shopify Variants Subform" = X,
        page "TPP Shopify Config. Setup" = X,
        page "TPP Shopify Order Lists" = X,
        page "TPP Shopify Role Activity" = X,
        page "TPP Shopify Role Center" = X,
        page "TPP Shopify Pending RV" = X,
        page "TPP Shopify Get Payment Dialog" = X;
}
