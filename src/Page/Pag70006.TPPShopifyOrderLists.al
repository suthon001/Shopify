/// <summary>
/// Page TPP Shopify Order Lists (ID 70006).
/// </summary>
page 70006 "TPP Shopify Order Lists"
{
    Caption = 'Shopify Order Lists';
    PageType = List;
    SourceTable = "TPP Shopify Order";
    SourceTableView = sorting(id) where("Closed Order" = const(false), "Create to Sales Order" = const(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    CardPageId = "TPP Shopify Order Card";
    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(order_number; Rec.order_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the order_number field.';
                }
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(status; rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the status field.';
                }
                field("Tracking No."; Rec."Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tracking No. field.';
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Create Date field.';
                }
                field("customer.first_name"; Rec."customer.first_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customer.first_name field.';
                }
                field("customer.last_name"; Rec."customer.last_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customer.last_name field.';
                }
                field("customer.phone"; Rec."customer.phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customer.phone field.';
                }
                field(financial_status; Rec.financial_status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the financial_status field.';
                }
                field(fulfillment_status; Rec.fulfillment_status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillment_status field.';
                }
                field("customer.email"; Rec."customer.email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customer.email field.';
                }
                field("billing_address.first_name"; Rec."billing_address.first_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address first_name field.';
                }
                field("billing_address.last_name"; Rec."billing_address.last_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address last_name field.';
                }
                field("billing_address.address1"; Rec."billing_address.address1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address address1 field.';
                }
                field("billing_address.address2"; Rec."billing_address.address2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address address2 field.';
                }
                field("billing_address.city"; Rec."billing_address.city")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address city field.';
                }
                field("billing_address.province"; Rec."billing_address.province")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address province field.';
                }
                field("billing_address.phone"; Rec."billing_address.phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address phone field.';
                }
                field(phone; Rec.phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the phone field.';
                }
                field(current_subtotal_price; Rec.current_subtotal_price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the current_subtotal_price field.';
                }
                field(current_total_discounts; Rec.current_total_discounts)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the current_total_discounts field.';
                }
                field(current_total_tax; Rec.current_total_tax)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the current_total_tax field.';
                }
                field(total_shipping_price_set; Rec.total_shipping_price_set)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the total_shipping_price_set field.';
                }
                field(current_total_price; Rec.current_total_price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the current_total_price field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetOrders)
            {
                Caption = 'Get Orders';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = ItemLines;
                ToolTip = 'Executes the Orders action.';
                trigger OnAction()
                var
                    GetOrderDialog: Page "TPP Shopify Get Orders Dialog";
                begin
                    CLEAR(GetOrderDialog);
                    GetOrderDialog.RunModal();
                    CLEAR(GetOrderDialog);
                end;
            }
            action(PaymentStatus)
            {
                Caption = 'Payment & Refund Detail';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Payment;
                ToolTip = 'Executes the Get Payment & Refund Detail action.';
                trigger OnAction()
                var
                    ShopifyOrderTransactions: Record "TPP Shopify Order Transaction";
                    ShopifyOrderTransaction: Page "TPP Shopify Order Transaction";
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                begin
                    ShopifyFunction.InsertToTable('GET', Database::"TPP Shopify Order Transaction", 'orders/' + rec.id + '/transactions.json', 'transactions', 1);
                    ShopifyFunction.InsertToTable('GET', Database::"TPP Shopify Order Transaction", 'orders/' + rec.id + '/refunds.json', 'transactions', 2);
                    Commit();
                    CLEAR(ShopifyOrderTransaction);
                    ShopifyOrderTransactions.reset();
                    ShopifyOrderTransactions.SetRange(order_id, rec.id);
                    ShopifyOrderTransaction.Editable := false;
                    ShopifyOrderTransaction.SetTableView(ShopifyOrderTransactions);
                    ShopifyOrderTransaction.RunModal();
                    CLEAR(ShopifyOrderTransaction);
                end;
            }

            action(GetFulfillment)
            {
                Caption = 'Order Fulfillment';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = ItemLines;
                ToolTip = 'Executes the Order Fulfillment action.';
                trigger OnAction()
                var
                    FulfillmentOrderRec: Record "TPP Shopify Fulfillment Header";
                    FulfillmentOrder: Page "TPP Shopify Fulfillment Lists";
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                begin
                    ShopifyFunction.FulfillmentOrder(rec.id);
                    Commit();
                    FulfillmentOrderRec.reset();
                    FulfillmentOrderRec.SetRange(order_id, rec.id);
                    FulfillmentOrder.SetTableView(FulfillmentOrderRec);
                    FulfillmentOrder.RunModal();
                    CurrPage.Update();
                end;
            }

            // action(RefundOrder)
            // {
            //     Caption = 'Refund Order';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     ApplicationArea = Basic, Suite;
            //     Image = Payment;
            //     ToolTip = 'Executes the Create To Refund Order action.';
            //     trigger OnAction()
            //     var
            //         ShopifyOrder: Record "TPP Shopify Order";
            //         ShopifyFunction: Codeunit "TPP Shopify Function";
            //     begin
            //         if not Confirm('Do you want Refund Order?') then
            //             exit;
            //         ShopifyOrder.Copy(rec);
            //         CurrPage.SetSelectionFilter(ShopifyOrder);
            //         ShopifyOrder.SetRange("Create to Sales Order", false);
            //         ShopifyOrder.SetRange(financial_status, 'paid');
            //         if ShopifyOrder.FindSet() then begin
            //             repeat
            //                 ShopifyFunction.RefundOrder(ShopifyOrder.id);
            //             until ShopifyOrder.Next() = 0;
            //             Message('Refund Order is successfully');
            //         end;
            //     end;
            // }

            action(CreateToSalesOrderFunc)
            {
                Caption = 'Create To Sales Order';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Payment;
                ToolTip = 'Executes the Create To SalesOrder action.';
                trigger OnAction()
                var
                    ShopifyOrder: Record "TPP Shopify Order";

                begin
                    if not Confirm('Do you want create to Sales Order?') then
                        exit;
                    ShopifyOrder.Copy(rec);
                    CurrPage.SetSelectionFilter(ShopifyOrder);
                    ShopifyOrder.SetRange("Create to Sales Order", false);
                    if ShopifyOrder.FindSet() then
                        repeat
                            rec.CreateToSalesOrder(ShopifyOrder.id);
                        until ShopifyOrder.Next() = 0;


                end;
            }
            // action(CloseSalesOrderFunc)
            // {
            //     Caption = 'Close Order';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     ApplicationArea = Basic, Suite;
            //     Image = Payment;
            //     ToolTip = 'Executes the Close Order action.';
            //     trigger OnAction()
            //     var
            //         ShopifyOrder: Record "TPP Shopify Order";
            //         ShopifyFunction: Codeunit "TPP Shopify Function";
            //     begin
            //         if not Confirm('Do you want Close to Order?') then
            //             exit;
            //         ShopifyOrder.Copy(rec);
            //         CurrPage.SetSelectionFilter(ShopifyOrder);
            //         ShopifyOrder.SetRange("Create to Sales Order", false);
            //         ShopifyOrder.SetRange(financial_status, 'paid');
            //         if ShopifyOrder.FindSet() then begin
            //             repeat
            //                 ShopifyFunction.CloseOrder(ShopifyOrder.id);
            //             until ShopifyOrder.Next() = 0;
            //             Message('Closed Order is successfully');
            //         end;
            //     end;
            // }

            // action(CancelOrder)
            // {
            //     Caption = 'Cancel Order';
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     ApplicationArea = Basic, Suite;
            //     Image = Payment;
            //     ToolTip = 'Executes the Cancel action.';
            //     trigger OnAction()
            //     var
            //         ShopifyOrder: Record "TPP Shopify Order";
            //         ShopifyFunction: Codeunit "TPP Shopify Function";
            //     begin
            //         if not Confirm('Do you want Cancel to Order?') then
            //             exit;
            //         ShopifyOrder.Copy(rec);
            //         CurrPage.SetSelectionFilter(ShopifyOrder);
            //         ShopifyOrder.SetRange("Create to Sales Order", false);
            //         ShopifyOrder.SetRange("Closed Order", false);
            //         ShopifyOrder.SetFilter(financial_status, '%1|%2', 'pending', 'unpaid', 'paid');
            //         if ShopifyOrder.FindSet() then begin
            //             repeat
            //                 ShopifyFunction.CancelOrder(ShopifyOrder.id);
            //             until ShopifyOrder.Next() = 0;
            //             Message('Cancel Order is successfully');
            //         end;
            //     end;
            // }
        }
    }
}
