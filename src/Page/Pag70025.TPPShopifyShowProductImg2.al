/// <summary>
/// Page TPP Shopify Show Product Img 2 (ID 70025).
/// </summary>
page 70025 "TPP Shopify Show Product Img 2"
{
    Caption = 'Shopify Show Product Img';
    PageType = CardPart;
    SourceTable = "TPP Shopify Image";
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
    var
        ShopifyFunction: Codeunit "TPP Shopify Function";
    begin

        ShopifyFunction.UpdateProductImg(rec.product_id, rec.id, 2);

    end;

    /// <summary>
    /// DeleteSignature.
    /// </summary>
    procedure DeletePicture()
    var
        ShopifyFunction: Codeunit "TPP Shopify Function";
        DeleteImageQst: Label 'Are you sure you want to delete the Picture?';
    begin
        if rec.src = '' then
            exit;
        if not Confirm(DeleteImageQst) then
            exit;
        ShopifyFunction.DeleteImage(rec.product_id, rec.id, rec.src);
        rec.Delete();
    end;
}