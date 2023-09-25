/// <summary>
/// PageExtension TPP Shopify Item Variants List (ID 70001) extends Record Item Variants.
/// </summary>
pageextension 70001 "TPP Shopify Item Variants List" extends "Item Variants"
{
    layout
    {
        addlast(Control1)
        {
            field("TPP Shopify Variant ID"; Rec."TPP Shopify Variant ID")
            {
                ToolTip = 'Specifies the value of the TPP Shopify Variant ID field.';
                ApplicationArea = all;
            }
            field("TPP Shopify Price"; Rec."TPP Shopify Price")
            {
                ToolTip = 'Specifies the value of the TPP Shopify Price field.';
                ApplicationArea = all;
            }
        }
    }
}
