/// <summary>
/// Page TPP Shopify fulfill Services (ID 70031).
/// </summary>
page 70031 "TPP Shopify fulfill. Services"
{
    ApplicationArea = All;
    Caption = 'Shopify fulfillment Services';
    PageType = List;
    SourceTable = "TPP Shopify fulfillment Ser.";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
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
                field(service_name; Rec.service_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the service_name field.';
                }
                field(handle; Rec.handle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the handle field.';
                }
                field(fulfillment_orders_opt_in; Rec.fulfillment_orders_opt_in)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the fulfillment_orders_opt_in field.';
                }
                field(include_pending_stock; Rec.include_pending_stock)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the include_pending_stock field.';
                }
                field(provider_id; Rec.provider_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the callback_url field.';
                }
                field(location_id; Rec.location_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the location_id field.';
                }
                field(callback_url; Rec.callback_url)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the callback_url field.';
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
            action(CreateCarrierService)
            {
                Caption = 'Create fulfillment Service';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Add;
                ToolTip = 'Executes the Create fulfillment Service action.';
                trigger OnAction()
                var
                    ShopifyAddCerrierSer: Page "TPP Shopify Add fulfill. Ser.";
                begin
                    CLEAR(ShopifyAddCerrierSer);
                    ShopifyAddCerrierSer.RunModal();
                    CLEAR(ShopifyAddCerrierSer);
                end;
            }
            action(GetfulfillmentService)
            {
                Caption = 'Get fulfillment Service';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = GetActionMessages;
                ToolTip = 'Executes the Get fulfillment Service action.';
                trigger OnAction()
                var
                    ShopifyfulfillmentService: Record "TPP Shopify fulfillment Ser.";
                    ShopifyFunction: Codeunit "TPP Shopify Function";

                begin
                    ShopifyfulfillmentService.reset();
                    ShopifyfulfillmentService.DeleteAll();
                    Commit();
                    ShopifyFunction.InsertToTable('GET', Database::"TPP Shopify fulfillment Ser.", 'fulfillment_services.json?scope=all', 'fulfillment_services', 0);
                    CurrPage.Update();
                end;
            }
            action(DeleteCarrierService)
            {
                Caption = 'Delete';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Image = Delete;
                ToolTip = 'Executes the Delete action.';
                trigger OnAction()
                var
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                    DeleteImageQst: Label 'Are you sure you want to delete the fulfillment Service?';
                    ltJsonObject: JsonObject;
                begin
                    if rec.id = '' then
                        exit;
                    if not Confirm(DeleteImageQst) then
                        exit;
                    ShopifyFunction.ConnectTOShopify('DELETE', 'fulfillment_services/' + rec.id + '.json', ltJsonObject);
                    rec.Delete();
                end;
            }

        }
    }
}
