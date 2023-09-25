/// <summary>
/// TableExtension TPP Shopify Sales Ship. Line (ID 70003) extends Record Sales Shipment Line.
/// </summary>
tableextension 70003 "TPP Shopify Sales Ship. Line" extends "Sales Shipment Line"
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
