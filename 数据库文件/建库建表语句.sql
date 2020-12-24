create database JiuBa  --数据库
on
(
name='JiuBa',
filename='C:\九吧\数据库\JiuBa'
)
create table Admins--管理员表
(
AdminId int primary key identity(1,1),--管理员Id
AdminName nvarchar(50),--管理员昵称
AdminAccount nvarchar(50),--管理员账号
AdminPwd nvarchar(50),--管理员密码
AdminType int--0超级管理员1普通管理员
)
create table Model--贴吧模块表
(
ModelId int primary key identity(1,1),--模块Id
ModelName nvarchar(50),--模块名字
ModelImg nvarchar(200),--模块图片
ModelTime nvarchar(50),--模块最后修改时间
ModelState int --模块状态(1，启用状态，2禁用状态)
)
create table Users--用户表
(
UserId int primary key identity(1,1),--用户id
UserName nvarchar(50),--用户昵称
UserImg nvarchar(50),--用户头像
UserSex nvarchar(50),--用户性别
UserAccount nvarchar(50),--用户账号
UserPwd nvarchar(50),--用户密码
UsersTime nvarchar(50),--注册时间
UsersEmail nvarchar(50),--（0启用，1禁用）
)
insert into Users values('1','1','1','1','1','1','1')
create table Post--帖子表
(
PostId int primary key identity(1,1),--帖子Id
PostText nvarchar(4000),--帖子内容
PostTime nvarchar(50),--发帖时间
UserId int foreign key references Users(UserId),--外键关联用户id
ModelId int foreign key references Model(ModelId),--外键关模块id
PostCount int--浏览次数
)
create table PostBrowse--浏览记录表
(
PostBrowseId int primary key identity(1,1),--浏览记录Id
UserId int foreign key references Users(UserId),--外键关联用户id
PostId int foreign key references Post(PostId),--外键关联帖子表
PostBrowseTime nvarchar(50)--浏览时间
)
delete PostBrowse where PostId=72
create table PostCollection--收藏表
(
PostCollectionId int primary key identity(1,1),--收藏id
UserId int foreign key references Users(UserId),--外键关联用户id
PostId int foreign key references Post(PostId),--外键关联帖子表
PostCollectionTime nvarchar(50)--收藏时间
)
delete PostCollection where PostId=72
create table PostImg--帖子图片表
(
PostImgId int primary key identity(1,1),--图片Id
PostImgImages nvarchar(2000),--帖子图片
PostId int foreign key references Post(PostId),--外键关联帖子表（首先上传文本内容，然后查询该用户这一时间上传的帖子）
)
create table PostComments--帖子评论表
(
PostCommentsId int primary key identity(1,1),--帖子评论Id
PostCommentsText nvarchar(4000),--帖子评论内容
PostCommentsTime nvarchar(50),--帖子评论时间
UserId int foreign key references Users(UserId),--外键关联用户id
PostId int foreign key references Post(PostId),--外键关联帖子表
)
create table PostLikes --帖子点赞表
(
PostLikesId int primary key identity(1,1),--点赞Id
UserId int foreign key references Users(UserId),--外键关联用户id
PostId int foreign key references Post(PostId),--外键关联帖子表

)
create table PostCommentsLikes--评论点赞表
(
PostLikesId int primary key identity(1,1),--点赞Id
UserId int foreign key references Users(UserId),--外键关联用户id
PostCommentsId int foreign key references PostComments(PostCommentsId),--外键关联帖子评论
)
