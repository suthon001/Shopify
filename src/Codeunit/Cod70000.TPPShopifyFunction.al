/// <summary>
/// Codeunit TPP Shopify Function (ID 70000).
/// </summary>
codeunit 70000 "TPP Shopify Function"
{

    /// <summary>
    /// CreateToCashReceipt.
    /// </summary>
    /// <param name="pOderID">code[50].</param>
    /// <param name="pTransactionID">code[50].</param>
    /// <param name="pAmount">Decimal.</param>
    procedure CreateToCashReceipt(pOderID: code[50]; pTransactionID: code[50]; pAmount: Decimal)
    var
        ltShopifyonfig: Record "TPP Shopify Configuration";
        ltShopifyPayment: Record "TPP Shopify Pending RV";
        ltShopifyOrder: record "TPP Shopify Order";
        GenJournalLine: Record "Gen. Journal Line";
        GemJournalTemp: Record "Gen. Journal Template";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ltDocumentNo: code[20];
        ltCurrDateTime: DateTime;
    begin
        ltShopifyonfig.GET();
        ltShopifyonfig.TestField("Journal Template Name");
        ltShopifyonfig.TestField("Journal Batch Name");
        ltShopifyonfig.TestField("Journal No. Series");
        ltShopifyonfig.TestField("Bank Account No.");
        ltCurrDateTime := CurrentDateTime();
        GemJournalTemp.GET(ltShopifyonfig."Journal Template Name");
        CustLedgerEntry.reset();
        CustLedgerEntry.SetRange("Ref. Shopify Order No.", pOderID);
        if CustLedgerEntry.FindFirst() then begin
            ltDocumentNo := NoSeriesMgt.GetNextNo(ltShopifyonfig."Journal No. Series", WorkDate(), true);
            GenJournalLine.Init();
            GenJournalLine."Journal Template Name" := ltShopifyonfig."Journal Template Name";
            GenJournalLine."Journal Batch Name" := ltShopifyonfig."Journal Batch Name";
            GenJournalLine."Line No." := GenJournalLine.ShopifyGenLastLine();
            GenJournalLine."Document No." := ltDocumentNo;
            GenJournalLine."Document Date" := TODAY();
            GenJournalLine."Posting Date" := TODAY();
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Source Code" := GemJournalTemp."Source Code";
            GenJournalLine.Insert();
            GenJournalLine.Validate("Account No.", CustLedgerEntry."Customer No.");
            GenJournalLine.Validate(Amount, -pAmount);
            GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
            GenJournalLine.Validate("Applies-to Doc. No.", CustLedgerEntry."Document No.");
            GenJournalLine."Ref. Shopify Order No." := pOderID;
            GenJournalLine.Modify();

            GenJournalLine.Init();
            GenJournalLine."Journal Template Name" := ltShopifyonfig."Journal Template Name";
            GenJournalLine."Journal Batch Name" := ltShopifyonfig."Journal Batch Name";
            GenJournalLine."Line No." := GenJournalLine.ShopifyGenLastLine();
            GenJournalLine."Document No." := ltDocumentNo;
            GenJournalLine."Document Date" := TODAY();
            GenJournalLine."Posting Date" := TODAY();
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"Bank Account";
            GenJournalLine."Source Code" := GemJournalTemp."Source Code";
            GenJournalLine.Insert();
            GenJournalLine.Validate("Account No.", ltShopifyonfig."Bank Account No.");
            GenJournalLine.Validate(Amount, pAmount);
            GenJournalLine."Ref. Shopify Order No." := pOderID;
            GenJournalLine.Modify();
            if ltShopifyPayment.GET(ltShopifyPayment."Transaction Type"::Payment, pOderID, pTransactionID) then begin
                ltShopifyPayment."Create to RV No." := ltDocumentNo;
                ltShopifyPayment."Create to RV DateTime" := ltCurrDateTime;
                ltShopifyPayment."Sales Invoice No." := CustLedgerEntry."Document No.";
                ltShopifyPayment.Modify();
            end;
            if ltShopifyOrder.GET(pOderID) then begin
                ltShopifyOrder."Create to RV No." := ltDocumentNo;
                ltShopifyOrder."Create to RV DateTime" := ltCurrDateTime;
                ltShopifyOrder.Modify();
            end;
        end else
            Message('cannot find invoice in customer ledger');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure OnBeforeDeleteAfterPostingSales(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        ltShopifyOrder: Record "TPP Shopify Order";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
            if ltShopifyOrder.GET(SalesHeader."Ref. Shopify Order No.") then begin
                ltShopifyOrder."Posted Sales Invoice No." := SalesInvoiceHeader."No.";
                ltShopifyOrder.Modify();
            end;

    end;

    /// <summary>
    /// FulfillmentOrder.
    /// </summary>
    /// <param name="pOrderID">Code[50].</param>
    procedure FulfillmentOrder(pOrderID: Code[50])
    begin
        InsertToTable('GET', Database::"TPP Shopify Fulfillment Header", 'orders/' + pOrderID + '/fulfillments.json', 'fulfillments', 0);
    end;

    /// <summary>
    /// GetTrackingNo.
    /// </summary>
    /// <param name="pOderID">code[50].</param>
    /// <returns>Return value of type text[100].</returns>
    procedure GetTrackingNo(pOderID: code[50]): text[100]
    var
        ltJsonObject, ltJsonObjectValue : JsonObject;
        ltJsonToken: JsonToken;
        ltObjectArr: JsonArray;
        ltLineNo: Integer;
        ltTrackinNo: Text;
    begin
        ConnectTOShopify('GET', 'orders/' + pOderID + '/fulfillments.json', ltJsonObject);
        ltTrackinNo := '';
        if ltJsonObject.SelectToken('$.fulfillments', ltJsonToken) then begin
            ltObjectArr := ltJsonToken.AsArray();
            for ltLineNo := 0 to ltObjectArr.Count - 1 do begin
                ltObjectArr.GET(ltLineNo, ltJsonToken);
                ltJsonObjectValue := ltJsonToken.AsObject();
                if StrPos(ltTrackinNo, SelectJsonTokenText(ltJsonObjectValue, '$.tracking_number')) = 0 then begin
                    if ltTrackinNo <> '' then
                        ltTrackinNo := ltTrackinNo + ',';
                    ltTrackinNo := ltTrackinNo + SelectJsonTokenText(ltJsonObjectValue, '$.tracking_number');
                end;
            end;

        end;
        exit(COPYSTR(ltTrackinNo, 1, 100));
    end;
    /// <summary>
    /// ClaseSalesOrder.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    procedure CloseOrder(pOrderID: code[50])
    var
        ltShopifyOrder: Record "TPP Shopify Order";
        ltJsonObject, ltJsonObjectValue : JsonObject;
        ltJsonToken: JsonToken;
        ltDateTime: DateTime;
    begin
        ConnectTOShopify('POST', 'orders/' + pOrderID + '/close.json', ltJsonObject);
        if ltJsonObject.SelectToken('$.order', ltJsonToken) then begin
            ltJsonObjectValue := ltJsonToken.AsObject();
            ltShopifyOrder.GET(pOrderID);
            ltShopifyOrder."Clased Order" := true;
            Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectValue, '$.closed_at'));
            ltShopifyOrder."Cloase Order at" := ltDateTime;
            ltShopifyOrder.modify();
        end;
    end;

    /// <summary>
    /// RefundOrder.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    procedure RefundOrder(pOrderID: code[50])
    var
        ltShopifyOrder: Record "TPP Shopify Order";
        ltJsonObject, ltJsonObjectValue : JsonObject;
        ltJsonToken: JsonToken;
    begin
        ConnectTOShopify('POST', 'orders/' + pOrderID + '/refunds.json', ltJsonObject);
        if ltJsonObject.SelectToken('$.refund', ltJsonToken) then begin
            ltJsonObjectValue := ltJsonToken.AsObject();
            ltShopifyOrder.GET(pOrderID);
            ltShopifyOrder.financial_status := 'refunded';
            ltShopifyOrder.modify();
        end;
    end;

    /// <summary>
    /// CancelOrder.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    procedure CancelOrder(pOrderID: code[50])
    var
        ltShopifyOrder: Record "TPP Shopify Order";
        ltJsonObject, ltJsonObjectValue : JsonObject;
        ltJsonToken: JsonToken;
    begin
        ConnectTOShopify('POST', 'orders/' + pOrderID + '/cancel.json', ltJsonObject);
        if ltJsonObject.SelectToken('$.order', ltJsonToken) then begin
            ltJsonObjectValue := ltJsonToken.AsObject();
            ltShopifyOrder.GET(pOrderID);
            ltShopifyOrder."Cancelled Order" := true;
            ltShopifyOrder."Cancelled at" := CurrentDateTime();
            ltShopifyOrder.modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(SalesLine: Record "Sales Line"; var ItemJnlLine: Record "Item Journal Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin
            ItemJnlLine."Ref. Shopify Order No." := SalesLine."Ref. Shopify Order No.";
            ItemJnlLine."Shopify Tracking No." := SalesHeader."Shopify Tracking No.";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var ItemJournalLine: Record "Item Journal Line"; var NewItemLedgEntry: Record "Item Ledger Entry")
    begin
        NewItemLedgEntry."Ref. Shopify Order No." := ItemJournalLine."Ref. Shopify Order No.";
        NewItemLedgEntry."Shopify Tracking No." := ItemJournalLine."Shopify Tracking No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."Ref. Shopify Order No." := SalesHeader."Ref. Shopify Order No.";
        GenJournalLine."Shopify Tracking No." := SalesHeader."Shopify Tracking No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnAfterInitCustLedgEntry(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgerEntry."Ref. Shopify Order No." := GenJournalLine."Ref. Shopify Order No.";
        CustLedgerEntry."Shopify Tracking No." := GenJournalLine."Shopify Tracking No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLine', '', false, false)]
    local procedure OnBeforeInsertInvLineFromShptLine(var SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesLine."Ref. Shopify Order No." := SalesShptLine."Ref. Shopify Order No.";
        SalesLine."Shopify Tracking No." := SalesShptLine."Shopify Tracking No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnInsertInvLineFromShptLineOnAfterInsertAllLines', '', false, false)]
    local procedure OnInsertInvLineFromShptLineOnAfterInsertAllLines(SalesShipmentLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line")
    var
        SalesShipmentHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Header";
    begin
        if SalesShipmentHeader.GET(SalesShipmentLine."Document No.") then
            if SalesInvoiceHeader.GET(SalesLine."Document Type", SalesLine."Document No.") then begin
                SalesInvoiceHeader."Ref. Shopify Order No." := SalesShipmentHeader."Ref. Shopify Order No.";
                SalesInvoiceHeader."Shopify Tracking No." := SalesShipmentHeader."Shopify Tracking No.";
                SalesInvoiceHeader.Modify();
            end;

    end;




    /// <summary>
    /// TESTConnect.
    /// </summary>
    /// <param name="pFind">Text.</param>
    procedure TESTConnect(pFind: Text)
    var
        ShopifyConfiguration: Record "TPP Shopify Configuration";
        ltUrl, gvResponseText : Text;
        ltJsonToken: JsonToken;
        ltJsonObject: JsonObject;
        ltResult: Text;
    begin
        ShopifyConfiguration.GET();
        ShopifyConfiguration.TestField("API Key");
        ShopifyConfiguration.TestField("API Version");
        ShopifyConfiguration.TestField("URL Address");
        ShopifyConfiguration.TestField("Shop ID");
        ltUrl := StrSubstNo(gvUrlAddress, ShopifyConfiguration."Shop ID", ShopifyConfiguration."URL Address", ShopifyConfiguration."API Version", pFind);
        CLEAR(gvHttpRequestMessage);
        CLEAR(gvHttpClient);
        CLEAR(gvHttpResponseMessage);
        CLEAR(gvHttpContent);
        CLEAR(gvHttpContentaddboydy);
        CLEAR(gvHttpHeadersContent);
        gvHttpHeadersContent := gvHttpClient.DefaultRequestHeaders();
        gvHttpHeadersContent.Add('X-Shopify-Access-Token', ShopifyConfiguration."API Key");
        gvHttpClient.Get(ltUrl, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        ltJsonToken.ReadFrom(gvResponseText);
        ltJsonObject := ltJsonToken.AsObject();
        if (gvHttpResponseMessage.IsSuccessStatusCode()) then begin
            ltResult := 'Shop ID : ' + SelectJsonTokenText(ltJsonObject, '$.shop.id');
            ltResult := ltResult + '\Shop Name : ' + SelectJsonTokenText(ltJsonObject, '$.shop.name');
            ltResult := ltResult + '\Shop Owner : ' + SelectJsonTokenText(ltJsonObject, '$.shop.shop_owner');
            ltResult := ltResult + '\Address : ' + SelectJsonTokenText(ltJsonObject, '$.shop.address1');
            ltResult := ltResult + '\Address 2 : ' + SelectJsonTokenText(ltJsonObject, '$.shop.address2');
            ltResult := ltResult + '\Province : ' + SelectJsonTokenText(ltJsonObject, '$.shop.province');
            ltResult := ltResult + '\Country : ' + SelectJsonTokenText(ltJsonObject, '$.shop.country');
            ltResult := ltResult + '\Phone : ' + SelectJsonTokenText(ltJsonObject, '$.shop.phone');
            ltResult := ltResult + '\E-Mail : ' + SelectJsonTokenText(ltJsonObject, '$.shop.email');
            Message(ltResult);
        end else begin
            ltResult := 'Error : ' + SelectJsonTokenText(ltJsonObject, '$.errors');
            Message(ltResult);
        end;
    end;

    /// <summary>
    /// InsertToTable.
    /// </summary>
    /// <param name="pMehotd">code[10],pTableID.</param>
    /// <param name="pTableID">Integer.</param>
    /// <param name="pFind">Text.</param>
    /// <param name="pSelectToken">Text.</param>
    /// <param name="pPayType">Option " ",Payment,Refund.</param>
    procedure InsertToTable(pMehotd: code[10]; pTableID: Integer; pFind: Text; pSelectToken: Text; pPayType: Option " ",Payment,Refund)
    var
        ShopifyOrder: Record "TPP Shopify Order";
        ShopifyConfig: Record "TPP Shopify Configuration";
        ltRecordRef: RecordRef;
        ltFieldRef: FieldRef;
        ltField: Record Field;
        ltJsonObject, ltJsonObjectValue : JsonObject;
        ltJsonArray: JsonArray;
        ltJsonToken, ltJsonTokenTax : JsonToken;
        ltmyLoop: Integer;
        ltDate: Date;
        ltDateTime: DateTime;
        ltFieldName, ltFilter : Text;
        ltCountLine: Integer;
        ltsinceID: code[50];

    begin
        ltCountLine := 0;
        ShopifyConfig.GET();
        ConnectTOShopify(pMehotd, pFind, ltJsonObject);
        if ltJsonObject.SelectToken('$.' + pSelectToken, ltJsonToken) then begin
            ltJsonArray := ltJsonToken.AsArray();
            ltRecordRef.Open(pTableID);
            for ltmyLoop := 0 to ltJsonArray.Count - 1 do begin
                ltCountLine := ltCountLine + 1;
                ltJsonArray.Get(ltmyLoop, ltJsonToken);
                ltJsonObjectValue := ltJsonToken.AsObject();
                ltField.reset();
                ltField.SetRange(TableNo, pTableID);
                ltField.SetRange("No.", 1, 99999);
                if ltField.FindSet() then begin
                    ltRecordRef.Init();
                    if pTableID = Database::"TPP Shopify Order Transaction" then
                        if pPayType = pPayType::Refund then begin
                            ltFieldRef := ltRecordRef.FieldIndex(1);
                            ltFieldRef.Value(1);
                        end else begin
                            ltFieldRef := ltRecordRef.FieldIndex(1);
                            ltFieldRef.Value(0);
                        end;
                    repeat
                        ltFieldName := ltField.FieldName;
                        if pSelectToken = 'orders' then
                            if ltFieldName = 'total_shipping_price_set' then
                                ltFieldName := 'total_shipping_price_set.shop_money.amount';
                        ltFieldRef := ltRecordRef.Field(ltField."No.");
                        if ltJsonObjectValue.SelectToken('$.' + ltFieldName, ltJsonTokenTax) then begin
                            if ltFieldRef.Type IN [ltFieldRef.Type::boolean] then
                                if UpperCase(SelectJsonTokenText(ltJsonObjectValue, '$.' + ltFieldName)) IN ['YES', 'TRUE'] then
                                    ltFieldRef.Validate(true)
                                else
                                    ltFieldRef.Validate(false);
                            if ltFieldRef.Type IN [ltFieldRef.Type::Text, ltFieldRef.Type::Code] then
                                ltFieldRef.Validate(SelectJsonTokenText(ltJsonObjectValue, '$.' + ltFieldName));
                            if ltFieldRef.Type = ltFieldRef.Type::Integer then
                                ltFieldRef.Validate(SelectJsonTokenInteger(ltJsonObjectValue, '$.' + ltFieldName));
                            if ltFieldRef.Type = ltFieldRef.Type::Decimal then
                                ltFieldRef.Validate(SelectJsonTokenDecimal(ltJsonObjectValue, '$.' + ltFieldName));
                            if ltFieldRef.Type = ltFieldRef.Type::Date then begin
                                Evaluate(ltDate, SelectJsonTokenText(ltJsonObjectValue, '$.' + ltFieldName));
                                ltFieldRef.Validate(ltDate);
                            end;
                            if ltFieldRef.Type = ltFieldRef.Type::DateTime then begin
                                Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectValue, '$.' + ltFieldName));
                                ltFieldRef.Validate(ltDateTime);
                            end;
                        end;
                    until ltField.Next() = 0;
                    if not ltRecordRef.insert() then
                        ltRecordRef.Modify();
                    if pSelectToken = 'products' then begin
                        ltsinceID := COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.id'), 1, 50);
                        InsertToDetailTable(Database::"TPP Shopify Variants", ltJsonObjectValue, 'variants', '');
                        InsertToDetailTable(Database::"TPP Shopify Options", ltJsonObjectValue, 'options', '');
                        InsertToDetailTable(Database::"TPP Shopify Image", ltJsonObjectValue, 'images', '');
                    end;
                    if pSelectToken = 'fulfillments' then
                        InsertToDetailTable(Database::"TPP Shopify Fulfillment Line", ltJsonObjectValue, 'line_items', COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.id'), 1, 50));
                    if pSelectToken = 'orders' then begin
                        ltsinceID := COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.id'), 1, 50);
                        InsertToDetailTable(Database::"TPP Shopify Order line", ltJsonObjectValue, 'line_items', COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.order_number'), 1, 50));
                        ShopifyOrder.GET(ltsinceID);
                        ShopifyOrder."Tracking No." := GetTrackingNo(ShopifyOrder.id);
                        ShopifyOrder.Modify();
                    end;
                end;
            end;
            ltRecordRef.Close();
        end;
        if ltCountLine = ShopifyConfig."Limit Page" then
            if ltsinceID <> '' then begin
                if StrPos(pFind, '&since_id') <> 0 then
                    ltFilter := COPYSTR(pFind, 1, StrPos(pFind, '&since_id') - 1)
                else
                    ltFilter := COPYSTR(pFind, 1, StrPos(pFind, '&order=created_at') - 1);

                ltFilter := ltFilter + '&since_id=' + ltsinceID;

                InsertToTable('GET', pTableID, ltFilter, pSelectToken, 0);
            end;

    end;


    /// <summary>
    /// InsertToRefundTable.
    /// </summary>
    /// <param name="pTableID">Integer.</param>
    /// <param name="pFind">Text.</param>
    /// <param name="pSelectToken">Text.</param>
    procedure InsertToRefundTable(pTableID: Integer; pFind: Text; pSelectToken: Text)
    var
        ltRecordRef: RecordRef;
        ltFieldRef: FieldRef;
        ltField: Record Field;
        ltJsonObject, ltJsonObjectValue, ltJsonObjectValueRefund : JsonObject;
        ltJsonArray, ltJsonArrayRefund : JsonArray;
        ltJsonToken, ltJsonTokenTax, ltJsonTokenRefund : JsonToken;
        ltmyLoop, ltmyLoopRefund : Integer;
        ltDate: Date;
        ltDateTime: DateTime;
        ltFieldName: Text;
    begin
        ConnectTOShopify('GET', pFind, ltJsonObject);
        if ltJsonObject.SelectToken('$.' + pSelectToken, ltJsonToken) then begin
            ltJsonArray := ltJsonToken.AsArray();
            ltRecordRef.Open(pTableID);
            for ltmyLoop := 0 to ltJsonArray.Count - 1 do begin
                ltJsonArray.Get(ltmyLoop, ltJsonToken);
                ltJsonObjectValue := ltJsonToken.AsObject();
                if ltJsonObjectValue.SelectToken('$.refund_line_items', ltJsonTokenRefund) then begin
                    ltJsonArrayRefund := ltJsonTokenRefund.AsArray();
                    for ltmyLoopRefund := 0 to ltJsonArrayRefund.Count - 1 do begin


                        ltRecordRef.Init();
                        ltFieldRef := ltRecordRef.Field(1);
                        ltFieldRef.Validate(SelectJsonTokenText(ltJsonObjectValue, '$.order_id'));
                        ltFieldRef := ltRecordRef.Field(2);
                        ltFieldRef.Validate(SelectJsonTokenText(ltJsonObjectValue, '$.id'));
                        ltFieldRef := ltRecordRef.Field(4);
                        ltFieldRef.Validate(SelectJsonTokenText(ltJsonObjectValue, '$.note'));
                        ltFieldRef := ltRecordRef.Field(3);
                        Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectValue, '$.created_at'));
                        ltFieldRef.Validate(ltDateTime);
                        ltFieldRef := ltRecordRef.Field(5);
                        Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectValue, '$.processed_at'));
                        ltFieldRef.Validate(ltDateTime);
                        ltFieldRef := ltRecordRef.Field(6);
                        if UpperCase(SelectJsonTokenText(ltJsonObjectValue, '$.restock')) IN ['YES', 'TRUE'] then
                            ltFieldRef.Validate(true)
                        else
                            ltFieldRef.Validate(false);


                        ltJsonArrayRefund.Get(ltmyLoopRefund, ltJsonTokenRefund);
                        ltJsonObjectValueRefund := ltJsonTokenRefund.AsObject();

                        ltField.reset();
                        ltField.SetRange(TableNo, pTableID);
                        ltField.SetRange("No.", 7, 99999);
                        if ltField.FindSet() then
                            repeat
                                ltFieldName := DelChr(ltField.FieldName, '=', 'refund_line_items.');
                                ltFieldRef := ltRecordRef.Field(ltField."No.");
                                if ltJsonObjectValueRefund.SelectToken('$.' + ltFieldName, ltJsonTokenTax) then begin
                                    if ltFieldRef.Type IN [ltFieldRef.Type::boolean] then
                                        if UpperCase(SelectJsonTokenText(ltJsonObjectValueRefund, '$.' + ltFieldName)) IN ['YES', 'TRUE'] then
                                            ltFieldRef.Validate(true)
                                        else
                                            ltFieldRef.Validate(false);
                                    if ltFieldRef.Type IN [ltFieldRef.Type::Text, ltFieldRef.Type::Code] then
                                        ltFieldRef.Validate(SelectJsonTokenText(ltJsonObjectValueRefund, '$.' + ltFieldName));
                                    if ltFieldRef.Type = ltFieldRef.Type::Integer then
                                        ltFieldRef.Validate(SelectJsonTokenInteger(ltJsonObjectValueRefund, '$.' + ltFieldName));
                                    if ltFieldRef.Type = ltFieldRef.Type::Decimal then
                                        ltFieldRef.Validate(SelectJsonTokenDecimal(ltJsonObjectValueRefund, '$.' + ltFieldName));
                                    if ltFieldRef.Type = ltFieldRef.Type::Date then begin
                                        Evaluate(ltDate, SelectJsonTokenText(ltJsonObjectValueRefund, '$.' + ltFieldName));
                                        ltFieldRef.Validate(ltDate);
                                    end;
                                    if ltFieldRef.Type = ltFieldRef.Type::DateTime then begin
                                        Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectValueRefund, '$.' + ltFieldName));
                                        ltFieldRef.Validate(ltDateTime);
                                    end;
                                end;
                            until ltField.Next() = 0;
                        if not ltRecordRef.insert() then
                            ltRecordRef.Modify();
                    end;
                end;

            end;
            ltRecordRef.Close();
        end;

    end;

    /// <summary>
    /// InsertToDetailTable.
    /// </summary>
    /// <param name="pTableID">Integer.</param>
    /// <param name="pSelectToken">Text.</param>
    local procedure InsertToDetailTable(pTableID: Integer; pJsonObject: JsonObject; pSelectToken: Text; pOrderNo: code[50])
    var
        ltRecordRef: RecordRef;
        ltFieldRef: FieldRef;
        ltField: Record Field;
        ltJsonObjectValue, ltJsonObjectValueTax : JsonObject;
        ltJsonArray, ltJsonArrayTax : JsonArray;
        ltJsonToken, ltJsonTokenTax : JsonToken;
        ltmyLoop: Integer;
        ltDate: Date;
        ltDateTime: DateTime;


    begin
        if pJsonObject.SelectToken('$.' + pSelectToken, ltJsonToken) then begin
            ltJsonArray := ltJsonToken.AsArray();
            ltRecordRef.Open(pTableID);
            for ltmyLoop := 0 to ltJsonArray.Count - 1 do begin
                ltJsonArray.Get(ltmyLoop, ltJsonToken);
                ltJsonObjectValue := ltJsonToken.AsObject();
                ltField.reset();
                ltField.SetRange(TableNo, pTableID);
                ltField.SetRange("No.", 1, 99999);
                if ltField.FindSet() then begin
                    ltRecordRef.Init();
                    if pOrderNo <> '' then begin
                        ltFieldRef := ltRecordRef.FieldIndex(1);
                        ltFieldRef.Validate(pOrderNo);
                    end;
                    repeat
                        ltFieldRef := ltRecordRef.Field(ltField."No.");
                        if ltJsonObjectValue.SelectToken('$.' + ltField.FieldName, ltJsonTokenTax) then begin
                            if ltFieldRef.Type IN [ltFieldRef.Type::boolean] then
                                if UpperCase(SelectJsonTokenText(ltJsonObjectValue, '$.' + ltField.FieldName)) IN ['YES', 'TRUE'] then
                                    ltFieldRef.Validate(true)
                                else
                                    ltFieldRef.Validate(false);

                            if ltFieldRef.Type IN [ltFieldRef.Type::Text, ltFieldRef.Type::Code] then
                                ltFieldRef.Validate(SelectJsonTokenText(ltJsonObjectValue, '$.' + ltField.FieldName));
                            if ltFieldRef.Type = ltFieldRef.Type::Integer then
                                ltFieldRef.Validate(SelectJsonTokenInteger(ltJsonObjectValue, '$.' + ltField.FieldName));
                            if ltFieldRef.Type = ltFieldRef.Type::Decimal then
                                ltFieldRef.Validate(SelectJsonTokenDecimal(ltJsonObjectValue, '$.' + ltField.FieldName));
                            if ltFieldRef.Type = ltFieldRef.Type::Date then begin
                                Evaluate(ltDate, SelectJsonTokenText(ltJsonObjectValue, '$.' + ltField.FieldName));
                                ltFieldRef.Validate(ltDate);
                            end;
                            if ltFieldRef.Type = ltFieldRef.Type::DateTime then begin
                                Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectValue, '$.' + ltField.FieldName));
                                ltFieldRef.Validate(ltDateTime);
                            end;
                        end;
                    until ltField.Next() = 0;
                    if pSelectToken = 'line_items' then
                        if ltJsonObjectValue.SelectToken('$.tax_lines', ltJsonTokenTax) then begin
                            ltJsonArrayTax := ltJsonTokenTax.AsArray();
                            if ltJsonArrayTax.Get(0, ltJsonTokenTax) then begin
                                ltJsonObjectValueTax := ltJsonTokenTax.AsObject();
                                ltFieldRef := ltRecordRef.Field(18);
                                ltFieldRef.Validate(SelectJsonTokenDecimal(ltJsonObjectValueTax, '$.price'));
                                ltFieldRef := ltRecordRef.Field(19);
                                ltFieldRef.Validate(SelectJsonTokenDecimal(ltJsonObjectValueTax, '$.rate'));
                                ltFieldRef := ltRecordRef.Field(20);
                                ltFieldRef.Validate(SelectJsonTokenText(ltJsonObjectValueTax, '$.title'));
                            end;
                        end;
                    if not ltRecordRef.insert() then
                        ltRecordRef.Modify();
                end;
            end;
            ltRecordRef.Close();
        end;

    end;


    local procedure SelectJsonTokenText(JsonObject: JsonObject; Path: text): text;
    var
        ltJsonToken: JsonToken;
        ltText: Text;
    begin

        if not JsonObject.SelectToken(Path, ltJsonToken) then
            exit('');
        if Format(ltJsonToken) <> '' then begin
            ltText := Format(ltJsonToken);
            if CopyStr(ltText, 1, 1) = '[' then begin
                ltText := delchr(ltText, '=', '[]');
                exit(ltText);
            end;
        end;
        if ltJsonToken.AsValue().IsNull then
            exit('');
        exit(ltJsonToken.asvalue().astext());
    end;

    local procedure SelectJsonTokenDecimal(JsonObject: JsonObject; Path: text): Decimal;
    var
        ltJsonToken: JsonToken;
        ConvertTextToDecimal: Decimal;
        DecimalText: Text;
    begin

        if not JsonObject.SelectToken(Path, ltJsonToken) then
            exit(0);
        if ltJsonToken.AsValue().IsNull then
            exit(0);
        DecimalText := delchr(format(ltJsonToken), '=', '"');
        if DecimalText = '' then
            DecimalText := '0';
        Evaluate(ConvertTextToDecimal, DecimalText);
        exit(ConvertTextToDecimal);
    end;


    local procedure SelectJsonTokenInteger(JsonObject: JsonObject; Path: text): Integer;
    var
        ltJsonToken: JsonToken;
        ConvertTextToDecimal: Integer;
        DecimalText: Text;
    begin
        if not JsonObject.SelectToken(Path, ltJsonToken) then
            exit(0);
        if ltJsonToken.AsValue().IsNull then
            exit(0);
        DecimalText := delchr(format(ltJsonToken), '=', '"');
        if DecimalText = '' then
            DecimalText := '0';
        Evaluate(ConvertTextToDecimal, DecimalText);
        exit(ConvertTextToDecimal);
    end;
    /// <summary>
    /// ConnectTOShopify.
    /// </summary>
    /// <param name="pMethod">code[10].</param>
    /// <param name="pFind">Text.</param>
    /// <param name="pJsonObject">VAR JsonObject.</param>
    procedure ConnectTOShopify(pMethod: code[10]; pFind: Text; var pJsonObject: JsonObject)
    var
        ShopifyConfiguration: Record "TPP Shopify Configuration";
        ltUrl, gvResponseText : Text;
        ltJsonToken: JsonToken;
        ltResult: Text;
    begin
        ShopifyConfiguration.GET();
        ShopifyConfiguration.TestField("API Key");
        ShopifyConfiguration.TestField("API Version");
        ShopifyConfiguration.TestField("URL Address");
        ShopifyConfiguration.TestField("Shop ID");
        ltUrl := StrSubstNo(gvUrlAddress, ShopifyConfiguration."Shop ID", ShopifyConfiguration."URL Address", ShopifyConfiguration."API Version", pFind);
        CLEAR(gvHttpRequestMessage);
        CLEAR(gvHttpClient);
        CLEAR(gvHttpResponseMessage);
        CLEAR(gvHttpContent);
        CLEAR(gvHttpContentaddboydy);
        CLEAR(gvHttpHeadersContent);
        gvHttpHeadersContent := gvHttpClient.DefaultRequestHeaders();
        gvHttpHeadersContent.Add('X-Shopify-Access-Token', ShopifyConfiguration."API Key");
        gvHttpRequestMessage.SetRequestUri(ltUrl);
        gvHttpRequestMessage.Method := pMethod;
        gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        ltJsonToken.ReadFrom(gvResponseText);
        pJsonObject := ltJsonToken.AsObject();
        if not (gvHttpResponseMessage.IsSuccessStatusCode()) then begin
            ltResult := 'Error : ' + SelectJsonTokenText(pJsonObject, '$.errors');
            Message(ltResult);
        end;
    end;

    var
        gvHttpRequestMessage: HttpRequestMessage;
        gvHttpResponseMessage: HttpResponseMessage;
        gvHttpClient: HttpClient;
        gvHttpContent, gvHttpContentaddboydy : HttpContent;
        gvHttpHeadersContent: HttpHeaders;
        gvUrlAddress: Label 'https://%1.%2/admin/api/%3/%4', Locked = true;
}
