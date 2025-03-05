with
    source as (
        select *
        from {{ source('RAW_ADVENTURE_WORKS', 'SALESORDERHEADER') }}
    )

    , renamed as (
        select
            SalesOrderID as pk_sales_order_header
            , CustomerID as fk_customer
            , SalesPersonID as fk_sales_person
            , TerritoryID as fk_territory
            , BillToAddressID as fk_bill_to_address
            , ShipToAddressID as fk_ship_to_address
            , ShipMethodID as fk_ship_method
            , CreditCardID as fk_credit_card
            , RevisionNumber as revision_number
            , CurrencyRateID as fk_currency_rate
            , CreditCardApprovalCode as credit_card_approval_code
            , status
            , OnlineOrderFlag as online_order_flag
            , PurchaseOrderNumber as purchase_order_number
            , AccountNumber as account_number
            , SubTotal as sub_total
            , TaxAmt as tax_amt
            , Freight as freight
            , TotalDue as total_due
            , Comment as comment
            , rowguid
            , OrderDate as order_date
            , DueDate as due_date
            , ShipDate as ship_date
            , ModifiedDate as modified_date
        from source
    )

select *
from renamed