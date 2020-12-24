create database JiuBa  --���ݿ�
on
(
name='JiuBa',
filename='C:\�Ű�\���ݿ�\JiuBa'
)
create table Admins--����Ա��
(
AdminId int primary key identity(1,1),--����ԱId
AdminName nvarchar(50),--����Ա�ǳ�
AdminAccount nvarchar(50),--����Ա�˺�
AdminPwd nvarchar(50),--����Ա����
AdminType int--0��������Ա1��ͨ����Ա
)
create table Model--����ģ���
(
ModelId int primary key identity(1,1),--ģ��Id
ModelName nvarchar(50),--ģ������
ModelImg nvarchar(200),--ģ��ͼƬ
ModelTime nvarchar(50),--ģ������޸�ʱ��
ModelState int --ģ��״̬(1������״̬��2����״̬)
)
create table Users--�û���
(
UserId int primary key identity(1,1),--�û�id
UserName nvarchar(50),--�û��ǳ�
UserImg nvarchar(50),--�û�ͷ��
UserSex nvarchar(50),--�û��Ա�
UserAccount nvarchar(50),--�û��˺�
UserPwd nvarchar(50),--�û�����
UsersTime nvarchar(50),--ע��ʱ��
UsersEmail nvarchar(50),--��0���ã�1���ã�
)
insert into Users values('1','1','1','1','1','1','1')
create table Post--���ӱ�
(
PostId int primary key identity(1,1),--����Id
PostText nvarchar(4000),--��������
PostTime nvarchar(50),--����ʱ��
UserId int foreign key references Users(UserId),--��������û�id
ModelId int foreign key references Model(ModelId),--�����ģ��id
PostCount int--�������
)
create table PostBrowse--�����¼��
(
PostBrowseId int primary key identity(1,1),--�����¼Id
UserId int foreign key references Users(UserId),--��������û�id
PostId int foreign key references Post(PostId),--����������ӱ�
PostBrowseTime nvarchar(50)--���ʱ��
)
delete PostBrowse where PostId=72
create table PostCollection--�ղر�
(
PostCollectionId int primary key identity(1,1),--�ղ�id
UserId int foreign key references Users(UserId),--��������û�id
PostId int foreign key references Post(PostId),--����������ӱ�
PostCollectionTime nvarchar(50)--�ղ�ʱ��
)
delete PostCollection where PostId=72
create table PostImg--����ͼƬ��
(
PostImgId int primary key identity(1,1),--ͼƬId
PostImgImages nvarchar(2000),--����ͼƬ
PostId int foreign key references Post(PostId),--����������ӱ������ϴ��ı����ݣ�Ȼ���ѯ���û���һʱ���ϴ������ӣ�
)
create table PostComments--�������۱�
(
PostCommentsId int primary key identity(1,1),--��������Id
PostCommentsText nvarchar(4000),--������������
PostCommentsTime nvarchar(50),--��������ʱ��
UserId int foreign key references Users(UserId),--��������û�id
PostId int foreign key references Post(PostId),--����������ӱ�
)
create table PostLikes --���ӵ��ޱ�
(
PostLikesId int primary key identity(1,1),--����Id
UserId int foreign key references Users(UserId),--��������û�id
PostId int foreign key references Post(PostId),--����������ӱ�

)
create table PostCommentsLikes--���۵��ޱ�
(
PostLikesId int primary key identity(1,1),--����Id
UserId int foreign key references Users(UserId),--��������û�id
PostCommentsId int foreign key references PostComments(PostCommentsId),--���������������
)
