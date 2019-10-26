tableextension 50100 "DOR CloseOrder - Sales Header" extends "Sales Header" //36
{
    fields
    {
        field(50100; "DOR Close Order"; enum "DOR Close Sales Order Action")
        {
            DataClassification = CustomerContent;
            Caption = 'Close Order';
        }
    }
}