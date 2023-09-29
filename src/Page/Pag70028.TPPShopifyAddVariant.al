/// <summary>
/// Page TPP Shopify Add Variant (ID 70028).
/// </summary>
page 70028 "TPP Shopify Add Variant"
{
    Caption = 'Shopify Create Variant';
    PageType = List;
    SourceTable = "TPP Shopify Variants";
    UsageCategory = None;
    SourceTableTemporary = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(option1; Rec.option1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the option1 field.';
                }
                field(price; Rec.price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the price field.';
                }
                field(sku; Rec.sku)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the sku field.';
                }
                field(position; Rec.position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the position field.';
                }

                field(barcode; Rec.barcode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the barcode field.';
                }
                field(grams; Rec.grams)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the grams field.';
                }
                field(weight; Rec.weight)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the weight field.';
                }
                field(weight_unit; Rec.weight_unit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the weight_unit field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PostVariant)
            {
                Caption = 'Post Variant';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = all;
                ToolTip = 'Executes the Post Variant action.';
                trigger OnAction()
                var
                    ShopifyVariantsTemp: Record "TPP Shopify Variants" temporary;
                    ShopifyFunction: Codeunit "TPP Shopify Function";
                begin
                    rec.reset();
                    ShopifyVariantsTemp.Copy(rec, true);
                    if ShopifyVariantsTemp.FindSet() then
                        repeat
                            ShopifyVariantsTemp.TestField(option1);
                        until ShopifyVariantsTemp.Next() = 0;

                    ShopifyVariantsTemp.reset();
                    if ShopifyVariantsTemp.FindSet() then
                        repeat
                            ShopifyFunction.InsertNewVariantbyProduct(ShopifyVariantsTemp, ProductID);
                        until ShopifyVariantsTemp.Next() = 0;
                    ShopifyFunction.GetProductVariant(ProductID);
                    commit();
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.product_id := ProductID;
        rec.id := format(Random(10000));
    end;




    /// <summary>
    /// SetProductID.
    /// </summary>
    /// <param name="pProductID">code[50].</param>
    procedure SetProductID(pProductID: code[50])
    begin
        ProductID := pProductID;
    end;

    var
        ProductID: code[50];
}
