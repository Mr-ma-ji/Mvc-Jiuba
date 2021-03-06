USE [master]
GO
/****** Object:  Database [JiuBa]    Script Date: 2020/12/24 13:54:27 ******/
CREATE DATABASE [JiuBa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'JiuBa', FILENAME = N'C:\九吧\数据库\JiuBa' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'JiuBa_log', FILENAME = N'C:\九吧\数据库\JiuBa_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [JiuBa] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JiuBa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JiuBa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JiuBa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JiuBa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JiuBa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JiuBa] SET ARITHABORT OFF 
GO
ALTER DATABASE [JiuBa] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [JiuBa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JiuBa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JiuBa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JiuBa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JiuBa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JiuBa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JiuBa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JiuBa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JiuBa] SET  DISABLE_BROKER 
GO
ALTER DATABASE [JiuBa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JiuBa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JiuBa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JiuBa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JiuBa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JiuBa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [JiuBa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JiuBa] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [JiuBa] SET  MULTI_USER 
GO
ALTER DATABASE [JiuBa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JiuBa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JiuBa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JiuBa] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [JiuBa] SET DELAYED_DURABILITY = DISABLED 
GO
USE [JiuBa]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[AdminId] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [nvarchar](50) NULL,
	[AdminAccount] [nvarchar](50) NULL,
	[AdminPwd] [nvarchar](50) NULL,
	[AdminType] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Model]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Model](
	[ModelId] [int] IDENTITY(1,1) NOT NULL,
	[ModelName] [nvarchar](50) NULL,
	[ModelImg] [nvarchar](200) NULL,
	[ModelTime] [nvarchar](50) NULL,
	[ModelState] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ModelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Post]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[PostId] [int] IDENTITY(1,1) NOT NULL,
	[PostText] [nvarchar](4000) NULL,
	[PostTime] [nvarchar](50) NULL,
	[UserId] [int] NULL,
	[ModelId] [int] NULL,
	[PostCount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostBrowse]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostBrowse](
	[PostBrowseId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[PostId] [int] NULL,
	[PostBrowseTime] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PostBrowseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostCollection]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostCollection](
	[PostCollectionId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[PostId] [int] NULL,
	[PostCollectionTime] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PostCollectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostComments]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostComments](
	[PostCommentsId] [int] IDENTITY(1,1) NOT NULL,
	[PostCommentsText] [nvarchar](4000) NULL,
	[PostCommentsTime] [nvarchar](50) NULL,
	[UserId] [int] NULL,
	[PostId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostCommentsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostCommentsLikes]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostCommentsLikes](
	[PostLikesId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[PostCommentsId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostLikesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostImg]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostImg](
	[PostImgId] [int] IDENTITY(1,1) NOT NULL,
	[PostImgImages] [nvarchar](2000) NULL,
	[PostId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostImgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PostLikes]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostLikes](
	[PostLikesId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[PostId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PostLikesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 2020/12/24 13:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[UserImg] [nvarchar](50) NULL,
	[UserSex] [nvarchar](50) NULL,
	[UserAccount] [nvarchar](50) NULL,
	[UserPwd] [nvarchar](50) NULL,
	[UsersTime] [nvarchar](50) NULL,
	[UsersEmail] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Admins] ON 

INSERT [dbo].[Admins] ([AdminId], [AdminName], [AdminAccount], [AdminPwd], [AdminType]) VALUES (1, N'超级管理员', N'admin', N'1', 0)
INSERT [dbo].[Admins] ([AdminId], [AdminName], [AdminAccount], [AdminPwd], [AdminType]) VALUES (11, N'普通管理员', NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Admins] OFF
SET IDENTITY_INSERT [dbo].[Model] ON 

INSERT [dbo].[Model] ([ModelId], [ModelName], [ModelImg], [ModelTime], [ModelState]) VALUES (20, N'DNF', N'2020年5月21日QQ截图20200521104309.jpg', N'2020/5/21 11:44:11', 1)
INSERT [dbo].[Model] ([ModelId], [ModelName], [ModelImg], [ModelTime], [ModelState]) VALUES (31, N'C#交流区', N'2020年7月8日cb6259d9d48847a09678f5dd6b0d0704.jpg', N'2020/7/8 13:47:04', 1)
INSERT [dbo].[Model] ([ModelId], [ModelName], [ModelImg], [ModelTime], [ModelState]) VALUES (32, N'LOL', N'2020年7月8日water_47476_698_698_.png', N'2020/7/8 13:49:07', 1)
INSERT [dbo].[Model] ([ModelId], [ModelName], [ModelImg], [ModelTime], [ModelState]) VALUES (34, N'起点易购', N'2020年12月4日logo2.jpg', N'2020/12/4 8:45:05', 1)
SET IDENTITY_INSERT [dbo].[Model] OFF
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (19, N'图片测3', N'2020/5/29 22:40:10', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (20, N'图片测试4', N'2020/5/29 22:40:39', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (21, N'原标题：张文宏：天热可以开空调戴口罩，同时保持窗户定时打开
            张文宏：天热可以开空调戴口罩
          5月18日晚，复旦大学附属华山医院感染科主任张文宏在参加一场直播活动时表示，在天气炎热需要开空调的时候，可以戴着口罩，同时保持窗户定时打开。张文宏说，天气炎热的时候很多人忍受不了戴口罩，“我情愿是戴口罩开空调。（开了空调）窗户还是要开，定期地开窗再关闭。”张文宏表示，目前国内的疫情控制得很好，因此应该尽快地开放旅游，“我们的政府有极大的决心、医护人员有拼命的精神、民众极大的配合，组成了一个严密的‘防控网’。”采写：南都记者 周斐', N'2020/5/29 22:55:49', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (23, N'原标题：失实举报被澄清后，举报人：愿意当面向普洱市长道歉云南省纪委监委网站 图“失实检举控告澄清会为我卸下了包袱、消除了顾虑，让我深刻感受到了组织的强大力量和温暖。”在自己的失实举报澄清会上，云南普洱市市长刘勇作了上述表态。 据云南省纪委监委官网消息，5月18日下午，云南省纪委省监委在普洱市召开失实检举控告澄清会，以“面对面”的方式，对群众举报反映普洱市委副书记、市长刘勇同志有关问题的调查结果进行通报并对相关问题当场予以澄清。 消息称，前段时间，云南省纪委省监委收到实名举报反映普洱市刘勇同志的有关问题后，高度重视，主要领导亲自批示，相关部门迅速成立工作组，对举报反映的问题进行了严肃认真的调查核实。经查，举报反映的问题失实。经省纪委省监委研究同意，决定对举报反映刘勇同志的问题线索作了结处理，并予以澄清。 5月17日下午，云南省纪委省监委第五监督检查室的工作人员将调查结果向举报人进行了当面反馈。举报人表示，相信组织，认可省纪委省监委的调查结论，其不认识刘勇，这次不实举报给刘勇同志造成了困扰，觉得对不起他，愿意向刘勇同志赔礼道歉。 出生于1967年12月的刘勇是一名纳西族干部，云南丽江人，博士研究生学历，曾在云南建工集团有限公司、省投资控股集团有限公司工作，2018年6月任普洱市委副书记、代市长，同年9月任市长。 在澄清会上，刘勇表态发言时称，“在今后的工作中，我将始终把党员身份作为自己的第一身份，始终把普洱的发展作为自己的职责使命，始终把廉洁从政作为根本底线，把每件事情办好办实，以实实在在的具体行动、工作成效回报组织的信任和群众的期待。” 根据《纪检监察机关处理检举控告工作规则》，云南省纪委省监委出台了《云南省纪检监察机关查处诬告陷害行为及失实检举控告澄清工作办法（试行）》。省纪委省监委有关负责人表示，“召开这次会议对相关问题予以澄清，目的就是要树立为担当者担当、为实干者负责的鲜明导向，给干事者撑腰鼓劲，让流汗者不流泪，在全省上下营造风清气正的政治生态和干事创业环境。” 2019年以来，云南省各级纪检监察机关已多次召开失实举报澄清通报反馈会，为受到诬告陷害的党员干部澄清正名、消除顾虑、还以清白。 比如，2019年1月9日，云南省纪委监委在红河哈尼族彝族自治州蒙自市召开不实举报澄清了结反馈会，首次为厅级领导澄清正名。反馈会以“面对面”的方式，通报了红河州委原常委、州委政法委原书记和建《致州委常委的公开信》所反映问题线索的调查核实意见，为被不实举报的红河州委书记姚国华澄清事实、消除影响，以为担当者担当、为负责者负责的有力举措，激励广大干部勇于担当履职、大胆干事创业。 (本文来自澎湃新闻，更多原创资讯请下载“澎湃新闻”APP)', N'2020/5/29 22:56:33', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (24, N'原标题：印媒：印空军计划采购450架战斗机，部署在印度北部和西部边境【环球网报道 记者 徐璐明 张晓雅】印度空军司令近日公布了印度空军未来战机发展计划，将采购多达450架各型战机，这些战机还将部署在印度北部和西部边境。印度Zee新闻网站援引亚洲国际新闻社（ANI）消息称，当地时间19日，印度空军总司令巴达乌里亚（RKS Bhadauria）表示，印度空军正计划采购450架战斗机，部署在印度北部和西部边境。报道称，印度空军正寻求采购114架多用途战斗机、100架“先进中型战斗机”（AMCA）以及200多架LCA“光辉”轻型战斗机。这一计划已经得到了印度空军司令巴达乌里亚的确认。巴达乌里亚接受采访时说：“未来15年，多达83架LCA轻型战斗机将是我们的关注重点，此后再列装约100架LCA MK2型战斗机，LCA战机的总数将能达到接近200架。”“对于AMCA战斗机，我们有6个空军中队的编制，所以要部署将近100架。”巴达乌里亚还说：“在教练机方面，我们将引入70架HTT-40教练机。这样一来装备的国产战斗机总数达到了约370架。”而对于有关购买114架多用途战斗机的计划，巴达乌里亚说：“该项目属于中等规模项目，是‘阵风’战斗机项目的一部分。在这个问题上，我们将通过‘印度制造’的方式来解决，增加外国直接投资，支持私营部门。我认为这在未来将能带给我们支持航空业发展所需的技术。我认为拥有新一代飞机与打造制造该机的技术和能力同等重要。”巴达乌里亚还补充说，训练计划也必须考虑到未来的需求，有关战斗人员将在未来35年的一段时间内接受训练。', N'2020/5/29 22:57:03', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (25, N'原标题：接留美学生回国航班遭推迟 中方：希望美方尽快办妥相关手续中新网北京5月19日电 (李京泽 张素)中国外交部发言人赵立坚19日在例行记者会上应询时证实，中国接留美学生回国的临时航班在美国因未得到批准而推迟。他还说，希望美方从人道主义精神出发，尽快为有关接回学生的航班办妥相关手续，使中国学生能够顺利回国。中国驻纽约总领馆日前先后两次就有关临时航班推迟一事发布通知，有记者在会上向中方求证。赵立坚表示，中国有关航空公司拟于近日安排部分临时航班自美接回一些确有困难、急需回国的留学人员，由于美方未批准相关航班申请，导致航班被迫推迟，中方对此表示遗憾。他介绍，拟搭乘临时航班的中国留学人员有的并不住在航班出发城市，为了乘机，他们已退掉了宿舍、住房。临时航班推迟给这些孩子带来极大不便。中国驻美使领馆已协助予以安排和解决。“我们希望美方从人道主义精神出发，尽快为有关接回学生的航班办妥相关手续，使中国学生能够顺利回国”，他说。(完)', N'2020/5/29 22:57:21', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (26, N'原标题：特朗普威胁永久“断供”并退出世卫，中方：打错算盘找错对象5月19日，外交部发言人赵立坚主持例行记者会。有记者提问，美国总统特朗普威胁称，如果世卫组织不独立对待中国，美国可能永久“断供”并退出世卫组织，中方对此有何回应？ 赵立坚表示，世卫组织会员国缴纳会费的比例和标准是由会员国共同确定的，不是美国一家说了算的。及时足额缴纳会费是美国作为世卫组织成员国应尽的义务，而不是可以讨价还价的。美国任意对国际组织“断供”、减资的行为是单边主义行径，违反自身国际义务。 赵立坚指出，国际抗疫正处于关键阶段，支持世卫组织就是在捍卫多边主义的理念和原则，支持世卫组织就是支持国际抗疫合作、支持挽救生命。中国始终严格遵守世卫组织章程和规定，及时足额缴纳会费，并在力所能及范围内向世卫组织提供捐款。新冠肺炎疫情发生以来，中国先后向世卫组织提供了5000万美元捐款，设立了20亿元人民币抗疫合作专项资金，派出了24支抗疫医疗专家组，并向世卫组织和各国提供了大量物资援助，习近平主席在世卫大会上庄重承诺，中国将在两年内提供20亿美元国际援助，用于支持受疫情影响的国家特别是发展中国家抗疫斗争以及经济社会恢复发展，中国新冠肺炎疫苗研发完成并投入使用后将作为全球公共产品。中方将一如既往支持世卫组织在国际防疫合作中发挥领导作用，并将继续以各种方式支持世卫组织工作，中国呼吁国际社会加大对世卫组织的政治支持和资金投入，调动全球资源打赢疫情阻击战。 赵立坚强调，美国拿中国说事，在履行应向世卫组织承担国际义务的问题上推卸责任、讨价还价是打错了算盘，找错了对象。 (本文来自澎湃新闻，更多原创资讯请下载“澎湃新闻”APP)', N'2020/5/29 22:58:11', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (27, N'原标题：尼日利亚海军解救遭劫中国渔船 18人获救新华社阿布贾5月19日电（记者郭骏）中国驻拉各斯总领馆19日证实，尼日利亚海军日前成功解救一艘在几内亚湾海域遭海盗劫持的中国渔船，船上18人获救，其中包括8名中国公民。驻拉各斯总领馆副总领事管仲奇告诉新华社记者，总领馆得到中国渔船遭海盗劫持的消息后立即联系尼日利亚海军。尼方随即出动巡逻船，成功拦截遭劫渔船，解救全体船员并抓获多名海盗。在尼海军护送下，渔船已于18日抵达拉各斯港，18名船员均安好。尼日利亚海军一位发言人18日向新华社记者证实，海盗15日在科特迪瓦附近海域袭击并劫持了这艘中国渔船，随后控制渔船驶向尼日利亚海域。尼海军在拉各斯以南140海里处的海域拦截遭劫持渔船，救出船员并抓获10名海盗。船上18名船员分别来自中国、加纳和科特迪瓦。（完）', N'2020/5/29 22:58:33', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (29, N'原标题：全国政协十三届三次会议新闻发布会将于20日15时召开中新网5月19日电 全国政协十三届三次会议秘书处新闻组19日发布通知，定于5月20日15:00召开全国政协十三届三次会议新闻发布会。通知指出，为有效防控疫情，共同维护公共卫生与健康，发布会将采用网络视频形式进行。大会新闻发言人郭卫民将向中外媒体介绍本次大会有关情况并回答记者提问。', N'2020/5/29 22:59:11', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (30, N'原标题：全国已打掉涉黑组织3120个涉恶犯罪集团9888个新华社北京5月19日电（记者刘奕湛）记者19日从全国扫黑办获悉，截至今年4月底，全国共打掉涉黑组织3120个，涉恶犯罪集团9888个，刑拘犯罪嫌疑人388442人，立案查处涉黑涉恶腐败和“保护伞”67190人。19日，全国扫黑办召开新闻发布会，通报辽宁宋琦案、河南李含富案、广东谢培忠案、海南黄鸿发案等4起已判决生效的全国扫黑办挂牌督办案件情况。中央政法委秘书长、全国扫黑办主任陈一新表示，扫黑除恶专项斗争开展以来，各地各有关部门将打击锋芒对准人民群众深恶痛绝的黑恶势力及其“保护伞”，促进了社会生态和政治生态、经济生态的改善，赢得了广大人民群众的赞誉。据介绍，从本月起，全国扫黑办将每月从挂牌督办的111起大要案中，精选3至4起案件发布，回应群众关切，交流办案经验，带动全国扫黑办挂牌百起、省级挂牌千起、全国万起涉黑涉恶案件依法加快办理，确保今年“一十百千万”行动目标如期实现。陈一新表示，中央政法委已将挂牌督办案件办理情况纳入平安建设考核内容，对挂牌督办案件办理缓慢的，要派出特派督导组重点督导；对推诿塞责、失职渎职的，要严肃追责问责。据了解，今年4月9日，根据全国扫黑办统一部署，公安部以1712名涉黑涉恶在逃人员为目标，组织全国公安机关开展扫黑除恶“逃犯清零”行动，对涉黑涉恶在逃人员展开凌厉攻势。截至目前，1481名境内逃犯到案987人，到案率66.6%；潜逃境外逃犯到案37人。其中，22名A级通缉令逃犯到案14名。公安部副部长、全国扫黑办副主任杜航伟表示，下一步，全国公安机关将持续加大追逃力度，进一步强化组织领导、工作措施、科技支撑以及国际合作，努力实现涉黑涉恶逃犯清零见底。（完）', N'2020/5/29 22:59:29', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (34, N'
                                        川普自作自受！制裁中国却坑哭美国猪农，加拿大竟渔翁得利
                                    ', N'2020/5/29 23:00:26', 24, 20, 4)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (48, N'12123', N'2020/5/30 10:51:18', 24, 20, 1)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (51, N'645641351', N'2020/5/30 11:00:16', 24, 20, 0)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (53, N'867896786', N'2020/5/30 11:03:09', 24, 20, 6)
INSERT [dbo].[Post] ([PostId], [PostText], [PostTime], [UserId], [ModelId], [PostCount]) VALUES (142, N'ces', N'2020/9/7 16:36:26', 29, 32, 8)
SET IDENTITY_INSERT [dbo].[Post] OFF
SET IDENTITY_INSERT [dbo].[PostCollection] ON 

INSERT [dbo].[PostCollection] ([PostCollectionId], [UserId], [PostId], [PostCollectionTime]) VALUES (21, 27, 53, N'2020/7/9 14:51:34')
INSERT [dbo].[PostCollection] ([PostCollectionId], [UserId], [PostId], [PostCollectionTime]) VALUES (23, 27, 30, N'2020/7/9 14:51:50')
INSERT [dbo].[PostCollection] ([PostCollectionId], [UserId], [PostId], [PostCollectionTime]) VALUES (24, 27, 29, N'2020/7/9 14:51:52')
SET IDENTITY_INSERT [dbo].[PostCollection] OFF
SET IDENTITY_INSERT [dbo].[PostImg] ON 

INSERT [dbo].[PostImg] ([PostImgId], [PostImgImages], [PostId]) VALUES (106, N'2020年9月7日1.png', 142)
INSERT [dbo].[PostImg] ([PostImgId], [PostImgImages], [PostId]) VALUES (107, N'2020年9月7日2.png', 142)
INSERT [dbo].[PostImg] ([PostImgId], [PostImgImages], [PostId]) VALUES (108, N'2020年9月7日14634608_100458314183_2.jpg', 142)
INSERT [dbo].[PostImg] ([PostImgId], [PostImgImages], [PostId]) VALUES (109, N'2020年9月7日64568130.jpg', 142)
INSERT [dbo].[PostImg] ([PostImgId], [PostImgImages], [PostId]) VALUES (110, N'2020年9月7日01200000027111136352651553670.jpg', 142)
SET IDENTITY_INSERT [dbo].[PostImg] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (1, N'测试1', N'2020年5月31日QQ图片20200510110516.jpg', N'男', N'12', N'3', NULL, N'0')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (2, N'1', N'1', N'1', N'13', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (3, N'1', N'1', N'1', N'14', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (4, N'1', N'1', N'1', N'15', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (5, N'1', N'1', N'1', N'16', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (6, N'1', N'1', N'1', N'7', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (7, N'1', N'1', N'1', N'8', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (8, N'1', N'1', N'1', N'9', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (9, N'1', N'1', N'1', N'10', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (10, N'1', N'1', N'1', N'11', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (11, N'1', N'1', N'1', N'22', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (12, N'1', N'1', N'1', N'23', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (13, N'1', N'1', N'1', N'24', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (14, N'1', N'1', N'1', N'25', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (15, N'1', N'1', N'1', N'26', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (16, N'1', N'1', N'1', N'27', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (17, N'1', N'1', N'1', N'28', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (18, N'1', N'1', N'1', N'29', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (19, N'1', N'1', N'1', N'70', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (20, N'1', N'1', N'1', N'53', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (21, N'1', N'1', N'1', N'62', N'1', N'1', N'1')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (24, N'玖吧管理员测试账号', N'2020年5月31日QQ图片20191129193025.jpg', N'男', N'2236418809@qq.com', N'2', N'2020/5/27 23:23:52', N'0')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (25, N'玖吧用户', N'私人的-1.jpg', N'女', N'2302443415@qq.com', N'1', N'2020/5/28 22:50:57', N'0')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (26, N'玖吧用户', N'私人的-1.jpg', N'女', N'2386411271@qq.com', N'123456', N'2020/7/8 13:54:44', N'0')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (27, N'lucky 7', N'2020年7月9日QQ截图20200526211256.jpg', N'男', N'1585584325@qq.com', N'1', N'2020/7/9 14:50:32', N'0')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (28, N'玖吧用户', N'私人的-1.jpg', N'男', N'3189588084@qq.com', N'123123', N'2020/7/23 20:50:26', N'0')
INSERT [dbo].[Users] ([UserId], [UserName], [UserImg], [UserSex], [UserAccount], [UserPwd], [UsersTime], [UsersEmail]) VALUES (29, N'玖吧用户', N'私人的-1.jpg', N'男', N'1592986961@qq.com', N'123456', N'2020/9/7 16:35:14', N'0')
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([ModelId])
REFERENCES [dbo].[Model] ([ModelId])
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PostBrowse]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostBrowse]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PostCollection]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostCollection]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PostComments]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostComments]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PostCommentsLikes]  WITH CHECK ADD FOREIGN KEY([PostCommentsId])
REFERENCES [dbo].[PostComments] ([PostCommentsId])
GO
ALTER TABLE [dbo].[PostCommentsLikes]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[PostImg]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostLikes]  WITH CHECK ADD FOREIGN KEY([PostId])
REFERENCES [dbo].[Post] ([PostId])
GO
ALTER TABLE [dbo].[PostLikes]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
USE [master]
GO
ALTER DATABASE [JiuBa] SET  READ_WRITE 
GO
