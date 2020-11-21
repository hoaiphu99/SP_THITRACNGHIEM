USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiSuaBD]    Script Date: 11/21/2020 10:27:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiSuaBD](@NewMaCauHoi int, @OldMaCauHoi int, @OldMaGV char(8),  @OldMaMH char(5), @OldTrinhDo char(1), @OldNoiDung nvarchar(500),  @OldA nvarchar(100), @OldB nvarchar(100), @OldC nvarchar(100), @OldD nvarchar(100), @OldDapAn char(1))
as

begin
	declare @ErorStr nvarchar(200)

	--còn 1 trường hợp làm cho sp sửa lỗi đó là ai đó xoá hoặc sửa mã cái câu hỏi đã sửa, chỉ cần xét mã vì câu lệnh update chỉ cần mã
	if not exists(SELECT CAUHOI FROM  dbo.BODE WHERE CAUHOI = @NewMaCauHoi)
		begin
			set @ErorStr = N'Phục hồi sửa thất bại! Mã câu hỏi mới"'+ rtrim(convert(nvarchar(200),@NewMaCauHoi)) +N'" đã sửa lúc trước không tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
	
	--nếu như mã câu hỏi cũ và mới bằng nhau thì khỏi ktra trùng làm gì, còn nếu khác thì kiểm tra cái mã câu hỏi cũ có tồn tại chưa để còn sửa thành nó
	if (@NewMaCauHoi != @OldMaCauHoi)
		if exists(SELECT CAUHOI FROM  dbo.BODE WHERE CAUHOI = @OldMaCauHoi)
			begin
				set @ErorStr = N'Phục hồi sửa thất bại! Mã câu hỏi cũ "'+ rtrim(convert(nvarchar(200),@OldMaCauHoi)) +N'" đã sửa lúc trước đang tồn tại nên không thể sửa! Đã có người khác hiệu chỉnh!' 
				raiserror (@ErorStr,16,1)
				return
			end	
	
	update [dbo].[BODE] set CAUHOI = @OldMaCauHoi,  MAGV = @OldMaGV ,MAMH = @OldMaMH, TRINHDO = @OldTrinhDo ,NOIDUNG = @OldNoiDung,A = @OldA, B=@OldB, C=@OldC, D=@OldD, DAP_AN=@OldDapAn 
	where CAUHOI = @NewMaCauHoi
end
GO

