USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiSuaMH]    Script Date: 11/20/2020 5:08:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiSuaMH](@NewMaMH char(5), @NewTenMH nvarchar(50), @OldMaMH char(5), @OldTenMH nvarchar(50))
as

begin
	declare @ErorStr nvarchar(200)

	--còn 1 trường hợp làm cho sp sửa lỗi đó là ai đó xoá hoặc sửa mã cái môn học đã sửa, chỉ cần xét mã vì câu lệnh update chỉ cần mã
	if not exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @NewMaMH)
		begin
			set @ErorStr = N'Phục hồi sửa thất bại! Mã môn học mới "'+ rtrim(convert(nvarchar(200),@NewMaMH)) +N'" đã sửa lúc trước không tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
	
	--nếu như mã môn học cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái mã mh cũ có tồn tại chưa để còn sửa thành nó
		if (@NewMaMH != @OldMaMH)
			if exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @OldMaMH)
				begin
					set @ErorStr = N'Phục hồi sửa thất bại! Mã môn học cũ "'+ rtrim(convert(nvarchar(200),@OldMaMH)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
					raiserror (@ErorStr,16,1)
					return
				end	
	
	--nếu như tên môn học cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái tên mh cũ có tồn tại chưa để còn sửa thành nó
   		if (@NewTenMH != @OldTenMH)
			if exists(SELECT TENMH FROM  dbo.MONHOC WHERE TENMH = @OldTenMH)
				begin
					set @ErorStr = N'Phục hồi sửa thất bại! Tên môn học "'+ rtrim(convert(nvarchar(200),@OldTenMH)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
					raiserror (@ErorStr,16,1)
					return
				end	
	
		update [dbo].[MONHOC] set MAMH = @OldMaMH, TENMH = @OldTenMH where MAMH = @NewMaMH
end
GO

