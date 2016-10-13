USE [CWM]
GO

/****** Object:  Table [dbo].[ADDITIONALSERVICE]    Script Date: 11/15/2014 20:43:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ADDITIONALSERVICE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ASNAME] [nvarchar](max) NOT NULL,
	[COST] [int] NOT NULL,
 CONSTRAINT [PK_ADDITIONALSERVICE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

