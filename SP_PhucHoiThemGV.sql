USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiThemGV]    Script Date: 11/27/2020 11:33:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiThemGV](@NewMaGV char(8))
as

begin
	declare @ErorStr nvarchar(200)

	--đã thêm thì giờ xoá, kiếm thấy mã giáo viên thì mới xoá đc
	if exists(SELECT MAGV FROM  dbo.GIAOVIEN WHERE MAGV = @NewMaGV)		
   			delete  dbo.GIAOVIEN where MAGV = @NewMaGV
	else
		begin
			set @ErorStr = N'Phục hồi thêm thất bại! Mã giáo viên "'+ rtrim(convert(nvarchar(200),@NewMaGV)) +N'" đã thêm bây giờ không tồn tại nên không thể xoá! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
		end	
end
GO

