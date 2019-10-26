tableextension 50104 "DOR CloseOrder - Sales Setup" extends "Sales & Receivables Setup" // 312
{
    fields
    {
        field(50100; "DOR Close Orders Setup"; enum "DOR Close Sales Order Action")
        {
            DataClassification = CustomerContent;
            Caption = 'Close Orders Setup';
        }
    }

}