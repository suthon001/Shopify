/// <summary>
/// Page TPP Shopify Refund Lists(ID 70011).
/// </summary>
page 70011 "TPP Shopify Refund Lists"
{
    Caption = 'Shopify Refund Lists';
    ApplicationArea = all;
    PageType = List;
    SourceTable = "TPP Shopify Order Transaction";
    SourceTableView = sorting("Transaction Type", order_id, id) where("Transaction Type" = filter(Refund));
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
    actions
    {
        area(Processing)
        {
            action(CreateToSalesCreditFunc)
            {
                Caption = 'Create Sales Credit Memo';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Payment;
                ToolTip = 'Executes the Create To Sales Credit Memo action.';
                Enabled = rec.id <> '';
                trigger OnAction()
                //  var
                //   ShopifyOrder: Record "TPP Shopify Order";

                begin
                    if not Confirm('Do you want create to Sales Credit Memo?') then
                        exit;
                    Message('Waiting Dev.');
                    // ShopifyOrder.Copy(rec);
                    // CurrPage.SetSelectionFilter(ShopifyOrder);
                    // ShopifyOrder.SetRange("Create to Sales Order", false);
                    // if ShopifyOrder.FindSet() then
                    //     repeat
                    //         rec.CreateToSalesOrder(ShopifyOrder.id);
                    //     until ShopifyOrder.Next() = 0;


                end;
            }
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
                Enabled = rec.id <> '';
                trigger OnAction()
                var
                    ShopifyOrderRefund: Record "TPP Shopify Refund Detail";
                    ShopifyOrderRefundDetail: Page "TPP Shopify Refund Detail List";
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                begin
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
