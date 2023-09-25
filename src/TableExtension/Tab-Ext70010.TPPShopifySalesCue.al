/// <summary>
/// TableExtension TPP Shopify Sales Cue (ID 70010) extends Record Sales Cue.
/// </summary>
tableextension 70010 "TPP Shopify Sales Cue" extends "Sales Cue"
{
    fields
    {
        field(70000; "Shopify Sales Order Open"; Integer)
        {
            Caption = 'Shopify Sales Order Open';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order), Status = const(Open), "Ref. Shopify Order No." = filter(<> '')));
        }
        field(70001; "Shopify Product"; Integer)
        {
            Caption = 'Shopify Product';
            FieldClass = FlowField;
            CalcFormula = count("TPP Shopify Product");
        }
        field(70002; "Shopify Order"; Integer)
        {
            Caption = 'Shopify Order';
            FieldClass = FlowField;
            CalcFormula = count("TPP Shopify Order");
        }
        field(70003; "Shopify Order not to Sales"; Integer)
        {
            Caption = 'Shopify Order not to Sales Order';
            FieldClass = FlowField;
            CalcFormula = count("TPP Shopify Order" where(financial_status = const('paid'), "Create to Sales Order" = const(false)));
        }
        field(70004; "Shopify Sales Order Pending"; Integer)
        {
            Caption = 'Shopify Sales Order Pending';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order), Status = const("Pending Approval"), "Ref. Shopify Order No." = filter(<> '')));

        }
        field(70005; "Shopify Sales Order Released"; Integer)
        {
            Caption = 'Shopify Sales Order Released';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Order), Status = const(Released), "Ref. Shopify Order No." = filter(<> '')));
        }
    }
}
