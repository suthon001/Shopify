/// <summary>
/// Page PP Shopify Add fulfill Ser. (ID 70032).
/// </summary>
page 70032 "TPP Shopify Add fulfill. Ser."
{
    Caption = 'Shopify Create fulfillment Service';
    PageType = List;
    SourceTable = "TPP Shopify fulfillment Ser.";
    UsageCategory = None;
    SourceTableTemporary = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(name; Rec.name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the name field.';
                }
                field(email; Rec.email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the email field.';
                }
                field(callback_url; Rec.callback_url)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the callback_url field.';
                }
                field(fulfillment_orders_opt_in; Rec.fulfillment_orders_opt_in)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillment_orders_opt_in field.';
                }
                field(tracking_support; Rec.tracking_support)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tracking_support field.';
                }
                field(inventory_management; Rec.inventory_management)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the inventory_management field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PostFulfillmentService)
            {
                Caption = 'Post Fulfillment Service';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = 'Executes the Post Fulfillment Service action.';
                trigger OnAction()
                var
                    ShopifyFulfillmentService: Record "TPP Shopify fulfillment Ser.";
                    ShopifyFulfillmentServiceTemp: Record "TPP Shopify fulfillment Ser." temporary;
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                begin
                    rec.reset();
                    ShopifyFulfillmentServiceTemp.Copy(rec, true);
                    if ShopifyFulfillmentServiceTemp.FindSet() then
                        repeat
                            ShopifyFulfillmentServiceTemp.TestField(name);
                            ShopifyFulfillmentServiceTemp.TestField(callback_url);
                        until ShopifyFulfillmentServiceTemp.Next() = 0;

                    ShopifyFulfillmentServiceTemp.reset();
                    if ShopifyFulfillmentServiceTemp.FindSet() then
                        repeat
                            ShopifyFunction.InsertNewFulfillmentService(ShopifyFulfillmentServiceTemp);
                        until ShopifyFulfillmentServiceTemp.Next() = 0;

                    ShopifyFulfillmentService.reset();
                    ShopifyFulfillmentService.DeleteAll();
                    ShopifyFunction.InsertToTable('GET', Database::"TPP Shopify fulfillment Ser.", 'fulfillment_services.json?scope=all', 'fulfillment_services', 0);
                    commit();
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.id := format(Random(10000));
    end;

}
