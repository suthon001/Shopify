/// <summary>
/// Page TPP Shopify Order Card (ID 70007).
/// </summary>
page 70007 "TPP Shopify Order Card"
{
    Caption = 'Shopify Order Card';
    PageType = Card;
    SourceTable = "TPP Shopify Order";
    UsageCategory = None;
    RefreshOnActivate = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    Extensible = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(order_number; Rec.order_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the order_number field.';
                }
                field("Tracking No."; Rec."Tracking No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tracking No. field.';
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
                field("customer.email"; Rec."customer.email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customer.email field.';
                }
                field("customer.phone"; Rec."customer.phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customer.phone field.';
                }
                field("customer.currency"; Rec."customer.currency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the customer.currency field.';
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Create Date field.';
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
                field(updated_at; Rec.updated_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the updated_at field.';
                }

            }
            part(ShopifySubform; "TPP Shopify Order Subform")
            {
                Caption = 'Lines';
                UpdatePropagation = Both;
                SubPageLink = order_number = field(order_number);
                ApplicationArea = Basic, Suite;
            }
            group(Billing)
            {
                Caption = 'Billing';
                field("billing_address.first_name"; Rec."billing_address.first_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address first_name field.';
                }
                field("billing_address.address1"; Rec."billing_address.address1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address address1 field.';
                }
                field("billing_address.phone"; Rec."billing_address.phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address phone field.';
                }
                field("billing_address.city"; Rec."billing_address.city")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address city field.';
                }
                field("billing_address.zip"; Rec."billing_address.zip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address zip field.';
                }
                field("billing_address.province"; Rec."billing_address.province")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address province field.';
                }
                field("billing_address.country"; Rec."billing_address.country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address country field.';
                }
                field("billing_address.last_name"; Rec."billing_address.last_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address last_name field.';
                }
                field("billing_address.address2"; Rec."billing_address.address2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address address2 field.';
                }
                field("billing_address.company"; Rec."billing_address.company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address company field.';
                }
                field("billing_address.name"; Rec."billing_address.name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address name field.';
                }
                field("billing_address.country_code"; Rec."billing_address.country_code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address country_code field.';
                }
                field("billing_address.province_code"; Rec."billing_address.province_code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the billing_address province_code field.';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("shipping_address.first_name"; Rec."shipping_address.first_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address first_name field.';
                }
                field("shipping_address.address1"; Rec."shipping_address.address1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address address1 field.';
                }
                field("shipping_address.phone"; Rec."shipping_address.phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address phone field.';
                }
                field("shipping_address.city"; Rec."shipping_address.city")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address city field.';
                }
                field("shipping_address.zip"; Rec."shipping_address.zip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address zip field.';
                }
                field("shipping_address.province"; Rec."shipping_address.province")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address province field.';
                }
                field("shipping_address.country"; Rec."shipping_address.country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address country field.';
                }
                field("shipping_address.last_name"; Rec."shipping_address.last_name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address last_name field.';
                }
                field("shipping_address.address2"; Rec."shipping_address.address2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address address2 field.';
                }
                field("shipping_address.company"; Rec."shipping_address.company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address company field.';
                }
                field("shipping_address.name"; Rec."shipping_address.name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address name field.';
                }
                field("shipping_address.country_code"; Rec."shipping_address.country_code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address country_code field.';
                }
                field("shipping_address.province_code"; Rec."shipping_address.province_code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipping_address province_code field.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
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

            action(CreateToSalesOrderFunc)
            {
                Caption = 'Create To Sales Order';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Payment;
                ToolTip = 'Executes the Create To Sales Order action.';
                trigger OnAction()
                begin
                    if not Confirm('Do you want create to Sales Order?') then
                        exit;
                    rec.TestField("Create to Sales Order", false);
                    rec.CreateToSalesOrder(rec.id);
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

            //     action(CloseSalesOrderFunc)
            //     {
            //         Caption = 'Close Order';
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         PromotedOnly = true;
            //         ApplicationArea = Basic, Suite;
            //         Image = Payment;
            //         ToolTip = 'Executes the Close Order action.';
            //         trigger OnAction()
            //         var

            //             ShopifyFunction: Codeunit "TPP Shopify Function";
            //         begin
            //             rec.TestField(financial_status, 'paid');
            //             if not Confirm('Do you want Close to Order?') then
            //                 exit;
            //             ShopifyFunction.CloseOrder(rec.id);
            //             Message('Closed Order is successfully');
            //         end;
            //     }

            //     action(CancelOrder)
            //     {
            //         Caption = 'Cancel Order';
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = true;
            //         PromotedOnly = true;
            //         ApplicationArea = Basic, Suite;
            //         Image = Payment;
            //         ToolTip = 'Executes the Cancel action.';
            //         trigger OnAction()
            //         var

            //             ShopifyFunction: Codeunit "TPP Shopify Function";
            //         begin
            //             if not (rec.financial_status in ['pending', 'unpaid']) then begin
            //                 Message('Status must be pending or unpaid only');
            //                 exit;
            //             end;
            //             if not Confirm('Do you want Cancel to Order?') then
            //                 exit;
            //             ShopifyFunction.CloseOrder(rec.id);
            //             Message('Calcen Order is successfully');
            //         end;
            //     }
        }
    }
}
