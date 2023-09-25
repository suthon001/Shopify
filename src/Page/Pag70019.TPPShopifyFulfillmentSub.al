/// <summary>
/// Page TPP Shopify Fulfillment Sub. (ID 70019).
/// </summary>
page 70019 "TPP Shopify Fulfillment Sub."
{
    Caption = 'Shopify Fulfillment Sub.';
    PageType = ListPart;
    SourceTable = "TPP Shopify Fulfillment Line";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(variant_id; Rec.variant_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the variant_id field.';
                }
                field(title; Rec.title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the title field.';
                }
                field(sku; Rec.sku)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the sku field.';
                }
                field(variant_title; Rec.variant_title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the variant_title field.';
                }
                field(vendor; Rec.vendor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vendor field.';
                }

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
                field(variant_inventory_management; Rec.variant_inventory_management)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the product_id field.';
                }
                field(fulfillment_status; Rec.fulfillment_status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillment_status field.';
                }
                field(fulfillment_service; Rec.fulfillment_service)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillment_service field.';
                }
                field(fulfillment_line_item_id; Rec.fulfillment_line_item_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillment_line_item_id field.';
                }
                field(fulfillable_quantity; Rec.fulfillable_quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillable_quantity field.';
                }

                field(grams; Rec.grams)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the grams field.';
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
                    ToolTip = 'Specifies the value of the price field.';
                }
                field("tax_lines.rate"; Rec."tax_lines.rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the rate field.';
                }
                field("tax_lines.title"; Rec."tax_lines.title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the title field.';
                }
                field("Total Amount Include Vat"; Rec."Total Amount Include Vat")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount Include Vat field.';

                }


            }
        }
    }
}
