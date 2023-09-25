/// <summary>
/// TableExtension TPP Shopify Sales Ship. Header (ID 70001) extends Record Sales Shipment Header.
/// </summary>
tableextension 70001 "TPP Shopify Sales Ship. Header" extends "Sales Shipment Header"
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
            Caption = 'Shopify Tracking No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
