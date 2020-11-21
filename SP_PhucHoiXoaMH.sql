USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiXoaMH]    Script Date: 11/21/2020 10:28:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiXoaMH](@MaMH char(5), @TenMH nvarchar(50))
as

begin
	declare @ErorStr nvarchar(200)

	--nếu như định thêm lại nhưng mã môn học đã xoá đang có
	if exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @MaMH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã môn học "'+ rtrim(convert(nvarchar(200),@MaMH)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
	--nếu như định thêm lại nhưng tên môn học đã xoá đang có		
   	if exists(SELECT TENMH FROM  dbo.MONHOC WHERE TENMH = @TenMH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Tên môn học "'+ rtrim(convert(nvarchar(200),@TenMH)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end		
	
	insert into [dbo].[MONHOC] ( MAMH, TENMH ) values (@MaMH, @TenMH)
end
GO

