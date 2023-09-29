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
    DeleteAllowed = false;
    InsertAllowed = false;
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
    actions
    {
        area(Processing)
        {
            action(DeleteVariant)
            {
                Caption = 'Delete Variant';
                Image = Delete;
                ApplicationArea = all;
                ToolTip = 'Executes the Delete Variant action.';
                trigger OnAction()
                var
                    ShopifyVariants: Record "TPP Shopify Variants";
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                    DeleteImageQst: Label 'Are you sure you want to delete Variant id %1 , %2 ?', Locked = true;
                begin
                    ShopifyVariants.reset();
                    ShopifyVariants.SetRange(product_id, rec.product_id);
                    if ShopifyVariants.Count = 1 then begin
                        Message('Cannot delete becaese not less 1 record.');
                        exit;
                    end;
                    if not Confirm(StrSubstNo(DeleteImageQst, rec.id, rec.title)) then
                        exit;
                    ShopifyFunction.DeleteVariant(rec.product_id, rec.id);
                    ShopifyFunction.GetProductOptions(rec.product_id);
                    rec.Delete(true);
                    CurrPage.Update();
                end;

            }
            action(CreateVariant)
            {
                Caption = 'Create Variant';
                Image = Add;
                ApplicationArea = all;
                ToolTip = 'Executes the Create Variant action.';
                trigger OnAction()
                var
                    ShopifyAddVariant: Page "TPP Shopify Add Variant";
                begin
                    CLEAR(ShopifyAddVariant);
                    ShopifyAddVariant.SetProductID(rec.product_id);
                    ShopifyAddVariant.RunModal();
                    CLEAR(ShopifyAddVariant);
                end;
            }
        }
    }
}
