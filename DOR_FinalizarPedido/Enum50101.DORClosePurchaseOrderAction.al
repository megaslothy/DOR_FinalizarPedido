enum 50101 "DOR Close Purchase Order Action"
{
    Extensible = true;

    value(0; "No")
    {
        Caption = 'Don''t close orders';
    }
    value(1; Yes)
    {
        Caption = 'Close orders';
    }
    value(2; "By Vendor No.")
    {
        Caption = 'By Vendor No.';
    }
}