/// <summary>
/// Table TPP Shopify Product (ID 70001).
/// </summary>
table 70001 "TPP Shopify Product"
{
    Caption = 'Shopify Product';
    DataClassification = CustomerContent;
    LookupPageId = "TPP Shopify Product Lists";
    DrillDownPageId = "TPP Shopify Product Lists";
    Extensible = false;
    fields
    {
        field(1; id; code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(2; title; Text[250])
        {
            Caption = 'title';
            DataClassification = CustomerContent;
        }
        field(3; body_html; Text[2047])
        {
            Caption = 'body_html';
            DataClassification = CustomerContent;
        }
        field(4; vendor; Text[250])
        {
            Caption = 'vendor';
            DataClassification = CustomerContent;
        }
        field(5; product_type; Text[250])
        {
            Caption = 'product_type';
            DataClassification = CustomerContent;
        }
        field(6; created_at; DateTime)
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if created_at <> 0DT then
                    rec."Create Date" := DT2Date(created_at);
            end;
        }
        field(7; handle; Text[250])
        {
            Caption = 'handle';
            DataClassification = CustomerContent;
        }
        field(8; updated_at; DateTime)
        {
            Caption = 'updated_at';
            DataClassification = CustomerContent;
        }
        field(9; published_at; Text[250])
        {
            Caption = 'published_at';
            DataClassification = CustomerContent;
        }
        field(10; published_scope; Text[250])
        {
            Caption = 'published_scope';
            DataClassification = CustomerContent;
        }
        field(11; tags; Text[250])
        {
            Caption = 'tags';
            DataClassification = CustomerContent;
        }
        field(12; admin_graphql_api_id; Text[250])
        {
            Caption = 'admin_graphql_api_id';
            DataClassification = CustomerContent;
        }
        field(13; "Create Date"; Date)
        {
            Caption = 'Create Date';
            DataClassification = CustomerContent;
        }
        field(14; status; Text[50])
        {
            Caption = 'status';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; id, title, handle, vendor, product_type) { }
    }
    trigger OnDelete()
    var
        ShopifyVariant: Record "TPP Shopify Variants";
        ShopifyOption: Record "TPP Shopify Options";
        ShopifyImage: Record "TPP Shopify Image";
    begin
        ShopifyVariant.reset();
        ShopifyVariant.SetRange(product_id, id);
        ShopifyVariant.DeleteAll();

        ShopifyOption.reset();
        ShopifyOption.SetRange(product_id, id);
        ShopifyOption.DeleteAll();

        ShopifyImage.reset();
        ShopifyImage.SetRange(product_id, id);
        ShopifyImage.DeleteAll();
    end;

}
