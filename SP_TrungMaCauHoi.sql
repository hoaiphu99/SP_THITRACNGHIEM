USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_TrungMaCauHoi]    Script Date: 11/21/2020 10:30:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_TrungMaCauHoi] (@MaCauHoi int)
as
begin
	if exists(SELECT CAUHOI FROM  dbo.BODE WHERE CAUHOI = @MaCauHoi)
   		raiserror ('Mã câu hỏi đã tồn tại!',16,1)
end
GO

