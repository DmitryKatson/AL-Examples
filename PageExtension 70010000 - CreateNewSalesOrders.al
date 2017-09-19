pageextension 70010000 "CreateNewSalesOrders" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            field(AIRStatus;Status)
            {
                ApplicationArea = All;
                Visible = true;
                CaptionML = ENU = 'Status';
                
            }
        }
        
    }
    
    actions
    {
        addbefore("SendApprovalRequest")
        {
            Action("Create 1000 Orders")
            {
                ApplicationArea = All;
                Image = Copy;
                
                trigger OnAction();
                var
                    CreateNewSalesOrders: Codeunit CreateNewSalesOrders;
                begin
                    CreateNewSalesOrders.Run(Rec);
                end;
            }
            Action("Delete Half Sales orders")
            {
                ApplicationArea = All;
                Image = RemoveLine;
                
                trigger OnAction();
                var
                    CreateNewSalesOrders: Codeunit CreateNewSalesOrders;
                begin
                    CreateNewSalesOrders.DeleteHalfSalesOrders;
                end;
                
            }
            Action(AIRRelease)
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                
                trigger OnAction();
                var
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                begin
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                end;
            }
            
            Action(LinesCount)
            {
                ApplicationArea = All;
                Image = NewSum;
                
                trigger OnAction();
                begin
                    Message('Total number of Sales Orders are %1',Count);
                end;
            }
        }
    }
    
    var
}