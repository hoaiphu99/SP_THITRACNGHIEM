USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiSuaGV]    Script Date: 11/27/2020 11:32:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiSuaGV](@MaGV char(8), @OldHo varchar(40), @OldTen varchar(10), @OldHocVi varchar(50), @OldMaKH nchar(8))
as

begin
	declare @ErorStr nvarchar(200)

	--khoá chính ko đc sửa nên ko kiểm tra

	--khoá ngoại
	--mã khoa đc phép sửa, nên khi sửa thì có thể khoa đó hết giáo viên -> khoa đc xoá, vậy nên phải ktra mã khoa
	--nếu có người xoá mã khoa của giáo viên này thì ko thể sửa giáo viên này lại
	if not exists(SELECT MAKH FROM  dbo.KHOA WHERE MAKH = @OldMaKH)
		begin
			set @ErorStr = N'Phục hồi sửa thất bại! Mã khoa cũ "'+ rtrim(convert(nvarchar(200),@OldMaKH)) +N'" đã sửa lúc trước bây giờ không tồn tại nữa nên không thể sửa! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	update [dbo].[GIAOVIEN] set HO = @OldHo, TEN = @OldTen, HOCVI = @OldHocVi, MAKH = @OldMaKH
	where MAGV = @MaGV
end
GO

