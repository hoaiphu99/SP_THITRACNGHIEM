USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_KTLapLichThi]    Script Date: 12/15/2020 17:18:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_KTLapLichThi]
	@MAMH NCHAR(5), 
	@MALOP NCHAR(8), 
	@LAN int
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.GIAOVIEN_DANGKY WHERE MAMH = @MAMH AND MALOP = @MALOP AND LAN = @LAN)
	BEGIN
		RAISERROR('Đã lập lịch thi cho môn này!', 16, 1)
	END
    ELSE
		RETURN 1
END
GO

