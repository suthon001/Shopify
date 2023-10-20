/// <summary>
/// Page TPP Shopify New Product Img3(ID 70036).
/// </summary>
page 70036 "TPP Shopify New Product Img3"
{
    Caption = 'Shopify New Product Img';
    PageType = CardPart;
    SourceTable = "TPP Shopify Image";
    SourceTableTemporary = true;
    Extensible = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signature field.';
                }
            }

        }

    }
    actions
    {
        area(processing)
        {
            action(IPicture)
            {
                ApplicationArea = All;
                Caption = 'Import Picture';
                Image = Import;
                ToolTip = 'Import a picture file.';
                trigger OnAction()
                begin
                    ImportPicture();
                end;
            }
            action(DeleteSignatureAction)
            {
                ApplicationArea = All;
                Caption = 'Delete Picture';
                Image = Import;
                ToolTip = 'Delete a picture file.';
                Enabled = rec.id <> '';
                trigger OnAction()
                begin
                    DeletePicture();
                end;
            }
        }
    }
    /// <summary>
    /// ImportFromDevice.
    /// </summary>
    procedure ImportPicture()
    begin

        CreateNewProductViaImage();
    end;

    /// <summary>
    /// DeleteSignature.
    /// </summary>
    procedure DeletePicture()
    begin

        rec.Delete();
    end;

    /// <summary>
    /// GetLines.
    /// </summary>
    /// <param name="pBase64Text">VAR Text.</param>
    procedure GetLines(var pBase64Text: Text)
    begin
        pBase64Text := gvBase64Text;
    end;

    /// <summary>
    /// CreateNewProductViaImage.
    /// </summary>
    procedure CreateNewProductViaImage()
    var
        Base64Convert: codeunit "Base64 Convert";
        ltFileName: text;
        ltInstream, ltInstream2 : InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
    begin
        if UploadIntoStream('Select Picture', '', '', ltFileName, ltInstream) then
            if ltFileName <> '' then begin

                gvBase64Text := Base64Convert.ToBase64(ltInstream);
                TempBlob.CreateOutStream(OutStr);
                Base64Convert.FromBase64(gvBase64Text, OutStr);
                rec.Init();
                rec.product_id := '3';
                rec.id := '3';
                TempBlob.CreateInStream(ltInstream2);
                rec.Picture.IMPORTSTREAM(ltInstream2, 'Picture 3');
                rec.Insert();
                CurrPage.Update();
            end;

    end;

    var
        gvBase64Text: Text;

}
