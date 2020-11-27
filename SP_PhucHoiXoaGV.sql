USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiXoaGV]    Script Date: 11/27/2020 11:34:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiXoaGV](@MaGV char(8), @Ho varchar(40), @Ten varchar(10), @HocVi varchar(50), @MaKH nchar(8))
as

begin
	declare @ErorStr nvarchar(200)

	--nếu như định thêm lại nhưng mã giáo viên đã xoá đang có
	if exists(SELECT MAGV FROM  dbo.GIAOVIEN WHERE MAGV = @MaGV)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã giáo viên "'+ rtrim(convert(nvarchar(200),@MaGV)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
	--khoá ngoại
	--xoá giáo viên thì có thể khoa ko còn giáo viên -> khoa có thể bị xoá
	--nếu có người xoá mã khoa của giáo viên này thì ko thể thêm giáo viên này  lại
	if not exists(SELECT MAKH FROM  dbo.KHOA WHERE MAKH = @MaKH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã khoa "'+ rtrim(convert(nvarchar(200),@MaKH)) +N'" đã xoá lúc trước bây giờ không tồn tại nữa nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
		
	insert into [dbo].[GIAOVIEN] (MAGV,HO, TEN,HOCVI,MAKH) 
	values (@MaGV ,  @Ho , @Ten , @HocVi , @MaKH)
end
GO

