/// <summary>
/// Page TPP Shopify Product Card (ID 70002).
/// </summary>
page 70002 "TPP Shopify Product Card"
{
    Caption = 'Shopify Product Card';
    PageType = Card;
    SourceTable = "TPP Shopify Product";
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
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
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
                field(created_at; Rec.created_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the created_at field.';
                }
                field(handle; Rec.handle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the handle field.';
                }
                field(updated_at; Rec.updated_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the updated_at field.';
                }
                field(published_at; Rec.published_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the published_at field.';
                }
                field(published_scope; Rec.published_scope)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the published_scope field.';
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Create Date field.';
                }
                field(tags; Rec.tags)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tags field.';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
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

            part(Shopifyvariant; "TPP Shopify Variants Subform")
            {
                Caption = 'Variants';
                SubPageLink = product_id = field(id);
                SubPageView = sorting(product_id, id);
                UpdatePropagation = Both;
                ApplicationArea = Basic, Suite;
            }
            part(ShopifyOptions; "TPP Shopify Options Sub.")
            {
                Caption = 'Option';
                SubPageLink = product_id = field(id);
                SubPageView = sorting(product_id, id);
                UpdatePropagation = Both;
                ApplicationArea = Basic, Suite;
            }
            part(ShopifyImage; "TPP Shopify Image Subform")
            {
                Caption = 'Image';
                SubPageLink = product_id = field(id);
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
                Caption = 'Position 1';
            }
            part(ShopifyPic_2; "TPP Shopify Show Product Img 2")
            {
                ApplicationArea = all;
                SubPageLink = product_id = field(id);
                SubPageView = where(position = filter(2));
                Caption = 'Position 2';
            }
            part(ShopifyPic_3; "TPP Shopify Show Product Img 3")
            {
                ApplicationArea = all;
                SubPageLink = product_id = field(id);
                SubPageView = where(position = filter(3));
                Caption = 'Position 3';
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action(DeleteProduct)
            {
                Caption = 'Delete Product';
                Image = DeleteQtyToHandle;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = 'Executes the Delete Product action.';
                trigger OnAction()
                var
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                    DeleteImageQst: Label 'Are you sure you want to delete the product?';
                begin
                    if not Confirm(DeleteImageQst) then
                        exit;
                    ShopifyFunction.DeleteProduct(rec.id);
                    rec.Delete(true);
                end;

            }
            action(UpdateStatus)
            {
                Caption = 'Update Status';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = 'Executes the Update Status action.';
                trigger OnAction()
                var
                    ShopifyUpdateStat: Page "TPP Shopify Update Status Item";
                begin
                    CLEAR(ShopifyUpdateStat);
                    ShopifyUpdateStat.SetFromStatus(rec.status, rec.id);
                    ShopifyUpdateStat.RunModal();
                    CLEAR(ShopifyUpdateStat);
                end;
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

    var
        EditorReady: Boolean;
}
