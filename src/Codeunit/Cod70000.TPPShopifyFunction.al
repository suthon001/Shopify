/// <summary>
/// Codeunit TPP Shopify Function (ID 70000).
/// </summary>
codeunit 70000 "TPP Shopify Function"
{
    /// <summary>
    /// CreateNewProduct.
    /// </summary>
    /// <param name="pJsonBody">Text.</param>
    procedure CreateNewProduct(pJsonBody: Text)
    VAR
        ltJsonObject: JsonObject;

    begin
        ConnectTOShopify('POST', 'products.json', ltJsonObject, pJsonBody);
        Message('Create Product is successfully');

    end;
    /// <summary>
    /// CreateMultiSalesOrder.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    /// <returns>False if an runtime error occurred. Otherwise true.</returns>
    [TryFunction]
    procedure CreateMultiSalesOrder(pOrderID: code[50])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ShopifyOrder: Record "TPP Shopify Order";
        ShopifyOrderLine: Record "TPP Shopify Order Line";
        ShopifyConfiguration: Record "TPP Shopify Configuration";
        ltRecordRefShopify, ltRecordRefBC : RecordRef;
        ltFieldRefShopify, ltFieldRefBC : FieldRef;
        ltMappingLine: Record "TPP Shopify Mapping Field Line";
        ltShopifyProduct: Record "TPP Shopify Product";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ShopifyFunc: Codeunit "TPP Shopify Function";
        ltLineNO: Integer;
        ltItemNo: code[20];
        ltTrackingNo: Text[100];
    begin
        ltLineNO := 0;
        ltTrackingNo := '';
        ShopifyConfiguration.GET();
        ShopifyConfiguration.TestField("Customer No.");
        ShopifyConfiguration.TestField("Order Nos.");
        ShopifyConfiguration.TestField("Location Code");
        ShopifyOrder.GET(pOrderID);
        ltMappingLine.reset();
        ltMappingLine.SetRange(Type, ltMappingLine.Type::Item);
        ltMappingLine.SetFilter("BC Field", '<>%1', 0);
        ltMappingLine.SetFilter("Shopify Field", '<>%1', 0);
        if ltMappingLine.IsEmpty() then
            ERROR('Nothing to Mapping');

        ltTrackingNo := ShopifyFunc.GetTrackingNo(pOrderID);

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := NoSeriesMgt.GetNextNo(ShopifyConfiguration."Order Nos.", WorkDate(), true);
        SalesHeader."No. Series" := ShopifyConfiguration."Order Nos.";
        SalesHeader."Posting Date" := today();
        SalesHeader."Document Date" := Today();
        if SalesHeader.Insert(true) then begin
            SalesHeader.Validate("Sell-to Customer No.", ShopifyConfiguration."Customer No.");
            SalesHeader."Ref. Shopify Order No." := ShopifyOrder.id;
            SalesHeader."Shopify Tracking No." := ltTrackingNo;
            SalesHeader.Modify();
            ShopifyOrderLine.reset();
            ShopifyOrderLine.SetRange(order_number, ShopifyOrder.order_number);
            ShopifyOrderLine.SetFilter(product_id, '<>%1', '');
            ShopifyOrderLine.setfilter(quantity, '<>%1', 0);
            if ShopifyOrderLine.FindSet() then
                repeat
                    ltItemNo := '';
                    ltShopifyProduct.GET(ShopifyOrderLine.product_id);
                    ltRecordRefShopify.GetTable(ltShopifyProduct);
                    ltLineNO := ltLineNO + 10000;
                    SalesLine.init();
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := ltLineNO;
                    SalesLine.Type := SalesLine.Type::Item;
                    ltMappingLine.reset();
                    ltMappingLine.SetRange(Type, ltMappingLine.Type::Item);
                    ltMappingLine.SetFilter("BC Field", '<>%1', 0);
                    ltMappingLine.SetFilter("Shopify Field", '<>%1', 0);
                    if ltMappingLine.FindSet() then begin
                        ltRecordRefBC.Open(Database::Item);
                        repeat
                            ltFieldRefShopify := ltRecordRefShopify.Field(ltMappingLine."Shopify Field");
                            ltFieldRefBC := ltRecordRefBC.Field(ltMappingLine."BC Field");
                            ltFieldRefBC.SetRange(ltFieldRefShopify.Value);
                        until ltMappingLine.Next() = 0;
                        if ltRecordRefBC.FindFirst() then begin
                            ltFieldRefBC := ltRecordRefBC.FieldIndex(1);
                            ltItemNo := ltFieldRefBC.Value;
                        end;
                        ltRecordRefBC.Close();
                    end;
                    ltRecordRefShopify.Close();

                    SalesLine.Validate("No.", ltItemNo);
                    SalesLine.Insert();
                    SalesLine.Validate(Quantity, ShopifyOrderLine.quantity);
                    SalesLine.Validate("Location Code", ShopifyConfiguration."Location Code");
                    SalesLine.Validate("Unit Price", ShopifyOrderLine.price);
                    SalesLine."Ref. Shopify Order No." := SalesHeader."Ref. Shopify Order No.";
                    SalesLine."Shopify Tracking No." := SalesHeader."Shopify Tracking No.";
                    SalesLine.Modify();

                until ShopifyOrderLine.Next() = 0;
            ShopifyOrder."Create to Sales Order" := true;
            ShopifyOrder."Create to Sales Order No." := SalesHeader."No.";
            ShopifyOrder."Create to Sales Order Date" := Today();
            ShopifyOrder.Modify();
        end;
    end;

    /// <summary>
    /// CreateToSalesOrder.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    procedure CreateToSalesOrder(pOrderID: code[50])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ShopifyOrder: Record "TPP Shopify Order";
        ShopifyOrderLine: Record "TPP Shopify Order Line";
        ShopifyConfiguration: Record "TPP Shopify Configuration";
        ltRecordRefShopify, ltRecordRefBC : RecordRef;
        ltFieldRefShopify, ltFieldRefBC : FieldRef;
        ltMappingLine: Record "TPP Shopify Mapping Field Line";
        ltShopifyProduct: Record "TPP Shopify Product";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ShopifyFunc: Codeunit "TPP Shopify Function";
        ltLineNO: Integer;
        ltItemNo: code[20];
        ltTrackingNo: Text[100];
    begin
        ltLineNO := 0;
        ltTrackingNo := '';
        ShopifyConfiguration.GET();
        ShopifyConfiguration.TestField("Customer No.");
        ShopifyConfiguration.TestField("Order Nos.");
        ShopifyConfiguration.TestField("Location Code");
        ShopifyOrder.GET(pOrderID);
        ltMappingLine.reset();
        ltMappingLine.SetRange(Type, ltMappingLine.Type::Item);
        ltMappingLine.SetFilter("BC Field", '<>%1', 0);
        ltMappingLine.SetFilter("Shopify Field", '<>%1', 0);
        if ltMappingLine.IsEmpty() then
            ERROR('Nothing to Mapping');

        ltTrackingNo := ShopifyFunc.GetTrackingNo(pOrderID);

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := NoSeriesMgt.GetNextNo(ShopifyConfiguration."Order Nos.", WorkDate(), true);
        SalesHeader."No. Series" := ShopifyConfiguration."Order Nos.";
        SalesHeader."Posting Date" := today();
        SalesHeader."Document Date" := Today();
        if SalesHeader.Insert(true) then begin
            SalesHeader.Validate("Sell-to Customer No.", ShopifyConfiguration."Customer No.");
            SalesHeader."Ref. Shopify Order No." := ShopifyOrder.id;
            SalesHeader."Shopify Tracking No." := ltTrackingNo;
            SalesHeader.Modify();
            ShopifyOrderLine.reset();
            ShopifyOrderLine.SetRange(order_number, ShopifyOrder.order_number);
            ShopifyOrderLine.SetFilter(product_id, '<>%1', '');
            ShopifyOrderLine.setfilter(quantity, '<>%1', 0);
            if ShopifyOrderLine.FindSet() then
                repeat
                    ltItemNo := '';
                    ltShopifyProduct.GET(ShopifyOrderLine.product_id);
                    ltRecordRefShopify.GetTable(ltShopifyProduct);
                    ltLineNO := ltLineNO + 10000;
                    SalesLine.init();
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := ltLineNO;
                    SalesLine.Type := SalesLine.Type::Item;
                    ltMappingLine.reset();
                    ltMappingLine.SetRange(Type, ltMappingLine.Type::Item);
                    ltMappingLine.SetFilter("BC Field", '<>%1', 0);
                    ltMappingLine.SetFilter("Shopify Field", '<>%1', 0);
                    if ltMappingLine.FindSet() then begin
                        ltRecordRefBC.Open(Database::Item);
                        repeat
                            ltFieldRefShopify := ltRecordRefShopify.Field(ltMappingLine."Shopify Field");
                            ltFieldRefBC := ltRecordRefBC.Field(ltMappingLine."BC Field");
                            ltFieldRefBC.SetRange(ltFieldRefShopify.Value);
                        until ltMappingLine.Next() = 0;
                        if ltRecordRefBC.FindFirst() then begin
                            ltFieldRefBC := ltRecordRefBC.FieldIndex(1);
                            ltItemNo := ltFieldRefBC.Value;
                        end;
                        ltRecordRefBC.Close();
                    end;
                    ltRecordRefShopify.Close();

                    SalesLine.Validate("No.", ltItemNo);
                    SalesLine.Insert();
                    SalesLine.Validate(Quantity, ShopifyOrderLine.quantity);
                    SalesLine.Validate("Location Code", ShopifyConfiguration."Location Code");
                    SalesLine.Validate("Unit Price", ShopifyOrderLine.price);
                    SalesLine."Ref. Shopify Order No." := SalesHeader."Ref. Shopify Order No.";
                    SalesLine."Shopify Tracking No." := SalesHeader."Shopify Tracking No.";
                    SalesLine.Modify();

                until ShopifyOrderLine.Next() = 0;
            ShopifyOrder."Create to Sales Order" := true;
            ShopifyOrder."Create to Sales Order No." := SalesHeader."No.";
            ShopifyOrder."Create to Sales Order Date" := Today();
            ShopifyOrder.Modify();
            Message('Has been create to Order No. %1', SalesHeader."No.");
        end;
    end;

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
            if not CustLedgerEntry.Open then
                Message('The Remaining Amount to apply is 0')
            else begin
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
            end;
        end else
            Message('cannot find invoice in customer ledger');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertInvoiceHeader', '', false, false)]
    local procedure OnBeforeDeleteAfterPostingSales(var SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    var
        ltShopifyOrder: Record "TPP Shopify Order";
    begin
        if ltShopifyOrder.GET(SalesHeader."Ref. Shopify Order No.") then begin
            ltShopifyOrder."Posted Sales Invoice No." := SalesInvHeader."No.";
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
    /// GetProductOptions.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    procedure GetProductOptions(pProductID: code[50])
    var
        ltShopifyOptions: Record "TPP Shopify Options";
        ltJsonObject, ltJsonObject2 : JsonObject;
        ltJsonToken: JsonToken;
    begin
        if pProductID = '' then
            exit;
        ConnectTOShopify('GET', 'products/' + pProductID + '.json', ltJsonObject, '');
        ltShopifyOptions.reset();
        ltShopifyOptions.SetRange(product_id, pProductID);
        ltShopifyOptions.DeleteAll();
        ltJsonObject.SelectToken('$.product', ltJsonToken);
        ltJsonObject2 := ltJsonToken.AsObject();
        InsertToDetailTable(Database::"TPP Shopify Options", ltJsonObject2, 'options', '');
    end;

    /// <summary>
    /// GetProductVariant.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    procedure GetProductVariant(pProductID: code[50])
    var
        ltShopifyvariant: Record "TPP Shopify Variants";
        ltJsonObject, ltJsonObject2 : JsonObject;
        ltJsonToken: JsonToken;
    begin
        if pProductID = '' then
            exit;
        ConnectTOShopify('GET', 'products/' + pProductID + '.json', ltJsonObject, '');
        ltShopifyvariant.reset();
        ltShopifyvariant.SetRange(product_id, pProductID);
        ltShopifyvariant.DeleteAll();
        ltJsonObject.SelectToken('$.product', ltJsonToken);
        ltJsonObject2 := ltJsonToken.AsObject();
        InsertToDetailTable(Database::"TPP Shopify Variants", ltJsonObject2, 'variants', '');
        InsertToDetailTable(Database::"TPP Shopify Options", ltJsonObject2, 'options', '');
    end;


    /// <summary>
    /// SetInventory.
    /// </summary>
    /// <param name="pJsonBody">text.</param>
    /// <param name="pProductID">code[50].</param>
    procedure SetInventory(pJsonBody: text; pProductID: code[50])
    var
        ltJsonObject: JsonObject;
    begin
        ConnectTOShopify('POST', 'inventory_levels/set.json', ltJsonObject, pJsonBody);
        GetProductVariant(pProductID);
    end;

    /// <summary>
    /// InsertNewVariantbyProduct.
    /// </summary>
    /// <param name="pVariantTemp">Temporary Record "TPP Shopify Variants".</param>
    /// <param name="pProductID">code[50].</param>
    procedure InsertNewVariantbyProduct(pVariantTemp: Record "TPP Shopify Variants" temporary; pProductID: code[50])
    var
        ltJsonObject, ltJsonObjectBuild : JsonObject;
        JsonBody: Text;
    begin
        ltJsonObject.Add('option1', pVariantTemp.option1);
        ltJsonObject.Add('sku', pVariantTemp.sku);
        ltJsonObject.Add('position', pVariantTemp.position);
        ltJsonObject.Add('barcode', pVariantTemp.barcode);
        ltJsonObject.Add('price', pVariantTemp.price);
        ltJsonObject.Add('grams', pVariantTemp.grams);
        ltJsonObject.Add('weight', pVariantTemp.weight);
        ltJsonObject.Add('weight_unit', pVariantTemp.weight_unit);
        ltJsonObjectBuild.Add('variant', ltJsonObject);
        ltJsonObjectBuild.WriteTo(JsonBody);
        CLEAR(ltJsonObject);
        ConnectTOShopify('POST', 'products/' + pProductID + '/variants.json', ltJsonObject, JsonBody);

    end;
    /// <summary>
    /// UpdateStatusProduct.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    procedure updateProduct(pProductID: code[50])
    var
        ltshopifyProduct: Record "TPP Shopify Product";
        ltJsonObject, ltJsonObjectBuild, ltJsonObjectFileName : JsonObject;
        ltJsonToken: JsonToken;
        JsonBody: text;
        ltDateTime: DateTime;
        ltHaveOptions: Boolean;
    begin
        ltshopifyProduct.GET(pProductID);
        ltHaveOptions := false;
        CLEAR(ltJsonObject);
        ltJsonObject.Add('id', ltshopifyProduct.id);
        ltJsonObject.Add('title', ltshopifyProduct.title);
        ltJsonObject.Add('body_html', ltshopifyProduct.body_html);
        ltJsonObject.Add('vendor', ltshopifyProduct.vendor);
        ltJsonObject.Add('product_type', ltshopifyProduct.product_type);
        ltJsonObject.Add('handle', ltshopifyProduct.handle);
        ltJsonObject.Add('published_scope', ltshopifyProduct.published_scope);
        ltJsonObject.Add('tags', ltshopifyProduct.tags);
        ltJsonObjectBuild.Add('product', ltJsonObject);
        ltJsonObjectBuild.WriteTo(JsonBody);
        CLEAR(ltJsonObject);
        ConnectTOShopify('PUT', 'products/' + pProductID + '.json', ltJsonObject, JsonBody);
        ltJsonObject.SelectToken('$.product', ltJsonToken);
        ltJsonObjectFileName := ltJsonToken.AsObject();
        Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectFileName, '$.updated_at'));
        ltshopifyProduct.updated_at := ltDateTime;
        ltshopifyProduct.Modify();
        UpdateVariant(ltshopifyProduct.id);
        Message('Update Detail is successfully');
    end;
    /// <summary>
    /// UpdateVariant.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    procedure UpdateVariant(pProductID: code[50])
    var
        ltshopifyVariant: Record "TPP Shopify Variants";
        ltJsonObject, ltJsonObjectBuild, ltJsonObjectFileName : JsonObject;
        ltJsonToken: JsonToken;
        JsonBody: Text;
        ltDateTime: DateTime;
    begin
        if (pProductID = '') then
            exit;
        ltshopifyVariant.reset();
        ltshopifyVariant.SetRange(product_id, pProductID);
        ltshopifyVariant.SetFilter(id, '<>%1', '');
        if ltshopifyVariant.FindSet() then
            repeat
                CLEAR(ltJsonObjectBuild);
                CLEAR(ltJsonObject);
                CLEAR(ltJsonObjectFileName);
                CLEAR(ltJsonToken);
                ltJsonObject.Add('id', ltshopifyVariant.id);
                ltJsonObject.Add('price', ltshopifyVariant.price);
                ltJsonObject.Add('sku', ltshopifyVariant.sku);
                ltJsonObject.Add('position', ltshopifyVariant.position);
                ltJsonObject.Add('option1', ltshopifyVariant.option1);
                ltJsonObject.Add('option2', ltshopifyVariant.option2);
                ltJsonObject.Add('option3', ltshopifyVariant.option3);
                ltJsonObject.Add('barcode', ltshopifyVariant.barcode);
                ltJsonObject.Add('grams', ltshopifyVariant.grams);
                ltJsonObject.Add('weight', ltshopifyVariant.weight);
                ltJsonObject.Add('weight_unit', ltshopifyVariant.weight_unit);
                ltJsonObjectBuild.Add('variant', ltJsonObject);
                ltJsonObjectBuild.WriteTo(JsonBody);
                CLEAR(ltJsonObject);
                ConnectTOShopify('PUT', 'variants/' + ltshopifyVariant.id + '.json', ltJsonObject, JsonBody);
                ltJsonObject.SelectToken('$.variant', ltJsonToken);
                ltJsonObjectFileName := ltJsonToken.AsObject();
                Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectFileName, '$.updated_at'));
                ltshopifyVariant.updated_at := ltDateTime;
                ltshopifyVariant.Modify();
            until ltshopifyVariant.Next() = 0;
    end;


    /// <summary>
    /// UpdateStatusProduct.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    /// <param name="pStatus">Text.</param>
    procedure UpdateStatusProduct(pProductID: code[50]; pStatus: Text)
    var
        ltshopifyProduct: Record "TPP Shopify Product";
        ltJsonObject, ltJsonObjectBuild : JsonObject;
        JsonBody: Text;
    begin
        if (pProductID = '') or (pStatus = '') then
            exit;
        ltJsonObject.Add('id', pProductID);
        ltJsonObject.Add('status', pStatus);
        ltJsonObjectBuild.Add('product', ltJsonObject);
        ltJsonObjectBuild.WriteTo(JsonBody);
        CLEAR(ltJsonObject);
        ConnectTOShopify('PUT', 'products/' + pProductID + '.json', ltJsonObject, JsonBody);
        ltshopifyProduct.GET(pProductID);
        ltshopifyProduct.status := COPYSTR(pStatus, 1, 50);
        ltshopifyProduct.Modify();
        Message('Update status is successfully');
    end;


    /// <summary>
    /// DeleteVariant.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    /// <param name="pid">Code[50].</param>
    procedure DeleteVariant(pProductID: code[50]; pid: Code[50])
    var
        ltJsonObject: JsonObject;
    begin
        if (pProductID = '') or (pid = '') then
            exit;

        ConnectTOShopify('DELETE', 'products/' + pProductID + '/variants/' + pid + '.json', ltJsonObject, '');

    end;

    /// <summary>
    /// DeleteImage.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    /// <param name="pid">Code[50].</param>
    /// <param name="pSrc">Text.</param>
    procedure DeleteImage(pProductID: code[50]; pid: Code[50]; pSrc: Text)
    var
        ltJsonObject: JsonObject;
    begin
        if (pSrc = '') or (pProductID = '') or (pid = '') then
            exit;

        ConnectTOShopify('DELETE', 'products/' + pProductID + '/images/' + pid + '.json', ltJsonObject, '');
    end;
    /// <summary>
    /// DeleteProduct.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    procedure DeleteProduct(pProductID: code[50])
    var
        ltJsonObject: JsonObject;
    begin
        if (pProductID = '') then
            exit;

        ConnectTOShopify('DELETE', 'products/' + pProductID + '.json', ltJsonObject, '');
    end;





    /// <summary>
    /// UpdateProductImg.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    /// <param name="pid">Code[50].</param>
    /// <param name="pPosition">Integer.</param>
    procedure UpdateProductImg(pProductID: code[50]; pid: Code[50]; pPosition: Integer)
    var
        ltProductImg: Record "TPP Shopify Image";
        Base64Convert: codeunit "Base64 Convert";
        ltJsonObject, ltJsonObject2, ltJsonObjectBuild, ltJsonObjectFileName : JsonObject;
        ltJsonToken: JsonToken;
        ltJsonArray: JsonArray;
        Base64Text, ltFileName, JsonBody : Text;
        ltInstream: InStream;
        ltDateTime: DateTime;
    begin
        CLEAR(ltInstream);
        CLEAR(ltJsonObject);
        CLEAR(ltJsonObject2);
        CLEAR(ltJsonObjectBuild);
        CLEAR(ltJsonArray);
        CLEAR(ltJsonToken);
        ltFileName := '';
        UploadIntoStream('Select Picture', '', '', ltFileName, ltInstream);
        if ltFileName <> '' then begin
            Base64Text := Base64Convert.ToBase64(ltInstream);
            ltJsonObject.Add('key', 'new');
            ltJsonObject.Add('value', 'newvalue');
            ltJsonObject.Add('type', 'single_line_text_field');
            ltJsonObject.Add('namespace', 'global');
            ltJsonArray.Add(ltJsonObject);
            ltJsonObject2.Add('position', pPosition);
            ltJsonObject2.Add('metafields', ltJsonArray);
            ltJsonObject2.Add('attachment', Base64Text);
            ltJsonObject2.Add('filename ', ltFileName);
            ltJsonObjectBuild.Add('image', ltJsonObject2);
            ltJsonObjectBuild.WriteTo(JsonBody);
            CLEAR(ltJsonObject);
            ConnectTOShopify('POST', 'products/' + pProductID + '/images.json', ltJsonObject, JsonBody);
            ltJsonObject.SelectToken('$.image', ltJsonToken);
            ltJsonObjectFileName := ltJsonToken.AsObject();
            ltProductImg.reset();
            ltProductImg.SetRange(product_id, pProductID);
            ltProductImg.SetRange(id, pid);
            if ltProductImg.FindFirst() then
                ltProductImg.Delete();
            ltProductImg.Init();
            ltProductImg.product_id := pProductID;
            ltProductImg.id := format(SelectJsonTokenText(ltJsonObjectFileName, '$.id'));
            ltProductImg.width := SelectJsonTokenInteger(ltJsonObjectFileName, '$.width');
            ltProductImg.height := SelectJsonTokenInteger(ltJsonObjectFileName, '$.height');
            ltProductImg.position := SelectJsonTokenInteger(ltJsonObjectFileName, '$.position');
            ltProductImg.Insert();
            ltProductImg.Validate(src, SelectJsonTokenText(ltJsonObjectFileName, '$.src'));
            ltProductImg.admin_graphql_api_id := COPYSTR(SelectJsonTokenText(ltJsonObjectFileName, '$.admin_graphql_api_id'), 1, 2047);
            Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectFileName, '$.created_at'));
            ltProductImg.created_at := ltDateTime;
            ltProductImg.Modify();

        end;


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
        ConnectTOShopify('GET', 'orders/' + pOderID + '/fulfillments.json', ltJsonObject, '');
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
        ConnectTOShopify('POST', 'orders/' + pOrderID + '/close.json', ltJsonObject, '');
        if ltJsonObject.SelectToken('$.order', ltJsonToken) then begin
            ltJsonObjectValue := ltJsonToken.AsObject();
            ltShopifyOrder.GET(pOrderID);
            ltShopifyOrder.status := 'closed';
            ltShopifyOrder."Closed Order" := true;
            Evaluate(ltDateTime, SelectJsonTokenText(ltJsonObjectValue, '$.closed_at'));
            ltShopifyOrder.closed_at := ltDateTime;
            ltShopifyOrder.modify();
        end;
    end;

    /// <summary>
    /// Reopenclosedorder.
    /// </summary>
    /// <param name="pOrderID">code[50].</param>
    procedure Reopenclosedorder(pOrderID: code[50])
    var
        ltShopifyOrder: Record "TPP Shopify Order";
        ltJsonObject: JsonObject;
    begin
        ConnectTOShopify('POST', 'orders/' + pOrderID + '/open.json', ltJsonObject, '');
        ltShopifyOrder.GET(pOrderID);
        ltShopifyOrder.status := 'open';
        ltShopifyOrder."Closed Order" := false;
        ltShopifyOrder.closed_at := 0DT;
        ltShopifyOrder.modify();
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnProcessLinesOnAfterPostGenJnlLines', '', false, false)]
    local procedure OnProcessLinesOnAfterPostGenJnlLines(var GenJournalLine: Record "Gen. Journal Line"; PreviewMode: Boolean)
    var

        GenJnlLine3: record "Gen. Journal Line";
        RefOrderNo: code[50];
    begin
        RefOrderNo := '';
        if not PreviewMode then begin
            GenJnlLine3.Reset();
            GenJnlLine3.copy(GenJournalLine);
            GenJnlLine3.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Ref. Shopify Order No.");
            GenJnlLine3.setfilter("Ref. Shopify Order No.", '<>%1', '');
            if GenJnlLine3.FindSet() then
                repeat
                    if GenJnlLine3."Ref. Shopify Order No." <> RefOrderNo then
                        CloseOrder(GenJnlLine3."Ref. Shopify Order No.");
                    RefOrderNo := GenJnlLine3."Ref. Shopify Order No.";
                until GenJnlLine3.Next() = 0;

        end;
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
    /// <param name="ltResult">VAR Text.</param>

    [TryFunction]
    procedure TESTConnect(pFind: Text; var ltResult: Text)
    var
        ShopifyConfiguration: Record "TPP Shopify Configuration";
        ltUrl, gvResponseText : Text;
        ltJsonToken: JsonToken;
        ltJsonObject: JsonObject;
    begin
        ltResult := '';
        ShopifyConfiguration.GET();
        ShopifyConfiguration.TestField(Code);
        ShopifyConfiguration.TestField("Shopify URL");
        ShopifyConfiguration.TestField("API Version");
        ltUrl := StrSubstNo(gvUrlAddress, ShopifyConfiguration."Shopify URL", ShopifyConfiguration."API Version", pFind);
        CLEAR(gvHttpRequestMessage);
        CLEAR(gvHttpClient);
        CLEAR(gvHttpResponseMessage);
        CLEAR(gvHttpContent);
        CLEAR(gvHttpContentaddboydy);
        CLEAR(gvHttpHeadersContent);
        gvHttpHeadersContent := gvHttpClient.DefaultRequestHeaders();
        gvHttpHeadersContent.Add('X-Shopify-Access-Token', ShopifyConfiguration.Code);
        gvHttpClient.Get(ltUrl, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        ltJsonToken.ReadFrom(gvResponseText);
        ltJsonObject := ltJsonToken.AsObject();
        if (gvHttpResponseMessage.IsSuccessStatusCode()) then begin
            ltResult := 'Status : Successfully';
            ltResult := ltResult + '\Shop Details';
            ltResult := ltResult + '\Shop ID : ' + SelectJsonTokenText(ltJsonObject, '$.shop.id');
            ltResult := ltResult + '\Shop Name : ' + SelectJsonTokenText(ltJsonObject, '$.shop.name');
            ltResult := ltResult + '\Shop Owner : ' + SelectJsonTokenText(ltJsonObject, '$.shop.shop_owner');
            ltResult := ltResult + '\Address : ' + SelectJsonTokenText(ltJsonObject, '$.shop.address1');
            ltResult := ltResult + '\Address 2 : ' + SelectJsonTokenText(ltJsonObject, '$.shop.address2');
            ltResult := ltResult + '\Province : ' + SelectJsonTokenText(ltJsonObject, '$.shop.province');
            ltResult := ltResult + '\Country : ' + SelectJsonTokenText(ltJsonObject, '$.shop.country');
            ltResult := ltResult + '\Phone : ' + SelectJsonTokenText(ltJsonObject, '$.shop.phone');
            ltResult := ltResult + '\E-Mail : ' + SelectJsonTokenText(ltJsonObject, '$.shop.email');
        end else begin
            ltResult := 'Error : ' + SelectJsonTokenText(ltJsonObject, '$.errors');
            Error('');
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
        ltShopifyVariants: Record "TPP Shopify Variants";
        ltShopifyImage: Record "TPP Shopify Image";
        ltShopifyOptions: Record "TPP Shopify Options";

    begin
        ltCountLine := 0;
        ShopifyConfig.GET();
        ConnectTOShopify(pMehotd, pFind, ltJsonObject, '');
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
                    if pSelectToken in ['products', 'product'] then begin
                        ltsinceID := COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.id'), 1, 50);

                        ltShopifyVariants.reset();
                        ltShopifyVariants.SetRange(product_id, ltsinceID);
                        ltShopifyVariants.DeleteAll();
                        InsertToDetailTable(Database::"TPP Shopify Variants", ltJsonObjectValue, 'variants', '');

                        ltShopifyOptions.reset();
                        ltShopifyOptions.SetRange(product_id, ltsinceID);
                        ltShopifyOptions.DeleteAll();
                        InsertToDetailTable(Database::"TPP Shopify Options", ltJsonObjectValue, 'options', '');

                        ltShopifyImage.reset();
                        ltShopifyImage.SetRange(product_id, ltsinceID);
                        ltShopifyImage.DeleteAll();
                        InsertToDetailTable(Database::"TPP Shopify Image", ltJsonObjectValue, 'images', '');
                    end;
                    if pSelectToken = 'fulfillments' then
                        InsertToDetailTable(Database::"TPP Shopify Fulfillment Line", ltJsonObjectValue, 'line_items', COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.id'), 1, 50));
                    if pSelectToken = 'orders' then begin
                        ltsinceID := COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.id'), 1, 50);
                        ShopifyOrder.GET(ltsinceID);
                        ShopifyOrder.status := 'open';
                        if COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.cancelled_at'), 1, 50) <> '' then begin
                            ShopifyOrder.status := 'cancelled';
                            ShopifyOrder."Cancelled Order" := true;
                        end;
                        if COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.closed_at'), 1, 50) <> '' then begin
                            ShopifyOrder.status := 'closed';
                            ShopifyOrder."Closed Order" := true;
                        end;

                        InsertToDetailTable(Database::"TPP Shopify Order line", ltJsonObjectValue, 'line_items', COPYSTR(SelectJsonTokenText(ltJsonObjectValue, '$.order_number'), 1, 50));
                        InsertToTable('GET', Database::"TPP Shopify Order Transaction", 'orders/' + ltsinceID + '/transactions.json', 'transactions', 1);
                        InsertToTable('GET', Database::"TPP Shopify Order Transaction", 'orders/' + ltsinceID + '/refunds.json', 'transactions', 2);
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
        ConnectTOShopify('GET', pFind, ltJsonObject, '');
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

    /// <summary>
    /// SelectJsonTokenText.
    /// </summary>
    /// <param name="JsonObject">JsonObject.</param>
    /// <param name="Path">text.</param>
    /// <returns>Return value of type text.</returns>
    procedure SelectJsonTokenText(JsonObject: JsonObject; Path: text): text;
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
    /// <summary>
    /// SelectJsonTokenDecimal.
    /// </summary>
    /// <param name="JsonObject">JsonObject.</param>
    /// <param name="Path">text.</param>
    /// <returns>Return value of type Decimal.</returns>
    procedure SelectJsonTokenDecimal(JsonObject: JsonObject; Path: text): Decimal;
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

    /// <summary>
    /// SelectJsonTokenInteger.
    /// </summary>
    /// <param name="JsonObject">JsonObject.</param>
    /// <param name="Path">text.</param>
    /// <returns>Return value of type Integer.</returns>
    procedure SelectJsonTokenInteger(JsonObject: JsonObject; Path: text): Integer;
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
    /// <param name="pJsonBody">Text.</param>
    procedure ConnectTOShopify(pMethod: code[10]; pFind: Text; var pJsonObject: JsonObject; pJsonBody: Text)
    var
        ShopifyConfiguration: Record "TPP Shopify Configuration";
        ltUrl, gvResponseText : Text;
        ltJsonToken: JsonToken;
        ltResult: Text;
    begin
        ShopifyConfiguration.GET();
        ShopifyConfiguration.TestField(Code);
        ShopifyConfiguration.TestField("Shopify URL");
        ShopifyConfiguration.TestField("API Version");
        ShopifyConfiguration.TestField(Enabled, true);
        ltUrl := StrSubstNo(gvUrlAddress, ShopifyConfiguration."Shopify URL", ShopifyConfiguration."API Version", pFind);
        CLEAR(gvHttpRequestMessage);
        CLEAR(gvHttpClient);
        CLEAR(gvHttpResponseMessage);
        CLEAR(gvHttpContent);
        CLEAR(gvHttpContentaddboydy);
        CLEAR(gvHttpHeadersContent);
        if pJsonBody <> '' then begin
            gvHttpContent.WriteFrom(pJsonBody);
            gvHttpContent.GetHeaders(gvHttpHeadersContent);
            gvHttpHeadersContent.Clear();
            gvHttpHeadersContent.Add('Content-Type', 'application/json');
            gvHttpHeadersContent.Add('X-Shopify-Access-Token', ShopifyConfiguration.Code);
        end else begin
            gvHttpHeadersContent := gvHttpClient.DefaultRequestHeaders();
            gvHttpHeadersContent.Add('X-Shopify-Access-Token', ShopifyConfiguration.Code);
        end;
        if pJsonBody <> '' then
            gvHttpRequestMessage.Content := gvHttpContent;
        gvHttpRequestMessage.SetRequestUri(ltUrl);
        gvHttpRequestMessage.Method := pMethod;
        gvHttpClient.Send(gvHttpRequestMessage, gvHttpResponseMessage);
        gvHttpResponseMessage.Content.ReadAs(gvResponseText);
        ltJsonToken.ReadFrom(gvResponseText);
        pJsonObject := ltJsonToken.AsObject();
        if not (gvHttpResponseMessage.IsSuccessStatusCode()) then begin
            ltResult := 'Error : ' + SelectJsonTokenText(pJsonObject, '$.errors');
            ERROR(ltResult);
        end;
    end;

    var
        gvHttpRequestMessage: HttpRequestMessage;
        gvHttpResponseMessage: HttpResponseMessage;
        gvHttpClient: HttpClient;
        gvHttpContent, gvHttpContentaddboydy : HttpContent;
        gvHttpHeadersContent: HttpHeaders;
        gvUrlAddress: Label 'https://%1/admin/api/%2/%3', Locked = true;
}
