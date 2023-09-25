/// <summary>
/// Enum TPP Shopify Fulfillment Status (ID 70002).
/// </summary>
enum 70002 "TPP Shopify Fulfillment Status"
{
    Extensible = true;
    value(0; "any") { Caption = 'any'; }
    value(1; "shipped") { Caption = 'shipped'; }
    value(2; "partial") { Caption = 'partial'; }
    value(3; "unshipped") { Caption = 'unshipped'; }
    value(4; "unfulfilled") { Caption = 'unfulfilled'; }
}
