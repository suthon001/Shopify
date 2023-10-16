/// <summary>
/// Page TPP Shopify Order Transaction (ID 70009).
/// </summary>
page 70009 "TPP Shopify Order Transaction"
{
    Caption = 'Shopify Order Transaction';
    PageType = List;
    ApplicationArea = all;
    SourceTable = "TPP Shopify Order Transaction";
    SourceTableView = sorting("Transaction Type", order_id, id) where("Transaction Type" = filter(Payment));
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(order_number; Rec.order_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the order_number field.';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the status field.';
                }
                field(message; Rec.message)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the message field.';
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the amount field.';
                }
                field(currency; Rec.currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the currency field.';
                }
                field(payment_id; Rec.payment_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the payment_id field.';
                }
                field(created_at; Rec.created_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the created_at field.';
                }
            }
        }
    }
}
