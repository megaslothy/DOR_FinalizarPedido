codeunit 50100 "DOR Close Orders Mgt."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', false, false)]
    local procedure Close_Sales_Order_OnAfterPostSalesLine(var SalesHeader: Record "Sales Header")
    var
        ShouldCloseSalesOrder: Boolean;
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        SetShouldCloseOrder(SalesHeader, ShouldCloseSalesOrder);

        if ShouldCloseSalesOrder then
            CloseOrder(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLines', '', false, false)]
    local procedure Close_Purch_Order_OnAfterPostPurchLine(var PurchHeader: Record "Purchase Header")
    var
        ShouldCloseSalesOrder: Boolean;
    begin
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Order then
            exit;

        SetShouldCloseOrder(PurchHeader, ShouldCloseSalesOrder);

        if ShouldCloseSalesOrder then
            CloseOrder(PurchHeader);
    end;

    local procedure SetShouldCloseOrder(pSalesHeader: Record "Sales Header"; var pShouldCloseSalesOrder: Boolean)
    begin
        case pSalesHeader."DOR Close Order" of
            pSalesHeader."DOR Close Order"::No:
                pShouldCloseSalesOrder := false;
            pSalesHeader."DOR Close Order"::Yes:
                pShouldCloseSalesOrder := true;
            pSalesHeader."DOR Close Order"::"By Customer No.":
                CheckCustomerCloseOrder(pSalesHeader."Sell-to Customer No.", pShouldCloseSalesOrder);
            else
                OnCheckCloseSalesOrderSetup(pSalesHeader, pShouldCloseSalesOrder)
        end;
    end;

    local procedure SetShouldCloseOrder(pPurchaseHeader: Record "Purchase Header"; var pShouldCloseSalesOrder: Boolean)
    begin
        case pPurchaseHeader."DOR Close Order" of
            pPurchaseHeader."DOR Close Order"::No:
                pShouldCloseSalesOrder := false;
            pPurchaseHeader."DOR Close Order"::Yes:
                pShouldCloseSalesOrder := true;
            pPurchaseHeader."DOR Close Order"::"By Vendor No.":
                CheckCustomerCloseOrder(pPurchaseHeader."Buy-from Vendor No.", pShouldCloseSalesOrder);
            else
                OnCheckClosePurchaseOrderSetup(pPurchaseHeader, pShouldCloseSalesOrder)
        end;
    end;

    local procedure CheckCustomerCloseOrder(pCustomerNo: Code[20]; pShouldCloseOrder: Boolean)
    var
        Customer: Record Customer;
    begin
        if Customer.Get(pCustomerNo) then
            pShouldCloseOrder := Customer."DOR Close Orders";
    end;

    local procedure CloseOrder(pSalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        SalesLine.SetRange("Document No.", pSalesHeader."No.");
        if SalesLine.FindFirst() then
            repeat
                SalesLine.Quantity := SalesLine."Quantity Shipped";
                SalesLine."Quantity (Base)" := SalesLine."Qty. Shipped (Base)";
                SalesLine."Outstanding Quantity" := 0;
                SalesLine."Outstanding Qty. (Base)" := 0;
                SalesLine.Modify();
            until SalesLine.Next() = 0;
    end;

    local procedure CloseOrder(pPurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", pPurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", pPurchaseHeader."No.");
        if PurchaseLine.FindFirst() then
            repeat
                if PurchaseLine."Quantity" <> PurchaseLine."Quantity Received" then
                    PurchaseLine."DOR Initial Quantity" := PurchaseLine."Quantity";
                PurchaseLine.Quantity := PurchaseLine."Quantity Received";
                PurchaseLine."Quantity (Base)" := PurchaseLine."Qty. Received (Base)";
                PurchaseLine."Outstanding Quantity" := 0;
                PurchaseLine."Outstanding Qty. (Base)" := 0;
                PurchaseLine.Modify();
            until PurchaseLine.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckCloseSalesOrderSetup(var SalesHeader: Record "Sales Header"; var ShouldCloseOrder: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckClosePurchaseOrderSetup(var PurchaseHeader: Record "Purchase Header"; var ShouldCloseOrder: Boolean)
    begin
    end;
}