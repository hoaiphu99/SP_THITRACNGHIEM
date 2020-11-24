USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiSuaLop]    Script Date: 11/24/2020 9:54:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_PhucHoiSuaLop](@NewMaLop char(8), @NewTenLop nvarchar(50), @OldMaLop char(8), @OldTenLop nvarchar(50), @OldMaKH nchar(8))
as

begin
	declare @ErorStr nvarchar(200)

	--còn 1 trường hợp làm cho sp sửa lỗi đó là ai đó xoá hoặc sửa mã cái LOP đã sửa, chỉ cần xét mã vì câu lệnh update chỉ cần mã
	--chỉ cần ktra site đang làm việc vì người phục hồi đc thì ko chuyển cơ sở đc, nên chỉ sửa đc những cái của site đang làm việc
	if not exists(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @NewMaLop)
		begin
			set @ErorStr = N'Phục hồi sửa thất bại! Mã lớp mới"'+ rtrim(convert(nvarchar(200),@NewMaLop)) +N'" đã sửa lúc trước không tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
	
	--site chính
	--nếu như mã lớp cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái mã lớp cũ có tồn tại chưa để còn sửa thành nó
	if (@NewMaLop != @OldMaLop)
		if exists(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @OldMaLop)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Mã lớp cũ"'+ rtrim(convert(nvarchar(200),@OldMaLop)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	--nếu như tên lớp cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái tên lớp cũ có tồn tại chưa để còn sửa thành nó
   	if (@NewTenLop != @OldTenLop)
		if exists(SELECT TENLOP FROM  dbo.LOP WHERE TENLOP = @OldTenLop)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Tên lớp cũ "'+ rtrim(convert(nvarchar(200),@OldTenLop)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	--site phụ 
	--nếu như mã lớp cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái mã lớp cũ có tồn tại chưa để còn sửa thành nó
	if (@NewMaLop != @OldMaLop)
		if exists(SELECT MALOP FROM  LINK1.TN_CSDLPT.dbo.LOP WHERE MALOP = @OldMaLop)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Mã lớp cũ"'+ rtrim(convert(nvarchar(200),@OldMaLop)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	--nếu như tên lớp cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái tên lớp cũ có tồn tại chưa để còn sửa thành nó
   	if (@NewTenLop != @OldTenLop)
		if exists(SELECT TENLOP FROM  LINK1.TN_CSDLPT.dbo.LOP WHERE TENLOP = @OldTenLop)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Tên lớp cũ "'+ rtrim(convert(nvarchar(200),@OldTenLop)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	update [dbo].[LOP] set MALOP = @OldMaLop, TENLOP = @OldTenLop, MAKH = @OldMaKH where MALOP = @NewMaLop
end
GO

