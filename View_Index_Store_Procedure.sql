create database demo;
use demo;
create table Products (
	Id int primary key auto_increment,
    productCode varchar(50),
    productName varchar(50),
    productPrice int not null,
    productAmount int,
    productDescription varchar(255),
    productStatus bit );
insert into products (productCode, productName, productPrice, productAmount, productDescription, productStatus )
values ("s1", "Sam sung", 2000, 1, "mới", 1),
		("s2", "iphone", 3000, 1, "cũ", 0),
		("s3", "Xiaomi", 2500, null, "mới", 1),
		("s4", "Nokia", 7000, 1, "cũ", 0),
		("s5", "lenovo", 5500, null, "mới", 1),
		("s6", "Vsmart", 3500, 1, "mới", 1);
        
# Trước khi thêm index
select * from products where productCode = "s5";
select * from products where productName = "sam sung" and productPrice = 2000;

explain select * from products where productCode = "s5";
explain select * from products where productName = "sam sung" and productPrice = 2000;

alter table products add Unique idx_productCode(productCode);
alter table products add index idx_composite (productName, productPrice);

# sau khi thêm index
explain select * from products where productCode = "s5";
explain select * from products where productName = "sam sung" and productPrice = 2000;
# view
create view product_view as
select productCode, productName, productPrice, productStatus from products
where productAmount is not null
with check option;
# sửa view
update product_view
set productName = "Oppo"
where productCode = "s1";
# Xóa view
drop view product_view;
# Tạo store procedure
delimiter //
create procedure allRecord()
begin
	select * from products;
end //
delimiter ;
call allRecord;
# Thêm sản phẩm mới
delimiter //
create procedure addProduct(
 in pCode varchar(50),
 in pName varchar(50),
 in pPrice int, 
 in pAmount int, 
 in pDesription varchar(25), 
 in pStatus bit)
 begin
	insert into products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    values (pCode ,pName ,pPrice , pAmount , pDesription , pStatus );
end //
delimiter ;
call addProduct("s7", "V-tule", 9000, 2, "lướt", 1);
# sửa thông tin sản phẩm theo id
delimiter //
create procedure updateProduct(
 in pId int,
 in pCode varchar(50),
 in pName varchar(50),
 in pPrice int, 
 in pAmount int, 
 in pDesription varchar(25), 
 in pStatus bit)
 begin
	update products 
    set productCode = pCode ,productName = pName ,productPrice = pPrice , productAmount = pAmount ,
    productDescription =  pDesription ,productStatus = pStatus 
    where id = Pid;
end //
delimiter ;
call updateProduct(1,"s1", "V-tule", 9000, 2, "lướt", 1);

# Xóa theo id
delimiter //
create procedure delProduct(in pId int )
begin
	delete from products where id = pId;
end //
delimiter ;
call delProduct(1);
 

