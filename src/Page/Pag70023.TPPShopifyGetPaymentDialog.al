/// <summary>
/// Page TPP Shopify Get Payment Dialog (ID 70023).
/// </summary>
page 70023 "TPP Shopify Get Payment Dialog"
{
    Caption = 'Shopify Get Payment Dialog';
    PageType = ConfirmationDialog;
    layout
    {
        area(content)
        {

            field(OrderID; OrderID)
            {
                Caption = 'Order ID';
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Order ID field.';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ltShopifyOrder: Record "TPP Shopify Order";
                    ltShopifyOrderLists: Page "TPP Shopify Order Lists";
                begin
                    CLEAR(ltShopifyOrderLists);
                    ltShopifyOrder.reset();
                    ltShopifyOrder.SetRange("Create to Sales Order", true);
                    ltShopifyOrder.SetRange("Create to RV No.", '');
                    ltShopifyOrder.SetFilter("Posted Sales Invoice No.", '<>%1', '');
                    ltShopifyOrderLists.SetTableView(ltShopifyOrder);
                    ltShopifyOrderLists.Editable := false;
                    ltShopifyOrderLists.LookupMode := true;
                    if ltShopifyOrderLists.RunModal() = Action::LookupOK then begin
                        ltShopifyOrderLists.GetRecord(ltShopifyOrder);
                        OrderID := ltShopifyOrder.id;
                    end;
                    CLEAR(ltShopifyOrderLists);
                end;
            }

        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction In [Action::OK, Action::Yes] then
            GetPayment();
    end;

    local procedure GetPayment()
    var
        ShopifyFunction: Codeunit "TPP Shopify Function";
        ShopifyPaymentTransction: Record "TPP Shopify Pending RV";
    begin
        if OrderID = '' then begin
            Message('Order ID must specifies');
            exit;
        end;
        ShopifyPaymentTransction.reset();
        ShopifyPaymentTransction.SetRange("Create to RV No.", '');
        ShopifyPaymentTransction.DeleteAll();
        ShopifyFunction.InsertToTable('GET', Database::"TPP Shopify Pending RV", 'orders/' + OrderID + '/transactions.json', 'transactions', 1);
        Commit();
    end;

    var
        OrderID: code[50];
}
