/// <summary>
/// Table TPP Shopify Inventory (ID 70014).
/// </summary>
table 70014 "TPP Shopify Inventory"
{
    Caption = 'Shopify Inventory';
    DataClassification = CustomerContent;
    TableType = Temporary;
    Extensible = false;
    fields
    {
        field(1; inventory_item_id; Code[50])
        {
            Caption = 'inventory_item_id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; location_id; Code[50])
        {
            Caption = 'location_id';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; available; Integer)
        {
            Caption = 'available';
            DataClassification = CustomerContent;
        }
        field(4; updated_at; DateTime)
        {
            Caption = 'updated_at';
            DataClassification = CustomerContent;
        }
        field(5; admin_graphql_api_id; Text[250])
        {
            Caption = 'admin_graphql_api_id';
            DataClassification = CustomerContent;
        }
        field(6; Product_id; text[250])
        {
            Caption = 'Product_id';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Product Name"; text[250])
        {
            Caption = 'Product Name';
            FieldClass = FlowField;
            CalcFormula = lookup("TPP Shopify Product".title where(id = field(Product_id)));
            Editable = false;

        }
    }
    keys
    {
        key(PK; inventory_item_id, location_id)
        {
            Clustered = true;
        }
    }
}
