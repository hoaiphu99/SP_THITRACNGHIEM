USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_TrungMaGV]    Script Date: 12/16/2020 14:22:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TrungMaGV]
	@MAGV CHAR(8)
AS
BEGIN
	IF EXISTS(SELECT MAGV FROM  dbo.GIAOVIEN WHERE MAGV = @MAGV)
   		RAISERROR ('Mã giáo viên đã tồn tại!',16,1)
END
GO

