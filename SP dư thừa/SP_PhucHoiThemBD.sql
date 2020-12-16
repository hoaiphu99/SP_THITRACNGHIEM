USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiThemBD]    Script Date: 11/27/2020 11:33:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiThemBD](@NewMaCauHoi int)
as

begin
	declare @ErorStr nvarchar(200)

	--đã thêm thì giờ xoá, kiếm thấy mã câu hỏi thì mới xoá đc
	if exists(SELECT CAUHOI FROM  dbo.BODE WHERE CAUHOI = @NewMaCauHoi)		
   			delete  dbo.BODE where CAUHOI = @NewMaCauHoi
	else
		begin
			set @ErorStr = N'Phục hồi thêm thất bại! Mã câu hỏi "'+ rtrim(convert(nvarchar(200),@NewMaCauHoi)) +N'" đã thêm bây giờ không tồn tại nên không thể xoá! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
		end	
end
GO

