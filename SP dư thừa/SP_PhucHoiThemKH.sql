USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiThemKH]    Script Date: 11/27/2020 11:33:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiThemKH](@NewMaKH nchar(8))
as

begin
	declare @ErorStr nvarchar(200)

	--đã thêm thì giờ xoá, kiếm thấy mã khoa thì mới xoá đc
	if exists(SELECT MAKH FROM  dbo.KHOA WHERE MAKH = @NewMaKH)		
   			delete  dbo.KHOA where MAKH = @NewMaKH
	else
		begin
			set @ErorStr = N'Phục hồi thêm thất bại! Mã khoa "'+ rtrim(convert(nvarchar(200),@NewMaKH)) +N'" đã thêm bây giờ không tồn tại nên không thể xoá! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
		end	
end
GO

