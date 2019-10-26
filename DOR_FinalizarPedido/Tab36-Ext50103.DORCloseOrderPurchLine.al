tableextension 50103 "DOR CloseOrder - Purch. Line" extends "Purchase Line" //36
{
    fields
    {
        field(50100; "DOR Initial Quantity"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Initial Quantity';
        }
    }
}