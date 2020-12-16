USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiXoaBD]    Script Date: 11/27/2020 11:34:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiXoaBD](@MaGV char(8),  @MaMH char(5), @TrinhDo char(1), @NoiDung nvarchar(500),  @A nvarchar(100), @B nvarchar(100), @C nvarchar(100), @D nvarchar(100), @DapAn char(1))
as

begin
	declare @ErorStr nvarchar(200)

	--khoá chính MaCauHoi là id tự động tăng, nên ko cần ktra trùng gì cả

	--khoá ngoại
	--xoá câu hỏi thì có thể giáo viên và môn học ko còn câu hỏi -> giáo viên, môn học có thể bị xoá
	--nếu có người xoá mã môn học của câu hỏi này thì ko thể thêm câu hỏi này  lại
	if not exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @MaMH)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã môn học "'+ rtrim(convert(nvarchar(200),@MaMH)) +N'" đã xoá lúc trước bây giờ không tồn tại nữa nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
		
	--nếu có người xoá mã giáo viên của câu hỏi này thì ko thể thêm câu hỏi này lại
	if not exists(SELECT MAGV FROM  dbo.GIAOVIEN WHERE MAGV = @MaGV)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã giáo viên "'+ rtrim(convert(nvarchar(200),@MaGV)) +N'" đã xoá lúc trước bây giờ không tồn tại nữa nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
		
	insert into [dbo].[BODE] (MAGV,MAMH, TRINHDO,NOIDUNG,A, B, C, D, DAP_AN) 
	values (@MaGV ,  @MaMH , @TrinhDo , @NoiDung ,  @A , @B , @C , @D , @DapAn )
end
GO

