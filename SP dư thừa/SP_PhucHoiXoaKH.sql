USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiXoaKH]    Script Date: 11/27/2020 11:34:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiXoaKH](@MaKH nchar(8), @TenKH nvarchar(50), @MaCS nchar(3))
as

begin
	declare @ErorStr nvarchar(200)

	--site chính
	--nếu như định thêm lại nhưng mã khoa đã xoá đang có
	if exists(SELECT MAKH FROM  dbo.KHOA WHERE MAKH = @MaKH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã khoa "'+ rtrim(convert(nvarchar(200),@MaKH)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	--nếu như định thêm lại nhưng tên khoa đã xoá đang có		
   	if exists(SELECT TENKH FROM  dbo.KHOA WHERE TENKH = @TenKH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Tên khoa "'+ rtrim(convert(nvarchar(200),@TenKH)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end		
	
	--site phụ
	--nếu như định thêm lại nhưng mã khoa đã xoá đang có
	if exists(SELECT MAKH FROM  LINK1.TN_CSDLPT.dbo.KHOA WHERE MAKH = @MaKH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã khoa "'+ rtrim(convert(nvarchar(200),@MaKH)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	--nếu như định thêm lại nhưng tên khoa đã xoá đang có		
   	if exists(SELECT TENKH FROM  LINK1.TN_CSDLPT.dbo.KHOA WHERE TENKH = @TenKH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Tên khoa "'+ rtrim(convert(nvarchar(200),@TenKH)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	insert into [dbo].[KHOA] ( MAKH, TENKH, MACS ) values (@MaKH, @TenKH, @MaCS)
end


GO

