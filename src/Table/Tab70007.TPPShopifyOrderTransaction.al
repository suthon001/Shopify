/// <summary>
/// Table TPP Shopify Order Transaction (ID 70007).
/// </summary>
table 70007 "TPP Shopify Order Transaction"
{
    Caption = 'Shopify Order Transaction';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; "Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Payment,Refund';
            OptionMembers = Payment,Refund;
            DataClassification = CustomerContent;
        }
        field(2; order_id; Code[50])
        {
            Caption = 'order_id';
            DataClassification = CustomerContent;
        }
        field(3; id; Code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(4; kind; Text[100])
        {
            Caption = 'kind';
            DataClassification = CustomerContent;
        }
        field(5; status; Text[100])
        {
            Caption = 'status';
            DataClassification = CustomerContent;
        }
        field(6; message; Text[100])
        {
            Caption = 'message';
            DataClassification = CustomerContent;
        }
        field(7; created_at; DateTime)
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
        }
        field(8; amount; Decimal)
        {
            Caption = 'amount';
            DataClassification = CustomerContent;
        }
        field(9; currency; Code[10])
        {
            Caption = 'currency';
            DataClassification = CustomerContent;
        }
        field(10; payment_id; Text[100])
        {
            Caption = 'payment_id';
            DataClassification = CustomerContent;
        }
        field(11; parent_id; code[50])
        {
            Caption = 'parent_id';
            DataClassification = CustomerContent;
        }
        field(12; gateway; Text[100])
        {
            Caption = 'gateway';
            DataClassification = CustomerContent;

        }
    }
    keys
    {
        key(PK; "Transaction Type", order_id, id)
        {
            Clustered = true;
        }
    }
}
