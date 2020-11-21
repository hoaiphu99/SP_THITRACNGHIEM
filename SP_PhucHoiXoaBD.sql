USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_PhucHoiXoaBD]    Script Date: 11/21/2020 10:28:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_PhucHoiXoaBD](@MaCauHoi int, @MaGV char(8),  @MaMH char(5), @TrinhDo char(1), @NoiDung nvarchar(500),  @A nvarchar(100), @B nvarchar(100), @C nvarchar(100), @D nvarchar(100), @DapAn char(1))
as

begin
	declare @ErorStr nvarchar(200)

	--nếu như định thêm lại nhưng mã câu hỏi đã xoá đang có
	if exists(SELECT CAUHOI FROM  dbo.BODE WHERE CAUHOI = @MaCauHoi)
		begin
			set @ErorStr = N'Phục hồi xoá thất bại! Mã câu hỏi "'+ rtrim(convert(nvarchar(200),@MaCauHoi)) +N'" đã xoá đang tồn tại nên không thể thêm! Đã có người khác hiệu chỉnh!' 
			raiserror (@ErorStr,16,1)
			return
		end	
		
	insert into [dbo].[BODE] ( CAUHOI,  MAGV,MAMH, TRINHDO,NOIDUNG,A, B, C, D, DAP_AN) 
	values (@MaCauHoi , @MaGV ,  @MaMH , @TrinhDo , @NoiDung ,  @A , @B , @C , @D , @DapAn )
end
GO

