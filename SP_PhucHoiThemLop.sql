USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiThemLop]    Script Date: 11/24/2020 9:54:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiThemLop](@NewMaLop char(8))
as

begin
	declare @ErorStr nvarchar(200)

	--đã thêm thì giờ xoá, kiếm thấy mã lớp thì mới xoá đc
	if exists(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @NewMaLop)		
   			delete  dbo.LOP where MALOP = @NewMaLop
	else
		begin
			set @ErorStr = N'Phục hồi thêm thất bại! Mã lớp "'+ rtrim(convert(nvarchar(200),@NewMaLop)) +N'" đã thêm bây giờ không tồn tại nên không thể xoá! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
		end	
end
GO

