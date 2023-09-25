/// <summary>
/// TableExtension TPP Shopify Item Variant (ID 70009) extends Record Item Variant.
/// </summary>
tableextension 70009 "TPP Shopify Item Variant" extends "Item Variant"
{
    fields
    {
        field(70000; "TPP Shopify Variant ID"; Code[50])
        {
            Caption = 'TPP Shopify Variant ID';
            DataClassification = CustomerContent;
        }
        field(70001; "TPP Shopify Price"; Decimal)
        {
            Caption = 'TPP Shopify Price';
            DataClassification = CustomerContent;
        }
    }
}
