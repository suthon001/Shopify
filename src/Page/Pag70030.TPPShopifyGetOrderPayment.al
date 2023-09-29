/// <summary>
/// Page TPP Shopify Get Order Payment (ID 70030).
/// </summary>
page 70030 "TPP Shopify Get Order Payment"
{
    Caption = 'Shopify Get Order Payment';
    PageType = List;
    SourceTable = "Sales Invoice Header";
    SourceTableView = where(Open = filter(true), "Ref. Shopify Order No." = filter(<> ''));
    UsageCategory = None;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the record.';
                    Caption = 'Invoice No.';
                }
                field("Ref. Shopify Order No."; Rec."Ref. Shopify Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shopify Order No. of the record.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer the invoice concerns.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name.';
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name 2 field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
                }
            }
        }
    }
}
