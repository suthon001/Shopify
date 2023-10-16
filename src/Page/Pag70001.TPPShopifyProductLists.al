/// <summary>
/// Page TPP Shopify Product Lists (ID 70001).
/// </summary>
page 70001 "TPP Shopify Product Lists"
{
    ApplicationArea = All;
    Caption = 'Shopify Product Lists';
    PageType = List;
    SourceTable = "TPP Shopify Product";
    UsageCategory = Lists;
    CardPageId = "TPP Shopify Product Card";
    Editable = false;
    RefreshOnActivate = true;
    Extensible = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the id field.';
                }
                field("Create Date"; Rec."Create Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Create Date field.';
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetProduct)
            {
                Caption = 'Sync Product';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = GetOrder;
                ToolTip = 'Executes the Sync Product action.';

                trigger OnAction()
                var
                    GetProductDialog: Report "TPP Shopify Get Product";
                begin
                    CLEAR(GetProductDialog);
                    GetProductDialog.RunModal();
                    CLEAR(GetProductDialog);
                end;
            }
            action(GetLastInventory)
            {
                Caption = 'Inventory';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = GetActionMessages;
                Enabled = rec.id <> '';
                ToolTip = 'Executes the Sync Inventory action.';
                trigger OnAction()
                var
                    ShopifyInventory: Page "TPP Shopify Inventory";
                begin
                    CLEAR(ShopifyInventory);
                    ShopifyInventory.SetProductID(rec.id);
                    ShopifyInventory.RunModal();
                    CLEAR(ShopifyInventory);
                end;
            }
        }
    }
}
