/// <summary>
/// Page TPP Shopify Mapping Subform (ID 70016).
/// </summary>
page 70016 "TPP Shopify Mapping Subform"
{
    Caption = 'Shopify Mapping Subform';
    PageType = ListPart;
    SourceTable = "TPP Shopify Mapping Field Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("BC Field"; Rec."BC Field")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Field field.';
                }
                field("BC Field Name"; Rec."BC Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BC Field Name field.';
                }
                field("Shopify Field"; Rec."Shopify Field")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopify Field field.';
                }
                field("Shopify Field Name"; Rec."Shopify Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shopify Field Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("BC Field Type"; Rec."BC Field Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field Type field.';
                }
                field("BC Field Len"; Rec."BC Field Len")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field Len field.';
                }
                field(IsPartOfPrimaryKey; Rec.IsPartOfPrimaryKey)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IsPartOfPrimaryKey field.';
                }

            }
        }
    }
}
