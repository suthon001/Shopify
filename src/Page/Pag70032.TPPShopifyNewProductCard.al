/// <summary>
/// Page TPP Shopify New Product(ID 70032).
/// </summary>
page 70032 "TPP Shopify New Product"
{
    Caption = 'Shopify New Product';
    PageType = Card;
    UsageCategory = None;
    RefreshOnActivate = true;
    Extensible = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(gvtitle; gvtitle)
                {
                    ApplicationArea = All;

                    Caption = 'Title';
                    ToolTip = 'Specifies the value of the title field.';
                }
                field(gvvendor; gvvendor)
                {
                    Caption = 'Vendor';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vendor field.';
                }
                field(gvproduct_type; gvproduct_type)
                {
                    ApplicationArea = All;
                    Caption = 'Product Type';
                    ToolTip = 'Specifies the value of the product_type field.';
                }
                field(gvtags; gvtags)
                {
                    ApplicationArea = All;
                    Caption = 'Tags';
                    ToolTip = 'Specifies the value of the tags field.';
                }
                field(gvStats; gvStats)
                {
                    ApplicationArea = all;
                    OptionCaption = 'draft,active';
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the tags field.';

                }

                group(bodyHtml)
                {
                    Caption = 'Body HTML';
                    usercontrol(EditCtl; Wysiwyg)
                    {
                        ApplicationArea = all;
                        trigger ControlReady()
                        begin
                            CurrPage.EditCtl.Init();
                        end;

                        trigger OnAfterInit()
                        begin
                            EditorReady := true;
                            CurrPage.EditCtl.SetReadOnly(not CurrPage.Editable);
                        end;

                        trigger ContentChanged()
                        begin
                            CurrPage.EditCtl.RequestSave();
                        end;

                        trigger SaveRequested(data: Text[2047])
                        begin
                            HtmlBody := Data;
                        end;
                    }
                }
            }

            part(Shopifyvariant; "TPP Shopify New Variants")
            {
                Caption = 'Variants';
                SubPageView = sorting(product_id, id);
                UpdatePropagation = Both;
                ApplicationArea = Basic, Suite;
            }
        }
        area(FactBoxes)
        {

            part(ShopifyPic; "TPP Shopify New Product Img")
            {
                ApplicationArea = all;
                Caption = 'Position 1';
            }
            part(ShopifyPic_2; "TPP Shopify New Product Img2")
            {
                ApplicationArea = all;
                Caption = 'Position 2';
            }
            part(ShopifyPic_3; "TPP Shopify New Product Img3")
            {
                ApplicationArea = all;
                Caption = 'Position 3';
            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        if EditorReady then begin
            EditorReady := false;
            CurrPage.EditCtl.Init();
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [CloseAction::OK, CloseAction::Yes] then
            CreateProduct();
    end;

    local procedure CreateProduct()
    var
        Shopifyvariant: Record "TPP Shopify Variants" temporary;
        ShopifyFunc: Codeunit "TPP Shopify Function";
        ltJsonBody: Text;
        ltJsonObject, ltJsonObjectBuild, ALLJsonObjectBuild : JsonObject;
        ltJsonArray, ltJsonArrayImg : JsonArray;
        CheckImg: Boolean;
    begin
        if Confirm('Do you want create new product to shopify ?') then begin

            if gvTitle = '' then
                ERROR('title must have a value in Shopify : It cannot be zero or empty.');
            if gvVendor = '' then
                ERROR('Vendor must have a value in Shopify : It cannot be zero or empty.');
            if gvproduct_type = '' then
                ERROR('Product Type must have a value in Shopify : It cannot be zero or empty.');
            if HtmlBody = '' then
                ERROR('Body HTML must have a value in Shopify : It cannot be zero or empty.');

            CurrPage.Shopifyvariant.Page.GetLines(Shopifyvariant);
            if Shopifyvariant.FindSet() then
                repeat
                    Shopifyvariant.TestField(option1);
                    Shopifyvariant.TestField(price);
                    CLEAR(ltJsonObject);
                    ltJsonObject.Add('option1', Shopifyvariant.option1);
                    ltJsonObject.Add('price', Shopifyvariant.price);
                    ltJsonObject.Add('sku', Shopifyvariant.sku);
                    ltJsonArray.Add(ltJsonObject);
                until Shopifyvariant.Next() = 0
            else
                error('variant must specifies');

            CurrPage.ShopifyPic.Page.GetLines(Base64Text1);
            CurrPage.ShopifyPic_2.Page.GetLines(Base64Text2);
            CurrPage.ShopifyPic_3.Page.GetLines(Base64Text3);

            CheckImg := false;

            if Base64Text1 <> '' then begin
                CLEAR(ltJsonObject);
                ltJsonObject.Add('attachment', Base64Text1);
                ltJsonArrayImg.add(ltJsonObject);
                CheckImg := true;
            end;
            if Base64Text2 <> '' then begin
                CLEAR(ltJsonObject);
                ltJsonObject.Add('attachment', Base64Text2);
                ltJsonArrayImg.add(ltJsonObject);
                CheckImg := true;
            end;
            if Base64Text3 <> '' then begin
                CLEAR(ltJsonObject);
                ltJsonObject.Add('attachment', Base64Text3);
                ltJsonArrayImg.add(ltJsonObject);
                CheckImg := true;
            end;

            ltJsonObjectBuild.Add('title', gvTitle);
            ltJsonObjectBuild.Add('body_html', HtmlBody);
            ltJsonObjectBuild.Add('product_type', gvproduct_type);
            ltJsonObjectBuild.Add('vendor', gvVendor);
            ltJsonObjectBuild.Add('tags', gvtags);
            ltJsonObjectBuild.Add('variants', ltJsonArray);
            ltJsonObjectBuild.Add('status', Format(gvStats));
            if CheckImg then
                ltJsonObjectBuild.Add('images', ltJsonArrayImg);
            ALLJsonObjectBuild.Add('product', ltJsonObjectBuild);
            ALLJsonObjectBuild.WriteTo(ltJsonBody);
            ShopifyFunc.CreateNewProduct(ltJsonBody);
        end;
    end;

    var
        EditorReady: Boolean;
        HtmlBody, gvTitle, gvVendor, gvproduct_type, gvtags, Base64Text1, Base64Text2, Base64Text3 : Text;
        gvStats: Option "draft","active";
}
