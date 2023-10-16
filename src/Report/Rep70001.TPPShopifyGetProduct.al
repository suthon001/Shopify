/// <summary>
/// Report TPP Shopify Get Product (ID 70001).
/// </summary>
report 70001 "TPP Shopify Get Product"
{
    Caption = 'Shopify Get Product';
    ProcessingOnly = true;
    UsageCategory = None;
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Options';
                    field(gvProductIdFilter; ProductIdFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the ProductIdFilter field.';
                        Caption = 'Product ID Filter';
                    }
                    field(gvProductStatus; ProductStatus)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the StatusFilter field.';
                        Caption = 'Product Status Filter';
                    }

                    field(gvateTimeMethod; DateTimeMethod)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the DateTimeMethod field.';
                        Caption = 'Date Time Type';
                        OptionCaption = 'More,Less';
                    }
                    field(gvProductDateFilter; ProductDateFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the OrderAfterDate field.';
                        Caption = 'Product Date Filter';
                    }
                    field(gvProductTimeFilter; ProductTimeFilter)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the OrderAfterTime field.';
                        Caption = 'Product Time Filter';
                        trigger OnValidate()
                        begin
                            if ProductDateFilter = 0D then
                                ERROR('Product Date must specifies');
                        end;
                    }
                }
            }
        }

    }
    trigger OnPreReport()
    begin
        GetProduct();
    end;

    local procedure GetProduct()
    var
        ltShopifyConfig: Record "TPP Shopify Configuration";
        ShopifyFunction: Codeunit "TPP Shopify Function";
        ltTextFilter: text;
    begin
        CLEAR(ltTextFilter);

        ltShopifyConfig.GET();
        ltShopifyConfig.TestField("Limit Page");
        ltTextFilter := '?limit=' + format(ltShopifyConfig."Limit Page");
        if ProductStatus <> ProductStatus::any then
            ltTextFilter := ltTextFilter + '&status=' + format(ProductStatus);



        if ProductDateFilter <> 0D then
            if DateTimeMethod = DateTimeMethod::More then begin
                if ProductTimeFilter <> 0T then
                    ltTextFilter := ltTextFilter + '&created_at_min=>' + format(ProductDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T' + format(ProductTimeFilter, 0, '<Hours24>:<Minutes,2>:<Seconds,2>')
                else
                    ltTextFilter := ltTextFilter + '&created_at_min=>' + format(ProductDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:00:00';
            end else
                if ProductTimeFilter <> 0T then
                    ltTextFilter := ltTextFilter + '&created_at_min=<' + format(ProductDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T' + format(ProductTimeFilter, 0, '<Hours24>:<Minutes,2>:<Seconds,2>')
                else
                    ltTextFilter := ltTextFilter + '&created_at_min=<' + format(ProductDateFilter, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:00:00';
        if ProductIdFilter <> '' then
            ltTextFilter := ltTextFilter + '&ids=' + ProductIdFilter;

        ltTextFilter := ltTextFilter + '&order=created_at asc';

        ShopifyFunction.InsertToTable('GET', Database::"TPP Shopify Product", 'products.json' + ltTextFilter, 'products', 0);

    end;

    var
        ProductIdFilter: text;
        ProductDateFilter: date;
        ProductTimeFilter: time;
        DateTimeMethod: Option "More","Less";
        ProductStatus: Enum "TPP Shopify Product Status";
}
