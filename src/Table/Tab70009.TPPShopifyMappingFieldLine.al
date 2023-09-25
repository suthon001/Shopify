/// <summary>
/// Table TPP Shopify Mapping Field Line (ID 70009).
/// </summary>
table 70009 "TPP Shopify Mapping Field Line"
{
    Caption = 'Shopify Mapping Field Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Type"; Enum "TPP Shopify Mapping Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(2; "BC Field"; Integer)
        {
            Caption = 'BC Field';
            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                ltPageControl: record "Page Control Field";
                ltPageLists: Page "TPP Shopify Control Field";
                ltPageNo: Integer;

            begin
                if rec.Type = rec.Type::Item then
                    ltPageNo := page::"Item Card";
                if rec.Type = rec.Type::Variant then
                    ltPageNo := page::"Item Variants";
                CLEAR(ltPageLists);
                ltPageControl.reset();
                ltPageControl.SetCurrentKey(TableNo, FieldNo);
                ltPageControl.SetRange(PageNo, ltPageNo);
                ltPageControl.SetFilter(FieldNo, '<>%1', 0);
                ltPageLists.SetTableView(ltPageControl);
                ltPageLists.LookupMode := true;
                if ltPageLists.RunModal() = Action::LookupOK then begin
                    ltPageLists.GetRecord(ltPageControl);
                    rec.Validate("BC Field", ltPageControl.FieldNo);
                end;
                CLEAR(ltPageLists);
            end;

            trigger OnValidate()
            var
                ltFieldName: Record Field;
                ltTableID: Integer;
            begin
                if rec.Type = rec.Type::Item then
                    ltTableID := Database::Item;
                if rec.Type = rec.Type::Variant then
                    ltTableID := Database::"Item Variant";
                if not ltFieldName.GET(ltTableID, rec."BC Field") then
                    ltFieldName.Init();
                rec."BC Field Name" := ltFieldName.FieldName;
                rec."BC Field Len" := format(ltFieldName.Len);
                rec."BC Field Type" := format(ltFieldName.Type);
                rec.IsPartOfPrimaryKey := ltFieldName.IsPartOfPrimaryKey;

            end;
        }
        field(3; "Shopify Field"; Integer)
        {
            Caption = 'Shopify Field';
            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                ltPageControl: record "Page Control Field";
                ltPageLists: Page "TPP Shopify Control Field";
                ltPageNo: Integer;

            begin
                if rec.Type = rec.Type::Item then
                    ltPageNo := page::"TPP Shopify Product Card";
                if rec.Type = rec.Type::Variant then
                    ltPageNo := page::"TPP Shopify Variants Subform";
                ltPageControl.reset();
                ltPageControl.SetCurrentKey(TableNo, FieldNo);
                ltPageControl.SetRange(PageNo, ltPageNo);
                ltPageControl.SetFilter(FieldNo, '<>%1', 0);
                ltPageLists.SetTableView(ltPageControl);
                ltPageLists.LookupMode := true;
                if ltPageLists.RunModal() = Action::LookupOK then begin
                    ltPageLists.GetRecord(ltPageControl);
                    rec.Validate("Shopify Field", ltPageControl.FieldNo);
                end;
                CLEAR(ltPageLists);
            end;

            trigger OnValidate()
            var
                ltFieldName: Record Field;
                ltTableID: Integer;
            begin
                if rec.Type = rec.Type::Item then
                    ltTableID := Database::"TPP Shopify Product";
                if rec.Type = rec.Type::Variant then
                    ltTableID := Database::"TPP Shopify Variants";
                if not ltFieldName.GET(ltTableID, rec."Shopify Field") then
                    ltFieldName.Init();
                rec."Shopify Field Name" := ltFieldName.FieldName;

            end;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "BC Field Type"; Text[50])
        {
            Caption = 'Field Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "BC Field Len"; Text[50])
        {
            Caption = 'Field Len';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "BC Field Name"; Text[80])
        {
            Caption = 'BC Field Name';
            DataClassification = CustomerContent;
        }
        field(8; "Shopify Field Name"; Text[80])
        {
            Caption = 'Shopify Field Name';
            DataClassification = CustomerContent;
        }
        field(9; "IsPartOfPrimaryKey"; Boolean)
        {
            Caption = 'IsPartOfPrimaryKey';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Type", "BC Field")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        rec.TestField(Type);
    end;
}
