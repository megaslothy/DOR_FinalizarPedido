tableextension 50105 "DOR Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50100; "DOR Close Orders Setup"; enum "DOR Close Purchase Order Action")
        {
            DataClassification = CustomerContent;
            Caption = 'Close Orders Setup';
        }
    }

}