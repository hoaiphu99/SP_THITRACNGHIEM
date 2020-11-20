USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiThemMH]    Script Date: 11/20/2020 5:09:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiThemMH](@NewMaMH char(5))
as

begin
	declare @ErorStr nvarchar(200)

	--đã thêm thì giờ xoá, kiếm thấy mã môn học thì mới xoá đc
	if exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @NewMaMH)		
   			delete  dbo.MONHOC where MAMH = @NewMaMH
	else
		begin
			set @ErorStr = N'Phục hồi thêm thất bại! Mã môn học "'+ rtrim(convert(nvarchar(200),@NewMaMH)) +N'" đã thêm bây giờ không tồn tại nên không thể xoá! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
		end	
end
GO

