/// <summary>
/// Page TPP Shopify Update Status Item (ID 70027).
/// </summary>
page 70027 "TPP Shopify Update Status Item"
{
    Caption = 'Shopify Update Status Item';
    PageType = StandardDialog;
    layout
    {
        area(content)
        {
            Group(General)
            {
                Caption = 'Status';
                field(gvProductID; gvProductID)
                {
                    Caption = 'Product ID';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the From Status field.';
                    Editable = false;
                }
                field(FromStatus; FromStatus)
                {
                    Caption = 'From Status';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the From Status field.';
                    Editable = false;
                }
                field(ToStatus; ToStatus)
                {
                    Caption = 'To Status';
                    OptionCaption = 'active,archived,draft';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ShopifyFunction: Codeunit "TPP Shopify Function";
    begin
        if CloseAction In [Action::OK, Action::Yes] then
            if format(ToStatus) <> FromStatus then
                ShopifyFunction.UpdateStatusProduct(gvProductID, format(ToStatus));

    end;
    /// <summary>
    /// SetFromStatus.
    /// </summary>
    /// <param name="pFromStat">Text.</param>
    /// <param name="pProductID">Code[50].</param>
    procedure SetFromStatus(pFromStat: Text; pProductID: Code[50])
    begin
        FromStatus := pFromStat;
        gvProductID := pProductID;
    end;

    var
        FromStatus: Text;
        gvProductID: code[50];
        ToStatus: Option "active","archived","draft";
}
