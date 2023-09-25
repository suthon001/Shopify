/// <summary>
/// Page TPP Shopify Role Activity (ID 70021).
/// </summary>
page 70021 "TPP Shopify Role Activity"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Cue";

    layout
    {
        area(content)
        {
            cuegroup(ShopifyProduct)
            {
                Caption = 'Product';

                field("Shopify Product"; Rec."Shopify Product")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "TPP Shopify Product Lists";
                    ToolTip = 'Specifies the value of the Shopify Product field.';
                }
            }
            cuegroup(ShopifyOrder)
            {
                Caption = 'Shopify Order';

                field("Shopify Order"; Rec."Shopify Order")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "TPP Shopify Order Lists";
                    ToolTip = 'Specifies the value of the Shopify Order field.';
                }

                field("Shopify Order not to Sales"; Rec."Shopify Order not to Sales")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "TPP Shopify Order Lists";
                    ToolTip = 'Specifies the value of the Shopify Order not to Sales Order field.';
                }
            }
            cuegroup(SalesOrder)
            {
                Caption = 'Shopify Sales Order';

                field("Shopify Sales Order Open"; Rec."Shopify Sales Order Open")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the value of the Shopify Sales Order Open field.';
                }

                field("Shopify Sales Order Pending"; Rec."Shopify Sales Order Pending")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the value of the Shopify Sales Order Pending field.';
                }
                field("Shopify Sales Order Released"; Rec."Shopify Sales Order Released")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the value of the Shopify Sales Order Released field.';
                }
            }
        }
    }
}
