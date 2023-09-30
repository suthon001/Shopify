/// <summary>
/// Page TPP Shopify Add Fulfillment (ID 70033).
/// </summary>
page 70033 "TPP Shopify Add Fulfillment"
{
    Caption = 'Shopify Add Fulfillment';
    PageType = ConfirmationDialog;
    UsageCategory = None;
    Extensible = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field(OrderID; OrderID)
                {
                    ApplicationArea = all;
                    Caption = 'Order ID';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Order ID field.';
                }
                field(company; company)
                {
                    Caption = 'Company';
                    ToolTip = 'Specifies the value of the Company field.';
                    ApplicationArea = all;
                }
                field(number; number)
                {
                    Caption = 'Tracking Number';
                    ToolTip = 'Specifies the value of the trackinginfo field.';
                    ApplicationArea = all;

                }
                field(url; url)
                {
                    Caption = 'Url';
                    ToolTip = 'Specifies the value of the url field.';
                    ApplicationArea = all;

                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ShopifyFunction: Codeunit "TPP Shopify Function";
    begin
        if CloseAction In [Action::OK, Action::Yes] then begin
            CreateJsonText();
            ShopifyFunction.CreateFulfillment(JsonBody, OrderID);
        end;
    end;
    /// <summary>
    /// SetOrderID.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    procedure SetOrderID(pOrderID: code[50])
    begin
        OrderID := pOrderID;
    end;
    /// <summary>
    /// CreateJsonText.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure CreateJsonText()
    var
        ltJsonObject, ltJsonObjectBuild, ltJsonObjectBuild2 : JsonObject;
        ltJsonArray: JsonArray;
    begin
        JsonBody := '';
        ltJsonObject.Add('fulfillment_order_id', OrderID);
        ltJsonArray.Add(ltJsonObject);
        CLEAR(ltJsonObject);
        ltJsonObject.Add('company', format(company));
        ltJsonObject.Add('number', number);
        ltJsonObject.Add('url', url);
        ltJsonObjectBuild.Add('line_items_by_fulfillment_order', ltJsonArray);
        ltJsonObjectBuild.Add('tracking_info', ltJsonObject);
        ltJsonObjectBuild2.Add('fulfillment', ltJsonObjectBuild);
        ltJsonObjectBuild2.WriteTo(JsonBody);
        Message('%1', JsonBody);
    end;

    var
        JsonBody: Text;
        OrderID: code[50];
        number, url : Text;
        company: Enum "TPP Shopify Tracking Companies";
}
