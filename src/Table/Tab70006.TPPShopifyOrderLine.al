/// <summary>
/// Table TPP Shopify Order Line (ID 70006).
/// </summary>
table 70006 "TPP Shopify Order Line"
{
    Caption = 'Shopify Order Line';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; order_number; Code[50])
        {
            Caption = 'order_number';
            DataClassification = CustomerContent;
        }
        field(2; id; Code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(3; admin_graphql_api_id; Code[50])
        {
            Caption = 'admin_graphql_api_id';
            DataClassification = CustomerContent;
        }
        field(4; fulfillable_quantity; Decimal)
        {
            Caption = 'fulfillable_quantity';
            DataClassification = CustomerContent;
        }
        field(5; gift_card; Boolean)
        {
            Caption = 'gift_card';
            DataClassification = CustomerContent;
        }
        field(6; grams; Integer)
        {
            Caption = 'grams';
            DataClassification = CustomerContent;
        }
        field(7; name; Text[1047])
        {
            Caption = 'name';
            DataClassification = CustomerContent;
        }
        field(8; price; Decimal)
        {
            Caption = 'price';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalTotalAmount();
            end;
        }
        field(9; product_id; Code[50])
        {
            Caption = 'product_id';
            DataClassification = CustomerContent;
            TableRelation = "TPP Shopify Product".id;
        }
        field(10; quantity; Decimal)
        {
            Caption = 'quantity';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalTotalAmount();
            end;
        }
        field(11; sku; Code[50])
        {
            Caption = 'sku';
            DataClassification = CustomerContent;
        }
        field(12; title; Text[100])
        {
            Caption = 'title';
            DataClassification = CustomerContent;
        }
        field(13; total_discount; Decimal)
        {
            Caption = 'total_discount';
            DataClassification = CustomerContent;
        }
        field(14; variant_id; Code[50])
        {
            Caption = 'variant_id';
            DataClassification = CustomerContent;
        }
        field(15; variant_inventory_management; Text[100])
        {
            Caption = 'variant_inventory_management';
            DataClassification = CustomerContent;
        }
        field(16; variant_title; Text[100])
        {
            Caption = 'variant_title';
            DataClassification = CustomerContent;
        }
        field(17; vendor; Text[100])
        {
            Caption = 'vendor';
            DataClassification = CustomerContent;
        }
        field(18; "tax_lines.price"; Decimal)
        {
            Caption = 'tax_lines.price';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalTotalAmount();
            end;
        }
        field(19; "tax_lines.rate"; Decimal)
        {
            Caption = 'tax_lines.rate';
            DataClassification = CustomerContent;
        }
        field(20; "tax_lines.title"; Text[50])
        {
            Caption = 'tax_lines.title';
            DataClassification = CustomerContent;
        }
        field(21; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
        }
        field(22; "Total Amount Include Vat"; Decimal)
        {
            Caption = 'Total Amount Include Vat';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; order_number, id)
        {
            Clustered = true;
        }
    }
    local procedure CalTotalAmount()
    begin
        rec."Total Amount" := rec.quantity * rec.price;
        rec."Total Amount Include Vat" := "Total Amount" + "tax_lines.price";
    end;
}
