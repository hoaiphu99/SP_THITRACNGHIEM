USE [TN_CSDLPT]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_XuatDiemChu]    Script Date: 12/16/2020 15:08:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[FN_XuatDiemChu]
	(@DIEM FLOAT)
	RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @Result nvarchar(10), @StrThem nvarchar(10)
	SET @Result = ''
	SET @StrThem =''

	--TRƯỜNG HỢP ĐẶC BIỆT
	IF(@DIEM = 0.5) RETURN N'Nửa điểm'

	--ĐIỂM LÀM TRÒN TỚI NỬA ĐIỂM NÊN CHỈ DƯ 0.5 HOẶC KO DƯ
	--NẾU NHƯ CÓ PHẦN DƯ (VD statement: 3.5 - 3 = 0.5 > 0)
	IF (@DIEM - FLOOR(@DIEM) > 0) 
	BEGIN
		SET @StrThem = N' rưỡi'
		SET @DIEM = @DIEM - 0.5 --LÀM TRÒN ĐIỂM
	END
	
	IF (@DIEM = 0) SET @RESULT = N'Không' 
	ELSE IF (@DIEM = 1) SET @RESULT = N'Một' 
	ELSE IF (@DIEM = 2) SET @RESULT = N'Hai' 
	ELSE IF (@DIEM = 3) SET @RESULT = N'Ba' 
	ELSE IF (@DIEM = 4) SET @RESULT = N'Bốn' 
	ELSE IF (@DIEM = 5) SET @RESULT = N'Năm' 
	ELSE IF (@DIEM = 6) SET @RESULT = N'Sáu' 
	ELSE IF (@DIEM = 7) SET @RESULT = N'Bảy' 
	ELSE IF (@DIEM = 8) SET @RESULT = N'Tám' 
	ELSE IF (@DIEM = 9) SET @RESULT = N'Chín' 
	ELSE IF (@DIEM = 10) SET @RESULT = N'Mười'

	SET @RESULT = @RESULT + @StrThem
	RETURN @RESULT
END
GO

