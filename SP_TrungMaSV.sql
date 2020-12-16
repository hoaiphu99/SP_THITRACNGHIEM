USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_TrungMaSV]    Script Date: 12/16/2020 14:22:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TrungMaSV]
	@MASV CHAR(8)
AS
BEGIN
	IF EXISTS(SELECT MASV FROM  dbo.SINHVIEN WHERE MASV = @MASV)
   		RAISERROR ('Mã sinh viên đã tồn tại!',16,1)
END
GO

