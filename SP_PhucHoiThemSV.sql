USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiThemSV]    Script Date: 11/27/2020 11:34:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiThemSV](@NewMaSV char(8))
as

begin
	declare @ErorStr nvarchar(200)

	--đã thêm thì giờ xoá, kiếm thấy mã sinh viên thì mới xoá đc
	if exists(SELECT MASV FROM  dbo.SINHVIEN WHERE MASV = @NewMaSV)		
   			delete  dbo.GIAOVIEN where MAGV = @NewMaSV
	else
		begin
			set @ErorStr = N'Phục hồi thêm thất bại! Mã sinh viên "'+ rtrim(convert(nvarchar(200),@NewMaSV)) +N'" đã thêm bây giờ không tồn tại nên không thể xoá! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
		end	
end
GO

