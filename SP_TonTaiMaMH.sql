USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_TonTaiMaMH]    Script Date: 11/21/2020 10:30:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[SP_TonTaiMaMH] (@MaMH char(5))
as
begin
	if not exists(SELECT MAMH FROM  dbo.MONHOC WHERE MAMH = @MaMH)
   		raiserror ('Mã môn học không tồn tại!',16,1)
end
GO

