/// <summary>
/// Page TPP Shopify New Variants(ID 70033).
/// </summary>
page 70033 "TPP Shopify New Variants"
{
    Caption = 'Shopify Variants Subform';
    PageType = ListPart;
    SourceTable = "TPP Shopify Variants";
    SourceTableTemporary = true;
    UsageCategory = None;
    Extensible = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(option1; Rec.option1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the option1 field.';
                }

                field(price; Rec.price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the price field.';
                }
                field(sku; Rec.sku)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the sku field.';
                }

                field(barcode; Rec.barcode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the barcode field.';
                }
                field(grams; Rec.grams)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the grams field.';
                }

                field(weight; Rec.weight)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the weight field.';
                }
                field(weight_unit; Rec.weight_unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the weight_unit field.';
                }

                field(inventory_quantity; Rec.inventory_quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the inventory_quantity field.';
                }

            }
        }
    }
    /// <summary>
    /// GetLines.
    /// </summary>
    /// <param name="ShopifyVariants">Temporary VAR Record "TPP Shopify Variants".</param>
    procedure GetLines(var ShopifyVariants: Record "TPP Shopify Variants" temporary)
    begin
        rec.reset();
        ShopifyVariants.Copy(rec, true);
    end;
}
