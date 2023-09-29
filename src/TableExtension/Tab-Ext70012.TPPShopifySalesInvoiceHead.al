/// <summary>
/// TableExtension TPP Shopify Sales Invoice Head (ID 70012) extends Record Sales Invoice Header.
/// </summary>
tableextension 70012 "TPP Shopify Sales Invoice Head" extends "Sales Invoice Header"
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
        field(79999; "Open"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry".Open where("Document No." = field("No."), "Document Type" = filter(Invoice)));
            Caption = 'Open';
        }
    }

}
