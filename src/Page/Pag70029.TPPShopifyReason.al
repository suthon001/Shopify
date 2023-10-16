/// <summary>
/// Page TPP Shopify Reason (ID 70029).
/// </summary>
page 70029 "TPP Shopify Reason"
{
    Caption = 'Shopify Reason';
    PageType = StandardDialog;
    Extensible = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(OrderID; OrderID)
                {
                    Caption = 'Order ID';
                    editable = false;
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Order ID field.';
                }
                field(ReasonCode; ReasonCode)
                {
                    Caption = 'Reason';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Reason field.';
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ShopifyOrder: Record "TPP Shopify Order";
        ShopifyFunction: Codeunit "TPP Shopify Function";
        ltJsonObject: JsonObject;
    begin
        if CloseAction In [Action::OK, Action::Yes] then begin
            ShopifyFunction.ConnectTOShopify('POST', 'orders/' + OrderID + '/cancel.json?reason=' + Format(ReasonCode), ltJsonObject);
            if ShopifyOrder.GET(OrderID) then begin
                ShopifyOrder."Cancelled Order" := true;
                ShopifyOrder.cancelled_at := CurrentDateTime();
                ShopifyOrder.cancel_reason := Format(ReasonCode);
                ShopifyOrder.status := 'cancelled';
                ShopifyOrder.Modify();
            end;
        end;

    end;
    /// <summary>
    /// SetProductID.
    /// </summary>
    /// <param name="pOderID">code[50].</param>
    procedure SetProductID(pOderID: code[50])
    begin
        OrderID := pOderID;
    end;

    var
        ReasonCode: Enum "TPP Shopify Reason";
        OrderID: Code[50];
}
