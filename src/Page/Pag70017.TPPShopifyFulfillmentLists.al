/// <summary>
/// Page TPP Shopify Fulfillment Lists (ID 70017).
/// </summary>
page 70017 "TPP Shopify Fulfillment Lists"
{
    Caption = 'Shopify Fulfillment Lists';
    PageType = List;
    SourceTable = "TPP Shopify Fulfillment Header";
    Editable = false;
    RefreshOnActivate = true;
    UsageCategory = None;
    CardPageId = "TPP Shopify Fulfillment Card";
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
                field(order_id; Rec.order_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the order_id field.';
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the status field.';
                }
                field(name; Rec.name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the name field.';
                }
                field(created_at; Rec.created_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the created_at field.';
                }
                field(service; Rec.service)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the service field.';
                }
                field(updated_at; Rec.updated_at)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the updated_at field.';
                }
                field(tracking_company; Rec.tracking_company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tracking_company field.';
                }
                field(shipment_status; Rec.shipment_status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the shipment_status field.';
                }
                field(location_id; Rec.location_id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the destination.address1 field.';
                }
                field(origin_address; Rec.origin_address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the origin_address field.';
                }
                field(tracking_number; Rec.tracking_number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tracking_number field.';
                }
                field(tracking_numbers; Rec.tracking_numbers)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tracking_numbers field.';
                }
                field(tracking_url; Rec.tracking_url)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tracking_url field.';
                }
                field(tracking_urls; Rec.tracking_urls)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the tracking_urls field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateFulfillment)
            {
                Caption = 'Create Fulfillment';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Post;
                ApplicationArea = all;
                ToolTip = 'Executes the Create Fulfillment action.';
                trigger OnAction()
                var
                    Shopifyaddfulfillment: Page "TPP Shopify Add Fulfillment";
                begin
                    rec.TestField(Rec.order_id);
                    rec.TestField(rec.id);
                    CLEAR(Shopifyaddfulfillment);
                    Shopifyaddfulfillment.SetOrderID(rec.order_id);
                    Shopifyaddfulfillment.RunModal();
                    CLEAR(Shopifyaddfulfillment);
                end;
            }
        }
    }
}
