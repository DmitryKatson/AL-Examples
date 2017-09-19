// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

codeunit 70010000 CreateNewSalesOrders
{
    TableNo = "Sales Header";
    trigger OnRun();
    begin
        CreateNewSalesOrders(rec);
    end;
    
    var
    
    local procedure CreateNewSalesOrders(FromSalesOrder: Record "Sales Header");
    var
        NewSalesOrder: Record "Sales Header";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        i: Integer;
        SalesDocType: Integer;
        TotalNumber: Integer;
    begin
        TotalNumber := 1000 - NewSalesOrder.Count;
        if TotalNumber < 0 Then Exit;

        CopyDocMgt.SetProperties(true,false,false,false,false,false,false);
        for i := 1 to TotalNumber do
        begin
            InitSalesOrder(NewSalesOrder);
            SalesDocType := 2; //CopyDocMgt.SalesHeaderDocType(FromSalesOrder."Document Type");
            CopyDocMgt.CopySalesDoc(SalesDocType,FromSalesOrder."No.",NewSalesOrder);
        end;
        Message('New Orders created. Total number of sales orders is %1',NewSalesOrder.Count);
    end;
    
    procedure DeleteHalfSalesOrders();
    var
        DeleteSalesOrder: Record "Sales Header";
        i: Integer;   
        TotalNumber: Integer;             
    begin
        DeleteSalesOrder.Setrange("Document Type",DeleteSalesOrder."Document Type"::Order);
        TotalNumber := ROUND(DeleteSalesOrder.Count/2,1);
        if TotalNumber < 0 Then Exit;

        For i := 1 to TotalNumber do begin
            DeleteSalesOrder.FINDLAST;
            DeleteSalesOrder.Delete(true);
        end;
    end;
    
    local procedure InitSalesOrder(var NewSalesOrder: Record "Sales Header");
    var
    begin
        with NewSalesOrder do begin
            INIT;
            "No." := '';
            "Document Type" := "Document Type"::Order;
            Insert(true);
        end;
    end;
}