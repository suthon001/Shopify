/// <summary>
/// Page TPP Shopify Mapping Card (ID 70015).
/// </summary>
page 70015 "TPP Shopify Mapping Card"
{
    Caption = 'Shopify Mapping Card';
    PageType = Card;
    SourceTable = "TPP Shopify Mapping Field Head";
    UsageCategory = None;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            Group(General)
            {
                Caption = 'General';

                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remark field.';
                }
            }
            part(MappingSubform; "TPP Shopify Mapping Subform")
            {
                Caption = 'Lines';
                UpdatePropagation = Both;
                SubPageLink = Type = field(Type);
                SubPageView = sorting(Type, "BC Field");
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
