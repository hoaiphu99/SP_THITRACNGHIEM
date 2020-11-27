USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiSuaSV]    Script Date: 11/27/2020 11:33:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiSuaSV](@MaSV char(8), @OldHo nvarchar(50), @OldTen nvarchar(10), @OldNgaySinh char(10), @OldDiaChi nvarchar(500), @OldMaLop char(8))
as

begin
	declare @ErorStr nvarchar(200)

	--khoá chính ko đc sửa nên ko kiểm tra

	--khoá ngoại
	--mã lớp đc phép sửa, nên khi sửa thì có thể lớp đó hết sinh viên -> lớp đc xoá, vậy nên phải ktra mã lớp
	--nếu có người xoá mã khoa của giáo viên này thì ko thể sửa giáo viên này lại
	if not exists(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @OldMaLop)
		begin
			set @ErorStr = N'Phục hồi sửa thất bại! Mã lớp cũ "'+ rtrim(convert(nvarchar(200),@OldMaLop)) +N'" đã sửa lúc trước bây giờ không tồn tại nữa nên không thể sửa! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	update [dbo].[SINHVIEN] set HO = @OldHo, TEN = @OldTen, NGAYSINH = @OldNgaySinh, DIACHI = @OldDiaChi, MALOP = @OldMaLop
	where MASV = @MaSV
end
GO

