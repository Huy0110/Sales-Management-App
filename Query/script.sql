USE [master]
GO
/****** Object:  Database [CSDL_Project]    Script Date: 1/25/2022 10:42:18 PM ******/
CREATE DATABASE [CSDL_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CSDL_Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CSDL_Project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CSDL_Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CSDL_Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CSDL_Project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CSDL_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CSDL_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CSDL_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CSDL_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CSDL_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CSDL_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [CSDL_Project] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CSDL_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CSDL_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CSDL_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CSDL_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CSDL_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CSDL_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CSDL_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CSDL_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CSDL_Project] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CSDL_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CSDL_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CSDL_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CSDL_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CSDL_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CSDL_Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CSDL_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CSDL_Project] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CSDL_Project] SET  MULTI_USER 
GO
ALTER DATABASE [CSDL_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CSDL_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CSDL_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CSDL_Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CSDL_Project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CSDL_Project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CSDL_Project] SET QUERY_STORE = OFF
GO
USE [CSDL_Project]
GO
/****** Object:  Schema [production]    Script Date: 1/25/2022 10:42:18 PM ******/
CREATE SCHEMA [production]
GO
/****** Object:  Schema [sales]    Script Date: 1/25/2022 10:42:18 PM ******/
CREATE SCHEMA [sales]
GO
/****** Object:  Table [sales].[customers]    Script Date: 1/25/2022 10:42:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[birthday] [date] NULL,
	[address] [nvarchar](255) NULL,
	[phone] [varchar](25) NULL,
	[email] [varchar](255) NULL,
 CONSTRAINT [PK0] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vRealCustomer]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vRealCustomer] as
select * from sales.customers where customer_id != 1;
GO
/****** Object:  Table [sales].[goods]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[goods](
	[product_id] [int] NOT NULL,
	[created_at] [date] NOT NULL,
	[good_till] [date] NOT NULL,
	[store_id] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[discount] [decimal](4, 2) NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[created_at] ASC,
	[good_till] ASC,
	[store_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vOutdatedProduct]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vOutdatedProduct] as
select * from sales.goods where getdate() >= good_till;
GO
/****** Object:  View [dbo].[vCurrentProduct]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vCurrentProduct] as
select * from sales.goods where getdate() < good_till;
GO
/****** Object:  Table [production].[brands]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [production].[brands](
	[brand_id] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [nvarchar](255) NOT NULL,
	[country] [nvarchar](75) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [production].[categories]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [production].[categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [production].[products]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [production].[products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](255) NOT NULL,
	[brand_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sales].[order_items]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[order_items](
	[order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[created_at] [date] NOT NULL,
	[good_till] [date] NOT NULL,
	[store_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[discount] [decimal](4, 2) NOT NULL,
	[profit] [decimal](10, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [sales].[orders]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[staff_id] [int] NOT NULL,
	[created_date] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sales].[staffs]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[staffs](
	[staff_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[phone] [varchar](25) NOT NULL,
	[active] [tinyint] NOT NULL,
	[store_id] [int] NOT NULL,
	[manager_state] [int] NOT NULL,
	[gender] [nvarchar](10) NOT NULL,
	[password] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [sales].[stores]    Script Date: 1/25/2022 10:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [sales].[stores](
	[store_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[phone] [varchar](25) NULL,
	[email] [varchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[state] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[store_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [production].[brands] ON 

INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (1, N'Hảo Hảo', N'Việt Nam')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (2, N'Hải Châu', N'Việt Nam')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (3, N'Bibica', N'Pháp')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (4, N'Kinh Đô', N'Việt Nam')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (6, N'Orion', N'Nhật Bản')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (7, N'Clear', N'Nhật Bản')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (8, N'Hải Tiến', N'Trung Quốc')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (9, N'Mix', N'Thái Lan')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (10, N'Chanel', N'Pháp')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (14, N'Thố Ca', N'Việt Nam')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (17, N'Dokira', N'Trung Quốc')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (18, N'Poca', N'Việt Nam')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (19, N'Closeup', N'Mỹ')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (20, N'Gấu Đỏ', N'Việt Nam')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (21, N'Baby The Star Shine Bright', N'Nhật Bản')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (22, N'Axes Famme', N'Nhật Bản')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (23, N'Angellic Pretty', N'Nhật Bản')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (24, N'Encore Girl', N'Trung Quốc')
INSERT [production].[brands] ([brand_id], [brand_name], [country]) VALUES (25, N'Merino', N'Thái Lan')
SET IDENTITY_INSERT [production].[brands] OFF
GO
SET IDENTITY_INSERT [production].[categories] ON 

INSERT [production].[categories] ([category_id], [category_name]) VALUES (1, N'Mì Ăn Liền')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (2, N'Kem')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (3, N'Xúc Xích')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (4, N'Bánh Mì')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (5, N'Dầu Gội Đầu')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (6, N'Sữa Tắm')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (7, N'Sữa Rửa Mặt')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (8, N'Xà Phòng')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (9, N'Nước Rửa Tay')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (10, N'Bút Bi')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (11, N'Mì Chính')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (12, N'Muối')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (13, N'Đường')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (14, N'Dầu Ăn')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (15, N'Xì Dầu')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (16, N'JK')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (17, N'Phụ Kiện')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (18, N'Salo')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (19, N'JSK')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (20, N'OP')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (21, N'Bút Bi Bi')
INSERT [production].[categories] ([category_id], [category_name]) VALUES (22, N'Mì Ăn Liềnnnnn')
SET IDENTITY_INSERT [production].[categories] OFF
GO
SET IDENTITY_INSERT [production].[products] ON 

INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (1, N'Sữa Tắm Matra', 9, 6, CAST(100000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (2, N'Sữa Tắm Hương Hoa Sen', 25, 6, CAST(100000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (3, N'Sữa Tắm Gạo', 8, 6, CAST(150000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (4, N'Sữa Tắm Hương Hoa Nhài', 9, 6, CAST(95000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (5, N'Sữa Tắm Hương Lưu', 3, 6, CAST(80000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (6, N'Sữa Tắm Hương Táo', 8, 6, CAST(50000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (7, N'Sữa Tắm Hương Cam', 9, 6, CAST(100000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (8, N'Sữa Tắm Hương Hoa Hồng', 9, 6, CAST(140000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (9, N'Dầu Gội Đầu Dành Cho Nam', 9, 5, CAST(20999.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (10, N'Bánh Mì Vuông', 8, 4, CAST(15249.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (11, N'Bánh Mì Chuột', 8, 4, CAST(2000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (12, N'Xúc Xích Bò', 1, 3, CAST(1999.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (13, N'Xúc Xích Lợn', 1, 3, CAST(2609.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (14, N'Xúc Xích Gà', 1, 3, CAST(2609.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (15, N'Xúc Xích John', 1, 3, CAST(5329.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (16, N'Xúc Xích Micheal', 1, 3, CAST(5939.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (17, N'Xúc Xích Cỡ Lớn', 4, 3, CAST(10329.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (18, N'Xúc Xích Vị Bánh Quy', 4, 3, CAST(4249.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (19, N'Xúc Xích Nhân Socola', 4, 3, CAST(4249.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (20, N'Xúc Xích Vị Mì Tôm Chanh', 1, 3, CAST(5939.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (21, N'Mì Tôm Chanh', 1, 1, CAST(2269.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (22, N'Mì Trộn', 1, 1, CAST(2069.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (23, N'Mì Xào Vị Tôm Chua Ngọt', 1, 1, CAST(2399.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (24, N'Kem Vị Tôm Chanh', 1, 2, CAST(5429.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (25, N'Kem Vị Lẩu Thái', 1, 2, CAST(40099.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (26, N'Kem Trân Châu Đường Đen', 1, 2, CAST(5339.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (27, N'Sữa Tắm Hương Hoa Ly', 8, 6, CAST(9939.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (28, N'Sữa Tắm 3 In 1', 8, 6, CAST(24399.99 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (51, N'Bột Canh I-ot', 17, 12, CAST(5000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (52, N'Bút Bi Thiên Long', 18, 21, CAST(4000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (53, N'Áo Khoác Mũ Trùm Màu Xanh', 19, 17, CAST(123456.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (55, N'Xì Dầu Chinsu', 20, 15, CAST(12334.10 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (56, N'Love Poem', 21, 18, CAST(6752000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (57, N'Kem Mùa Hè Kawaii', 22, 19, CAST(1700000.00 AS Decimal(10, 2)))
INSERT [production].[products] ([product_id], [product_name], [brand_id], [category_id], [price]) VALUES (58, N'Misty Sky Brilliant Color Pink&gray', 23, 20, CAST(7600000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [production].[products] OFF
GO
SET IDENTITY_INSERT [sales].[customers] ON 

INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (1, N'Khách lẻ', NULL, NULL, NULL, NULL)
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (2, N'Trần Đức Mạnh', CAST(N'2001-12-09' AS Date), N'15 ngách 2 ngõ 119, đường Nước Phần Lan, Tấy Hồ, Hà Nội', N'0357251858', N'tranducmanh12092001@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (3, N'Phạm Đức Huy', CAST(N'1990-01-19' AS Date), N'14 Kim Ngưu , Hai Bà Trưng', N'0345127852', N'phamduchuy@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (4, N'Nguyễn Thị Thanh Thúy', CAST(N'1999-01-11' AS Date), N'19 Ngõ 14 Phố Vọng , Hai Bà Trưng', N'0985621489', N'nguyenthithuy@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (5, N'Phạm Thanh Chung', CAST(N'2001-01-04' AS Date), N'41 Minh Khai , Hai Bà Trưng', N'0971751698', N'phamthanhchung@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (6, N'Lê Thị Hồng Ngọc', CAST(N'1984-11-24' AS Date), N'Số 2, Tổ 1, Chi Đông, Mê Linh, Hà Nội', N'0323456782', N'ngoc@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (7, N'Nguyễn Hồng Nhung', CAST(N'1999-02-04' AS Date), N'Thôn Tráng Việt, Mê Linh, Hà Nội', N'0258741369', N'nhung@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (8, N'Phạm Huy Lâm', CAST(N'2000-01-13' AS Date), N'16 Hàng Than , Hà Nội', N'0925478963', N'ptck64hust@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (9, N'Nguyễn Thành Phong', CAST(N'2001-03-26' AS Date), N'85 Thôn Tiền Phong, Mê Linh', N'0355478963', N'phong@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (10, N'Nguyễn Bá Trọng', CAST(N'2001-01-23' AS Date), N'31 Hàng Muối , Hoàn Kiếm', N'0971031021', N'trongggg@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (11, N'Phạm Quân', CAST(N'2000-01-13' AS Date), N'16 Hàng Bún , Hoàn Kiếm', N'0325478962', N'ptckhus@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (12, N'Hà Đăng Hưng', CAST(N'2002-01-15' AS Date), N'157 Ngõ 23 Hồ Tùng Mậu', N'0971452104', N'hung2002@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (13, N'Nguyễn Ngọc Hưng', CAST(N'2000-04-04' AS Date), N'Thôn Phong Mỹ , Cầu Giấy', N'0971421758', N'hung1901@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (14, N'Lý Thị Luyến', CAST(N'1998-03-03' AS Date), N'Khu Đô Thị Thanh Hà , Hà Đông', N'0971241068', N'luyenlt@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (15, N'Nguyễn Thị Quỳnh Hoa', CAST(N'1996-04-17' AS Date), N'Xóm 3 Thanh Trì , Hà Nội', N'0979412871', N'hoa1010@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (16, N'Lại Thùy Trang', CAST(N'2001-07-18' AS Date), N'26 Ngõ 35 Hồ Đắc Di', N'0970310298', N'tranglt2001@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (17, N'Phạm Hướng Dương', CAST(N'1996-04-10' AS Date), N'17 Hàng Bông , Hoàn Kiếm', N'0951264108', N'duongmmt2@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (18, N'Đoàn Thị Điểm', CAST(N'1999-05-05' AS Date), N'Ngõ 119/23 Đồng Tâm , Hai Bà Trưng', N'0942310698', N'diemvui123@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (19, N'Ngô Quỳnh Trang', CAST(N'1971-04-13' AS Date), N'18 Hàng Buồm , Hoàn Kiếm', N'0982145012', N'trangdj@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (20, N'Nguyễn Thị Kim Anh', CAST(N'1995-05-03' AS Date), N'117 Phố Hàng Muối , Hoàn Kiếm', N'0910384197', N'kimanhhocgioi@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (21, N'Nguyễn Huy Hoàng', CAST(N'1999-01-12' AS Date), N'15 Phố Hàng Buồm , Hoàn Kiếm', N'0989254108', N'hoang132@gmail.com')
INSERT [sales].[customers] ([customer_id], [name], [birthday], [address], [phone], [email]) VALUES (22, N'Bành Thị Quỳnh Thư', CAST(N'2008-01-08' AS Date), N'16 Hàng Chiếu , Hoàn Kiếm', N'0971452187', N'thutuesday@gmail.com')
SET IDENTITY_INSERT [sales].[customers] OFF
GO
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 1, CAST(15000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 20)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, CAST(120000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 135)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (2, CAST(N'2021-01-01' AS Date), CAST(N'2022-01-01' AS Date), 1, CAST(15000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 20)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (2, CAST(N'2021-01-01' AS Date), CAST(N'2022-01-01' AS Date), 4, CAST(15000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 20)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (3, CAST(N'2021-01-01' AS Date), CAST(N'2022-01-01' AS Date), 1, CAST(21000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 20)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (3, CAST(N'2021-01-01' AS Date), CAST(N'2022-01-01' AS Date), 2, CAST(21000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), 17)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (4, CAST(N'2021-01-09' AS Date), CAST(N'2022-12-09' AS Date), 2, CAST(150000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), 33)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (5, CAST(N'2021-01-09' AS Date), CAST(N'2023-01-13' AS Date), 2, CAST(100000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 35)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (6, CAST(N'2022-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, CAST(100000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), 3)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (7, CAST(N'2021-06-17' AS Date), CAST(N'2022-06-17' AS Date), 2, CAST(150000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), 3)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (8, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (8, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-22' AS Date), 2, CAST(170000.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), 12)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (9, CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, CAST(50000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), 88)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (9, CAST(N'2021-02-02' AS Date), CAST(N'2022-03-03' AS Date), 1, CAST(20000.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(4, 2)), 188)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (9, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (10, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (10, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-19' AS Date), 2, CAST(20000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 7)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (11, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-19' AS Date), 2, CAST(5000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 11)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (12, CAST(N'2022-01-10' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(5000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 46)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (13, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 30)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (14, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 17)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (15, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 8)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (16, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 10)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (17, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(15000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), 18)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (18, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 13)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (19, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), 2)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (20, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), 6)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (21, CAST(N'2021-12-01' AS Date), CAST(N'2022-06-01' AS Date), 2, CAST(5000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 44)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (21, CAST(N'2022-01-06' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (21, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (22, CAST(N'2021-07-31' AS Date), CAST(N'2022-03-31' AS Date), 2, CAST(6000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 30)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (23, CAST(N'2021-07-01' AS Date), CAST(N'2022-06-01' AS Date), 2, CAST(5000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), 13)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (24, CAST(N'2021-12-22' AS Date), CAST(N'2022-01-22' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), 12)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (25, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(50000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 2)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(6000.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), 962)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (26, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (27, CAST(N'2021-01-31' AS Date), CAST(N'2022-01-31' AS Date), 2, CAST(20000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (27, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, CAST(30000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), 5)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 21)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (51, CAST(N'2022-01-06' AS Date), CAST(N'2022-01-13' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (51, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(9999.00 AS Decimal(10, 2)), CAST(99.12 AS Decimal(4, 2)), 2145)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (52, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), 2, CAST(5000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 82)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (52, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (53, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (55, CAST(N'2022-01-05' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (55, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-15' AS Date), 2, CAST(12345.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 1000)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (55, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-28' AS Date), 2, CAST(17234.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 122)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (56, CAST(N'2022-01-05' AS Date), CAST(N'2022-01-16' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (56, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-21' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (56, CAST(N'2022-01-17' AS Date), CAST(N'2022-06-30' AS Date), 2, CAST(3000000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 20)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (57, CAST(N'2021-01-01' AS Date), CAST(N'2024-01-01' AS Date), 2, CAST(2000000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), 9)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (57, CAST(N'2022-01-05' AS Date), CAST(N'2022-01-16' AS Date), 2, CAST(1.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), 1)
INSERT [sales].[goods] ([product_id], [created_at], [good_till], [store_id], [price], [discount], [quantity]) VALUES (58, CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, CAST(8000000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), 5)
GO
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (1, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 2, CAST(24000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(176000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (2, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 10, CAST(120000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(116200.10 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (3, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 20, CAST(240000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(232400.20 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (7, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 2, CAST(24000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(23240.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (8, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (10, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (15, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (16, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 2, CAST(24000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(23240.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (17, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (18, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (19, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (20, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (21, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (22, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (23, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 1, CAST(91000.00 AS Decimal(10, 2)), CAST(9.00 AS Decimal(4, 2)), CAST(90400.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (24, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 1, CAST(91000.00 AS Decimal(10, 2)), CAST(9.00 AS Decimal(4, 2)), CAST(90400.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (25, 55, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-28' AS Date), 2, 1, CAST(1234.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(0.10 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (26, 4, CAST(N'2021-01-09' AS Date), CAST(N'2022-12-09' AS Date), 2, 1, CAST(142500.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(47500.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (27, 5, CAST(N'2021-01-09' AS Date), CAST(N'2023-01-13' AS Date), 2, 1, CAST(100000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(20000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (27, 16, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 10, CAST(100000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(40600.10 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (28, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 10, CAST(960000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(40000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (29, 5, CAST(N'2021-01-09' AS Date), CAST(N'2023-01-13' AS Date), 2, 1, CAST(100000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(20000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (30, 4, CAST(N'2021-01-09' AS Date), CAST(N'2022-12-09' AS Date), 2, 1, CAST(142500.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(47500.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (33, 11, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-19' AS Date), 2, 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(6000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (35, 23, CAST(N'2021-07-01' AS Date), CAST(N'2022-06-01' AS Date), 2, 10, CAST(47500.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(23500.10 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (37, 6, CAST(N'2022-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 23, CAST(2070000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(920000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (37, 5, CAST(N'2021-01-09' AS Date), CAST(N'2023-01-13' AS Date), 2, 8, CAST(800000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(160000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (39, 7, CAST(N'2021-06-17' AS Date), CAST(N'2022-06-17' AS Date), 2, 3, CAST(427500.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(127500.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (40, 6, CAST(N'2022-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 3, CAST(270000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(120000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (44, 11, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-19' AS Date), 2, 3, CAST(15000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(9000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (45, 12, CAST(N'2022-01-10' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(20000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(12004.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (48, 28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, 3, CAST(81000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(7800.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (48, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 4, CAST(40000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(20000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (48, 52, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), 2, 4, CAST(20000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(4000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (49, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 2, CAST(20000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (49, 52, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), 2, 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(2000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (49, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(10560.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-119.98 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (49, 28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, 2, CAST(54000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(5200.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (51, 25, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(100000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(19800.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (51, 24, CAST(N'2021-12-22' AS Date), CAST(N'2022-01-22' AS Date), 2, 2, CAST(18000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(7140.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (51, 23, CAST(N'2021-07-01' AS Date), CAST(N'2022-06-01' AS Date), 2, 4, CAST(19000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(9400.04 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (51, 27, CAST(N'2021-01-31' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(72000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(32240.04 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (51, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(21120.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-239.96 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (54, 9, CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 2, CAST(90000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(48002.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (54, 8, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-22' AS Date), 2, 2, CAST(299200.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(19200.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (54, 11, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-19' AS Date), 2, 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(6000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (54, 19, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(19000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(10502.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (54, 17, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(48000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(6684.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (55, 16, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(20000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(8120.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (55, 18, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(20000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(11502.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (55, 19, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(38000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(21004.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (55, 17, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(24000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(3342.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (55, 22, CAST(N'2021-07-31' AS Date), CAST(N'2022-03-31' AS Date), 2, 2, CAST(12000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(7860.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (58, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(15000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (58, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 6, CAST(31680.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-359.94 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (58, 28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, 3, CAST(81000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(7800.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (58, 52, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), 2, 3, CAST(15000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(3000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (59, 52, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), 2, 3, CAST(15000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(3000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (59, 28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, 6, CAST(162000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(15600.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (60, 52, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), 2, 3, CAST(15000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(3000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (60, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(15000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (60, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(15840.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-179.97 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (60, 24, CAST(N'2021-12-22' AS Date), CAST(N'2022-01-22' AS Date), 2, 3, CAST(27000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(10710.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (65, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 6, CAST(576000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(-24000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (65, 5, CAST(N'2021-01-09' AS Date), CAST(N'2023-01-13' AS Date), 2, 6, CAST(600000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(120000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (65, 4, CAST(N'2021-01-09' AS Date), CAST(N'2022-12-09' AS Date), 2, 6, CAST(855000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(285000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (66, 4, CAST(N'2021-01-09' AS Date), CAST(N'2022-12-09' AS Date), 2, 6, CAST(855000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(285000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (66, 21, CAST(N'2021-12-01' AS Date), CAST(N'2022-06-01' AS Date), 2, 6, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(16380.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (66, 22, CAST(N'2021-07-31' AS Date), CAST(N'2022-03-31' AS Date), 2, 12, CAST(72000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(47160.12 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (66, 23, CAST(N'2021-07-01' AS Date), CAST(N'2022-06-01' AS Date), 2, 12, CAST(57000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(28200.12 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (66, 24, CAST(N'2021-12-22' AS Date), CAST(N'2022-01-22' AS Date), 2, 6, CAST(54000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(21420.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (69, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(-88000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (69, 6, CAST(N'2022-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 1, CAST(90000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(40000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (70, 4, CAST(N'2021-01-09' AS Date), CAST(N'2022-12-09' AS Date), 2, 2, CAST(285000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(95000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (71, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(-88000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (71, 5, CAST(N'2021-01-09' AS Date), CAST(N'2023-01-13' AS Date), 2, 2, CAST(200000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(40000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (72, 4, CAST(N'2021-01-09' AS Date), CAST(N'2022-12-09' AS Date), 2, 1, CAST(142500.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(47500.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (4, 9, CAST(N'2021-02-02' AS Date), CAST(N'2022-03-03' AS Date), 1, 12, CAST(235200.00 AS Decimal(10, 2)), CAST(2.00 AS Decimal(4, 2)), CAST(199200.12 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (12, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(-88000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (13, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (14, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (34, 9, CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 1, CAST(45000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(24001.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (64, 14, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(40000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(29560.04 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (64, 17, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(48000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(6684.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (64, 16, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(40000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(16240.04 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (64, 15, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(40000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(18680.04 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (68, 15, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(14010.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (68, 14, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(22170.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (68, 16, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(12180.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (68, 17, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(36000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(5013.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (5, 3, CAST(N'2021-01-01' AS Date), CAST(N'2022-01-01' AS Date), 2, 2, CAST(39900.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(37900.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (32, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 2, CAST(24000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(-176000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (41, 9, CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 4, CAST(180000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(96004.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (50, 28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, 2, CAST(54000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(5200.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (50, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 2, CAST(20000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (50, 27, CAST(N'2021-01-31' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(36000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(16120.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (62, 15, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(14010.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (62, 14, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(22170.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (62, 17, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(36000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(5013.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (67, 28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, 6, CAST(162000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(15600.06 AS Decimal(10, 2)))
GO
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (67, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(15000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (67, 52, CAST(N'2021-08-12' AS Date), CAST(N'2022-08-12' AS Date), 2, 3, CAST(15000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(3000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (67, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(15840.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-179.97 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (6, 3, CAST(N'2021-01-01' AS Date), CAST(N'2022-01-01' AS Date), 2, 2, CAST(39900.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(37900.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (9, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (11, 1, CAST(N'2021-01-01' AS Date), CAST(N'2022-11-01' AS Date), 2, 1, CAST(12000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(11620.01 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (31, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 10, CAST(100000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(50000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (36, 5, CAST(N'2021-01-09' AS Date), CAST(N'2023-01-13' AS Date), 2, 7, CAST(700000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(140000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (56, 20, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(19000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(7120.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (56, 22, CAST(N'2021-07-31' AS Date), CAST(N'2022-03-31' AS Date), 2, 6, CAST(36000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(23580.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (56, 19, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(19000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(10502.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (38, 7, CAST(N'2021-06-17' AS Date), CAST(N'2022-06-17' AS Date), 2, 4, CAST(570000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(170000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (46, 15, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 4, CAST(40000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(18680.04 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (47, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(15840.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-179.97 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (47, 27, CAST(N'2021-01-31' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(54000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(24180.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (52, 25, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 6, CAST(300000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(59400.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (52, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(15840.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-179.97 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (52, 24, CAST(N'2021-12-22' AS Date), CAST(N'2022-01-22' AS Date), 2, 3, CAST(27000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(10710.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (52, 23, CAST(N'2021-07-01' AS Date), CAST(N'2022-06-01' AS Date), 2, 6, CAST(28500.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(14100.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (53, 24, CAST(N'2021-12-22' AS Date), CAST(N'2022-01-22' AS Date), 2, 3, CAST(27000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(10710.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (53, 9, CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 3, CAST(135000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(72003.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (53, 8, CAST(N'2022-01-15' AS Date), CAST(N'2022-01-22' AS Date), 2, 6, CAST(897600.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(57600.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (53, 11, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-19' AS Date), 2, 2, CAST(10000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(6000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (63, 15, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(14010.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (63, 14, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 3, CAST(30000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(22170.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (63, 16, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 6, CAST(60000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(24360.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (63, 17, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 6, CAST(72000.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(4, 2)), CAST(10026.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (42, 9, CAST(N'2021-01-01' AS Date), CAST(N'2023-01-01' AS Date), 2, 2, CAST(90000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(48002.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (57, 20, CAST(N'2022-01-01' AS Date), CAST(N'2022-01-31' AS Date), 2, 2, CAST(19000.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(7120.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (57, 23, CAST(N'2021-07-01' AS Date), CAST(N'2022-06-01' AS Date), 2, 2, CAST(9500.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(4700.02 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (57, 51, CAST(N'2022-01-01' AS Date), CAST(N'2022-07-01' AS Date), 2, 2, CAST(20000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(10000.00 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (57, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 5, CAST(26400.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-299.95 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (57, 28, CAST(N'2021-08-31' AS Date), CAST(N'2022-04-30' AS Date), 2, 3, CAST(81000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(7800.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (61, 24, CAST(N'2021-12-22' AS Date), CAST(N'2022-01-22' AS Date), 2, 6, CAST(54000.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(4, 2)), CAST(21420.06 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (61, 26, CAST(N'2022-01-09' AS Date), CAST(N'2022-01-31' AS Date), 2, 9, CAST(47520.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(4, 2)), CAST(-539.91 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (61, 23, CAST(N'2021-07-01' AS Date), CAST(N'2022-06-01' AS Date), 2, 3, CAST(14250.00 AS Decimal(10, 2)), CAST(5.00 AS Decimal(4, 2)), CAST(7050.03 AS Decimal(10, 2)))
INSERT [sales].[order_items] ([order_id], [product_id], [created_at], [good_till], [store_id], [quantity], [price], [discount], [profit]) VALUES (43, 10, CAST(N'2022-01-17' AS Date), CAST(N'2022-01-19' AS Date), 2, 3, CAST(60000.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(4, 2)), CAST(14253.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [sales].[orders] ON 

INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (1, 1, 2, CAST(N'2021-01-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (2, 3, 20, CAST(N'2021-01-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (3, 5, 6, CAST(N'2021-01-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (4, 7, 10, CAST(N'2021-01-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (5, 7, 20, CAST(N'2021-02-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (6, 6, 10, CAST(N'2021-02-10' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (7, 2, 1, CAST(N'2021-02-10' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (8, 4, 20, CAST(N'2021-03-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (9, 6, 2, CAST(N'2021-03-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (10, 5, 21, CAST(N'2021-03-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (11, 6, 6, CAST(N'2021-03-09' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (12, 2, 2, CAST(N'2021-03-10' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (13, 4, 20, CAST(N'2021-04-10' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (14, 5, 2, CAST(N'2021-04-10' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (15, 7, 21, CAST(N'2021-05-10' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (16, 8, 10, CAST(N'2021-05-11' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (17, 5, 2, CAST(N'2021-05-12' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (18, 4, 20, CAST(N'2021-05-12' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (19, 6, 20, CAST(N'2021-06-12' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (20, 3, 2, CAST(N'2021-06-12' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (21, 2, 10, CAST(N'2021-06-12' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (22, 9, 20, CAST(N'2021-07-13' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (23, 6, 2, CAST(N'2021-07-15' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (24, 10, 20, CAST(N'2021-08-15' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (25, 11, 2, CAST(N'2021-08-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (26, 4, 20, CAST(N'2021-09-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (27, 5, 2, CAST(N'2021-09-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (28, 21, 10, CAST(N'2021-09-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (29, 4, 10, CAST(N'2021-09-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (30, 6, 6, CAST(N'2021-09-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (31, 6, 2, CAST(N'2021-09-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (32, 6, 20, CAST(N'2021-10-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (33, 19, 2, CAST(N'2021-10-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (34, 4, 10, CAST(N'2021-10-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (35, 9, 1, CAST(N'2021-10-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (36, 14, 6, CAST(N'2021-10-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (37, 21, 10, CAST(N'2021-11-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (38, 22, 20, CAST(N'2021-11-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (39, 21, 2, CAST(N'2021-11-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (40, 21, 6, CAST(N'2021-11-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (41, 21, 2, CAST(N'2021-11-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (42, 17, 21, CAST(N'2021-11-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (43, 17, 20, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (44, 15, 2, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (45, 15, 2, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (46, 14, 10, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (47, 13, 6, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (48, 12, 2, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (49, 11, 20, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (50, 10, 2, CAST(N'2021-12-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (51, 9, 20, CAST(N'2022-01-15' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (52, 8, 2, CAST(N'2022-01-15' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (53, 7, 10, CAST(N'2022-01-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (54, 7, 21, CAST(N'2022-01-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (55, 7, 6, CAST(N'2022-01-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (56, 7, 10, CAST(N'2022-01-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (57, 3, 2, CAST(N'2022-01-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (58, 20, 20, CAST(N'2022-01-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (59, 20, 2, CAST(N'2022-01-16' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (60, 22, 1, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (61, 20, 6, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (62, 20, 10, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (63, 20, 20, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (64, 20, 2, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (65, 19, 2, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (66, 22, 20, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (67, 18, 20, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (68, 18, 20, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (69, 5, 20, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (70, 3, 20, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (71, 3, 20, CAST(N'2022-01-17' AS Date))
INSERT [sales].[orders] ([order_id], [customer_id], [staff_id], [created_date]) VALUES (72, 17, 20, CAST(N'2022-01-17' AS Date))
SET IDENTITY_INSERT [sales].[orders] OFF
GO
SET IDENTITY_INSERT [sales].[staffs] ON 

INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (1, N'Trần Đức Mạnh', N'tranducmanh@gmail', N'0357251858', 1, 1, 1, N'Nam', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (2, N'Phạm Thị Phương Thảo', N'phuongthao@gmail.com', N'0323456789', 1, 2, 0, N'Nữ', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (6, N'Nguyễn Thị Ngọc Hà', N'ha@gmail.com', N'0923256789', 0, 2, 0, N'Nữ', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (10, N'Phạm Đức Huy', N'duchuy01102001@gmail.com', N'0987654332', 1, 2, 0, N'Nam', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (20, N'Nguyễn Thị Thúy', N'bovainghiengnang2k1@gmail.com', N'0324578631', 1, 2, 1, N'Nữ', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (21, N'Phạm Băng Băng', N'bang@gmail.com', N'0947852147', 1, 1, 1, N'Nam', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (23, N'Tạ Quang Trường', N'truong@gmail.com', N'0947857147', 1, 1, 0, N'Nam', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [sales].[staffs] ([staff_id], [name], [email], [phone], [active], [store_id], [manager_state], [gender], [password]) VALUES (28, N'Ngọc Lam', N'bovainghiengnang289@gmail.com', N'0147852145', 1, 2, 0, N'Nam', N'801812cc56a92381c4c5d5f75163b4a0')
SET IDENTITY_INSERT [sales].[staffs] OFF
GO
SET IDENTITY_INSERT [sales].[stores] ON 

INSERT [sales].[stores] ([store_id], [name], [phone], [email], [address], [state]) VALUES (1, N'Store Như Ý', N'0357251858', N'storeA@gmail.com', N'Tây Hồ', N'Open')
INSERT [sales].[stores] ([store_id], [name], [phone], [email], [address], [state]) VALUES (2, N'Store Hi Nguyệt', N'0393896578', N'storeB@gmail.com', N'Hoàn Kiếm', N'Open')
INSERT [sales].[stores] ([store_id], [name], [phone], [email], [address], [state]) VALUES (3, N'Store Hải Lan', N'0395612456', N'storeC@gmail.com', N'Ba Đình', N'Open')
INSERT [sales].[stores] ([store_id], [name], [phone], [email], [address], [state]) VALUES (4, N'Store Lang Hoa', N'0949365214', N'storeD@gmail.com', N'Cầu Giấy', N'Close')
INSERT [sales].[stores] ([store_id], [name], [phone], [email], [address], [state]) VALUES (5, N'Store Nhụy Cơ', N'0945123652', N'storeE@gmail.com', N'Thanh Xuân', N'Open')
SET IDENTITY_INSERT [sales].[stores] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ0]    Script Date: 1/25/2022 10:42:19 PM ******/
ALTER TABLE [sales].[customers] ADD  CONSTRAINT [UQ0] UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ1]    Script Date: 1/25/2022 10:42:19 PM ******/
ALTER TABLE [sales].[customers] ADD  CONSTRAINT [UQ1] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__staffs__AB6E616490B857FE]    Script Date: 1/25/2022 10:42:19 PM ******/
ALTER TABLE [sales].[staffs] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__staffs__B43B145F876450FB]    Script Date: 1/25/2022 10:42:19 PM ******/
ALTER TABLE [sales].[staffs] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [sales].[goods] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [sales].[goods] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [sales].[goods] ADD  DEFAULT ((0)) FOR [quantity]
GO
ALTER TABLE [sales].[order_items] ADD  DEFAULT ((0)) FOR [quantity]
GO
ALTER TABLE [sales].[order_items] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [sales].[order_items] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [sales].[order_items] ADD  DEFAULT ((0)) FOR [profit]
GO
ALTER TABLE [production].[products]  WITH CHECK ADD FOREIGN KEY([brand_id])
REFERENCES [production].[brands] ([brand_id])
GO
ALTER TABLE [production].[products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [production].[categories] ([category_id])
GO
ALTER TABLE [sales].[goods]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [production].[products] ([product_id])
GO
ALTER TABLE [sales].[goods]  WITH CHECK ADD FOREIGN KEY([store_id])
REFERENCES [sales].[stores] ([store_id])
GO
ALTER TABLE [sales].[order_items]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [sales].[orders] ([order_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [sales].[order_items]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [production].[products] ([product_id])
GO
ALTER TABLE [sales].[order_items]  WITH CHECK ADD FOREIGN KEY([product_id], [created_at], [good_till], [store_id])
REFERENCES [sales].[goods] ([product_id], [created_at], [good_till], [store_id])
GO
ALTER TABLE [sales].[orders]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [sales].[customers] ([customer_id])
GO
ALTER TABLE [sales].[orders]  WITH CHECK ADD FOREIGN KEY([staff_id])
REFERENCES [sales].[staffs] ([staff_id])
GO
ALTER TABLE [sales].[staffs]  WITH CHECK ADD FOREIGN KEY([store_id])
REFERENCES [sales].[stores] ([store_id])
GO
USE [master]
GO
ALTER DATABASE [CSDL_Project] SET  READ_WRITE 
GO
