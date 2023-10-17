/// <summary>
/// Table TPP Shopify Order (ID 70005).
/// </summary>
table 70005 "TPP Shopify Order"
{
    Caption = 'Shopify Order';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; id; Code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(2; admin_graphql_api_id; Code[50])
        {
            Caption = 'admin_graphql_api_id';
            DataClassification = CustomerContent;
        }
        field(3; app_id; Code[50])
        {
            Caption = 'app_id';
            DataClassification = CustomerContent;
        }
        field(4; browser_ip; Code[50])
        {
            Caption = 'browser_ip';
            DataClassification = CustomerContent;
        }
        field(5; cancel_reason; Text[50])
        {
            Caption = 'cancel_reason';
            DataClassification = CustomerContent;
        }
        field(6; cancelled_at; DateTime)
        {
            Caption = 'cancelled_at';
            DataClassification = CustomerContent;
        }
        field(7; company; Text[1047])
        {
            Caption = 'company';
            DataClassification = CustomerContent;
        }
        field(8; confirmed; Text[100])
        {
            Caption = 'confirmed';
            DataClassification = CustomerContent;
        }
        field(9; contact_email; Text[100])
        {
            Caption = 'contact_email';
            DataClassification = CustomerContent;
        }
        field(10; created_at; DateTime)
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if created_at <> 0DT then
                    rec."Create Date" := DT2Date(created_at);
            end;
        }
        field(11; currency; Code[10])
        {
            Caption = 'currency';
            DataClassification = CustomerContent;
        }
        field(12; current_subtotal_price; Decimal)
        {
            Caption = 'current_subtotal_price';
            DataClassification = CustomerContent;
        }
        field(14; current_total_discounts; Decimal)
        {
            Caption = 'current_total_discounts';
            DataClassification = CustomerContent;
        }
        field(15; current_total_duties_set; Decimal)
        {
            Caption = 'current_total_duties_set';
            DataClassification = CustomerContent;
        }
        field(16; current_total_price; Decimal)
        {
            Caption = 'current_total_price';
            DataClassification = CustomerContent;
        }
        field(17; current_total_tax; Decimal)
        {
            Caption = 'current_total_tax';
            DataClassification = CustomerContent;
        }
        field(18; customer_locale; Text[1047])
        {
            Caption = 'customer_locale';
            DataClassification = CustomerContent;
        }
        field(19; discount_codes; Text[1047])
        {
            Caption = 'discount_codes';
            DataClassification = CustomerContent;
        }
        field(20; email; Text[100])
        {
            Caption = 'email';
            DataClassification = CustomerContent;
        }
        field(21; financial_status; Text[50])
        {
            Caption = 'financial_status';
            DataClassification = CustomerContent;
        }
        field(22; order_number; Code[50])
        {
            Caption = 'order_number';
            DataClassification = CustomerContent;
        }
        field(23; phone; Text[50])
        {
            Caption = 'phone';
            DataClassification = CustomerContent;
        }
        field(24; total_tip_received; Decimal)
        {
            Caption = 'total_tip_received';
            DataClassification = CustomerContent;
        }
        field(25; total_weight; Decimal)
        {
            Caption = 'total_weight';
            DataClassification = CustomerContent;
        }
        field(26; updated_at; DateTime)
        {
            Caption = 'updated_at';
            DataClassification = CustomerContent;
        }
        field(28; "customer.id"; Code[50])
        {
            Caption = 'customer.id';
            DataClassification = CustomerContent;
        }
        field(29; "customer.email"; Text[100])
        {
            Caption = 'customer.email';
            DataClassification = CustomerContent;
        }
        field(30; "customer.created_at"; DateTime)
        {
            Caption = 'customer.created_at';
            DataClassification = CustomerContent;
        }
        field(31; "customer.updated_at"; DateTime)
        {
            Caption = 'customer.updated_at';
            DataClassification = CustomerContent;
        }
        field(32; "customer.first_name"; Text[100])
        {
            Caption = 'customer.first_name';
            DataClassification = CustomerContent;
        }
        field(33; "customer.last_name"; Text[100])
        {
            Caption = 'customer.last_name';
            DataClassification = CustomerContent;
        }
        field(34; "customer.phone"; Text[50])
        {
            Caption = 'customer.phone';
            DataClassification = CustomerContent;
        }
        field(35; "customer.currency"; Code[10])
        {
            Caption = 'customer.currency';
            DataClassification = CustomerContent;
        }
        field(36; "billing_address.first_name"; Text[100])
        {
            Caption = 'billing_address first_name';
            DataClassification = CustomerContent;
        }
        field(37; "billing_address.address1"; Text[1047])
        {
            Caption = 'billing_address address1';
            DataClassification = CustomerContent;
        }
        field(38; "billing_address.phone"; Text[50])
        {
            Caption = 'billing_address phone';
            DataClassification = CustomerContent;
        }
        field(39; "billing_address.city"; Text[50])
        {
            Caption = 'billing_address city';
            DataClassification = CustomerContent;
        }
        field(40; "billing_address.zip"; Text[50])
        {
            Caption = 'billing_address zip';
            DataClassification = CustomerContent;
        }
        field(41; "billing_address.province"; Text[100])
        {
            Caption = 'billing_address province';
            DataClassification = CustomerContent;
        }
        field(42; "billing_address.country"; Text[100])
        {
            Caption = 'billing_address country';
            DataClassification = CustomerContent;
        }
        field(43; "billing_address.last_name"; Text[100])
        {
            Caption = 'billing_address last_name';
            DataClassification = CustomerContent;
        }
        field(44; "billing_address.address2"; Text[1047])
        {
            Caption = 'billing_address address2';
            DataClassification = CustomerContent;
        }
        field(45; "billing_address.company"; Text[150])
        {
            Caption = 'billing_address company';
            DataClassification = CustomerContent;
        }
        field(46; "billing_address.name"; Text[150])
        {
            Caption = 'billing_address name';
            DataClassification = CustomerContent;
        }
        field(47; "billing_address.country_code"; Text[50])
        {
            Caption = 'billing_address country_code';
            DataClassification = CustomerContent;
        }
        field(48; "billing_address.province_code"; Text[50])
        {
            Caption = 'billing_address province_code';
            DataClassification = CustomerContent;
        }
        field(49; "shipping_address.first_name"; Text[100])
        {
            Caption = 'shipping_address first_name';
            DataClassification = CustomerContent;
        }
        field(50; "shipping_address.address1"; Text[1047])
        {
            Caption = 'shipping_address address1';
            DataClassification = CustomerContent;
        }
        field(51; "shipping_address.phone"; Text[50])
        {
            Caption = 'shipping_address phone';
            DataClassification = CustomerContent;
        }
        field(52; "shipping_address.city"; Text[50])
        {
            Caption = 'shipping_address city';
            DataClassification = CustomerContent;
        }
        field(53; "shipping_address.zip"; Text[50])
        {
            Caption = 'shipping_address zip';
            DataClassification = CustomerContent;
        }
        field(54; "shipping_address.province"; Text[100])
        {
            Caption = 'shipping_address province';
            DataClassification = CustomerContent;
        }
        field(55; "shipping_address.country"; Text[100])
        {
            Caption = 'shipping_address country';
            DataClassification = CustomerContent;
        }
        field(56; "shipping_address.last_name"; Text[100])
        {
            Caption = 'shipping_address last_name';
            DataClassification = CustomerContent;
        }
        field(57; "shipping_address.address2"; Text[1047])
        {
            Caption = 'shipping_address address2';
            DataClassification = CustomerContent;
        }
        field(58; "shipping_address.company"; Text[150])
        {
            Caption = 'shipping_address company';
            DataClassification = CustomerContent;
        }
        field(59; "shipping_address.name"; Text[150])
        {
            Caption = 'shipping_address name';
            DataClassification = CustomerContent;
        }
        field(60; "shipping_address.country_code"; Text[50])
        {
            Caption = 'shipping_address country_code';
            DataClassification = CustomerContent;
        }
        field(61; "shipping_address.province_code"; Text[50])
        {
            Caption = 'shipping_address province_code';
            DataClassification = CustomerContent;
        }
        field(62; total_shipping_price_set; Decimal)
        {
            Caption = 'total_shipping_price_set';
            DataClassification = CustomerContent;
        }
        field(63; "Create Date"; Date)
        {
            Caption = 'Create Date';
            DataClassification = CustomerContent;
        }
        field(64; "fulfillment_status"; text[250])
        {
            Caption = 'fulfillment_status';
            DataClassification = CustomerContent;
        }
        field(65; "checkout_id"; code[50])
        {
            Caption = 'checkout_id';
            DataClassification = CustomerContent;
        }
        field(66; "checkout_token"; text[50])
        {
            Caption = 'checkout_token';
            DataClassification = CustomerContent;
        }
        field(67; "Create to Sales Order"; Boolean)
        {
            Caption = 'Create to Sales Order';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(68; "Create to Sales Order Date"; date)
        {
            Caption = 'Create to Sales Order Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(69; "Closed Order"; Boolean)
        {
            Caption = 'Closed Order';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70; closed_at; DateTime)
        {
            Caption = 'closed_at';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(71; "Cancelled Order"; Boolean)
        {
            Caption = 'Cancelled Order';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(73; "Create to Sales Order No."; Code[20])
        {
            Caption = 'Create to Sales Order No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(74; "Tracking No."; Text[100])
        {
            Caption = 'Tracking No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75; "Create to RV No."; code[20])
        {
            Caption = 'Create to RV No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(76; "Create to RV DateTime"; DateTime)
        {
            Caption = 'Create to RV DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(77; "Posted Sales Invoice No."; code[20])
        {
            Caption = 'Posted Sales Invoice No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(78; "cart_token"; text[50])
        {
            Caption = 'cart_token';
            DataClassification = CustomerContent;
        }
        field(79; status; text[50])
        {
            Caption = 'status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80; payment_status; text[50])
        {
            Caption = 'payment_status';
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
    trigger OnDelete()
    var
        ShopifyOrderLine: Record "TPP Shopify Order Line";
        ShopifyTransaction: Record "TPP Shopify Order Transaction";
        ShopifyRefurnDetail: Record "TPP Shopify Refund Detail";

    begin
        rec.TestField("Create to Sales Order", false);
        rec.TestField("Closed Order", false);
        ShopifyOrderLine.reset();
        ShopifyOrderLine.SetRange(order_number, rec.order_number);
        ShopifyOrderLine.DeleteAll();

        ShopifyTransaction.reset();
        ShopifyTransaction.SetRange(order_id, rec.id);
        ShopifyTransaction.DeleteAll();

        ShopifyRefurnDetail.reset();
        ShopifyRefurnDetail.SetRange(order_id, rec.id);
        ShopifyRefurnDetail.DeleteAll();
    end;


}
