/// <summary>
/// TableExtension TPP Shopify Gen. Journal Line (ID 70007) extends Record Gen. Journal Line.
/// </summary>
tableextension 70007 "TPP Shopify Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(70000; "Ref. Shopify Order No."; Code[50])
        {
            Caption = 'Ref. Shopify Order No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70001; "Shopify Tracking No."; Text[100])
        {
            Caption = 'Tracking No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70002; "Shopify Transaction ID"; code[50])
        {
            Caption = 'Transaction ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    /// <summary>
    /// ShopifyGenLastLine.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure ShopifyGenLastLine(): Integer
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.reset();
        GenJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        GenJournalLine.SetRange("Journal Template Name", rec."Journal Template Name");
        GenJournalLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
        if GenJournalLine.FindLast() then
            exit(GenJournalLine."Line No." + 10000);
        Exit(10000);
    end;
}
