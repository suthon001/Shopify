/// <summary>
/// Page TPP Shopify Config. Setup (ID 70000).
/// </summary>
page 70000 "TPP Shopify Config. Setup"
{
    Caption = 'Shop';
    PageType = Card;
    SourceTable = "TPP Shopify Configuration";
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = Basic, Suite;
    Extensible = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(code; Rec.code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                    ShowMandatory = true;
                }
                field("Shopify URL"; Rec."Shopify URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopify URL field.';
                    ShowMandatory = true;
                }
                field("API Version"; Rec."API Version")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the API Version field.';
                    ShowMandatory = true;
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of theEnabled field.';
                }
                field("Limit Page"; Rec."Limit Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the API Limit Page field.';

                }
            }
            group(OrderInformation)
            {
                Caption = 'Order Information';

                field("Order Nos."; Rec."Order Nos.")
                {
                    Caption = 'Order No. Series';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Order Nos. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Defualt Customer No.';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Defualt Location Code';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }

            }
            group(CreateToCashReceipt)
            {
                Caption = 'Cash Receipt Information';
                field("Journal Template Name"; Rec."Journal Template Name")
                {

                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Journal Template Name field.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {

                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Journal Batch Name field.';
                }
                field("Journal No. Series"; Rec."Journal No. Series")
                {

                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Journal No. Series field.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Bank Account No. field.';
                }
                field("Fee Account No."; Rec."Fee Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the ค่าธรรมเนียม field.';
                }
                field("Discount Account No."; Rec."Discount Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the ส่วนลด field.';
                }
                field("Shipping Account No."; Rec."Shipping Account No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the ค่าขนส่ง field.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Connection)
            {
                Caption = 'Connection to Shop';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = TestDatabase;
                ToolTip = 'Executes the Connection action.';
                trigger OnAction()
                var
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                    ltRespones: Text;
                begin
                    if ShopifyFunction.TESTConnect('shop.json', ltRespones) then
                        Message('%1', ltRespones)
                    else
                        Message('%1', ltRespones);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.Reset();
        if not rec.Get() then begin
            rec.Init();
            rec.Insert();
        end;
    end;
}
