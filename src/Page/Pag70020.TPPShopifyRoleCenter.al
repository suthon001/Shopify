/// <summary>
/// Page TPP Shopify Role Center (ID 70020).
/// </summary>
page 70020 "TPP Shopify Role Center"
{
    Caption = 'Shopify Role Center';
    PageType = RoleCenter;
    layout
    {
        area(RoleCenter)
        {
            part(HeadlineRCOrderProcessor; "Headline RC Order Processor")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ShopifyRoleActivity; "TPP Shopify Role Activity")
            {
                ApplicationArea = Basic, Suite;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control1905989608; "My Items")
            {
                AccessByPermission = TableData "My Item" = R;
                ApplicationArea = Basic, Suite;
            }
            part(Control13; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control21; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
                ApplicationArea = Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Creation)
        {

            action(ShopifyOrderCreation)
            {
                ApplicationArea = all;
                Caption = 'Shopify Order';
                RunObject = page "TPP Shopify Order Lists";
                ToolTip = 'Executes the Shopify Order action.';
            }
            action(ShopifySalesOrderCreation)
            {
                ApplicationArea = all;
                Caption = 'Sales Order';
                RunObject = page "Sales Order List";
                RunPageLink = "Ref. Shopify Order No." = filter(<> '');
                ToolTip = 'Executes the Sales Order action.';
            }
            action(ShopifyPaymentCreate)
            {
                ApplicationArea = all;
                Caption = 'Shopify Payment';
                RunObject = page "TPP Shopify Pending RV";
                ToolTip = 'Executes the Shopify Payment action.';
            }

            action(ShopifyProductCreation)
            {
                ApplicationArea = all;
                Caption = 'Shopify Product';
                RunObject = page "TPP Shopify Product Lists";
                ToolTip = 'Executes the Shopify Product action.';
            }
            action(itemsCreation)
            {
                ApplicationArea = all;
                Caption = 'Item List';
                RunObject = page "Item List";
                ToolTip = 'Executes the Item List action.';
            }

            action(ShopifyConfigCreation)
            {
                ApplicationArea = all;
                Caption = 'Shop';
                RunObject = page "TPP Shopify Config. Setup";
                ToolTip = 'Executes the Shopify Config. Setup action.';
            }
            action(ShopifyMappingCreation)
            {
                ApplicationArea = all;
                Caption = ' Shopify Mapping';
                RunObject = page "TPP Shopify Mapping Lists";
                ToolTip = 'Executes the Shopify Mapping action.';
            }

        }
        area(Sections)
        {
            Group(Order)
            {
                Caption = 'Orders';
                action(ShopifyOrder)
                {
                    ApplicationArea = all;
                    Caption = 'Shopify Order';
                    RunObject = page "TPP Shopify Order Lists";
                    ToolTip = 'Executes the Shopify Order action.';
                }
                action(ShopifySalesOrder)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Order';
                    RunObject = page "Sales Order List";
                    RunPageLink = "Ref. Shopify Order No." = filter(<> '');
                    ToolTip = 'Executes the Sales Order action.';
                }
            }
            Group(Transaction)
            {
                Caption = 'Transactions';
                action(TransactionLists)
                {
                    ApplicationArea = all;
                    Caption = 'Transaction';
                    RunObject = page "TPP Shopify Order Transaction";
                    ToolTip = 'Executes the Shopify Transaction action.';
                }

            }
            Group(Inventory)
            {
                Caption = 'Inventory';
                action(InventoryLists)
                {
                    ApplicationArea = all;
                    Caption = 'Inventory';
                    RunObject = page "TPP Shopify Inventory";
                    ToolTip = 'Executes the Shopify Inventory action.';
                }

            }
            Group(Refund)
            {
                Caption = 'Refunds';
                action(RefundLists)
                {
                    ApplicationArea = all;
                    Caption = 'Refund';
                    RunObject = page "TPP Shopify Refund Lists";
                    ToolTip = 'Executes the Shopify Refund action.';
                }

            }
            group(payment)
            {
                Caption = 'Payments';
                action(ShopifyPayment)
                {
                    ApplicationArea = all;
                    Caption = 'Shopify Payment';
                    RunObject = page "TPP Shopify Pending RV";
                    ToolTip = 'Executes the Shopify Payment action.';
                }
            }
            group(Product)
            {
                Caption = 'Products';
                action(ShopifyProduct)
                {
                    ApplicationArea = all;
                    Caption = 'Shopify Product';
                    RunObject = page "TPP Shopify Product Lists";
                    ToolTip = 'Executes the Shopify Product action.';
                }
                action(items)
                {
                    ApplicationArea = all;
                    Caption = 'Item List';
                    RunObject = page "Item List";
                    ToolTip = 'Executes the Item List action.';
                }
            }
            group(ShopifyConfiguration)
            {
                Caption = 'Shopify Configuration';
                action(ShopifyConfig)
                {
                    ApplicationArea = all;
                    Caption = 'Shop';
                    RunObject = page "TPP Shopify Config. Setup";
                    ToolTip = 'Executes the Shop action.';
                }
                action(ShopifyMapping)
                {
                    ApplicationArea = all;
                    Caption = ' Shopify Mapping';
                    RunObject = page "TPP Shopify Mapping Lists";
                    ToolTip = 'Executes the Shopify Mapping action.';
                }
            }
        }
    }
}
profile ShopifyRoleCenter
{
    Caption = 'Shopify Role Center';
    RoleCenter = "TPP Shopify Role Center";
    Description = 'Shopify Role Center';
}
