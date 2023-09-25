/// <summary>
/// TableExtension TPP Shopify Sales Line (ID 70002) extends Record Sales Line.
/// </summary>
tableextension 70002 "TPP Shopify Sales Line" extends "Sales Line"
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
