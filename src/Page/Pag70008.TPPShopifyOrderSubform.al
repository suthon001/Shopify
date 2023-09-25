/// <summary>
/// Page TPP Shopify Order Subform (ID 70008).
/// </summary>
page 70008 "TPP Shopify Order Subform"
{
    Caption = 'Shopify Order Subform';
    PageType = ListPart;
    SourceTable = "TPP Shopify Order Line";
    UsageCategory = None;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(product_id; Rec.product_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the product_id field.';
                }
                field(name; Rec.name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the name field.';
                }
                field(quantity; Rec.quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the quantity field.';
                }

                field(total_discount; Rec.total_discount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the total_discount field.';
                }
                field(price; Rec.price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the price field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("tax_lines.price"; Rec."tax_lines.price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tax_lines.price field.';
                }
                field("tax_lines.rate"; Rec."tax_lines.rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tax_lines.rate field.';
                }
                field("tax_lines.title"; Rec."tax_lines.title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tax_lines.title field.';
                }
                field("Total Amount Include Vat"; Rec."Total Amount Include Vat")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Include Vat field.';

                }
                field(vendor; Rec.vendor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vendor field.';
                }

                field(sku; Rec.sku)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the sku field.';
                }
                field(title; Rec.title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the title field.';
                }
                field(variant_id; Rec.variant_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the variant_id field.';
                }
                field(variant_title; Rec.variant_title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the variant_title field.';
                }
            }
        }
    }
}
