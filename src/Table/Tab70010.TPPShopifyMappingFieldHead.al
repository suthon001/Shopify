/// <summary>
/// Table TPP Shopify Mapping Field Head (ID 70010).
/// </summary>
table 70010 "TPP Shopify Mapping Field Head"
{
    Caption = 'Shopify Mapping Field Header';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; "Type"; Enum "TPP Shopify Mapping Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                rec.Description := format(rec.Type) + ' Mapping';
            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Type")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        rec.TestField(Type);
    end;

    trigger OnRename()
    begin
        ERROR('Cannot Rename');
    end;

    trigger OnDelete()
    var
        ShopifyMappingLine: Record "TPP Shopify Mapping Field Line";
    begin
        ShopifyMappingLine.reset();
        ShopifyMappingLine.SetRange(Type, rec.Type);
        ShopifyMappingLine.DeleteAll();
    end;
}
