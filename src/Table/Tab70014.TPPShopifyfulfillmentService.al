/// <summary>
/// Table TPP Shopify Carrier Service (ID 70014).
/// </summary>
table 70014 "TPP Shopify fulfillment Ser."
{
    Caption = 'TPP Shopify fulfillment Service';
    DataClassification = CustomerContent;
    fields
    {
        field(1; id; Code[50])
        {
            Caption = 'id';
            Editable = false;
        }
        field(2; name; Text[100])
        {
            Caption = 'name';
        }
        field(3; email; Text[100])
        {
            Caption = 'email';
        }
        field(4; service_name; Text[100])
        {
            Caption = 'service_name';
        }
        field(5; handle; Text[100])
        {
            Caption = 'handle';
        }
        field(6; fulfillment_orders_opt_in; Boolean)
        {
            Caption = 'fulfillment_orders_opt_in';
        }
        field(7; include_pending_stock; Boolean)
        {
            Caption = 'include_pending_stock';
        }
        field(8; provider_id; Code[50])
        {
            Caption = 'provider_id';
        }
        field(9; location_id; Code[50])
        {
            Caption = 'location_id';
        }
        field(10; callback_url; Text[250])
        {
            Caption = 'callback_url';
        }
        field(11; tracking_support; Boolean)
        {
            Caption = 'tracking_support';
        }
        field(12; inventory_management; Boolean)
        {
            Caption = 'inventory_management';
        }
        field(13; admin_graphql_api_id; Text[250])
        {
            Caption = 'admin_graphql_api_id';
        }
    }
    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }
}
