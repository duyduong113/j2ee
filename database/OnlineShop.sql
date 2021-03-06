USE [master]
GO
/****** Object:  Database [OnlineShop]    Script Date: 03-Jun-17 11:18:28 AM ******/
CREATE DATABASE [OnlineShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\OnlineShop.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'OnlineShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\OnlineShop_log.ldf' , SIZE = 3456KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [OnlineShop] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OnlineShop] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [OnlineShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineShop] SET QUERY_STORE = OFF
GO
USE [OnlineShop]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [OnlineShop]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1]
 (
  @strInput NVARCHAR(4000) 
 ) 
 RETURNS NVARCHAR(4000) 
 AS 
 BEGIN 
 IF @strInput IS NULL 
 RETURN @strInput 
 IF @strInput = '' 
 RETURN @strInput 
 DECLARE @RT NVARCHAR(4000) 
 DECLARE @SIGN_CHARS NCHAR(136) 
 DECLARE @UNSIGN_CHARS NCHAR (136) 
 SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' 
 DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END

GO
/****** Object:  Table [dbo].[About]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[About](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Description] [nvarchar](500) NULL,
	[Image] [nvarchar](250) NULL,
	[Detail] [ntext] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[MetaKeywords] [nvarchar](250) NULL,
	[MetaDescriptions] [nchar](250) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_About] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Banner]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](10) NULL,
	[Advertisement_Name] [nvarchar](250) NULL,
	[Image] [nvarchar](250) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Status] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Banner] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[ParentID] [bigint] NULL,
	[DisplayOrder] [int] NULL,
	[SeoTitle] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[MetaKeywords] [nvarchar](250) NULL,
	[MetaDescriptions] [nchar](250) NULL,
	[Status] [bit] NULL,
	[ShowOnHome] [bit] NULL,
	[Language] [varchar](2) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CheckInventory]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckInventory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_CheckInventory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CheckInventoryDetail]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckInventoryDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CheckInventoryCode] [nvarchar](50) NULL,
	[ProductCode] [varchar](10) NULL,
	[Quantity] [int] NULL,
	[StockOnhand] [int] NULL,
 CONSTRAINT [PK_CheckInventoryDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[City]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](15) NULL,
	[Name] [nvarchar](250) NULL,
	[AreaCode] [varchar](15) NULL,
	[Status] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contact]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Content] [ntext] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Content]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Content](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Description] [nvarchar](500) NULL,
	[Image] [nvarchar](250) NULL,
	[CategoryID] [bigint] NULL,
	[Detail] [ntext] NULL,
	[Warranty] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[MetaKeywords] [nvarchar](250) NULL,
	[MetaDescriptions] [nchar](250) NULL,
	[Status] [bit] NOT NULL,
	[TopHot] [datetime] NULL,
	[ViewCount] [int] NULL,
	[Tags] [nvarchar](500) NULL,
	[Language] [varchar](2) NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentTag]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentTag](
	[ContentID] [bigint] NOT NULL,
	[TagID] [bigint] NOT NULL,
 CONSTRAINT [PK_ContentTag] PRIMARY KEY CLUSTERED 
(
	[ContentID] ASC,
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Credential]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Credential](
	[UserGroupID] [varchar](20) NOT NULL,
	[RoleID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Credential] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[District]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[District](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](15) NULL,
	[Name] [nvarchar](250) NULL,
	[CityCode] [varchar](15) NULL,
	[Status] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Content] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Footer]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Footer](
	[ID] [varchar](50) NOT NULL,
	[Content] [ntext] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Footer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Language]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[ID] [varchar](2) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Menu]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](50) NULL,
	[Link] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[Target] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[TypeID] [int] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuType]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_MenuType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[CustomerID] [bigint] NULL,
	[ShipName] [nvarchar](250) NULL,
	[ShipMobile] [varchar](50) NULL,
	[ShipAddress] [nvarchar](250) NULL,
	[ShipEmail] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrdersDetail]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](10) NOT NULL,
	[OrdersCode] [nvarchar](50) NOT NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Code] [varchar](10) NULL,
	[MetaTitle] [varchar](250) NULL,
	[Description] [nvarchar](500) NULL,
	[Image] [nvarchar](250) NULL,
	[MoreImages] [xml] NULL,
	[Price] [decimal](18, 0) NULL,
	[PromotionPrice] [decimal](18, 0) NULL,
	[IncludedVAT] [bit] NULL,
	[CategoryID] [bigint] NULL,
	[Detail] [ntext] NULL,
	[Warranty] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[MetaKeywords] [nvarchar](250) NULL,
	[MetaDescriptions] [nchar](250) NULL,
	[Status] [bit] NULL,
	[TopHot] [datetime] NULL,
	[ViewCount] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductAttribute]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttribute](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NULL,
	[Type] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_ProductAttribute] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[ParentID] [bigint] NULL,
	[Image] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[SeoTitle] [nvarchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[MetaKeywords] [nvarchar](250) NULL,
	[MetaDescriptions] [nchar](250) NULL,
	[Status] [bit] NULL,
	[ShowOnHome] [bit] NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](10) NOT NULL,
	[AttributeCode] [varchar](10) NULL,
	[Value] [nvarchar](250) NULL,
 CONSTRAINT [PK_ProductDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductWarehouse]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductWarehouse](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](15) NULL,
	[StockOnhand] [int] NULL,
	[StockAvailable] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_ProductWarehouse] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Slide]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slide](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Image] [nvarchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[Link] [nvarchar](250) NULL,
	[Description] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Slide] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockIn]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockIn](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Note] [nvarchar](250) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_StockIn] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockInDetail]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockInDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[StockInCode] [varchar](10) NULL,
	[ProductCode] [varchar](10) NULL,
	[UnitCode] [varchar](10) NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_StockInDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemConfig]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemConfig](
	[ID] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Type] [varchar](50) NULL,
	[Value] [nvarchar](250) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_SystemConfig] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tag]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tag] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Unit]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NULL,
	[Name] [nvarchar](250) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroup](
	[ID] [varchar](20) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 03-Jun-17 11:18:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](32) NULL,
	[GroupID] [varchar](20) NULL,
	[Name] [nvarchar](250) NULL,
	[Address] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[Phone] [nvarchar](50) NULL,
	[Image] [nvarchar](250) NULL,
	[ProvinceCode] [varchar](15) NULL,
	[DistrictCode] [varchar](15) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Banner] ON 

INSERT [dbo].[Banner] ([ID], [ProductCode], [Advertisement_Name], [Image], [StartDate], [EndDate], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'SP0000002', N'Công ty ABC', N'upload/categorys\banner-iphone7.jpg', CAST(N'2017-05-01T00:00:00.000' AS DateTime), CAST(N'2017-05-03T00:00:00.000' AS DateTime), 1, CAST(N'2017-05-28T10:59:23.537' AS DateTime), N'duyduong', CAST(N'2017-06-02T15:48:24.370' AS DateTime), N'duyduong')
INSERT [dbo].[Banner] ([ID], [ProductCode], [Advertisement_Name], [Image], [StartDate], [EndDate], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'SP0000004', N'Anh Sung', N'upload/categorys\banner-samsungs7.jpg', CAST(N'2017-05-28T00:00:00.000' AS DateTime), CAST(N'2017-06-04T00:00:00.000' AS DateTime), 1, CAST(N'2017-05-28T13:55:20.637' AS DateTime), N'duyduong', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Banner] OFF
SET IDENTITY_INSERT [dbo].[CheckInventory] ON 

INSERT [dbo].[CheckInventory] ([ID], [Code], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (31, N'PK0000001', N'kiểm kho 1', CAST(N'2017-06-01T21:48:19.653' AS DateTime), N'duyduong', CAST(N'2017-06-02T20:58:25.067' AS DateTime), N'duyduong', 0)
SET IDENTITY_INSERT [dbo].[CheckInventory] OFF
SET IDENTITY_INSERT [dbo].[CheckInventoryDetail] ON 

INSERT [dbo].[CheckInventoryDetail] ([ID], [CheckInventoryCode], [ProductCode], [Quantity], [StockOnhand]) VALUES (36, N'PK0000001', N'SP0000003', 45, 45)
INSERT [dbo].[CheckInventoryDetail] ([ID], [CheckInventoryCode], [ProductCode], [Quantity], [StockOnhand]) VALUES (37, N'PK0000001', N'SP0000003', 45, 45)
INSERT [dbo].[CheckInventoryDetail] ([ID], [CheckInventoryCode], [ProductCode], [Quantity], [StockOnhand]) VALUES (38, N'PK0000001', N'SP0000004', 11, 11)
SET IDENTITY_INSERT [dbo].[CheckInventoryDetail] OFF
SET IDENTITY_INSERT [dbo].[City] ON 

INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'C0001', N'Hà Nội', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'C0002', N'Hà Giang', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, N'C0003', N'Cao Bằng', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, N'C0004', N'Bắc Kạn', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, N'C0005', N'Tuyên Quang', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, N'C0006', N'Lào Cai', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'C0007', N'Điện Biên', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'C0008', N'Lai Châu', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, N'C0009', N'Sơn La', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, N'C0010', N'Yên Bái', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, N'C0011', N'Hòa Bình', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, N'C0012', N'Thái Nguyên', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, N'C0013', N'Lạng Sơn', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (14, N'C0014', N'Quảng Ninh', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, N'C0015', N'Bắc Giang', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, N'C0016', N'Phú Thọ', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, N'C0017', N'Vĩnh Phúc', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, N'C0018', N'Bắc Ninh', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, N'C0019', N'Hải Dương', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, N'C0020', N'Hải Phòng', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, N'C0021', N'Hưng Yên', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, N'C0022', N'Thái Bình', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (23, N'C0023', N'Hà Nam', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (24, N'C0024', N'Nam Định', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (25, N'C0025', N'Ninh Bình', N'R0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (26, N'C0026', N'Thanh Hóa', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (27, N'C0027', N'Nghệ An', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (28, N'C0028', N'Hà Tĩnh', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (29, N'C0029', N'Quảng Bình', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (30, N'C0030', N'Quảng Trị', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (31, N'C0031', N'Thừa Thiên Huế', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (32, N'C0032', N'Đà Nẵng', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (33, N'C0033', N'Quảng Nam', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (34, N'C0034', N'Quảng Ngãi', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (35, N'C0035', N'Bình Định', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (36, N'C0036', N'Phú Yên', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (37, N'C0037', N'Khánh Hòa', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (38, N'C0038', N'Ninh Thuận', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (39, N'C0039', N'Bình Thuận', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (40, N'C0040', N'Kon Tum', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (41, N'C0041', N'Gia Lai', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (42, N'C0042', N'Đắk Lắk', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (43, N'C0043', N'Đắk Nông', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (44, N'C0044', N'Lâm Đồng', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (45, N'C0045', N'Bình Phước', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (46, N'C0046', N'Tây Ninh', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (47, N'C0047', N'Bình Dương', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (48, N'C0048', N'Đồng Nai', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (49, N'C0049', N'Bà Rịa - Vũng Tàu', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (50, N'C0050', N'Hồ Chí Minh', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (51, N'C0051', N'Long An', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (52, N'C0052', N'Tiền Giang', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (53, N'C0053', N'Bến Tre', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (54, N'C0054', N'Trà Vinh', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (55, N'C0055', N'Vĩnh Long', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (56, N'C0056', N'Đồng Tháp', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (57, N'C0057', N'An Giang', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (58, N'C0058', N'Kiên Giang', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (59, N'C0059', N'Cần Thơ', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (60, N'C0060', N'Hậu Giang', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (61, N'C0061', N'Sóc Trăng', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (62, N'C0062', N'Bạc Liêu', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
INSERT [dbo].[City] ([ID], [Code], [Name], [AreaCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (63, N'C0063', N'Cà Mau', N'R0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.853' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[City] OFF
SET IDENTITY_INSERT [dbo].[District] ON 

INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (1, N'D0001', N'Ba Đình', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (2, N'D0002', N'Hoàn Kiếm', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (3, N'D0003', N'Tây Hồ', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (4, N'D0004', N'Long Biên', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, N'D0005', N'Cầu Giấy', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, N'D0006', N'Đống Đa', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'D0007', N'Hai Bà Trưng', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'D0008', N'Hoàng Mai', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, N'D0009', N'Thanh Xuân', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (10, N'D0010', N'Hà Đông', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (11, N'D0011', N'Sơn Tây', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (12, N'D0012', N'Sóc Sơn', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (13, N'D0013', N'Đông Anh', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (14, N'D0014', N'Gia Lâm', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (15, N'D0015', N'Từ Liêm', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (16, N'D0016', N'Thanh Trì', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (17, N'D0017', N'Mê Linh', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (18, N'D0018', N'Ba Vì', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (19, N'D0019', N'Phúc Thọ', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (20, N'D0020', N'Đan Phượng', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (21, N'D0021', N'Hoài Đức', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (22, N'D0022', N'Quốc Oai', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (23, N'D0023', N'Thạch Thất', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (24, N'D0024', N'Chương Mỹ', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (25, N'D0025', N'Thanh Oai', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (26, N'D0026', N'Thường Tín', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (27, N'D0027', N'Phú Xuyên', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (28, N'D0028', N'Ứng Hòa', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (29, N'D0029', N'Mỹ Đức', N'C0001', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (30, N'D0030', N'Hà Giang', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (31, N'D0031', N'Đồng Văn', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (32, N'D0032', N'Mèo Vạc', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (33, N'D0033', N'Yên Minh', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (34, N'D0034', N'Quản Bạ', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (35, N'D0035', N'Vị Xuyên', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (36, N'D0036', N'Bắc Mê', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (37, N'D0037', N'Hoàng Su Phì', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (38, N'D0038', N'Xín Mần', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (39, N'D0039', N'Bắc Quang', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (40, N'D0040', N'Quang Bình', N'C0002', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (41, N'D0041', N'Cao Bằng', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (42, N'D0042', N'Bảo Lâm', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (43, N'D0043', N'Bảo Lạc', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (44, N'D0044', N'Thông Nông', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (45, N'D0045', N'Hà Quảng', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (46, N'D0046', N'Trà Lĩnh', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (47, N'D0047', N'Trùng Khánh', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (48, N'D0048', N'Hạ Lang', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (49, N'D0049', N'Quảng Uyên', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (50, N'D0050', N'Phục Hoà', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (51, N'D0051', N'Hoà An', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (52, N'D0052', N'Nguyên Bình', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (53, N'D0053', N'Thạch An', N'C0003', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (54, N'D0054', N'Bắc Kạn', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (55, N'D0055', N'Pác Nặm', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (56, N'D0056', N'Ba Bể', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (57, N'D0057', N'Ngân Sơn', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (58, N'D0058', N'Bạch Thông', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (59, N'D0059', N'Chợ Đồn', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (60, N'D0060', N'Chợ Mới', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (61, N'D0061', N'Na Rì', N'C0004', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (62, N'D0062', N'Tuyên Quang', N'C0005', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (63, N'D0063', N'Nà Hang', N'C0005', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (64, N'D0064', N'Chiêm Hóa', N'C0005', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (65, N'D0065', N'Hàm Yên', N'C0005', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (66, N'D0066', N'Yên Sơn', N'C0005', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (67, N'D0067', N'Sơn Dương', N'C0005', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (68, N'D0068', N'Lào Cai', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (69, N'D0069', N'Bát Xát', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (70, N'D0070', N'Mường Khương', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (71, N'D0071', N'Si Ma Cai', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (72, N'D0072', N'Bắc Hà', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (73, N'D0073', N'Bảo Thắng', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (74, N'D0074', N'Bảo Yên', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (75, N'D0075', N'Sa Pa', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (76, N'D0076', N'Văn Bàn', N'C0006', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (77, N'D0077', N'Điện Biên Phủ', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (78, N'D0078', N'Mường Lay', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (79, N'D0079', N'Mường Nhé', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (80, N'D0080', N'Mường Chà', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (81, N'D0081', N'Tủa Chùa', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (82, N'D0082', N'Tuần Giáo', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (83, N'D0083', N'Điện Biên', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (84, N'D0084', N'Điện Biên Đông', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (85, N'D0085', N'Mường Ảng', N'C0007', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (86, N'D0086', N'Lai Châu', N'C0008', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (87, N'D0087', N'Tam Đường', N'C0008', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (88, N'D0088', N'Mường Tè', N'C0008', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (89, N'D0089', N'Sìn Hồ', N'C0008', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (90, N'D0090', N'Phong Thổ', N'C0008', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (91, N'D0091', N'Than Uyên', N'C0008', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (92, N'D0092', N'Tân Uyên', N'C0008', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (93, N'D0093', N'Sơn La', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (94, N'D0094', N'Quỳnh Nhai', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (95, N'D0095', N'Thuận Châu', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (96, N'D0096', N'Mường La', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (97, N'D0097', N'Bắc Yên', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (98, N'D0098', N'Phù Yên', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (99, N'D0099', N'Mộc Châu', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
GO
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (100, N'D0100', N'Yên Châu', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (101, N'D0101', N'Mai Sơn', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (102, N'D0102', N'Sông Mã', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (103, N'D0103', N'Sốp Cộp', N'C0009', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (104, N'D0104', N'Yên Bái', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (105, N'D0105', N'Nghĩa Lộ', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (106, N'D0106', N'Lục Yên', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (107, N'D0107', N'Văn Yên', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (108, N'D0108', N'Mù Cang Chải', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (109, N'D0109', N'Trấn Yên', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (110, N'D0110', N'Trạm Tấu', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (111, N'D0111', N'Văn Chấn', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (112, N'D0112', N'Yên Bình', N'C0010', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (113, N'D0113', N'Hòa Bình', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (114, N'D0114', N'Đà Bắc', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (115, N'D0115', N'Kỳ Sơn', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (116, N'D0116', N'Lương Sơn', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (117, N'D0117', N'Kim Bôi', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (118, N'D0118', N'Cao Phong', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (119, N'D0119', N'Tân Lạc', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (120, N'D0120', N'Mai Châu', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (121, N'D0121', N'Lạc Sơn', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (122, N'D0122', N'Yên Thủy', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (123, N'D0123', N'Lạc Thủy', N'C0011', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (124, N'D0124', N'Thái Nguyên', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (125, N'D0125', N'Sông Công', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (126, N'D0126', N'Định Hóa', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (127, N'D0127', N'Phú Lương', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (128, N'D0128', N'Đồng Hỷ', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (129, N'D0129', N'Võ Nhai', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (130, N'D0130', N'Đại Từ', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (131, N'D0131', N'Phổ Yên', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (132, N'D0132', N'Phú Bình', N'C0012', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (133, N'D0133', N'Lạng Sơn', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (134, N'D0134', N'Tràng Định', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (135, N'D0135', N'Bình Gia', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (136, N'D0136', N'Văn Lãng', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (137, N'D0137', N'Cao Lộc', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (138, N'D0138', N'Văn Quan', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (139, N'D0139', N'Bắc Sơn', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (140, N'D0140', N'Hữu Lũng', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (141, N'D0141', N'Chi Lăng', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (142, N'D0142', N'Lộc Bình', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (143, N'D0143', N'Đình Lập', N'C0013', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (144, N'D0144', N'Hạ Long', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (145, N'D0145', N'Móng Cái', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (146, N'D0146', N'Cẩm Phả', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (147, N'D0147', N'Uông Bí', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (148, N'D0148', N'Bình Liêu', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (149, N'D0149', N'Tiên Yên', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (150, N'D0150', N'Đầm Hà', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (151, N'D0151', N'Hải Hà', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (152, N'D0152', N'Ba Chẽ', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (153, N'D0153', N'Vân Đồn', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (154, N'D0154', N'Hoành Bồ', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (155, N'D0155', N'Đông Triều', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (156, N'D0156', N'Yên Hưng', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (157, N'D0157', N'Cô Tô', N'C0014', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (158, N'D0158', N'Bắc Giang', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (159, N'D0159', N'Yên Thế', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (160, N'D0160', N'Tân Yên', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (161, N'D0161', N'Lạng Giang', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (162, N'D0162', N'Lục Nam', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (163, N'D0163', N'Lục Ngạn', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (164, N'D0164', N'Sơn Động', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (165, N'D0165', N'Yên Dũng', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (166, N'D0166', N'Việt Yên', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (167, N'D0167', N'Hiệp Hòa', N'C0015', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (168, N'D0168', N'Việt Trì', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (169, N'D0169', N'Phú Thọ', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (170, N'D0170', N'Đoan Hùng', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (171, N'D0171', N'Hạ Hoà', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (172, N'D0172', N'Thanh Ba', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (173, N'D0173', N'Phù Ninh', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (174, N'D0174', N'Yên Lập', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (175, N'D0175', N'Cẩm Khê', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (176, N'D0176', N'Tam Nông', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (177, N'D0177', N'Lâm Thao', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (178, N'D0178', N'Thanh Sơn', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (179, N'D0179', N'Thanh Thuỷ', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (180, N'D0180', N'Tân Sơn', N'C0016', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (181, N'D0181', N'Vĩnh Yên', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (182, N'D0182', N'Phúc Yên', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (183, N'D0183', N'Lập Thạch', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (184, N'D0184', N'Tam Dương', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (185, N'D0185', N'Tam Đảo', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (186, N'D0186', N'Bình Xuyên', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (187, N'D0187', N'Yên Lạc', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (188, N'D0188', N'Vĩnh Tường', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (189, N'D0189', N'Sông Lô', N'C0017', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (190, N'D0190', N'Bắc Ninh', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (191, N'D0191', N'Từ Sơn', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (192, N'D0192', N'Yên Phong', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (193, N'D0193', N'Quế Võ', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (194, N'D0194', N'Tiên Du', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (195, N'D0195', N'Thuận Thành', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (196, N'D0196', N'Gia Bình', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (197, N'D0197', N'Lương Tài', N'C0018', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (198, N'D0198', N'Hải Dương', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (199, N'D0199', N'Chí Linh', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
GO
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (200, N'D0200', N'Nam Sách', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (201, N'D0201', N'Kinh Môn', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (202, N'D0202', N'Kim Thành', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (203, N'D0203', N'Thanh Hà', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (204, N'D0204', N'Cẩm Giàng', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (205, N'D0205', N'Bình Giang', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (206, N'D0206', N'Gia Lộc', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (207, N'D0207', N'Tứ Kỳ', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (208, N'D0208', N'Ninh Giang', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (209, N'D0209', N'Thanh Miện', N'C0019', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (210, N'D0210', N'Hồng Bàng', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (211, N'D0211', N'Ngô Quyền', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (212, N'D0212', N'Lê Chân', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (213, N'D0213', N'Hải An', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (214, N'D0214', N'Kiến An', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (215, N'D0215', N'Đồ Sơn', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (216, N'D0216', N'Kinh Dương', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (217, N'D0217', N'Thuỷ Nguyên', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (218, N'D0218', N'An Dương', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (219, N'D0219', N'An Lão', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (220, N'D0220', N'Kiến Thụy', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (221, N'D0221', N'Tiên Lãng', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (222, N'D0222', N'Vĩnh Bảo', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (223, N'D0223', N'Cát Hải', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (224, N'D0224', N'Bạch Long Vĩ', N'C0020', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (225, N'D0225', N'Hưng Yên', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (226, N'D0226', N'Văn Lâm', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (227, N'D0227', N'Văn Giang', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (228, N'D0228', N'Yên Mỹ', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (229, N'D0229', N'Mỹ Hào', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (230, N'D0230', N'Ân Thi', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (231, N'D0231', N'Khoái Châu', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (232, N'D0232', N'Kim Động', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (233, N'D0233', N'Tiên Lữ', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (234, N'D0234', N'Phù Cừ', N'C0021', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (235, N'D0235', N'Thái Bình', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (236, N'D0236', N'Quỳnh Phụ', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (237, N'D0237', N'Hưng Hà', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (238, N'D0238', N'Đông Hưng', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (239, N'D0239', N'Thái Thụy', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (240, N'D0240', N'Tiền Hải', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (241, N'D0241', N'Kiến Xương', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (242, N'D0242', N'Vũ Thư', N'C0022', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (243, N'D0243', N'Phủ Lý', N'C0023', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (244, N'D0244', N'Duy Tiên', N'C0023', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (245, N'D0245', N'Kim Bảng', N'C0023', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (246, N'D0246', N'Thanh Liêm', N'C0023', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (247, N'D0247', N'Bình Lục', N'C0023', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (248, N'D0248', N'Lý Nhân', N'C0023', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (249, N'D0249', N'Nam Định', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (250, N'D0250', N'Mỹ Lộc', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (251, N'D0251', N'Vụ Bản', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (252, N'D0252', N'Ý Yên', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (253, N'D0253', N'Nghĩa Hưng', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (254, N'D0254', N'Nam Trực', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (255, N'D0255', N'Trực Ninh', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (256, N'D0256', N'Xuân Trường', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (257, N'D0257', N'Giao Thủy', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (258, N'D0258', N'Hải Hậu', N'C0024', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (259, N'D0259', N'Ninh Bình', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (260, N'D0260', N'Tam Điệp', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (261, N'D0261', N'Nho Quan', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (262, N'D0262', N'Gia Viễn', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (263, N'D0263', N'Hoa Lư', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (264, N'D0264', N'Yên Khánh', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (265, N'D0265', N'Kim Sơn', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (266, N'D0266', N'Yên Mô', N'C0025', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (267, N'D0267', N'Thanh Hóa', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (268, N'D0268', N'Bỉm Sơn', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (269, N'D0269', N'Sầm Sơn', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (270, N'D0270', N'Mường Lát', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (271, N'D0271', N'Quan Hóa', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (272, N'D0272', N'Bá Thước', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (273, N'D0273', N'Quan Sơn', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (274, N'D0274', N'Lang Chánh', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (275, N'D0275', N'Ngọc Lặc', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (276, N'D0276', N'Cẩm Thủy', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (277, N'D0277', N'Thạch Thành', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (278, N'D0278', N'Hà Trung', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (279, N'D0279', N'Vĩnh Lộc', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (280, N'D0280', N'Yên Định', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (281, N'D0281', N'Thọ Xuân', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (282, N'D0282', N'Thường Xuân', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (283, N'D0283', N'Triệu Sơn', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (284, N'D0284', N'Thiệu Hoá', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (285, N'D0285', N'Hoằng Hóa', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (286, N'D0286', N'Hậu Lộc', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (287, N'D0287', N'Nga Sơn', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (288, N'D0288', N'Như Xuân', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (289, N'D0289', N'Như Thanh', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (290, N'D0290', N'Nông Cống', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (291, N'D0291', N'Đông Sơn', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (292, N'D0292', N'Quảng Xương', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (293, N'D0293', N'Tĩnh Gia', N'C0026', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (294, N'D0294', N'Vinh', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (295, N'D0295', N'Cửa Lò', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (296, N'D0296', N'Thái Hoà', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (297, N'D0297', N'Quế Phong', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (298, N'D0298', N'Quỳ Châu', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (299, N'D0299', N'Kỳ Sơn', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
GO
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (300, N'D0300', N'Tương Dương', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (301, N'D0301', N'Nghĩa Đàn', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (302, N'D0302', N'Quỳ Hợp', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (303, N'D0303', N'Quỳnh Lưu', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (304, N'D0304', N'Con Cuông', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (305, N'D0305', N'Tân Kỳ', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (306, N'D0306', N'Anh Sơn', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (307, N'D0307', N'Diễn Châu', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (308, N'D0308', N'Yên Thành', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (309, N'D0309', N'Đô Lương', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (310, N'D0310', N'Thanh Chương', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (311, N'D0311', N'Nghi Lộc', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (312, N'D0312', N'Nam Đàn', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (313, N'D0313', N'Hưng Nguyên', N'C0027', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (314, N'D0314', N'Hà Tĩnh', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (315, N'D0315', N'Hồng Lĩnh', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (316, N'D0316', N'Hương Sơn', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (317, N'D0317', N'Đức Thọ', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (318, N'D0318', N'Vũ Quang', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (319, N'D0319', N'Nghi Xuân', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (320, N'D0320', N'Can Lộc', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (321, N'D0321', N'Hương Khê', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (322, N'D0322', N'Thạch Hà', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (323, N'D0323', N'Cẩm Xuyên', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (324, N'D0324', N'Kỳ Anh', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (325, N'D0325', N'Lộc Hà', N'C0028', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (326, N'D0326', N'Đồng Hới', N'C0029', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (327, N'D0327', N'Minh Hóa', N'C0029', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (328, N'D0328', N'Tuyên Hóa', N'C0029', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (329, N'D0329', N'Quảng Trạch', N'C0029', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (330, N'D0330', N'Bố Trạch', N'C0029', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (331, N'D0331', N'Quảng Ninh', N'C0029', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (332, N'D0332', N'Lệ Thủy', N'C0029', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (333, N'D0333', N'Đông Hà', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (334, N'D0334', N'Quảng Trị', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (335, N'D0335', N'Vĩnh Linh', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (336, N'D0336', N'Hướng Hóa', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (337, N'D0337', N'Gio Linh', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (338, N'D0338', N'Đa Krông', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (339, N'D0339', N'Cam Lộ', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (340, N'D0340', N'Triệu Phong', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (341, N'D0341', N'Hải Lăng', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (342, N'D0342', N'Cồn Cỏ', N'C0030', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (343, N'D0343', N'Huế', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (344, N'D0344', N'Phong Điền', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (345, N'D0345', N'Quảng Điền', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (346, N'D0346', N'Phú Vang', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (347, N'D0347', N'Hương Thủy', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (348, N'D0348', N'Hương Trà', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (349, N'D0349', N'A Lưới', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (350, N'D0350', N'Phú Lộc', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (351, N'D0351', N'Nam Đông', N'C0031', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (352, N'D0352', N'Liên Chiểu', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (353, N'D0353', N'Thanh Khê', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (354, N'D0354', N'Hải Châu', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (355, N'D0355', N'Sơn Trà', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (356, N'D0356', N'Ngũ Hành Sơn', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (357, N'D0357', N'Cẩm Lệ', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (358, N'D0358', N'Hoà Vang', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (359, N'D0359', N'Hoàng Sa', N'C0032', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (360, N'D0360', N'Tam Kỳ', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (361, N'D0361', N'Hội An', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (362, N'D0362', N'Tây Giang', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (363, N'D0363', N'Đông Giang', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (364, N'D0364', N'Đại Lộc', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (365, N'D0365', N'Điện Bàn', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (366, N'D0366', N'Duy Xuyên', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (367, N'D0367', N'Quế Sơn', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (368, N'D0368', N'Nam Giang', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (369, N'D0369', N'Phước Sơn', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (370, N'D0370', N'Hiệp Đức', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (371, N'D0371', N'Thăng Bình', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (372, N'D0372', N'Tiên Phước', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (373, N'D0373', N'Bắc Trà My', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (374, N'D0374', N'Nam Trà My', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (375, N'D0375', N'Núi Thành', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (376, N'D0376', N'Phú Ninh', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (377, N'D0377', N'Nông Sơn', N'C0033', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (378, N'D0378', N'Quảng Ngãi', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (379, N'D0379', N'Bình Sơn', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (380, N'D0380', N'Trà Bồng', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (381, N'D0381', N'Tây Trà', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (382, N'D0382', N'Sơn Tịnh', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (383, N'D0383', N'Tư Nghĩa', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (384, N'D0384', N'Sơn Hà', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (385, N'D0385', N'Sơn Tây', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (386, N'D0386', N'Minh Long', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (387, N'D0387', N'Nghĩa Hành', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (388, N'D0388', N'Mộ Đức', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (389, N'D0389', N'Đức Phổ', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (390, N'D0390', N'Ba Tơ', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (391, N'D0391', N'Lý Sơn', N'C0034', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (392, N'D0392', N'Qui Nhơn', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (393, N'D0393', N'An Lão', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (394, N'D0394', N'Hoài Nhơn', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (395, N'D0395', N'Hoài Ân', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (396, N'D0396', N'Phù Mỹ', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (397, N'D0397', N'Vĩnh Thạnh', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (398, N'D0398', N'Tây Sơn', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (399, N'D0399', N'Phù Cát', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
GO
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (400, N'D0400', N'An Nhơn', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (401, N'D0401', N'Tuy Phước', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (402, N'D0402', N'Vân Canh', N'C0035', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (403, N'D0403', N'Tuy Hòa', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (404, N'D0404', N'Sông Cầu', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (405, N'D0405', N'Đồng Xuân', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (406, N'D0406', N'Tuy An', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (407, N'D0407', N'Sơn Hòa', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (408, N'D0408', N'Sông Hinh', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (409, N'D0409', N'Tây Hoà', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (410, N'D0410', N'Phú Hoà', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (411, N'D0411', N'Đông Hoà', N'C0036', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (412, N'D0412', N'Nha Trang', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (413, N'D0413', N'Cam Ranh', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (414, N'D0414', N'Cam Lâm', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (415, N'D0415', N'Vạn Ninh', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (416, N'D0416', N'Ninh Hòa', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (417, N'D0417', N'Khánh Vĩnh', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (418, N'D0418', N'Diên Khánh', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (419, N'D0419', N'Khánh Sơn', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (420, N'D0420', N'Trường Sa', N'C0037', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (421, N'D0421', N'Phan Rang-Tháp Chàm', N'C0038', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (422, N'D0422', N'Bác Ái', N'C0038', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (423, N'D0423', N'Ninh Sơn', N'C0038', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (424, N'D0424', N'Ninh Hải', N'C0038', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (425, N'D0425', N'Ninh Phước', N'C0038', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (426, N'D0426', N'Thuận Bắc', N'C0038', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (427, N'D0427', N'Thuận Nam', N'C0038', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (428, N'D0428', N'Phan Thiết', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (429, N'D0429', N'La Gi', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (430, N'D0430', N'Tuy Phong', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (431, N'D0431', N'Bắc Bình', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (432, N'D0432', N'Hàm Thuận Bắc', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (433, N'D0433', N'Hàm Thuận Nam', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (434, N'D0434', N'Tánh Linh', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (435, N'D0435', N'Đức Linh', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (436, N'D0436', N'Hàm Tân', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (437, N'D0437', N'Phú Quí', N'C0039', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (438, N'D0438', N'Kon Tum', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (439, N'D0439', N'Đắk Glei', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (440, N'D0440', N'Ngọc Hồi', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (441, N'D0441', N'Đắk Tô', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (442, N'D0442', N'Kon Plông', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (443, N'D0443', N'Kon Rẫy', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (444, N'D0444', N'Đắk Hà', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (445, N'D0445', N'Sa Thầy', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (446, N'D0446', N'Tu Mơ Rông', N'C0040', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (447, N'D0447', N'Pleiku', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (448, N'D0448', N'An Khê', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (449, N'D0449', N'Ayun Pa', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (450, N'D0450', N'Kbang', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (451, N'D0451', N'Đăk Đoa', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (452, N'D0452', N'Chư Păh', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (453, N'D0453', N'Ia Grai', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (454, N'D0454', N'Mang Yang', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (455, N'D0455', N'Kông Chro', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (456, N'D0456', N'Đức Cơ', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (457, N'D0457', N'Chư Prông', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (458, N'D0458', N'Chư Sê', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (459, N'D0459', N'Đăk Pơ', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (460, N'D0460', N'Ia Pa', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (461, N'D0461', N'Krông Pa', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (462, N'D0462', N'Phú Thiện', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (463, N'D0463', N'Chư Pưh', N'C0041', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (464, N'D0464', N'Buôn Ma Thuột', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (465, N'D0465', N'Buôn Hồ', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (466, N'D0466', N'Ea H leo', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (467, N'D0467', N'Ea Súp', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (468, N'D0468', N'Buôn Đôn', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (469, N'D0469', N'Cư M gar', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (470, N'D0470', N'Krông Búk', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (471, N'D0471', N'Krông Năng', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (472, N'D0472', N'Ea Kar', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (473, N'D0473', N'M đrắk', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (474, N'D0474', N'Krông Bông', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (475, N'D0475', N'Krông Pắc', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (476, N'D0476', N'Krông A Na', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (477, N'D0477', N'Lắk', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (478, N'D0478', N'Cư Kuin', N'C0042', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (479, N'D0479', N'Gia Nghĩa', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (480, N'D0480', N'Đắk Glong', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (481, N'D0481', N'Cư Jút', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (482, N'D0482', N'Đắk Mil', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (483, N'D0483', N'Krông Nô', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (484, N'D0484', N'Đắk Song', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (485, N'D0485', N'Đắk R lấp', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (486, N'D0486', N'Tuy Đức', N'C0043', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (487, N'D0487', N'Đà Lạt', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (488, N'D0488', N'Bảo Lộc', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (489, N'D0489', N'Đam Rông', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (490, N'D0490', N'Lạc Dương', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (491, N'D0491', N'Lâm Hà', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (492, N'D0492', N'Đơn Dương', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (493, N'D0493', N'Đức Trọng', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (494, N'D0494', N'Di Linh', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (495, N'D0495', N'Bảo Lâm', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (496, N'D0496', N'Đạ Huoai', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (497, N'D0497', N'Đạ Tẻh', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (498, N'D0498', N'Cát Tiên', N'C0044', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (499, N'D0499', N'Đồng Xoài', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
GO
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (500, N'D0500', N'Phước Long', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (501, N'D0501', N'Bình Long', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (502, N'D0502', N'Bù Gia Mập', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (503, N'D0503', N'Lộc Ninh', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (504, N'D0504', N'Bù Đốp', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (505, N'D0505', N'Hớn Quản', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (506, N'D0506', N'Đồng Phù', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (507, N'D0507', N'Bù Đăng', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (508, N'D0508', N'Chơn Thành', N'C0045', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (509, N'D0509', N'Tây Ninh', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (510, N'D0510', N'Tân Biên', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (511, N'D0511', N'Tân Châu', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (512, N'D0512', N'Dương Minh Châu', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (513, N'D0513', N'Châu Thành', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (514, N'D0514', N'Hòa Thành', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (515, N'D0515', N'Gò Dầu', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (516, N'D0516', N'Bến Cầu', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (517, N'D0517', N'Trảng Bàng', N'C0046', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (518, N'D0518', N'Thủ Dầu Một', N'C0047', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (519, N'D0519', N'Dầu Tiếng', N'C0047', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (520, N'D0520', N'Bến Cát', N'C0047', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (521, N'D0521', N'Phú Giáo', N'C0047', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (522, N'D0522', N'Tân Uyên', N'C0047', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (523, N'D0523', N'Dĩ An', N'C0047', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (524, N'D0524', N'Thuận An', N'C0047', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (525, N'D0525', N'Biên Hòa', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (526, N'D0526', N'Long Khánh', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (527, N'D0527', N'Tân Phú', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (528, N'D0528', N'Vĩnh Cửu', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (529, N'D0529', N'Định Quán', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (530, N'D0530', N'Trảng Bom', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (531, N'D0531', N'Thống Nhất', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (532, N'D0532', N'Cẩm Mỹ', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (533, N'D0533', N'Long Thành', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (534, N'D0534', N'Xuân Lộc', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (535, N'D0535', N'Nhơn Trạch', N'C0048', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (536, N'D0536', N'Vũng Tầu', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (537, N'D0537', N'Bà Rịa', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (538, N'D0538', N'Châu Đức', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (539, N'D0539', N'Xuyên Mộc', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (540, N'D0540', N'Long Điền', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (541, N'D0541', N'Đất Đỏ', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (542, N'D0542', N'Tân Thành', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (543, N'D0543', N'Côn Đảo', N'C0049', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (544, N'D0544', N'Quận 1', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (545, N'D0545', N'Quận 12', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (546, N'D0546', N'Thủ Đức', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (547, N'D0547', N'Quận 9', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (548, N'D0548', N'Gò Vấp', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (549, N'D0549', N'Bình Thạnh', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (550, N'D0550', N'Tân Bình', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (551, N'D0551', N'Tân Phú', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (552, N'D0552', N'Phú Nhuận', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (553, N'D0553', N'Quận 2', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (554, N'D0554', N'Quận 3', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (555, N'D0555', N'Quận 10', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (556, N'D0556', N'Quận 11', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (557, N'D0557', N'Quận 4', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (558, N'D0558', N'Quận 5', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (559, N'D0559', N'Quận 6', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (560, N'D0560', N'Quận 8', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (561, N'D0561', N'Bình Tân', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (562, N'D0562', N'Quận 7', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (563, N'D0563', N'Củ Chi', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (564, N'D0564', N'Hóc Môn', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (565, N'D0565', N'Bình Chánh', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (566, N'D0566', N'Nhà Bè', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (567, N'D0567', N'Cần Giờ', N'C0050', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (568, N'D0568', N'Tân An', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (569, N'D0569', N'Tân Hưng', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (570, N'D0570', N'Vĩnh Hưng', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (571, N'D0571', N'Mộc Hóa', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (572, N'D0572', N'Tân Thạnh', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (573, N'D0573', N'Thạnh Hóa', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (574, N'D0574', N'Đức Huệ', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (575, N'D0575', N'Đức Hòa', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (576, N'D0576', N'Bến Lức', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (577, N'D0577', N'Thủ Thừa', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (578, N'D0578', N'Tân Trụ', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (579, N'D0579', N'Cần Đước', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (580, N'D0580', N'Cần Giuộc', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (581, N'D0581', N'Châu Thành', N'C0051', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (582, N'D0582', N'Mỹ Tho', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (583, N'D0583', N'Gò Công', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (584, N'D0584', N'Tân Phước', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (585, N'D0585', N'Cái Bè', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (586, N'D0586', N'Cai Lậy', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (587, N'D0587', N'Châu Thành', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (588, N'D0588', N'Chợ Gạo', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (589, N'D0589', N'Gò Công Tây', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (590, N'D0590', N'Gò Công Đông', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (591, N'D0591', N'Tân Phú Đông', N'C0052', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (592, N'D0592', N'Bến Tre', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (593, N'D0593', N'Châu Thành', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (594, N'D0594', N'Chợ Lách', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (595, N'D0595', N'Mỏ Cày Nam', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (596, N'D0596', N'Giồng Trôm', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (597, N'D0597', N'Bình Đại', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (598, N'D0598', N'Ba Tri', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (599, N'D0599', N'Thạnh Phú', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
GO
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (600, N'D0600', N'Mỏ Cày Bắc', N'C0053', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (601, N'D0601', N'Trà Vinh', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (602, N'D0602', N'Càng Long', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (603, N'D0603', N'Cầu Kè', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (604, N'D0604', N'Tiểu Cần', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (605, N'D0605', N'Châu Thành', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (606, N'D0606', N'Cầu Ngang', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (607, N'D0607', N'Trà Cú', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (608, N'D0608', N'Duyên Hải', N'C0054', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (609, N'D0609', N'Vĩnh Long', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (610, N'D0610', N'Long Hồ', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (611, N'D0611', N'Mang Thít', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (612, N'D0612', N'Vũng Liêm', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (613, N'D0613', N'Tam Bình', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (614, N'D0614', N'Bình Minh', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (615, N'D0615', N'Trà Ôn', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (616, N'D0616', N'Bình Tân', N'C0055', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (617, N'D0617', N'Cao Lãnh', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (618, N'D0618', N'Sa Đéc', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (619, N'D0619', N'Hồng Ngự', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (620, N'D0620', N'Tân Hồng', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (621, N'D0621', N'Hồng Ngự', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (622, N'D0622', N'Tam Nông', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (623, N'D0623', N'Tháp Mười', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (624, N'D0624', N'Cao Lãnh', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (625, N'D0625', N'Thanh Bình', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (626, N'D0626', N'Lấp Vò', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (627, N'D0627', N'Lai Vung', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (628, N'D0628', N'Châu Thành', N'C0056', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (629, N'D0629', N'Long Xuyên', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (630, N'D0630', N'Châu Đốc', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (631, N'D0631', N'An Phú', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (632, N'D0632', N'Tân Châu', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (633, N'D0633', N'Phú Tân', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (634, N'D0634', N'Châu Phú', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (635, N'D0635', N'Tịnh Biên', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (636, N'D0636', N'Tri Tôn', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (637, N'D0637', N'Châu Thành', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (638, N'D0638', N'Chợ Mới', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (639, N'D0639', N'Thoại Sơn', N'C0057', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (640, N'D0640', N'Rạch Giá', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (641, N'D0641', N'Hà Tiên', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (642, N'D0642', N'Kiên Lương', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (643, N'D0643', N'Hòn Đất', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (644, N'D0644', N'Tân Hiệp', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (645, N'D0645', N'Châu Thành', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (646, N'D0646', N'Giồng Giềng', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (647, N'D0647', N'Gò Quao', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (648, N'D0648', N'An Biên', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (649, N'D0649', N'An Minh', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (650, N'D0650', N'Vĩnh Thuận', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (651, N'D0651', N'Phú Quốc', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (652, N'D0652', N'Kiên Hải', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (653, N'D0653', N'U Minh Thượng', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (654, N'D0654', N'Giang Thành', N'C0058', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (655, N'D0655', N'Ninh Kiều', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (656, N'D0656', N'Ô Môn', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (657, N'D0657', N'Bình Thuỷ', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (658, N'D0658', N'Cái Răng', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (659, N'D0659', N'Thốt Nốt', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (660, N'D0660', N'Vĩnh Thạnh', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (661, N'D0661', N'Cờ Đỏ', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (662, N'D0662', N'Phong Điền', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (663, N'D0663', N'Thới Lai', N'C0059', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (664, N'D0664', N'Vị Thanh', N'C0060', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (665, N'D0665', N'Ngã Bảy', N'C0060', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (666, N'D0666', N'Châu Thành A', N'C0060', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (667, N'D0667', N'Châu Thành', N'C0060', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (668, N'D0668', N'Phụng Hiệp', N'C0060', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (669, N'D0669', N'Vị Thuỷ', N'C0060', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (670, N'D0670', N'Long Mỹ', N'C0060', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (671, N'D0671', N'Sóc Trăng', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (672, N'D0672', N'Châu Thành', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (673, N'D0673', N'Kế Sách', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (674, N'D0674', N'Mỹ Tú', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (675, N'D0675', N'Cù Lao Dung', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (676, N'D0676', N'Long Phú', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (677, N'D0677', N'Mỹ Xuyên', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (678, N'D0678', N'Ngã Năm', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (679, N'D0679', N'Thạnh Trị', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (680, N'D0680', N'Vĩnh Châu', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (681, N'D0681', N'Trần Đề', N'C0061', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (682, N'D0682', N'Bạc Liêu', N'C0062', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (683, N'D0683', N'Hồng Dân', N'C0062', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (684, N'D0684', N'Phước Long', N'C0062', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (685, N'D0685', N'Vĩnh Lợi', N'C0062', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (686, N'D0686', N'Giá Rai', N'C0062', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (687, N'D0687', N'Đông Hải', N'C0062', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (688, N'D0688', N'Hoà Bình', N'C0062', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (689, N'D0689', N'Cà Mau', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (690, N'D0690', N'U Minh', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (691, N'D0691', N'Thới Bình', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (692, N'D0692', N'Trần Văn Thời', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (693, N'D0693', N'Cái Nước', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (694, N'D0694', N'Đầm Dơi', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (695, N'D0695', N'Năm Căn', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (696, N'D0696', N'Phú Tân', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
INSERT [dbo].[District] ([ID], [Code], [Name], [CityCode], [Status], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (697, N'D0697', N'Ngọc Hiển', N'C0063', 1, CAST(N'2016-10-29T00:00:00.000' AS DateTime), N'administator', CAST(N'2017-04-26T21:27:10.753' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[District] OFF
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([ID], [Name], [Phone], [Email], [Address], [Content], [CreatedDate], [Status]) VALUES (1004, N'Huy đẹp trai', N'0111111111', N'huydeptrai@gmail.com', NULL, N'Tổi rất là thích trang web bán hàng của bạn.', CAST(N'2017-05-28T13:49:02.517' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
INSERT [dbo].[Footer] ([ID], [Content], [Status]) VALUES (N'footer', N'<div class="wrap">	
	     <div class="section group">
				<div class="col_1_of_4 span_1_of_4">
						<h4>Information</h4>
						<ul>
						<li><a href="about.html">About Us</a></li>
						<li><a href="contact.html">Customer Service</a></li>
						<li><a href="#">Advanced Search</a></li>
						<li><a href="delivery.html">Orders and Returns</a></li>
						<li><a href="contact.html">Contact Us</a></li>
						</ul>
					</div>
				<div class="col_1_of_4 span_1_of_4">
					<h4>Why buy from us</h4>
						<ul>
						<li><a href="about.html">About Us</a></li>
						<li><a href="contact.html">Customer Service</a></li>
						<li><a href="#">Privacy Policy</a></li>
						<li><a href="contact.html">Site Map</a></li>
						<li><a href="#">Search Terms</a></li>
						</ul>
				</div>
				<div class="col_1_of_4 span_1_of_4">
					<h4>My account</h4>
						<ul>
							<li><a href="contact.html">Sign In</a></li>
							<li><a href="index.html">View Cart</a></li>
							<li><a href="#">My Wishlist</a></li>
							<li><a href="#">Track My Order</a></li>
							<li><a href="contact.html">Help</a></li>
						</ul>
				</div>
				<div class="col_1_of_4 span_1_of_4">
					<h4>Contact</h4>
						<ul>
							<li><span>+91-123-456789</span></li>
							<li><span>+00-123-000000</span></li>
						</ul>
						<div class="social-icons">
							<h4>Follow Us</h4>
					   		  <ul>
							      <li><a href="#" target="_blank"><img src="images/facebook.png" alt="" /></a></li>
							      <li><a href="#" target="_blank"><img src="images/twitter.png" alt="" /></a></li>
							      <li><a href="#" target="_blank"><img src="images/skype.png" alt="" /> </a></li>
							      <li><a href="#" target="_blank"> <img src="images/dribbble.png" alt="" /></a></li>
							      <li><a href="#" target="_blank"> <img src="images/linkedin.png" alt="" /></a></li>
							      <div class="clear"></div>
						     </ul>
   	 					</div>
				</div>
			</div>			
        </div>
        <div class="copy_right">
				<p>Company Name © All rights Reseverd | Design by  <a href="http://w3layouts.com">W3Layouts</a> </p>
		   </div>', 1)
INSERT [dbo].[Language] ([ID], [Name], [IsDefault]) VALUES (N'en', N'Tiếng Anh', 0)
INSERT [dbo].[Language] ([ID], [Name], [IsDefault]) VALUES (N'vi', N'Tiếng Việt', 1)
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([ID], [Text], [Link], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (1, N'Trang chủ', N'/', 1, N'_blank', 1, 1)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (2, N'Giới thiệu', N'/gioi-thieu', 2, N'_self', 1, 1)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (3, N'Tin tức', N'/tin-tuc', 3, N'_self', 1, 1)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (4, N'Sản phẩm', N'/san-pham', 4, N'_self', 1, 1)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (5, N'Liên hệ', N'/lien-he', 5, N'_self', 1, 1)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (6, N'Đăng nhập', N'/dang-nhap', 1, N'_self', 1, 2)
INSERT [dbo].[Menu] ([ID], [Text], [Link], [DisplayOrder], [Target], [Status], [TypeID]) VALUES (7, N'Đăng ký', N'/dang-ky', 2, N'_self', 1, 2)
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[MenuType] ON 

INSERT [dbo].[MenuType] ([ID], [Name]) VALUES (1, N'Menu chính')
INSERT [dbo].[MenuType] ([ID], [Name]) VALUES (2, N'Menu top')
SET IDENTITY_INSERT [dbo].[MenuType] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([ID], [Code], [CustomerID], [ShipName], [ShipMobile], [ShipAddress], [ShipEmail], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (34, N'1495957275742', 10035, N'Huy Kute', N'09999999999', N'Phú Mỹ Hưng-Quận 1-Hồ Chí Minh', N'nice_luv94@yahoo.com', CAST(N'2017-05-28T14:41:15.743' AS DateTime), NULL, CAST(N'2017-06-03T08:51:46.397' AS DateTime), N'duyduong', 2)
INSERT [dbo].[Orders] ([ID], [Code], [CustomerID], [ShipName], [ShipMobile], [ShipAddress], [ShipEmail], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (35, N'1495957364617', 10035, N'Huy Kute', N'09999999999', N'Phú Mỹ Hưng-Quận 1-Hồ Chí Minh', N'nice_luv94@yahoo.com', CAST(N'2017-05-28T14:42:44.617' AS DateTime), NULL, CAST(N'2017-05-28T14:43:03.890' AS DateTime), N'duyduong', 3)
INSERT [dbo].[Orders] ([ID], [Code], [CustomerID], [ShipName], [ShipMobile], [ShipAddress], [ShipEmail], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (36, N'1496391576173', 10035, N'Huy Kute', N'09999999999', N'Phú Mỹ Hưng-Quận 1-Hồ Chí Minh', N'nice_luv94@yahoo.com', CAST(N'2017-06-02T15:19:36.173' AS DateTime), NULL, CAST(N'2017-06-02T15:21:57.990' AS DateTime), N'duyduong', 3)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[OrdersDetail] ON 

INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10009, N'SP0000002', N'1495957275742', 5, CAST(15000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10010, N'SP0000003', N'1495957275742', 5, CAST(8000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10011, N'SP0000004', N'1495957275742', 5, CAST(12000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10012, N'SP0000001', N'1495957364617', 5, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10013, N'SP0000002', N'1495957364617', 5, CAST(15000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10014, N'SP0000004', N'1495957364617', 5, CAST(12000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10015, N'SP0000001', N'1496391576173', 2, CAST(3000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10016, N'SP0000003', N'1496391576173', 1, CAST(8000000 AS Decimal(18, 0)))
INSERT [dbo].[OrdersDetail] ([ID], [ProductCode], [OrdersCode], [Quantity], [Price]) VALUES (10017, N'SP0000004', N'1496391576173', 2, CAST(12000000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[OrdersDetail] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Image], [MoreImages], [Price], [PromotionPrice], [IncludedVAT], [CategoryID], [Detail], [Warranty], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [TopHot], [ViewCount]) VALUES (10025, N'Iphone 4', N'SP0000001', NULL, N'Siêu khuyến mãi', N'upload/products\iphone4.png', NULL, CAST(3000000 AS Decimal(18, 0)), CAST(2500000 AS Decimal(18, 0)), 0, 20026, NULL, 12, CAST(N'2017-05-28T09:53:01.423' AS DateTime), N'', NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Image], [MoreImages], [Price], [PromotionPrice], [IncludedVAT], [CategoryID], [Detail], [Warranty], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [TopHot], [ViewCount]) VALUES (10026, N'Iphone 7', N'SP0000002', NULL, N'Sản phẩm mới 2017', N'upload/products\iphone7.png', NULL, CAST(15000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 0, 20026, NULL, 12, CAST(N'2017-05-28T09:55:28.397' AS DateTime), N'', NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Image], [MoreImages], [Price], [PromotionPrice], [IncludedVAT], [CategoryID], [Detail], [Warranty], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [TopHot], [ViewCount]) VALUES (10027, N'Sony XA1', N'SP0000003', NULL, N'Siêu phẩm 2017', N'upload/products\sonyXA1.png', NULL, CAST(8000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 0, 20028, NULL, 12, CAST(N'2017-05-28T09:58:14.563' AS DateTime), N'', NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Image], [MoreImages], [Price], [PromotionPrice], [IncludedVAT], [CategoryID], [Detail], [Warranty], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [TopHot], [ViewCount]) VALUES (10028, N'Samsung Galaxy S7', N'SP0000004', NULL, N'Samsung thế hệ mới.', N'upload/products\samsungs7.jpg', NULL, CAST(12000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 0, 20029, NULL, 12, CAST(N'2017-05-28T13:54:43.737' AS DateTime), N'', NULL, NULL, NULL, NULL, 1, NULL, 0)
INSERT [dbo].[Product] ([ID], [Name], [Code], [MetaTitle], [Description], [Image], [MoreImages], [Price], [PromotionPrice], [IncludedVAT], [CategoryID], [Detail], [Warranty], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [TopHot], [ViewCount]) VALUES (10029, N'OPPO F3', N'SP0000005', NULL, N'XXX', N'upload/products\oppof3plus.gif', NULL, CAST(5000000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 0, 20027, NULL, 12, CAST(N'2017-06-03T09:25:54.290' AS DateTime), N'', CAST(N'2017-06-03T09:26:41.240' AS DateTime), N'duyduong', NULL, NULL, 1, NULL, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[ProductAttribute] ON 

INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (1, N'PA0000001', NULL, N'3G', CAST(N'2017-05-13T20:35:41.840' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (2, N'PA0000002', NULL, N'4G', CAST(N'2017-05-13T20:36:22.697' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (3, N'PA0000003', NULL, N'SIM', CAST(N'2017-05-13T20:36:29.007' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (4, N'PA0000004', NULL, N'Kích thước', CAST(N'2017-05-13T20:36:34.883' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (5, N'PA0000005', NULL, N'Trọng lượng', CAST(N'2017-05-13T20:36:40.677' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (6, N'PA0000006', NULL, N'Màn hình', CAST(N'2017-05-13T20:36:47.893' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (7, N'PA0000007', NULL, N'Kích thước màn hình', CAST(N'2017-05-13T20:36:55.307' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (8, N'PA0000008', NULL, N'Bộ nhớ trong', CAST(N'2017-05-13T20:37:01.693' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (9, N'PA0000009', NULL, N'Khe cắm thẻ nhớ', CAST(N'2017-05-13T20:37:13.470' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10, N'PA0000010', NULL, N'WLAN', CAST(N'2017-05-13T20:37:21.787' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (11, N'PA0000011', NULL, N'Bluetooth', CAST(N'2017-05-13T20:37:29.577' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (12, N'PA0000012', NULL, N'USB', CAST(N'2017-05-13T20:37:35.387' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (13, N'PA0000013', NULL, N'NFC', CAST(N'2017-05-13T20:37:40.737' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (14, N'PA0000014', NULL, N'GPS', CAST(N'2017-05-13T20:37:46.263' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (15, N'PA0000015', NULL, N'Hệ điều hành', CAST(N'2017-05-13T20:37:51.753' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (16, N'PA0000016', NULL, N'Chipset', CAST(N'2017-05-13T20:37:55.960' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (17, N'PA0000017', NULL, N'CPU', CAST(N'2017-05-13T20:37:59.870' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (18, N'PA0000018', NULL, N'GPU', CAST(N'2017-05-13T20:38:03.583' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (19, N'PA0000019', NULL, N'Bộ cảm biến', CAST(N'2017-05-13T20:38:09.237' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (20, N'PA0000020', NULL, N'Camera chính', CAST(N'2017-05-13T20:38:14.117' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (21, N'PA0000021', NULL, N'Camera phụ', CAST(N'2017-05-13T20:38:18.823' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (22, N'PA0000022', NULL, N'Video', CAST(N'2017-05-13T20:38:22.597' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (23, N'PA0000023', NULL, N'Pin', CAST(N'2017-05-13T20:38:26.253' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (24, N'PA0000024', NULL, N'Thời gian đàm thoại', CAST(N'2017-05-13T20:38:32.480' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (25, N'PA0000025', NULL, N'Thời gian chờ', CAST(N'2017-05-13T20:38:39.060' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[ProductAttribute] ([ID], [Code], [Type], [Name], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (26, N'PA0000026', NULL, N'Thời gian chơi nhạc', CAST(N'2017-05-13T20:38:43.830' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[ProductAttribute] OFF
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [ParentID], [Image], [DisplayOrder], [SeoTitle], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [ShowOnHome]) VALUES (20026, N'Iphone', NULL, 0, N'upload/categorys\brand_Apple.png', 0, NULL, CAST(N'2017-05-28T09:51:13.653' AS DateTime), N'duyduong114', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [ParentID], [Image], [DisplayOrder], [SeoTitle], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [ShowOnHome]) VALUES (20027, N'Oppo', NULL, 0, N'upload/categorys\brand_Oppo.png', 0, NULL, CAST(N'2017-05-28T09:51:22.597' AS DateTime), N'duyduong114', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [ParentID], [Image], [DisplayOrder], [SeoTitle], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [ShowOnHome]) VALUES (20028, N'Sony', NULL, 0, N'upload/categorys\brand_sony.png', 0, NULL, CAST(N'2017-05-28T09:51:31.117' AS DateTime), N'duyduong114', NULL, NULL, NULL, NULL, 1, 0)
INSERT [dbo].[ProductCategory] ([ID], [Name], [MetaTitle], [ParentID], [Image], [DisplayOrder], [SeoTitle], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [MetaKeywords], [MetaDescriptions], [Status], [ShowOnHome]) VALUES (20029, N'Samsung', NULL, 0, N'upload/categorys\brand_samsung.png', 0, NULL, CAST(N'2017-05-28T09:51:38.840' AS DateTime), N'duyduong114', NULL, NULL, NULL, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
SET IDENTITY_INSERT [dbo].[ProductDetail] ON 

INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10060, N'SP0000004', N'PA0000001', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10061, N'SP0000004', N'PA0000002', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10062, N'SP0000004', N'PA0000003', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10063, N'SP0000004', N'PA0000004', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10064, N'SP0000004', N'PA0000005', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10065, N'SP0000004', N'PA0000006', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10066, N'SP0000004', N'PA0000007', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10067, N'SP0000004', N'PA0000008', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10068, N'SP0000004', N'PA0000009', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10069, N'SP0000004', N'PA0000010', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10070, N'SP0000004', N'PA0000011', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10071, N'SP0000004', N'PA0000012', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10072, N'SP0000004', N'PA0000013', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10073, N'SP0000004', N'PA0000014', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10074, N'SP0000004', N'PA0000015', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10075, N'SP0000004', N'PA0000016', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10076, N'SP0000004', N'PA0000017', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10077, N'SP0000004', N'PA0000018', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10078, N'SP0000004', N'PA0000019', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10079, N'SP0000004', N'PA0000020', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10080, N'SP0000004', N'PA0000021', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10081, N'SP0000004', N'PA0000022', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10082, N'SP0000004', N'PA0000023', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10083, N'SP0000004', N'PA0000024', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10084, N'SP0000004', N'PA0000025', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10085, N'SP0000004', N'PA0000026', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10086, N'SP0000003', N'PA0000001', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10087, N'SP0000003', N'PA0000002', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10088, N'SP0000003', N'PA0000003', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10089, N'SP0000003', N'PA0000004', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10090, N'SP0000003', N'PA0000005', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10091, N'SP0000003', N'PA0000006', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10092, N'SP0000003', N'PA0000007', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10093, N'SP0000003', N'PA0000008', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10094, N'SP0000003', N'PA0000009', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10095, N'SP0000003', N'PA0000010', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10096, N'SP0000003', N'PA0000011', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10097, N'SP0000003', N'PA0000012', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10098, N'SP0000003', N'PA0000013', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10099, N'SP0000003', N'PA0000014', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10100, N'SP0000003', N'PA0000015', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10101, N'SP0000003', N'PA0000016', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10102, N'SP0000003', N'PA0000017', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10103, N'SP0000003', N'PA0000018', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10104, N'SP0000003', N'PA0000019', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10105, N'SP0000003', N'PA0000020', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10106, N'SP0000003', N'PA0000021', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10107, N'SP0000003', N'PA0000022', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10108, N'SP0000003', N'PA0000023', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10109, N'SP0000003', N'PA0000024', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10110, N'SP0000003', N'PA0000025', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10111, N'SP0000003', N'PA0000026', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10112, N'SP0000002', N'PA0000001', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10113, N'SP0000002', N'PA0000002', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10114, N'SP0000002', N'PA0000003', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10115, N'SP0000002', N'PA0000004', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10116, N'SP0000002', N'PA0000005', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10117, N'SP0000002', N'PA0000006', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10118, N'SP0000002', N'PA0000007', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10119, N'SP0000002', N'PA0000008', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10120, N'SP0000002', N'PA0000009', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10121, N'SP0000002', N'PA0000010', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10122, N'SP0000002', N'PA0000011', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10123, N'SP0000002', N'PA0000012', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10124, N'SP0000002', N'PA0000013', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10125, N'SP0000002', N'PA0000014', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10126, N'SP0000002', N'PA0000015', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10127, N'SP0000002', N'PA0000016', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10128, N'SP0000002', N'PA0000017', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10129, N'SP0000002', N'PA0000018', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10130, N'SP0000002', N'PA0000019', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10131, N'SP0000002', N'PA0000020', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10132, N'SP0000002', N'PA0000021', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10133, N'SP0000002', N'PA0000022', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10134, N'SP0000002', N'PA0000023', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10135, N'SP0000002', N'PA0000024', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10136, N'SP0000002', N'PA0000025', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10137, N'SP0000002', N'PA0000026', N'')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10138, N'SP0000001', N'PA0000001', N'HSPA 42.2/5.76 Mbps, EV-DO Rev.A 3.1 Mbps')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10139, N'SP0000001', N'PA0000002', N'LTE Cat6 300/50 Mbps')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10140, N'SP0000001', N'PA0000003', N'Nano-SIM')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10141, N'SP0000001', N'PA0000004', N'158.2 x 77.9 x 7.3 mm (6.23 x 3.07 x 0.29 in)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10142, N'SP0000001', N'PA0000005', N'192 g (6.77 oz)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10143, N'SP0000001', N'PA0000006', N'Cảm ứng điện dung LED-backlit IPS LCD, 16 triệu màu')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10144, N'SP0000001', N'PA0000007', N'1080 x 1920 pixels, 5.5 inches (~401 ppi mật độ điểm ảnh)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10145, N'SP0000001', N'PA0000008', N'64 GB, 2 GB RAM')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10146, N'SP0000001', N'PA0000009', N'Không')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10147, N'SP0000001', N'PA0000010', N'Wi-Fi 802.11 a/b/g/n/ac, dual-band, hotspot')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10148, N'SP0000001', N'PA0000011', N'v4.1, A2DP, LE')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10149, N'SP0000001', N'PA0000012', N'v2.0')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10150, N'SP0000001', N'PA0000013', N'Có (Apple Pay)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10151, N'SP0000001', N'PA0000014', N'A-GPS, GLONASS')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10152, N'SP0000001', N'PA0000015', N'iOS 9')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10153, N'SP0000001', N'PA0000016', N'Apple A9')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10154, N'SP0000001', N'PA0000017', N'Dual-core 1.84 GHz Twister')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10155, N'SP0000001', N'PA0000018', N'PowerVR GT7600 (6 lõi đồ họa)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10156, N'SP0000001', N'PA0000019', N'Gia tốc, la bàn, khoảng cách, con quay quy hồi, phong vũ biểu')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10157, N'SP0000001', N'PA0000020', N'12 MP, f/2.2, 29mm, OIS, tự động lấy nét nhận diện theo giai đoạn, LED flash kép (2 tone)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10158, N'SP0000001', N'PA0000021', N'5 MP, f/2.2, 31mm, 1080p@30fps, 720p@240fps, nhận diện khuôn mặt, HDR, panorama')
GO
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10159, N'SP0000001', N'PA0000022', N'2160p@30fps, 1080p@60fps, 1080p@120fps, 720p@240fps')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10160, N'SP0000001', N'PA0000023', N'Li-Po 2750 mAh')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10161, N'SP0000001', N'PA0000024', N'24 giờ (3G)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10162, N'SP0000001', N'PA0000025', N'384 giờ (3G)')
INSERT [dbo].[ProductDetail] ([ID], [ProductCode], [AttributeCode], [Value]) VALUES (10163, N'SP0000001', N'PA0000026', N'80 giờ')
SET IDENTITY_INSERT [dbo].[ProductDetail] OFF
SET IDENTITY_INSERT [dbo].[ProductWarehouse] ON 

INSERT [dbo].[ProductWarehouse] ([ID], [ProductCode], [StockOnhand], [StockAvailable], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (5, N'SP0000001', 50, 50, CAST(N'2017-05-28T09:53:01.467' AS DateTime), N'duyduong114', CAST(N'2017-06-02T15:21:58.030' AS DateTime), N'duyduong')
INSERT [dbo].[ProductWarehouse] ([ID], [ProductCode], [StockOnhand], [StockAvailable], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (6, N'SP0000002', 19, 24, CAST(N'2017-05-28T09:55:28.427' AS DateTime), N'duyduong114', CAST(N'2017-06-03T08:51:46.470' AS DateTime), N'duyduong')
INSERT [dbo].[ProductWarehouse] ([ID], [ProductCode], [StockOnhand], [StockAvailable], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (7, N'SP0000003', 40, 45, CAST(N'2017-05-28T09:58:14.587' AS DateTime), N'duyduong114', CAST(N'2017-06-03T08:51:46.503' AS DateTime), N'duyduong')
INSERT [dbo].[ProductWarehouse] ([ID], [ProductCode], [StockOnhand], [StockAvailable], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (8, N'SP0000004', 6, 11, CAST(N'2017-05-28T13:54:43.763' AS DateTime), N'duyduong', CAST(N'2017-06-03T08:51:46.530' AS DateTime), N'duyduong')
INSERT [dbo].[ProductWarehouse] ([ID], [ProductCode], [StockOnhand], [StockAvailable], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy]) VALUES (9, N'SP0000005', 0, 0, CAST(N'2017-06-03T09:25:54.427' AS DateTime), N'duyduong', NULL, NULL)
SET IDENTITY_INSERT [dbo].[ProductWarehouse] OFF
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'ADD_CONTENT', N'Thêm tin tức')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'ADD_USER', N'Thêm user')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'DELETE_USER', N'Xoá user')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'EDIT_CONTENT', N'Sửa tin tức')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'EDIT_USER', N'Sửa user')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (N'VIEW_USER', N'Xem danh sách user')
SET IDENTITY_INSERT [dbo].[Slide] ON 

INSERT [dbo].[Slide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (1, N'/assets/client/images/slide-2-image.jpg', 1, N'/', NULL, CAST(N'2015-08-26T19:21:44.440' AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[Slide] ([ID], [Image], [DisplayOrder], [Link], [Description], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (2, N'/assets/client/images/slide-1-image.jpg', 2, N'/', NULL, CAST(N'2015-08-26T19:22:01.173' AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Slide] OFF
SET IDENTITY_INSERT [dbo].[StockIn] ON 

INSERT [dbo].[StockIn] ([ID], [Code], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Note], [Status]) VALUES (97, N'PN0000001', CAST(N'2017-06-01T21:47:08.627' AS DateTime), N'duyduong', NULL, NULL, N'Nhập kho ngày 1-6-2017', 1)
INSERT [dbo].[StockIn] ([ID], [Code], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Note], [Status]) VALUES (98, N'PN0000002', CAST(N'2017-06-01T21:48:38.853' AS DateTime), N'duyduong', CAST(N'2017-06-02T15:12:12.067' AS DateTime), N'duyduong', N'nhập kho 2', 2)
SET IDENTITY_INSERT [dbo].[StockIn] OFF
SET IDENTITY_INSERT [dbo].[StockInDetail] ON 

INSERT [dbo].[StockInDetail] ([ID], [StockInCode], [ProductCode], [UnitCode], [Quantity]) VALUES (207, N'PN0000001', N'SP0000004', N'CAI', 11)
INSERT [dbo].[StockInDetail] ([ID], [StockInCode], [ProductCode], [UnitCode], [Quantity]) VALUES (208, N'PN0000001', N'SP0000003', N'CAI', 22)
INSERT [dbo].[StockInDetail] ([ID], [StockInCode], [ProductCode], [UnitCode], [Quantity]) VALUES (210, N'PN0000002', N'SP0000002', N'HOP', 1)
INSERT [dbo].[StockInDetail] ([ID], [StockInCode], [ProductCode], [UnitCode], [Quantity]) VALUES (211, N'PN0000002', N'SP0000002', N'CAI', 1)
SET IDENTITY_INSERT [dbo].[StockInDetail] OFF
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([ID], [Code], [Name], [Status]) VALUES (1, N'CAI', N'Cái', 1)
INSERT [dbo].[Unit] ([ID], [Code], [Name], [Status]) VALUES (2, N'CHIEC', N'Chiếc', 1)
INSERT [dbo].[Unit] ([ID], [Code], [Name], [Status]) VALUES (3, N'HOP', N'Hộp', 1)
SET IDENTITY_INSERT [dbo].[Unit] OFF
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'ADMIN', N'Quản trị')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'MEMBER', N'Thành viên')
INSERT [dbo].[UserGroup] ([ID], [Name]) VALUES (N'MOD', N'Moderatior')
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10031, N'duyduong', N'c4ca4238a0b923820dcc509a6f75849b', N'ADMIN', N'Dương ', N'XXX', N'namkute@gmail.com', N'0123456789', N'upload/users\user_4.png', N'C0008', N'D0090', CAST(N'2017-05-23T17:02:09.293' AS DateTime), N'', CAST(N'2017-06-02T15:56:43.173' AS DateTime), N'', 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10035, N'huykute', N'827ccb0eea8a706c4c34a16891f84e7b', N'MEMBER', N'Huy Kute', N'Phú Mỹ Hưng', N'nice_luv94@yahoo.com', N'09999999999', N'upload/users\user_7.png', N'C0050', N'D0544', CAST(N'2017-05-28T10:51:07.927' AS DateTime), N'duyduong', CAST(N'2017-06-02T15:49:37.813' AS DateTime), N'', 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10036, N'vinhtran', N'827ccb0eea8a706c4c34a16891f84e7b', N'MEMBER', N'Vinh Trần', N'Trần Hưng Đạo', N'vinhtran@gmail.com', N'02225553334', NULL, N'C0013', N'D0139', CAST(N'2017-06-01T10:11:53.523' AS DateTime), N'System', CAST(N'2017-06-01T17:00:58.013' AS DateTime), N'vinhtran', 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10037, N'trinhphat', N'c4ca4238a0b923820dcc509a6f75849b', N'MEMBER', N'Trịnh Phát', N'Khu Đông ', N'trinhphat@gmail.com', N'06451234647', NULL, N'C0015', N'D0158', CAST(N'2017-06-01T17:34:34.147' AS DateTime), N'System', NULL, NULL, 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10038, N'tuan', N'c4ca4238a0b923820dcc509a6f75849b', N'MEMBER', N'Tuấn 123', N'Thành Thái', N'tuan@gmail.com', N'0978666444', N'upload/users\user_7.png', N'C0013', N'D0136', CAST(N'2017-06-01T17:39:06.177' AS DateTime), N'System', CAST(N'2017-06-01T18:34:14.080' AS DateTime), N'', 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10039, N'ty', N'c4ca4238a0b923820dcc509a6f75849b', N'MEMBER', N'Tý', N'Tý Thành', N'ty@gmail.com', N'0456789123', N'upload/users\user_2.png', N'C0010', N'D0105', CAST(N'2017-06-01T18:48:30.647' AS DateTime), N'System', CAST(N'2017-06-01T18:54:26.060' AS DateTime), N'', 0)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10040, N'lan', N'c4ca4238a0b923820dcc509a6f75849b', N'MEMBER', N'Lan', N'lan@gmail.com', N'lan@gmail.com', N'0987654321', N'upload/users\user_7.png', N'C0010', N'D0106', CAST(N'2017-06-01T18:56:02.553' AS DateTime), N'System', CAST(N'2017-06-01T18:56:12.527' AS DateTime), N'', 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10041, N'hangnga', N'c4ca4238a0b923820dcc509a6f75849b', N'MOD', N'Hằng Nga', N'Cung Trăng', N'ngahang@gmail.com', N'064312564798', N'upload/users\user_6.png', N'C0004', N'D0054', CAST(N'2017-06-02T15:52:11.097' AS DateTime), N'duyduong', CAST(N'2017-06-02T15:52:53.737' AS DateTime), N'hangnga', 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10042, N'yeyeye', N'202cb962ac59075b964b07152d234b70', N'MEMBER', N'yEYEYEEYEY', N'3', N'yeyeyey@gmail.com', N'088555222', NULL, N'C0015', N'D0161', CAST(N'2017-06-03T05:43:01.140' AS DateTime), N'System', NULL, NULL, 1)
INSERT [dbo].[Users] ([ID], [UserName], [Password], [GroupID], [Name], [Address], [Email], [Phone], [Image], [ProvinceCode], [DistrictCode], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [Status]) VALUES (10043, N'namhoanguit', N'827ccb0eea8a706c4c34a16891f84e7b', N'ADMIN', N'Hoang Van Nam,', N'tp hcm', N'namhoanguit@gmail.com', N'0985865186', N'upload/users\logo.png', N'C0001', N'D0002', CAST(N'2017-06-03T08:54:07.483' AS DateTime), N'duyduong', NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[About] ADD  CONSTRAINT [DF_About_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[About] ADD  CONSTRAINT [DF_About_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Banner] ADD  CONSTRAINT [DF_Banner_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_DisplayOrder]  DEFAULT ((0)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_ShowOnHome]  DEFAULT ((0)) FOR [ShowOnHome]
GO
ALTER TABLE [dbo].[CheckInventory] ADD  CONSTRAINT [DF_CheckInventory_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Content] ADD  CONSTRAINT [DF_Content_ViewCount]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[Feedback] ADD  CONSTRAINT [DF_Feedback_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Language_IsDefault]  DEFAULT ((0)) FOR [IsDefault]
GO
ALTER TABLE [dbo].[OrdersDetail] ADD  CONSTRAINT [DF_OrderDetail_Quantity]  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ViewCount]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[ProductAttribute] ADD  CONSTRAINT [DF_ProductAttribute_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_DisplayOrder]  DEFAULT ((0)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_ShowOnHome]  DEFAULT ((0)) FOR [ShowOnHome]
GO
ALTER TABLE [dbo].[ProductWarehouse] ADD  CONSTRAINT [DF_ProductWarehouse_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Slide] ADD  CONSTRAINT [DF_Slide_DisplayOrder]  DEFAULT ((1)) FOR [DisplayOrder]
GO
ALTER TABLE [dbo].[Slide] ADD  CONSTRAINT [DF_Slide_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[StockIn] ADD  CONSTRAINT [DF_StockIn_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[StockIn] ADD  CONSTRAINT [DF_StockIn_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_User_GroupID]  DEFAULT ('MEMBER') FOR [GroupID]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
USE [master]
GO
ALTER DATABASE [OnlineShop] SET  READ_WRITE 
GO
