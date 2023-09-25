/// <summary>
/// Page TPP Shopify Fulfillment Card (ID 70018).
/// </summary>
page 70018 "TPP Shopify Fulfillment Card"
{
    Caption = 'Shopify Fulfillment Card';
    PageType = Card;
    SourceTable = "TPP Shopify Fulfillment Header";
    UsageCategory = None;
    RefreshOnActivate = true;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
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
            part(FulfillmentSub; "TPP Shopify Fulfillment Sub.")
            {
                Caption = 'Lines';
                UpdatePropagation = Both;
                SubPageLink = fulfillment_id = field(id);
                SubPageView = sorting(fulfillment_id, id);
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
