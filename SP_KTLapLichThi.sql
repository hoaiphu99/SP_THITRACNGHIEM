USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_KTLapLichThi]    Script Date: 12/21/2020 11:09:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[SP_KTLapLichThi]
	@MAMH NCHAR(5), 
	@MALOP NCHAR(8), 
	@LAN int,
	@NGAYTHI VARCHAR(10)
AS
BEGIN
	IF EXISTS(SELECT * FROM dbo.GIAOVIEN_DANGKY WHERE MAMH = @MAMH AND MALOP = @MALOP AND LAN = @LAN)
	BEGIN
		RAISERROR('Đã lập lịch thi cho môn này!', 16, 1)
		RETURN
	END
    
	--nếu như chưa đăng ký 
	--nếu là lần 2 thì kiểm tra nó có lớn hơn ngày thi lần 1 ko
	IF(@LAN = 2)
	BEGIN
		IF NOT EXISTS(
		SELECT * 
		FROM dbo.BANGDIEM 
		WHERE MAMH = @MAMH AND LAN = 1 AND MASV IN(SELECT MASV FROM SINHVIEN WHERE MALOP = @MALOP))
		BEGIN
			RAISERROR('Lần 1 chưa thi, không được đăng ký lần 2!', 16, 1)
			RETURN
		END

		IF NOT EXISTS(SELECT * FROM dbo.GIAOVIEN_DANGKY WHERE MAMH = @MAMH AND MALOP = @MALOP AND LAN = 1 AND NGAYTHI < Convert(datetime, @NGAYTHI))
		BEGIN
			RAISERROR('Ngày thi lần 2 phải lớn hơn ngày thi của lần 1!', 16, 1)
			RETURN
		END
	END
END
GO

