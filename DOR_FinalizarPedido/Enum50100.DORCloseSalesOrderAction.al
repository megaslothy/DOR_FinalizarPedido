enum 50100 "DOR Close Sales Order Action"
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
    value(2; "By Customer No.")
    {
        Caption = 'By Customer No.';
    }
}