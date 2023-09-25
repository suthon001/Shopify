/// <summary>
/// TableExtension TPP Shopify Sales Header (ID 70000) extends Record Sales Header.
/// </summary>
tableextension 70000 "TPP Shopify Sales Header" extends "Sales Header"
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

    trigger OnDelete()
    var
        ltShopifyOrder: Record "TPP Shopify Order";
    begin
        if rec."Document Type" = rec."Document Type"::Order then
            if ltShopifyOrder.GET(rec."Ref. Shopify Order No.") then begin
                ltShopifyOrder."Create to Sales Order" := false;
                ltShopifyOrder."Create to Sales Order Date" := 0D;
                ltShopifyOrder."Create to Sales Order No." := '';
                ltShopifyOrder.Modify();
            end;

    end;
}
