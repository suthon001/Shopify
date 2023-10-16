/// <summary>
/// Table TPP Shopify Fulfillment Line (ID 70012).
/// </summary>
table 70012 "TPP Shopify Fulfillment Line"
{
    Caption = 'Shopify Fulfillment Line';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; id; Code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(2; variant_id; Code[50])
        {
            Caption = 'variant_id';
            DataClassification = CustomerContent;
        }
        field(3; title; Text[100])
        {
            Caption = 'title';
            DataClassification = CustomerContent;
        }
        field(4; sku; Text[100])
        {
            Caption = 'sku';
            DataClassification = CustomerContent;
        }
        field(5; variant_title; Text[100])
        {
            Caption = 'variant_title';
            DataClassification = CustomerContent;
        }
        field(6; vendor; Text[100])
        {
            Caption = 'vendor';
            DataClassification = CustomerContent;
        }
        field(7; fulfillment_service; Text[100])
        {
            Caption = 'fulfillment_service';
            DataClassification = CustomerContent;
        }
        field(8; product_id; Code[50])
        {
            Caption = 'product_id';
            DataClassification = CustomerContent;
        }
        field(9; name; text[250])
        {
            Caption = 'name';
            DataClassification = CustomerContent;
        }
        field(10; variant_inventory_management; Text[100])
        {
            Caption = 'product_id';
            DataClassification = CustomerContent;
        }
        field(11; grams; Decimal)
        {
            Caption = 'grams';
            DataClassification = CustomerContent;
        }
        field(12; price; Decimal)
        {
            Caption = 'price';
            DataClassification = CustomerContent;
        }
        field(13; total_discount; Decimal)
        {
            Caption = 'total_discount';
            DataClassification = CustomerContent;
        }
        field(14; fulfillable_quantity; Decimal)
        {
            Caption = 'fulfillable_quantity';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalTotalAmount();
            end;
        }
        field(15; fulfillment_status; Text[100])
        {
            Caption = 'fulfillment_status';
            DataClassification = CustomerContent;
        }
        field(16; fulfillment_line_item_id; code[50])
        {
            Caption = 'fulfillment_line_item_id';
            DataClassification = CustomerContent;
        }
        field(17; fulfillment_id; code[50])
        {
            Caption = 'fulfillment_id';
            DataClassification = CustomerContent;
        }
        field(18; "tax_lines.price"; Decimal)
        {
            Caption = 'tax_lines.price';
            DataClassification = CustomerContent;
        }
        field(19; "tax_lines.rate"; Decimal)
        {
            Caption = 'tax_lines.rate';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalTotalAmount();
            end;
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
        key(PK; fulfillment_id, id)
        {
            Clustered = true;
        }
    }
    local procedure CalTotalAmount()
    begin
        rec."Total Amount" := rec.fulfillable_quantity * rec.price;
        rec."Total Amount Include Vat" := "Total Amount" + "tax_lines.price";
    end;
}
