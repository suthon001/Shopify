/// <summary>
/// Page TPP Shopify Inventory (ID 70010).
/// </summary>
page 70010 "TPP Shopify Inventory"
{
    Caption = 'Shopify Inventory';
    PageType = Worksheet;
    SourceTable = "TPP Shopify Inventory";
    ApplicationArea = all;
    UsageCategory = Lists;
    ModifyAllowed = false;
    InsertAllowed = false;
    DelayedInsert = false;
    Extensible = false;
    layout
    {
        area(content)
        {
            field(ProductID; ProductID)
            {
                ApplicationArea = all;
                Caption = 'Select Prodict ID';
                ToolTip = 'Specifies the value of the ProductID field.';
                TableRelation = "TPP Shopify Product".id;
                trigger OnValidate()
                begin
                    getInventory(ProductID);
                end;
            }
            repeater(General)
            {
                field(Product_id; Rec.Product_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product_id field.';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Name field.';
                }
                field(inventory_item_id; Rec.inventory_item_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the inventory_item_id field.';
                }
                field(location_id; Rec.location_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the location_id field.';
                }
                field(available; Rec.available)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the available field.';
                }
                field(updated_at; Rec.updated_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the updated_at field.';
                }
            }
        }

    }
    actions
    {

        area(Processing)
        {
            action(UpdateInventory)
            {
                Caption = 'Update Inventory';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = UpdateUnitCost;
                ToolTip = 'Executes the Update Inventory action.';
                Enabled = rec.inventory_item_id <> '';
                trigger OnAction()
                var
                    UpdateInventory: Report "TPP Shopify Update Inventory";
                begin
                    CLEAR(UpdateInventory);
                    rec.CalcFields("Product Name");
                    UpdateInventory.SetInventory(rec.available, rec.location_id, rec.inventory_item_id, rec."Product Name", ProductID);
                    UpdateInventory.RunModal();
                    rec.available := UpdateInventory.GetInventory();
                    rec.Modify();
                    CLEAR(UpdateInventory);
                end;
            }
        }
    }

    /// <summary>
    /// SetProductID.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    procedure SetProductID(pProductID: code[50])
    begin
        ProductID := pProductID;
        getInventory(ProductID);
    end;
    /// <summary>
    /// getInventory.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    local procedure getInventory(pProductID: code[50])
    var
        ProductVariant: Record "TPP Shopify Variants";
        ShopifyFunction: Codeunit "TPP Shopify Function";
        ltJsonObject, ltJsonObjectValue : JsonObject;
        ltJsonArray: JsonArray;
        ltJsonToken: JsonToken;
        ltmyLoop, ltCountLine : Integer;
        ltTextFilter, ltFieldName : Text;
        ltDateTime: DateTime;
    begin
        rec.Reset();
        rec.DeleteAll();
        Commit();
        ltTextFilter := '';
        ProductVariant.reset();
        ProductVariant.SetRange(product_id, pProductID);
        ProductVariant.SetFilter(id, '<>%1', '');
        if ProductVariant.FindSet() then
            repeat
                if ltTextFilter <> '' then
                    ltTextFilter := ltTextFilter + ',';
                ltTextFilter := ltTextFilter + ProductVariant.inventory_item_id;
            until ProductVariant.Next() = 0;
        ShopifyFunction.ConnectTOShopify('GET', 'inventory_levels.json?inventory_item_ids=' + ltTextFilter, ltJsonObject);
        if ltJsonObject.SelectToken('$.inventory_levels', ltJsonToken) then begin
            ltJsonArray := ltJsonToken.AsArray();
            for ltmyLoop := 0 to ltJsonArray.Count - 1 do begin
                ltCountLine := ltCountLine + 1;
                ltJsonArray.Get(ltmyLoop, ltJsonToken);
                ltJsonObjectValue := ltJsonToken.AsObject();
                rec.Init();
                rec.inventory_item_id := copystr(ShopifyFunction.SelectJsonTokenText(ltJsonObjectValue, '$.inventory_item_id'), 1, 50);
                rec.Product_id := pProductID;
                rec.location_id := copystr(ShopifyFunction.SelectJsonTokenText(ltJsonObjectValue, '$.location_id'), 1, 50);
                rec.available := ShopifyFunction.SelectJsonTokenInteger(ltJsonObjectValue, '$.available');
                Evaluate(ltDateTime, ShopifyFunction.SelectJsonTokenText(ltJsonObjectValue, '$.' + ltFieldName));
                rec.Validate(updated_at, ltDateTime);
                rec.Insert();
            end;
        end;
        Commit();
        CurrPage.Update(false);
    end;


    var
        ProductID: code[50];
}
