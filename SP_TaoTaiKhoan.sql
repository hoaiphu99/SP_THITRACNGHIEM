USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_TaoTaiKhoan]    Script Date: 12/16/2020 21:15:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TaoTaiKhoan] 
  @LGNAME VARCHAR(50),
  @PASS VARCHAR(50),
  @USERNAME VARCHAR(50),
  @ROLE VARCHAR(50)
AS
BEGIN
  DECLARE @RET INT
  EXEC @RET= SP_ADDLOGIN @LGNAME, @PASS, 'TN_CSDLPT'                     

  IF (@RET =1)  -- LOGIN NAME BI TRUNG
     RAISERROR('Login name bị trùng', 16, 1)

  EXEC @RET= SP_GRANTDBACCESS @LGNAME, @USERNAME
  IF (@RET =1)  -- USER  NAME BI TRUNG
  BEGIN
       EXEC SP_DROPLOGIN @LGNAME
	   RAISERROR('User name bị trùng', 16, 1)
  END
  EXEC sp_addrolemember @ROLE, @USERNAME

  IF @ROLE= 'TRUONG'
	BEGIN
		EXEC sp_addsrvrolemember @LGNAME, 'sysadmin'
		EXEC sp_addsrvrolemember @LGNAME, 'SecurityAdmin'
		EXEC sp_addsrvrolemember @LGNAME, 'ProcessAdmin'
	END
  IF @ROLE= 'COSO'
	BEGIN
		EXEC sp_addsrvrolemember @LGNAME, 'sysadmin'
		EXEC sp_addsrvrolemember @LGNAME, 'SecurityAdmin'
		EXEC sp_addsrvrolemember @LGNAME, 'ProcessAdmin'
	END 
  IF @ROLE= 'GIANGVIEN'
	BEGIN  
		EXEC sp_addsrvrolemember @LGNAME, 'ProcessAdmin'
	END
	RETURN 0  -- THANH CONG
END

GO

