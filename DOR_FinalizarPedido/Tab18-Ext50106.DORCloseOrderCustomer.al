tableextension 50106 "DOR CloseOrder - Customer" extends Customer // 18
{
    fields
    {
        field(50100; "DOR Close Orders"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Close Orders';
        }
    }
}