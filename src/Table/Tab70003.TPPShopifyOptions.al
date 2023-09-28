/// <summary>
/// Table TPP Shopify Options (ID 70003).
/// </summary>
table 70003 "TPP Shopify Options"
{
    Caption = 'Shopify Options';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; product_id; code[50])
        {
            Caption = 'product_id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; id; code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; name; Text[250])
        {
            Caption = 'name';
            DataClassification = CustomerContent;
        }
        field(4; position; Integer)
        {
            Caption = 'position';
            DataClassification = CustomerContent;
        }
        field(5; values; Text[2047])
        {
            Caption = 'values';
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
