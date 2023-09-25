/// <summary>
/// Page TPP Shopify Refund Detail List (ID 70012).
/// </summary>
page 70012 "TPP Shopify Refund Detail List"
{
    Caption = 'Shopify Refund Detail List';
    PageType = List;
    SourceTable = "TPP Shopify Refund Detail";
    UsageCategory = None;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    Extensible = false;
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
                field(note; Rec.note)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the note field.';
                }
                field(restock; Rec.restock)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the restock field.';
                }
                field("refund_line_items.id"; Rec."refund_line_items.id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the refund_line_items.id field.';
                }
                field("refund_line_items.quantity"; Rec."refund_line_items.quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the refund_line_items.quantity field.';
                }
                field("refund_line_items.line_item_id"; Rec."refund_line_items.line_item_id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the refund_line_items.line_item_id field.';
                }
                field("refund_line_items.location_id"; Rec."refund_line_items.location_id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the refund_line_items.location_id field.';
                }
                field("refund_line_items.restock_type"; Rec."refund_line_items.restock_type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the refund_line_items.restock_type field.';
                }
                field("refund_line_items.subtotal"; Rec."refund_line_items.subtotal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the refund_line_items.subtotal field.';
                }
                field("refund_line_items.total_tax"; Rec."refund_line_items.total_tax")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the refund_line_items.total_tax field.';
                }
                field("line_item.id"; Rec."line_item.id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.id field.';
                }
                field("line_item.variant_id"; Rec."line_item.variant_id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.variant_id field.';
                }
                field("line_item.title"; Rec."line_item.title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.title field.';
                }
                field("line_item.quantity"; Rec."line_item.quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.quantity field.';
                }
                field("line_item.sku"; Rec."line_item.sku")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.sku field.';
                }
                field("line_item.product_id"; Rec."line_item.product_id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.product_id field.';
                }
                field("line_item.grams"; Rec."line_item.grams")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.grams field.';
                }
                field("line_item.price"; Rec."line_item.price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.price field.';
                }
                field("line_item.total_discount"; Rec."line_item.total_discount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.total_discount field.';
                }
                field("line_item.fulfillment_status"; Rec."line_item.fulfillment_status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the line_item.fulfillment_status field.';
                }
                field(created_at; Rec.created_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the created_at field.';
                }
                field(processed_at; Rec.processed_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the processed_at field.';
                }
            }
        }
    }
}
