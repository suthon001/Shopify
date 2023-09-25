/// <summary>
/// Page TPP Shopify Variants Subform (ID 70003).
/// </summary>
page 70003 "TPP Shopify Variants Subform"
{
    Caption = 'Shopify Variants Subform';
    PageType = ListPart;
    SourceTable = "TPP Shopify Variants";
    UsageCategory = None;
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
                field(title; Rec.title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the title field.';
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
                field(position; Rec.position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the position field.';
                }
                field(inventory_policy; Rec.inventory_policy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the inventory_policy field.';
                }
                field(fulfillment_service; Rec.fulfillment_service)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillment_service field.';
                }
                field(option1; Rec.option1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the option1 field.';
                }
                field(option2; Rec.option2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the option2 field.';
                }
                field(option3; Rec.option3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the option3 field.';
                }
                field(created_at; Rec.created_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the created_at field.';
                }
                field(updated_at; Rec.updated_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the updated_at field.';
                }
                field(taxable; Rec.taxable)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the taxable field.';
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
                field(image_id; Rec.image_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the image_id field.';
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
                field(inventory_item_id; Rec.inventory_item_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the inventory_item_id field.';
                }
                field(inventory_quantity; Rec.inventory_quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the inventory_quantity field.';
                }
                field(old_inventory_quantity; Rec.old_inventory_quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the old_inventory_quantity field.';
                }
            }
        }
    }
}
