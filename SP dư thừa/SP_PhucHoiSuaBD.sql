USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiSuaBD]    Script Date: 11/27/2020 11:31:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiSuaBD](@MaCauHoi int, @OldMaGV char(8),  @OldMaMH char(5), @OldTrinhDo char(1), @OldNoiDung nvarchar(500),  @OldA nvarchar(100), @OldB nvarchar(100), @OldC nvarchar(100), @OldD nvarchar(100), @OldDapAn char(1))
as

begin
	declare @ErorStr nvarchar(200)

	--khoá chính ko đc sửa nên ko kiểm tra

	--khoá ngoại
	--mã giáo viên ko đc phép sửa, ai tạo ra câu đó thì của người đó, ko đc sửa
	--mã môn học đc phép sửa, nên khi sửa thì có thể môn học đó hết câu hỏi -> môn học đc xoá, vậy nên phải ktra mã mh
	--nếu có người xoá hay sửa mã môn học của câu hỏi này thì ko thể sửa câu hỏi này  lại
	if not exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @OldMaMH)
		begin
			set @ErorStr = N'Phục hồi sửa thất bại! Mã môn học cũ "'+ rtrim(convert(nvarchar(200),@OldMaMH)) +N'" đã sửa lúc trước bây giờ không tồn tại nữa nên không thể sửa! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	

	update [dbo].[BODE] set MAGV = @OldMaGV ,MAMH = @OldMaMH, TRINHDO = @OldTrinhDo ,NOIDUNG = @OldNoiDung,A = @OldA, B=@OldB, C=@OldC, D=@OldD, DAP_AN=@OldDapAn 
	where CAUHOI = @MaCauHoi
end
GO

