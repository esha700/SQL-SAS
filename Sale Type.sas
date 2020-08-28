libname orion '/global/home/gbc_everma/gbc/shared/BUS_4022/Datasets/Assignment_2';

data work.ordertype;
    set orion.orders;
    length Type $ 15 SaleAds $ 10;
    DayOfWeek=weekday(Order_Date);

    If Order_Type=1 then
        Type='Retail Sale';
    Else if Order_Type=2 then
        do;
            Type='Catalog Sale';
            SaleAds='Mail';
        end;
    Else if Order_Type=3 then
        do;
            Type='Internet Sale';
            SaleAds='Email';
        end;
    drop Order_Type Employee_ID Customer_ID;

run;

proc print data=work.ordertype; 
    var Order_ID Order_Date Delivery_Date Type SaleAds DayOfWeek;
run;
