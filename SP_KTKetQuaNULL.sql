USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_KTKetQuaNULL]    Script Date: 12/15/2020 17:17:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_KTKetQuaNULL]
	@MASV NCHAR(8),
	@MAMH NCHAR(5),
	@LAN SMALLINT,
	@NGAYTHI DATETIME
AS
BEGIN
	IF EXISTS (
		SELECT STT, BODE.CAUHOI, NOIDUNG, A, B, C, D, DAP_AN, DACHON 
		FROM dbo.CT_BAITHI JOIN dbo.BODE 
		ON BODE.CAUHOI = CT_BAITHI.CAUHOI 
		WHERE (SELECT IDBD FROM dbo.BANGDIEM WHERE MASV = @MASV AND MAMH = @MAMH AND LAN = @LAN AND NGAYTHI = @NGAYTHI) = IDBD
	)
	BEGIN
		RETURN 1
	END
	ELSE
    BEGIN
    	RAISERROR('Chưa thi môn này!', 16, 1)
    END
END	
GO
