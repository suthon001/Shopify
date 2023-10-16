/// <summary>
/// Report TPP Shopify Get Orders (ID 70000).
/// </summary>
report 70000 "TPP Shopify Get Orders"
{
    Caption = 'Shopify Sync Orders';
    ProcessingOnly = true;
    UsageCategory = None;
    Extensible = false;
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Options';
                    field(gvOrderIDFilter; OrderIDFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the OrderIDFilter field.';
                        Caption = 'Order ID Filter';
                    }
                    field(gvStatusFilter; StatusFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the StatusFilter field.';
                        Caption = 'Order Status Filter';

                    }
                    field(gvfinancialStatusFilter; financialStatusFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the financialStatusFilter field.';
                        Caption = 'Order Fianacial Status Filter';
                    }
                    field(gvFulfillmentStatusFilter; FulfillmentStatusFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the FulfillmentStatusFilter field.';
                        Caption = 'Order Fulfillment Status Filter';
                    }
                    field(gvDateTimeMethod; DateTimeMethod)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the DateTimeMethod field.';
                        Caption = 'Date Time Type';
                        OptionCaption = 'More,Less';
                    }
                    field(gvOrderDateFilter; OrderDateFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the OrderAfterDate field.';
                        Caption = 'Order Date Filter';
                    }
                    field(gvOrderTimeFilter; OrderTimeFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the OrderAfterTime field.';
                        Caption = 'Order Time Filter';
                        trigger OnValidate()
                        begin
                            if OrderDateFilter = 0D then
                                ERROR('Order Date must specifies');
                        end;
                    }
                }
            }
        }

    }
    trigger OnPreReport()
    begin
        GetOrder();
    end;

    local procedure GetOrder()
    var
        ltShopifyOrder: Record "TPP Shopify Order";
        ltShopifyConfig: Record "TPP Shopify Configuration";
        ShopifyFunction: Codeunit "TPP Shopify Function";
        ltTextFilter, ltTextFilterWithoutSince : text;
    begin

        CLEAR(ltTextFilter);
        ltShopifyConfig.GET();
        ltShopifyConfig.TestField("Limit Page");
        ltTextFilter := '?limit=' + format(ltShopifyConfig."Limit Page");
        ltTextFilter := ltTextFilter + '&status=' + format(StatusFilter);
        ltTextFilter := ltTextFilter + '&financial_status=' + format(financialStatusFilter);
        ltTextFilter := ltTextFilter + '&fulfillment_status=' + format(FulfillmentStatusFilter);

        if OrderDateFilter <> 0D then
            if DateTimeMethod = DateTimeMethod::More then begin
                if OrderTimeFilter <> 0T then
                    ltTextFilter := ltTextFilter + '&created_at_min=>' + format(OrderDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T' + format(OrderTimeFilter, 0, '<Hours24>:<Minutes,2>:<Seconds,2>')
                else
                    ltTextFilter := ltTextFilter + '&created_at_min=>' + format(OrderDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:00:00';
            end else
                if OrderTimeFilter <> 0T then
                    ltTextFilter := ltTextFilter + '&created_at_min=<' + format(OrderDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T' + format(OrderTimeFilter, 0, '<Hours24>:<Minutes,2>:<Seconds,2>')
                else
                    ltTextFilter := ltTextFilter + '&created_at_min=<' + format(OrderDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:00:00';

        ltTextFilterWithoutSince := ltTextFilter;
        if OrderIDFilter <> '' then
            ltTextFilter := ltTextFilter + '&ids=' + OrderIDFilter;


        ltShopifyOrder.reset();
        ltShopifyOrder.SetRange("Create to Sales Order", false);
        ltShopifyOrder.SetRange("Closed Order", false);
        ltShopifyOrder.DeleteAll(true);
        ltTextFilter := ltTextFilter + '&order=created_at asc';
        ShopifyFunction.InsertToTable('GET', Database::"TPP Shopify Order", 'orders.json' + ltTextFilter, 'orders', 0);

    end;

    var
        OrderIDFilter: Code[50];
        StatusFilter: Enum "TPP Shopify Order Status";
        financialStatusFilter: Enum "TPP Shopify Financial Status";
        FulfillmentStatusFilter: Enum "TPP Shopify Fulfillment Status";
        OrderDateFilter: Date;
        OrderTimeFilter: Time;
        DateTimeMethod: Option "More","Less";
}
