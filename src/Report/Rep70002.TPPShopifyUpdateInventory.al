/// <summary>
/// Report TPP Shopify Update Inventory (ID 70002).
/// </summary>
report 70002 "TPP Shopify Update Inventory"
{
    Caption = 'Shopify Update Inventory';
    UsageCategory = None;
    ProcessingOnly = true;
    Extensible = false;
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Options';
                    field(gvItemName; ItemName)
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Caption = 'Name';
                        ToolTip = 'Specifies the value of the Item Name field.';
                    }
                    field(gvOldInventory; OldInventory)
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Caption = 'Current Inventory';
                        ToolTip = 'Specifies the value of the Current Inventory field.';
                    }
                    field(gvNewInventory; NewInventory)
                    {
                        ApplicationArea = all;
                        Caption = 'New Inventory';
                        ToolTip = 'Specifies the value of the New Inventory field.';
                    }
                }
            }
        }

    }
    trigger OnPreReport()
    var
        ShopifyFunction: Codeunit "TPP Shopify Function";
        ltJsonObject: JsonObject;
        ltJsonBody: Text;
    begin
        if OldInventory <> NewInventory then begin
            CLEAR(ltJsonObject);
            ltJsonBody := '';
            ltJsonObject.Add('location_id', LocationID);
            ltJsonObject.Add('inventory_item_id', InventItemID);
            ltJsonObject.Add('available', NewInventory);
            ltJsonObject.WriteTo(ltJsonBody);
            ShopifyFunction.SetInventory(ltJsonBody, ProductID);
        end;
    end;
    /// <summary>
    /// GetInventory.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetInventory(): Integer
    begin
        exit(NewInventory);
    end;
    /// <summary>
    /// SetInventory.
    /// </summary>
    /// <param name="pOldInventory">Integer.</param>
    /// <param name="pLocationID">code[50].</param>
    /// <param name="pInventItemID">code[50].</param>
    /// <param name="pItemName">text[250].</param>
    /// <param name="pProductID">code[50].</param>
    procedure SetInventory(pOldInventory: Integer; pLocationID: code[50]; pInventItemID: code[50]; pItemName: text[250]; pProductID: code[50])
    begin
        OldInventory := pOldInventory;
        NewInventory := pOldInventory;
        ItemName := pItemName;
        LocationID := pLocationID;
        InventItemID := pInventItemID;
        ProductID := pProductID;
    end;

    var
        OldInventory, NewInventory : Integer;
        LocationID, InventItemID, ProductID : code[50];
        ItemName: Text[250];

}
