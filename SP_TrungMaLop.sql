USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_TrungMaLop]    Script Date: 12/16/2020 14:22:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TrungMaLop]
	@MALOP CHAR(8)
AS
BEGIN
	IF EXISTS(SELECT MALOP FROM  dbo.LOP WHERE MALOP = @MALOP)
   		RAISERROR ('Mã lớp đã tồn tại!',16,1)
END
GO

