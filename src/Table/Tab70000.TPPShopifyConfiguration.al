/// <summary>
/// Table TPP Shopify Configuration (ID 70000).
/// </summary>
table 70000 "TPP Shopify Configuration"
{
    Caption = 'Shopify Configuration';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "API Key"; Text[1047])
        {
            Caption = 'API Key';
            DataClassification = CustomerContent;
        }
        field(3; "Shop ID"; Text[100])
        {
            Caption = 'Shop ID';
            DataClassification = CustomerContent;
        }
        field(4; "URL Address"; Text[1024])
        {
            Caption = 'URL Address';
            DataClassification = CustomerContent;
        }
        field(5; "API Version"; Text[50])
        {
            Caption = 'API Version';
            DataClassification = CustomerContent;
        }
        field(6; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(7; "Order Nos."; code[20])
        {
            Caption = 'Order Nos.';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(9; "Limit Page"; Integer)
        {
            Caption = 'Limit Page';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 250;
        }
        field(10; "Bank Account No."; code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account"."No.";
            DataClassification = CustomerContent;
        }
        field(11; "Fee Account No."; code[20])
        {
            Caption = 'ค่าธรรมเนียม';
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting), Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(12; "Discount Account No."; code[20])
        {
            Caption = 'ส่วนลด';
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting), Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(13; "Shipping Account No."; code[20])
        {
            Caption = 'ค่าขนส่ง';
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting), Blocked = const(false));
            DataClassification = CustomerContent;
        }
        field(14; "Journal Template Name"; code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template".Name;
            DataClassification = CustomerContent;
        }
        field(15; "Journal Batch Name"; code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
            DataClassification = CustomerContent;
        }
        field(16; "Journal No. Series"; code[20])
        {
            Caption = 'Journal No. Series';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
