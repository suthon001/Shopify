/// <summary>
/// TableExtension TPP Shopify Cust. Leager Entry (ID 70004) extends Record Cust. Ledger Entry.
/// </summary>
tableextension 70004 "TPP Shopify Cust. Leager Entry" extends "Cust. Ledger Entry"
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
