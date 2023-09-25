/// <summary>
/// Enum TPP Shopify Financial Status (ID 70001).
/// </summary>
enum 70001 "TPP Shopify Financial Status"
{
    Extensible = true;
    value(0; "any") { Caption = 'any'; }
    value(1; "pending") { Caption = 'pending'; }
    value(2; "paid") { Caption = 'paid'; }
    value(3; "partially_paid") { Caption = 'partially_paid'; }
    value(4; "refunded") { Caption = 'refunded'; }
    value(5; "voided") { Caption = 'voided'; }
    value(6; "partially_refunded") { Caption = 'partially_refunded'; }
    value(7; "unpaid") { Caption = 'unpaid'; }
}
