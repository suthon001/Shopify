/// <summary>
/// Page TPP Shopify New Product(ID 70032).
/// </summary>
page 70032 "TPP Shopify New Product"
{
    Caption = 'Shopify New Product';
    PageType = Card;
    SourceTable = "TPP Shopify Product";
    UsageCategory = None;
    RefreshOnActivate = true;
    Extensible = false;
    InsertAllowed = false;
    SourceTableTemporary = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(title; Rec.title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the title field.';
                }
                field(vendor; Rec.vendor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the vendor field.';
                }
                field(product_type; Rec.product_type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the product_type field.';
                }
                field(tags; Rec.tags)
                {
                    ApplicationArea = All;
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
                            if rec.body_html <> '' then
                                CurrPage.EditCtl.Load(rec.body_html);
                            CurrPage.EditCtl.SetReadOnly(not CurrPage.Editable);
                        end;

                        trigger ContentChanged()
                        begin
                            CurrPage.EditCtl.RequestSave();
                        end;

                        trigger SaveRequested(data: Text[2047])
                        begin
                            rec.body_html := Data;
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

            part(ShopifyPic; "TPP Shopify Show Product Img 1")
            {
                ApplicationArea = all;
                SubPageLink = product_id = field(id);
                SubPageView = where(position = filter(1));
                Enabled = rec.id <> '';
                Caption = 'Position 1';
            }
            part(ShopifyPic_2; "TPP Shopify Show Product Img 2")
            {
                ApplicationArea = all;
                SubPageLink = product_id = field(id);
                SubPageView = where(position = filter(2));
                Enabled = rec.id <> '';
                Caption = 'Position 2';
            }
            part(ShopifyPic_3; "TPP Shopify Show Product Img 3")
            {
                ApplicationArea = all;
                SubPageLink = product_id = field(id);
                SubPageView = where(position = filter(3));
                Enabled = rec.id <> '';
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
        ltJsonArray: JsonArray;
    begin
        if Confirm('Do you want create new product to shopify ?') then begin
            rec.TestField(title);
            rec.TestField(body_html);
            rec.TestField(product_type);

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
            ltJsonObjectBuild.Add('title', rec.title);
            ltJsonObjectBuild.Add('body_html', rec.body_html);
            ltJsonObjectBuild.Add('product_type', rec.product_type);
            ltJsonObjectBuild.Add('vendor', rec.vendor);
            ltJsonObjectBuild.Add('tags', rec.tags);
            ltJsonObjectBuild.Add('variants', ltJsonArray);
            ALLJsonObjectBuild.Add('product', ltJsonObjectBuild);
            ALLJsonObjectBuild.WriteTo(ltJsonBody);
            ShopifyFunc.CreateNewProduct(ltJsonBody);
        end;
    end;

    var
        EditorReady: Boolean;
}
