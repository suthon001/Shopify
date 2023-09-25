/// <summary>
/// Enum TPP Shopify Order Status (ID 70000).
/// </summary>
enum 70000 "TPP Shopify Order Status"
{
    Extensible = true;
    value(0; "Open") { Caption = 'Open'; }
    value(1; "closed") { Caption = 'closed'; }
    value(2; "cancelled") { Caption = 'cancelled'; }
    value(3; "any") { Caption = 'any'; }
}
