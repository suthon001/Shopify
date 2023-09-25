/// <summary>
/// Table TPP Shopify Fulfillment Header (ID 70011).
/// </summary>
table 70011 "TPP Shopify Fulfillment Header"
{
    Caption = 'Shopify Fulfillment Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; id; Code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(2; order_id; Code[50])
        {
            Caption = 'order_id';
            DataClassification = CustomerContent;
        }
        field(3; status; text[50])
        {
            Caption = 'status';
            DataClassification = CustomerContent;
        }
        field(4; created_at; DateTime)
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
        }
        field(5; service; Text[50])
        {
            Caption = 'service';
            DataClassification = CustomerContent;
        }
        field(6; updated_at; DateTime)
        {
            Caption = 'updated_at';
            DataClassification = CustomerContent;
        }
        field(7; tracking_company; Text[100])
        {
            Caption = 'tracking_company';
            DataClassification = CustomerContent;
        }
        field(8; shipment_status; text[100])
        {
            Caption = 'shipment_status';
            DataClassification = CustomerContent;
        }
        field(9; location_id; code[50])
        {
            Caption = 'destination.address1';
            DataClassification = CustomerContent;
        }
        field(10; origin_address; Text[250])
        {
            Caption = 'origin_address';
            DataClassification = CustomerContent;
        }
        field(11; tracking_number; Text[100])
        {
            Caption = 'tracking_number';
            DataClassification = CustomerContent;
        }
        field(12; "tracking_numbers"; Text[250])
        {
            Caption = 'tracking_numbers';
            DataClassification = CustomerContent;
        }
        field(13; tracking_url; Text[250])
        {
            Caption = 'tracking_url';
            DataClassification = CustomerContent;
        }
        field(14; tracking_urls; Text[250])
        {
            Caption = 'tracking_urls';
            DataClassification = CustomerContent;
        }
        field(15; name; Text[250])
        {
            Caption = 'name';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; id, order_id)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        ShopifyFulfillmentLine: Record "TPP Shopify Fulfillment Line";
    begin
        ShopifyFulfillmentLine.reset();
        ShopifyFulfillmentLine.SetRange(fulfillment_id, rec.id);
        ShopifyFulfillmentLine.DeleteAll();
    end;
}
