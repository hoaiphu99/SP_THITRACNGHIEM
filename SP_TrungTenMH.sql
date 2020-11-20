USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_TrungTenMH]    Script Date: 11/20/2020 5:10:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[SP_TrungTenMH](@TENMH nvarchar(50))
as

begin
	if exists(SELECT TENMH FROM  dbo.MONHOC WHERE TENMH = @TENMH)
   		raiserror ('Tên môn học đã tồn tại!',16,1)
end
GO

