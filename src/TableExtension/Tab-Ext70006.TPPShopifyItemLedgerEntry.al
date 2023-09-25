/// <summary>
/// TableExtension TPP Shopify Item Ledger Entry (ID 70006) extends Record Item Ledger Entry.
/// </summary>
tableextension 70006 "TPP Shopify Item Ledger Entry" extends "Item Ledger Entry"
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
