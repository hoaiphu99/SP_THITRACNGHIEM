USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiSuaKH]    Script Date: 11/27/2020 11:32:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiSuaKH](@NewMaKH nchar(8), @NewTenKH nvarchar(50), @OldMaKH nchar(8), @OldTenKH nvarchar(50), @OldMaCS nchar(3))
as

begin
	declare @ErorStr nvarchar(200)

	--còn 1 trường hợp làm cho sp sửa lỗi đó là ai đó xoá hoặc sửa mã cái KHOA đã sửa, chỉ cần xét mã vì câu lệnh update chỉ cần mã
	--chỉ cần ktra site đang làm việc vì người phục hồi đc thì ko chuyển cơ sở đc, nên chỉ sửa đc những cái của site đang làm việc
	if not exists(SELECT MAKH FROM  dbo.KHOA WHERE MAKH = @NewMaKH)
		begin
			set @ErorStr = N'Phục hồi sửa thất bại! Mã khoa mới"'+ rtrim(convert(nvarchar(200),@NewMaKH)) +N'" đã sửa lúc trước không tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
	
	--site chính
	--nếu như mã khoa cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái mã kh cũ có tồn tại chưa để còn sửa thành nó
	if (@NewMaKH != @OldMaKH)
		if exists(SELECT MAKH FROM  dbo.KHOA WHERE MAKH = @OldMaKH)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Mã khoa cũ"'+ rtrim(convert(nvarchar(200),@OldMaKH)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	--nếu như tên môn học cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái tên mh cũ có tồn tại chưa để còn sửa thành nó
   	if (@NewTenKH != @OldTenKH)
		if exists(SELECT TENKH FROM  dbo.KHOA WHERE TENKH = @OldTenKH)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Tên khoa cũ "'+ rtrim(convert(nvarchar(200),@OldTenKH)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	--site phụ
	--nếu như mã khoa cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái mã kh cũ có tồn tại chưa để còn sửa thành nó
	if (@NewMaKH != @OldMaKH)
		if exists(SELECT MAKH FROM  LINK1.TN_CSDLPT.dbo.KHOA WHERE MAKH = @OldMaKH)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Mã khoa cũ"'+ rtrim(convert(nvarchar(200),@OldMaKH)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	--nếu như tên môn học cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái tên mh cũ có tồn tại chưa để còn sửa thành nó
   	if (@NewTenKH != @OldTenKH)
		if exists(SELECT TENKH FROM  LINK1.TN_CSDLPT.dbo.KHOA WHERE TENKH = @OldTenKH)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Tên khoa cũ "'+ rtrim(convert(nvarchar(200),@OldTenKH)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	update [dbo].[KHOA] set MAKH = @OldMaKH, TENKH = @OldTenKH, MACS = @OldMaCS where MAKH = @NewMaKH
end
GO

