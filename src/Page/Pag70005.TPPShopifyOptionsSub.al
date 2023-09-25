/// <summary>
/// Page TPP Shopify Options Sub. (ID 70005).
/// </summary>
page 70005 "TPP Shopify Options Sub."
{
    Caption = 'Shopify Options Sub.';
    PageType = ListPart;
    SourceTable = "TPP Shopify Options";
    UsageCategory = None;
    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(name; Rec.name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the name field.';
                }
                field(position; Rec.position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the position field.';
                }
                field(values; Rec.values)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the values field.';
                }
            }
        }
    }
}
