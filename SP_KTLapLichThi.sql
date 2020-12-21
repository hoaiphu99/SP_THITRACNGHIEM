USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_KTLapLichThi]    Script Date: 12/21/2020 11:14:45 AM ******/
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
	END
    
	--nếu như chưa đăng ký 
	--nếu là lần 2 thì kiểm tra nó có lớn hơn ngày thi lần 1 ko
	IF(@LAN = 2)
	BEGIN
		IF NOT EXISTS(
		SELECT * 
		FROM dbo.BANGDIEM BD JOIN dbo.GIAOVIEN_DANGKY GVDK
		ON GVDK.MAMH = BD.MAMH AND GVDK.LAN = BD.LAN AND MASV IN(SELECT MASV FROM SINHVIEN WHERE MALOP = @MALOP) AND BD.MAMH = @MAMH AND MALOP = @MALOP AND BD.LAN = 1)
		BEGIN
			RAISERROR('Lần 1 chưa thi, không được đăng ký lần 2!', 16, 1)
		END

		IF NOT EXISTS(SELECT * FROM dbo.GIAOVIEN_DANGKY WHERE MAMH = @MAMH AND MALOP = @MALOP AND LAN = 1 AND NGAYTHI < Convert(datetime, @NGAYTHI))
		BEGIN
			RAISERROR('Ngày thi lần 2 phải lớn hơn ngày thi của lần 1!', 16, 1)
		END
	END
END
GO

