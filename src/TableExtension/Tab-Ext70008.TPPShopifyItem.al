/// <summary>
/// TableExtension TPP Shopify Item (ID 70008) extends Record Item.
/// </summary>
tableextension 70008 "TPP Shopify Item" extends Item
{
    fields
    {
        field(70000; "TPP Shopify Ref. ID"; Code[50])
        {
            Caption = 'Shopify Ref. ID';
            DataClassification = CustomerContent;
            TableRelation = "TPP Shopify Product".id;
        }
    }
}
