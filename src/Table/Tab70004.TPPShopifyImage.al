/// <summary>
/// Table TPP Shopify Image (ID 70004).
/// </summary>
table 70004 "TPP Shopify Image"
{
    Caption = 'Shopify Image';
    DataClassification = CustomerContent;
    Extensible = false;
    fields
    {
        field(1; product_id; code[50])
        {
            Caption = 'product_id';
            DataClassification = CustomerContent;
        }
        field(2; id; code[50])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(3; position; Integer)
        {
            Caption = 'position';
            DataClassification = CustomerContent;
        }
        field(5; created_at; DateTime)
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
        }
        field(6; "width"; Integer)
        {
            Caption = 'width';
            DataClassification = CustomerContent;
        }
        field(7; "height"; Integer)
        {
            Caption = 'width';
            DataClassification = CustomerContent;
        }
        field(8; src; Text[2047])
        {
            Caption = 'src';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if rec.src <> '' then
                    ImportItemPictureFromURL()
                else
                    clear(Picture);
            end;
        }
        field(9; admin_graphql_api_id; Text[2047])
        {
            Caption = 'admin_graphql_api_id';
            DataClassification = CustomerContent;
        }
        field(10; Picture; MediaSet)
        {
            Caption = 'Picture';
            DataClassification = CustomerContent;

        }


    }
    keys
    {
        key(PK; product_id, id)
        {
            Clustered = true;
        }
    }
    /// <summary>
    /// ImportItemPictureFromURL.
    /// </summary>
    procedure ImportItemPictureFromURL()
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        InStr: InStream;
    begin
        if Client.Get(src, Response) then begin
            Response.Content.ReadAs(InStr);
            Clear(Picture);
            rec.Picture.ImportStream(InStr, 'Picture');
        end;
    end;
}
