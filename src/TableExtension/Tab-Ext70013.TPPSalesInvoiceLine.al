
/// <summary>
/// TableExtension TPP Sales Invoice Line (ID 70013) extends Record Sales Invoice Line.
/// </summary>
tableextension 70013 "TPP Sales Invoice Line" extends "Sales Invoice Line"
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
