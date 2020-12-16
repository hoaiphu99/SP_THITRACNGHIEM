USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiXoaLop]    Script Date: 11/27/2020 11:35:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiXoaLop](@MaLop char(8), @TenLop nvarchar(50), @MaKH nchar(8))
as

begin
	declare @ErorStr nvarchar(200)

	--site chính
	--nếu như định thêm lại nhưng mã lớp đã xoá đang có
	if exists(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @MaLop)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã lớp "'+ rtrim(convert(nvarchar(200),@MaLop)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	--nếu như định thêm lại nhưng tên lớp đã xoá đang có		
   	if exists(SELECT TENLOP FROM  dbo.LOP WHERE TENLOP = @TenLop)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Tên lớp "'+ rtrim(convert(nvarchar(200),@TenLop)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end		
	
	--site phụ 
	--nếu như định thêm lại nhưng mã lớp đã xoá đang có
	if exists(SELECT MALOP FROM  LINK1.TN_CSDLPT.dbo.LOP WHERE MALOP = @MaLop)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã lớp "'+ rtrim(convert(nvarchar(200),@MaLop)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	--nếu như định thêm lại nhưng tên lớp đã xoá đang có		
   	if exists(SELECT TENLOP FROM  LINK1.TN_CSDLPT.dbo.LOP WHERE TENLOP = @TenLop)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Tên lớp "'+ rtrim(convert(nvarchar(200),@TenLop)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end		
	

	insert into [dbo].LOP ( MALOP, TENLOP, MAKH ) values (@MaLop, @TenLop, @MaKH)
end
GO

