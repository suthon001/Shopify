/// <summary>
/// TableExtension TPP Shopify Item Journal Line (ID 70005) extends Record Item Journal Line.
/// </summary>
tableextension 70005 "TPP Shopify Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(70000; "Ref. Shopify Order No."; Code[50])
        {
            Caption = 'Ref. Shopify Order No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70001; "Shopify Tracking No."; Text[100])
        {
            Caption = 'Tracking No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
