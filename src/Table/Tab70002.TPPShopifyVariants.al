/// <summary>
/// Table TPP Shopify Variants (ID 70002).
/// </summary>
table 70002 "TPP Shopify Variants"
{
    Caption = 'Shopify Variants';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; product_id; code[50])
        {
            Caption = 'product_id';
            DataClassification = CustomerContent;
        }
        field(2; id; code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(3; title; Text[250])
        {
            Caption = 'title';
            DataClassification = CustomerContent;
        }
        field(4; price; Decimal)
        {
            Caption = 'price';
            DataClassification = CustomerContent;
        }
        field(5; sku; Text[250])
        {
            Caption = 'sku';
            DataClassification = CustomerContent;
        }
        field(6; position; Integer)
        {
            Caption = 'position';
            DataClassification = CustomerContent;
        }
        field(7; inventory_policy; Text[250])
        {
            Caption = 'inventory_policy';
            DataClassification = CustomerContent;
        }
        field(8; fulfillment_service; Text[250])
        {
            Caption = 'fulfillment_service';
            DataClassification = CustomerContent;
        }
        field(9; option1; Text[250])
        {
            Caption = 'option1';
            DataClassification = CustomerContent;
        }
        field(10; option2; Text[250])
        {
            Caption = 'option2';
            DataClassification = CustomerContent;
        }
        field(11; option3; Text[250])
        {
            Caption = 'option3';
            DataClassification = CustomerContent;
        }
        field(12; created_at; DateTime)
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
        }
        field(13; updated_at; DateTime)
        {
            Caption = 'updated_at';
            DataClassification = CustomerContent;
        }
        field(14; taxable; Boolean)
        {
            Caption = 'taxable';
            DataClassification = CustomerContent;
        }
        field(15; barcode; Text[250])
        {
            Caption = 'barcode';
            DataClassification = CustomerContent;
        }
        field(16; grams; Integer)
        {
            Caption = 'grams';
            DataClassification = CustomerContent;
        }
        field(17; image_id; Text[250])
        {
            Caption = 'image_id';
            DataClassification = CustomerContent;
        }
        field(18; weight; Decimal)
        {
            Caption = 'weight';
            DataClassification = CustomerContent;
        }
        field(19; weight_unit; Text[250])
        {
            Caption = 'weight_unit';
            DataClassification = CustomerContent;
        }
        field(20; inventory_item_id; Code[50])
        {
            Caption = 'inventory_item_id';
            DataClassification = CustomerContent;
        }
        field(21; inventory_quantity; Integer)
        {
            Caption = 'inventory_quantity';
            DataClassification = CustomerContent;
        }
        field(22; old_inventory_quantity; Integer)
        {
            Caption = 'old_inventory_quantity';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; product_id, id)
        {
            Clustered = true;
        }
    }
}
