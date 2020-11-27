USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiXoaSV]    Script Date: 11/27/2020 11:35:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiXoaSV](@MaSV char(8), @Ho nvarchar(50), @Ten nvarchar(10), @NgaySinh char(10), @DiaChi nvarchar(500), @MaLop char(8))
as

begin
	declare @ErorStr nvarchar(200)

	--nếu như định thêm lại nhưng mã sinh viên đã xoá đang có
	if exists(SELECT MASV FROM  dbo.SINHVIEN WHERE MASV = @MaSV)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã sinh viên "'+ rtrim(convert(nvarchar(200),@MaSV)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
	--khoá ngoại
	--xoá sinh viên thì có thể lớp ko còn sinh viên -> lớp có thể bị xoá
	--nếu có người xoá mã lớp của sinh viên này thì ko thể thêm sinh viên này  lại
	if not exists(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @MaLop)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã lớp "'+ rtrim(convert(nvarchar(200),@MaLop)) +N'" đã xoá lúc trước bây giờ không tồn tại nữa nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
		
	insert into [dbo].[SINHVIEN] (MASV,HO, TEN,NGAYSINH,DIACHI,MALOP) 
	values (@MaSV ,  @Ho , @Ten , @NgaySinh , @DiaChi, @MaLop)
end
GO

