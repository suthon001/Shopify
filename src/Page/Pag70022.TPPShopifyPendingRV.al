/// <summary>
/// Page TPP Shopify Pending RV (ID 70022).
/// </summary>
page 70022 "TPP Shopify Pending RV"
{
    Caption = 'Shopify Pending Cash Receipt';
    PageType = List;
    SourceTable = "TPP Shopify Pending RV";
    SourceTableView = where("Create to RV No." = filter(<> ''));
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(order_id; Rec.order_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the order_id field.';
                }
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(kind; Rec.kind)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the kind field.';
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
                field(created_at; Rec.created_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the created_at field.';
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
                field(parent_id; Rec.parent_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the parent_id field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Getpayment)
            {
                Caption = 'Get Payment';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Payment;
                ToolTip = 'Executes the Get Payment action.';
                trigger OnAction()
                var
                    GetPayment: Page "TPP Shopify Get Payment Dialog";
                begin
                    CLEAR(GetPayment);
                    GetPayment.RunModal();
                    CLEAR(GetPayment);
                end;
            }
            action(CreateRV)
            {
                Caption = 'Create to Cash Receipt';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Create;
                ToolTip = 'Executes theCreate to Cash Receipt action.';
                trigger OnAction()
                var
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                begin
                    rec.TestField(status, 'success');
                    if not Confirm('Do you want Create to Cash Receipt') then
                        exit;
                    ShopifyFunction.CreateToCashReceipt(rec.order_id, rec.id, rec.amount);
                end;
            }
        }
    }
}
