/// <summary>
/// Page TPP Shopify Mapping Lists (ID 70014).
/// </summary>
page 70014 "TPP Shopify Mapping Lists"
{
    Caption = 'Shopify Mapping Lists';
    PageType = List;
    SourceTable = "TPP Shopify Mapping Field Head";
    Editable = false;
    RefreshOnActivate = true;
    ApplicationArea = all;
    UsageCategory = Administration;
    CardPageId = "TPP Shopify Mapping Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
        }
    }
}
