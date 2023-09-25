/// <summary>
/// TableExtension TPP Shopify Posted Gen. Line (ID 70011) extends Record Posted Gen. Journal Line.
/// </summary>
tableextension 70011 "TPP Shopify Posted Gen. Line" extends "Posted Gen. Journal Line"
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
        field(70002; "Shopify Transaction ID"; code[50])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
