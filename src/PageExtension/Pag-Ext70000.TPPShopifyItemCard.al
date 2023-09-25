/// <summary>
/// PageExtension TPP Shopify Item Card (ID 70000) extends Record Item Card.
/// </summary>
pageextension 70000 "TPP Shopify Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("TPP Shopify Ref. ID"; Rec."TPP Shopify Ref. ID")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shopify Ref. ID field.';
            }
        }
    }
}
