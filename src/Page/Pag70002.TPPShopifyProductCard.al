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
                field(admin_graphql_api_id; Rec.admin_graphql_api_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the admin_graphql_api_id field.';
                }
                field(body_html; Rec.body_html)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the body_html field.';
                    MultiLine = true;
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
    }
}
