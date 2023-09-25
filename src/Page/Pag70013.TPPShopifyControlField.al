/// <summary>
/// Page TPP Shopify Control Field (ID 70013).
/// </summary>
page 70013 "TPP Shopify Control Field"
{
    Caption = 'Shopify Control Field';
    PageType = List;
    SourceTable = "Page Control Field";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(gvPageMetadata_Name; gvPageMetadata.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FieldNo field.';
                    Editable = false;
                    Caption = 'Page Name';
                }

                field(FieldNo; Rec.FieldNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FieldNo field.';
                    Editable = false;
                    Caption = 'Field No.';
                }
                field(FieldName; gvFieldType."Field Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FieldNo field.';
                    Editable = false;
                    Caption = 'Field Name';
                }

            }
        }
    }
    trigger OnAfterGetRecord()

    begin
        if not gvFieldType.GET(rec.TableNo, rec.FieldNo) then
            gvFieldType.Init();
        if not gvPageMetadata.GET(rec.PageNo) then
            gvPageMetadata.Init();
    end;

    var
        gvFieldType: Record Field;
        gvPageMetadata: Record "Page Metadata";
}
