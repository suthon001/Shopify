/// <summary>
/// Page TPP Shopify Transaction ALL(ID 70031).
/// </summary>
page 70031 "TPP Shopify Transaction ALL"
{
    Caption = 'Shopify Transaction';
    PageType = List;
    SourceTable = "TPP Shopify Order Transaction";
    SourceTableView = sorting("Transaction Type", order_id, id);
    UsageCategory = None;
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
    actions
    {
        area(Processing)
        {
            action(RefundInformation)
            {
                Caption = 'Refund Information';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = RefreshDiscount;
                ToolTip = 'Executes the Refund Information action.';
                Enabled = rec."Transaction Type" = rec."Transaction Type"::Refund;
                trigger OnAction()
                var
                    ShopifyOrderRefund: Record "TPP Shopify Refund Detail";
                    ShopifyOrderRefundDetail: Page "TPP Shopify Refund Detail List";
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                begin
                    rec.TestField("Transaction Type", rec."Transaction Type"::Refund);
                    ShopifyFunction.InsertToRefundTable(Database::"TPP Shopify Refund Detail", 'orders/' + rec.order_id + '/refunds.json', 'refunds');
                    Commit();
                    CLEAR(ShopifyOrderRefundDetail);
                    ShopifyOrderRefund.reset();
                    ShopifyOrderRefund.SetRange(order_id, rec.id);
                    ShopifyOrderRefundDetail.Editable := false;
                    ShopifyOrderRefundDetail.SetTableView(ShopifyOrderRefund);
                    ShopifyOrderRefundDetail.RunModal();
                    CLEAR(ShopifyOrderRefundDetail);
                end;
            }
        }
    }
}
