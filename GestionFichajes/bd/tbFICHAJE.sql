-- tbFICHAJE
---------------------------------------------------------------------------------------------------------------------------
-- TABLA
USE [TEST]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[tbFICHAJE]
(
	[id] [uniqueidentifier] NOT NULL DEFAULT (newId()),
	[empresa] [int] NOT NULL DEFAULT 1,
	[empleado] [int] NOT NULL DEFAULT 0,
	[fecha] [datetime] NOT NULL DEFAULT GETDATE(),
	[horas] [int] NULL DEFAULT 0,
	[minutos] [int] NOT NULL DEFAULT 0,
	[concepto] [varchar](2) NOT NULL DEFAULT '00',
	[anho] [int] NOT NULL DEFAULT YEAR(GETDATE()),
	[borrado] [int] NOT NULL DEFAULT 0,
	[userc] [varchar](80) NULL,
	[hostc] [varchar](80) NULL,
	[datec] [datetime] NULL,
	[usera] [varchar](80) NULL,
	[hosta] [varchar](80) NULL,
	[datea] [datetime] NULL,
	[version] [int] NOT NULL DEFAULT 0,
	
	CONSTRAINT [PK_tbFICHAJE] PRIMARY KEY CLUSTERED ([id])
) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [IX_tbFICHAJE] ON [dbo].[tbFICHAJE] ([empleado])

GO

CREATE NONCLUSTERED INDEX [IX_tbFICHAJE_2] ON [dbo].[tbFICHAJE] ([fecha])

GO

SET ANSI_PADDING OFF
GO


---------------------------------------------------------------------------------------------------------------------------
-- TRIGGERS
USE [TEST]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[ins_tbFICHAJE] ON [dbo].[tbFICHAJE] AFTER INSERT
AS BEGIN  

	SET NOCOUNT ON 
	
	UPDATE [dbo].[tbFICHAJE] SET
		userc = user_name(),
		hostc = host_name(),
		datec = getdate()
	FROM inserted WHERE tbFICHAJE.id = inserted.id 
END

---------------------------------------------------------------------------------------------------------------------------

USE [TEST]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[upd_tbFICHAJE] ON [dbo].[tbFICHAJE] AFTER UPDATE 
AS BEGIN 

	SET NOCOUNT ON 
	
	UPDATE [dbo].[tbFICHAJE] SET
		usera = user_name(),
		hosta = host_name(),
		datea = getdate()
	FROM inserted WHERE tbFICHAJE.id = inserted.id
END

SELECT TOP 10 * FROM Test.dbo.tbFICHAJE WITH (NOLOCK)
-- INSERT INTO Test.dbo.tbFICHAJE ([empresa],[empleado],[fecha],[horas],[minutos],[concepto])VALUES(1, 666, '14-11-2017 16:13:00.000', 6, 54.32, '63')
-- INSERT INTO Test.dbo.tbFICHAJE ([empresa],[empleado],[fecha],[horas],[minutos],[concepto])VALUES(1, 666, '15-11-2017 12:11:00.000', 4, 0.54, '00')

SELECT COUNT(*) FROM [bd_epsilon].[dbo].[tbFICHAJE] WITH (NOLOCK) WHERE borrado = 0
-- DELETE FROM [bd_epsilon].[dbo].[tbFICHAJE]