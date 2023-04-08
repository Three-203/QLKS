use Qlks
go


alter proc [dbo].[dangnhap]
@taikhoan nvarchar(50),
@matkhau nvarchar(50)
as
if (exists(select TaiKhoan, MatKhau
		from NhanVien
		where TaiKhoan = @taikhoan and MatKhau = @matkhau ))
		select errcode =0
else
	select errcode = 1
 ----------------------------------------------------------------------------------------
go
alter proc [dbo].[phongtrong] 
	@maphong int

	as
		if @maphong = 0
			select MaPhong, TinhTrang, TenKh, NamSinh, SoCm, SoNguoiDp, NgayDp, NgayTp from [dbo].[phong]
		else
		 begin
			select MaPhong, TinhTrang, TenKh, NamSinh, SoCm, SoNguoiDp, NgayDp, NgayTp
			from [dbo].[phong]
			where MaPhong = @maphong 
		 end
 ----------------------------------------------------------------------------------------
go
alter proc [dbo].[suathongtinphong]
@maphong int,
@tinhtrang nvarchar(5),
@tenkh nvarchar(100),
@namsinh int,
@socm int,
@songuoidp int,
@ngaydp date,
@ngaytp date
as
	begin
		update phong
		set TinhTrang = @tinhtrang, TenKh = @tenkh, NamSinh = @namsinh, SoCm = @socm, SoNguoiDp = @songuoidp, NgayDp = @ngaydp, NgayTp = @ngaytp
		where MaPhong = @maphong
		select errcode = 1
	end 
go
 ----------------------------------------------------------------------------------------
alter proc[dbo].[xoaphong]
@maphong int
as
	begin
		update phong
		set TinhTrang = N'Trống', TenKh = null, NamSinh = null, SoCm = null, SoNguoiDp = null, NgayDp = null, NgayTp = null
		where MaPhong = @maphong
		select errcode = 1
	end

 ----------------------------------------------------------------------------------------
go

alter proc [dbo].[hiencpp] 
@maphong int
as
		if @maphong = 0
			select * from [dbo].[ChiPhiPhu]
		else
			begin
				select TienDc, DichVu, Gia,TienDc - Gia as TongTien
				from [dbo].[ChiPhiPhu]
				where MaPhong =@maphong
				select errcode = 0
			end

 ----------------------------------------------------------------------------------------
go
Alter proc [dbo].[CapNhatCp]
@maphong int,
@tiendatcoc int,
@dicvu Nvarchar(100),
@gia int
as
 begin
	update [dbo].[ChiPhiPhu]
	set TienDc = @tiendatcoc, DichVu = @dicvu, Gia = @gia
	where MaPhong = @maphong
	select errcode = 0, errmsg = N'Cập nhật thành công'
 end

  ----------------------------------------------------------------------------------------
 go
 alter proc [dbo].[hientongtien]
 @maphong int
 as
 select Tien
 from [dbo].[TongTien]
 where MaPhong = @maphong

 ----------------------------------------------------------------------------------------
go
alter proc [dbo].[capnhattongtien]
@maphong int,
@tien int
as
update [dbo].[TongTien]
set Tien = @tien
where MaPhong = @maphong
select errcode = 0

 ----------------------------------------------------------------------------------------
go
Alter Proc [dbo].[timnv] 
@hoten Nvarchar(100)
as
 		begin
			select Manv, HoTen, Phai, DiaChi, NgaySinh, SoDt, TaiKhoan, MatKhau 
			from NhanVien where HoTen = @hoten
		end


 ----------------------------------------------------------------------------------------
go
Alter Proc [dbo].[themnv] N'a',N'a',N'a',N'a',1,N'admin',N'a'
@hoten Nvarchar(100),
@phai Nvarchar(10),
@diachi Nvarchar(100),
@ngaysinh Nvarchar(100),
@sodt int,
@taikhoan Nvarchar(50),
@matkhau Nvarchar(50)
as
if(exists(select TaiKhoan from [dbo].[NhanVien] where TaiKhoan = @taikhoan))
	begin
		select errcode = 1, errmsg = N'Tài Khoản Đã Tồn Tại'
	end
else
	begin
		Insert [dbo].[NhanVien](HoTen, Phai, DiaChi, NgaySinh, SoDt, TaiKhoan, MatKhau)
		Values(@hoten, @phai, @diachi, @ngaysinh, @sodt, @taikhoan, @matkhau)
		select errcode=0, errmsg = N'Thêm Thành Công'
	end

 ----------------------------------------------------------------------------------------
go
Alter Proc [dbo].[suanv]  N'Nguyễn Văn Phước',N'Nam',N'Biên Hòa, Đồng Nai',N'1/03/1993',123456789,N'admin',N'admin'
@hoten Nvarchar(100),
@phai Nvarchar(10),
@diachi Nvarchar(100),
@ngaysinh Nvarchar(100),
@sodt int,
@taikhoan Nvarchar(50),
@matkhau Nvarchar(50)
as
if(exists(select HoTen, Phai, DiaChi, NgaySinh, SoDt, TaiKhoan, MatKhau from NhanVien where TaiKhoan = @taikhoan))
begin
	select errcode = 0
	UPDATE [dbo].[NhanVien]
	set HoTen = @hoten, Phai = @phai, DiaChi = @diachi, NgaySinh = @ngaysinh, SoDt = @sodt, MatKhau = @matkhau
	where TaiKhoan = @taikhoan
	
end
else
	select errcode = 1

 ----------------------------------------------------------------------------------------
go
Create Proc [dbo].[xoanhanvien]
@manv int
as
	Delete NhanVien
	where MaNv = @manv


---------------------------------------------------------------------------------------------------
Alter Proc [dbo].[hiennhanvien] 1
@manv int
as
if(@manv = 0)
begin
	select MaNv, HoTen
	from NhanVien
end
else
begin
	select MaNv, HoTen, Phai, DiaChi, NgaySinh, SoDt, TaiKhoan, MatKhau
	from NhanVien
	where MaNv = @manv
end
------------------------------------------------------------------------------------------
go
Alter Proc [dbo].[luuttphong]
@maphong int, 
@ten Nvarchar(100),
@namsinh int,
@socm int,
@ngaydp Nvarchar(100),
@ngaytp Nvarchar(100),
@tienphong int,
@chiphiphu int,
@tongtien int,
@nv Nvarchar (100)
as
	Insert Into [dbo].[luuthongtinphong](MaPhong, TenKh, NamSinh, SoCm, NgayDp, NgayTp, TienPhong, ChiPhiPhu, TongTien, NvLap)
	Values( @maphong, @ten, @namsinh, @socm, @ngaydp, @ngaytp, @tienphong, @chiphiphu, @tongtien, @nv)
	

---------------------------------------------------------------------------------------------------------
Alter proc [dbo].[cb] 
@so int
as
if @so = 0
	begin
		select Manv,Hoten from NhanVien
	end



-----------------------------------------------------------------------------------------------
Alter Proc [dbo].[hienloaiphong]
@maphong int
as
if(@maphong = 0)
	begin
		select distinct LoaiPhong from GiaPhong
	end
else
	select GiaPhong, LoaiPhong from GiaPhong where MaPhong = @maphong


Create  Proc [dbo].[hienmaphong]
@maphong int
as
if(@maphong = 0)
	begin
		select distinct MaPhong from GiaPhong
	end
else
	select GiaPhong, LoaiPhong from GiaPhong where MaPhong = @maphong
-----------------------------------------------------------------------------------------------------

Alter Proc [dbo].[capnhatgiaphong] 101,500000,N'VIP'
@maphong int,
@giaphong int,
@loaiphong Nvarchar(10)
as
	if(exists(select * from [dbo].[GiaPhong] where Maphong = @maphong))
		begin
			Update [dbo].[GiaPhong]
			set GiaPhong = @giaphong, LoaiPhong = @loaiphong
			where MaPhong = @maphong
			select errcode = 0
		end
	else
		select errcode = 1

-----------------------------------------------------------------------------------------------------------

 alter Proc [dbo].[abc] 
 @maphong int
 as
 if(exists(select MaPhong from Phong where [Maphong] = @maphong))
 select err = 1
 
 ---------------------------------------------------------------------------------------------------

 Alter Proc [dbo].[doimatkhau] N'admin',N'admi',N'admin'
 @taikhoan Nvarchar(50),
 @matkhaucu Nvarchar(50),
 @matkhaumoi Nvarchar(50)
 as
	if(exists(select TaiKhoan From NhanVien where TaiKhoan = @taikhoan and MatKhau = @matkhaucu))
		begin
			Update NhanVien
			Set MatKhau = @matkhaumoi
			Where TaiKhoan = @taikhoan and MatKhau = @matkhaucu
			select errcode = 0
		end
	else
		select errcode = 1

---------------------------------------------------------------------------------------------------

Create Proc [dbo].[tinhtrangphong]
@ma int
as
if(@ma = 0)
begin
	select MaPhong, TinhTrang
	from phong
end
else
begin
	select MaPhong, TinhTrang
	from phong
	where MaPhong = @ma
end
---------------------------------------------------------------------------------------------------

Alter PROC timkhachhang 
@chuoi nvarchar(50)
AS
SELECT MaPhong, TenKh, SoCm, NamSinh, NgayDp, NgayTp
FROM phong
WHERE TenKh LIKE '%' + @chuoi + '%' or SoCm like '%' + @chuoi + '%' or NamSinh like '%' + @chuoi + '%'

---------------------------------------------------------------------------------------------------

create proc danhsachphong 
@ma int 
as 
if(@ma = 0)
begin
	select GiaPhong.Maphong, phong.TinhTrang, GiaPhong.GiaPhong, GiaPhong.LoaiPhong
	from GiaPhong inner join phong on GiaPhong.Maphong = phong.MaPhong
end

---------------------------------------------------------------------------------------------------

create proc danhsachphongt 0
@ma int 
as 
if(@ma = 0)
begin
	select GiaPhong.Maphong, phong.TinhTrang, GiaPhong.GiaPhong, GiaPhong.LoaiPhong
	from GiaPhong inner join phong on GiaPhong.Maphong = phong.MaPhong
	where TinhTrang = N'Trống'
end

---------------------------------------------------------------------------------------------------

create proc danhsachphongkt 0
@ma int 
as 
if(@ma = 0)
begin
	select GiaPhong.Maphong, phong.TinhTrang, GiaPhong.GiaPhong, GiaPhong.LoaiPhong
	from GiaPhong inner join phong on GiaPhong.Maphong = phong.MaPhong
	where TinhTrang = N'Không'
end

---------------------------------------------------------------------------------------------------
create proc doanhthu 
@ma int
as
if(@ma = 0)
	begin
		select MaPhong, TongTien
		from luuthongtinphong
	end
else
	begin
		select  MaPhong, TongTien
		from luuthongtinphong
		where MaPhong = @ma
	end

---------------------------------------------------------------------------------------------------
Alter PROC doanhthuthang 
@chuoi nvarchar(50)
AS
select MaPhong, TongTien
from luuthongtinphong
WHERE (left([NgayDp],2) = @chuoi) and (left([NgayTp],2) = @chuoi)
--LIKE '%' + @chuoi + '%' or left([NgayDp],2) LIKE '%' + @chuoi + '%'

---------------------------------------------------------------------------------------------------
create proc laygame 1
@ma int
as
select  Cauhoi, Dapan from game where ma = @ma

---------------------------------------------------------------------------------------------------
alter proc report 1
@ma int
as
if(@ma = 0)
begin
	select MaPhong, MaKh, TenKh, NamSinh, SoCm, NgayDp, NgayTp, TienPhong, ChiPhiPhu, TongTien, NvLap
	from luuthongtinphong
end
else
begin
	select MaPhong, MaKh, TenKh, NamSinh, SoCm, NgayDp, NgayTp, TienPhong, ChiPhiPhu, TongTien, NvLap
	from luuthongtinphong
	where MaKh = @ma
end

---------------------------------------------------------------------------------------------------
alter proc laymakhachhang 
@maphong int,
@tenkh nvarchar(50),
@tongtien int
as
	select MaKh
	from luuthongtinphong
	where MaPhong = @maphong and TenKh = @tenkh and TongTien = @tongtien

---------------------------------------------------------------------------------------------------
Alter proc laytrangthaianhien --0,N'Hiện'
@ma int,
@trangthai nvarchar(10)
as
if(@ma = 0 and @trangthai = N'Hiện')
	begin
		select Maphong from SuaPhong where TrangThai = @trangthai
	end
if(@ma = 0 and @trangthai = N'Ẩn')
	begin
		select Maphong from SuaPhong where TrangThai = @trangthai
	end
---------------------------------------------------------------------------------------------------
create proc suatrangthaianhien 505,N'Ẩn'
@ma int,
@trangthai nvarchar(10)
as
update  Suaphong set TrangThai = @trangthai where Maphong = @ma
---------------------------------------------------------------------------------------------------
Create proc txp
@ma int
as
	select * from SuaPhong where Maphong = @ma