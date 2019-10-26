tableextension 50102 "DOR CloseOrder - Sales Line" extends "Sales Line" // 37
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