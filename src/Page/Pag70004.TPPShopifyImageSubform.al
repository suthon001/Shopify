/// <summary>
/// Page TPP Shopify Image Subform (ID 70004).
/// </summary>
page 70004 "TPP Shopify Image Subform"
{
    Caption = 'Shopify Image Subform';
    PageType = ListPart;
    SourceTable = "TPP Shopify Image";
    UsageCategory = None;
    Extensible = false;
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
                field(position; Rec.position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the position field.';
                }

                field(width; Rec.width)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the width field.';
                }
                field(height; Rec.height)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the height field.';
                }
                field(src; Rec.src)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the src field.';
                }
                field(created_at; Rec.created_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the created_at field.';
                }
            }
        }
    }
}
