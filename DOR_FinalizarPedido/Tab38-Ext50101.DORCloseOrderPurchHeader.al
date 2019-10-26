tableextension 50101 "DOR CloseOrder - Purch. Header" extends "Purchase Header" // 38
{
    fields
    {
        field(50100; "DOR Close Order"; Enum "DOR Close Purchase Order Action")
        {
            DataClassification = CustomerContent;
            Caption = 'Close Order';
        }
    }
}