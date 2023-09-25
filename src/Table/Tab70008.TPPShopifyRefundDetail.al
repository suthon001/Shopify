/// <summary>
/// Table TPP Shopify Refund Detail (ID 70008).
/// </summary>
table 70008 "TPP Shopify Refund Detail"
{
    Caption = 'Shopify Refund Detail';
    DataClassification = ToBeClassified;
    Extensible = false;
    fields
    {
        field(1; order_id; Code[50])
        {
            Caption = 'order_id';
            DataClassification = ToBeClassified;
        }
        field(2; id; Code[50])
        {
            Caption = 'id';
            DataClassification = ToBeClassified;
        }
        field(3; created_at; DateTime)
        {
            Caption = 'created_at';
            DataClassification = ToBeClassified;
        }
        field(4; note; Text[1047])
        {
            Caption = 'note';
            DataClassification = ToBeClassified;
        }
        field(5; processed_at; DateTime)
        {
            Caption = 'processed_at';
            DataClassification = ToBeClassified;
        }
        field(6; restock; Boolean)
        {
            Caption = 'restock';
            DataClassification = ToBeClassified;
        }
        field(7; "refund_line_items.id"; Code[50])
        {
            Caption = 'refund_line_items.id';
            DataClassification = ToBeClassified;
        }
        field(8; "refund_line_items.quantity"; Decimal)
        {
            Caption = 'refund_line_items.quantity';
            DataClassification = ToBeClassified;
        }
        field(9; "refund_line_items.line_item_id"; Code[50])
        {
            Caption = 'refund_line_items.line_item_id';
            DataClassification = ToBeClassified;
        }
        field(10; "refund_line_items.location_id"; Code[50])
        {
            Caption = 'refund_line_items.location_id';
            DataClassification = ToBeClassified;
        }
        field(11; "refund_line_items.restock_type"; Text[100])
        {
            Caption = 'refund_line_items.restock_type';
            DataClassification = ToBeClassified;
        }
        field(12; "refund_line_items.subtotal"; Decimal)
        {
            Caption = 'refund_line_items.subtotal';
            DataClassification = ToBeClassified;
        }
        field(13; "refund_line_items.total_tax"; Decimal)
        {
            Caption = 'refund_line_items.total_tax';
            DataClassification = ToBeClassified;
        }
        field(14; "line_item.id"; Code[50])
        {
            Caption = 'line_item.id';
            DataClassification = ToBeClassified;
        }
        field(15; "line_item.variant_id"; Code[50])
        {
            Caption = 'line_item.variant_id';
            DataClassification = ToBeClassified;
        }
        field(16; "line_item.title"; Text[1047])
        {
            Caption = 'line_item.title';
            DataClassification = ToBeClassified;
        }
        field(17; "line_item.quantity"; Decimal)
        {
            Caption = 'line_item.quantity';
            DataClassification = ToBeClassified;
        }
        field(18; "line_item.sku"; Text[100])
        {
            Caption = 'line_item.sku';
            DataClassification = ToBeClassified;
        }
        field(19; "line_item.product_id"; Code[50])
        {
            Caption = 'line_item.product_id';
            DataClassification = ToBeClassified;
        }
        field(20; "line_item.grams"; Decimal)
        {
            Caption = 'line_item.grams';
            DataClassification = ToBeClassified;
        }
        field(21; "line_item.price"; Decimal)
        {
            Caption = 'line_item.price';
            DataClassification = ToBeClassified;
        }
        field(22; "line_item.total_discount"; Decimal)
        {
            Caption = 'line_item.total_discount';
            DataClassification = ToBeClassified;
        }
        field(23; "line_item.fulfillment_status"; Text[100])
        {
            Caption = 'line_item.fulfillment_status';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; order_id, id)
        {
            Clustered = true;
        }
    }
}
