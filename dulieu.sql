create database QuanLyDeAn
GO
use QuanLyDeAn
go
Create	table NHANVIEN
(
	HOVN	nvarchar(15),
	TENLOT	nvarchar(15),
	TENNV	nvarchar(15) not null,
	MANV	char	(9) not null,
	NGSINH	Datetime,
	DCHI	nvarchar(30),
	PHAI	nvarchar(3),
	LUONG	float,
	MA_NQL	char(9),
	PHG	int,
	constraint PK_NHANVIEN primary key(MANV),
	
)

Create	table PHONGBAN
(
	TENPHG	nvarchar(15),
	MAPHG	int not null,
	TRPHG	char(9),
	NG_NHANCHUC Datetime
	constraint PK_PHONGBAN primary key(MAPHG)
)


Create table DIADIEM_PHG
(
	MAPHG	int,
	DIADIEM nvarchar(50)
	constraint PK_DIADIEM_PHG primary key (MAPHG, DIADIEM)
)

Create table DEAN
(
	TENDA	nvarchar(15),
	MADA	int,
	DDIEM_DA nvarchar(50),
	PHONG	int,
	constraint PK_DEAN primary key(MADA)
)

/*Create table CONGVIEC
(
	MADA int,
	STT  int,
	TEN_CONG_VIEC nvarchar(50),
	constraint PK_CONGVIEC primary key (MADA, STT)
	
)*/

Create table PHANCONG
(
	MA_NVIEN char(9),
	MADA	 int,
	THOIGIAN float,
	constraint PK_PHANCONG primary key (MA_NVIEN, MADA)
)

Create	table THANNHAN
(
	MA_NVIEN char(9),
	TENTN	 nvarchar(15),
	PHAI	 nvarchar(3),
	NGSINH	Datetime,
	QUANHE 	nvarchar(15),
	constraint PK_THANNHAN primary key (MA_NVIEN, TENTN) 
)

----------------------------------*tao khoa ngoai*---------------------------
--tao khoa ngoai cho bang NHANVIEN
alter table NHANVIEN
add 
constraint FK_NHANVIEN_NHANVIEN foreign key(MA_NQL) references NHANVIEN(MANV),
constraint FK_NHANVIEN_PHONGBAN foreign key(PHG) references PHONGBAN(MAPHG)
--tao khoa ngoai cho bang PHONGBAN
alter table PHONGBAN
add
constraint FK_PHONGBAN_NHANVIEN foreign key(TRPHG) references NHANVIEN(MANV)
--tao khoa ngoai cho bang DIADIEM_PHG
alter table DIADIEM_PHG
add
constraint FK_DIADIEMPHG_PHONGBAN foreign key(MAPHG) references PHONGBAN(MAPHG)
--tao khoa ngoai cho bang DEAN
alter table DEAN
add
constraint FK_DEAN_PHONGBAN foreign key(PHONG) references PHONGBAN(MAPHG)
--tao khoa ngoai cho CONGVIEC
/*alter table CONGVIEC
add
constraint FK_CONGVIEC_DEAN foreign key(MADA) references DEAN(MADA)
--tao khoa ngoai cho PHANCONG
alter table PHANCONG
add
constraint FK_PHANCONG_CONGVIEC foreign key(MADA, STT) references CONGVIEC(MADA, STT)
--tao khoa ngoai cho THANNHAN
alter table THANNHAN
add
*/
alter table PHANCONG
add
constraint FK_PHANCONG_DEAN foreign key(MADA) references DEAN(MADA),
constraint FK_PHANCONG_NHANVIEN foreign key(MA_NVIEN) references NHANVIEN(MANV)
alter table THANNHAN
add constraint FK_THANNHAN_NHANVIEN foreign key(MA_NVIEN) references NHANVIEN(MANV)


set dateformat dmy

insert into NHANVIEN values(N'Vương', N'Ngọc', N'Quyền', 
'006', '01/01/1965', N'45 Trưng Vương Hà Nội', N'Nữ', 55000, null, null)

insert into NHANVIEN values(N'Nguyễn', N'Thanh', N'Tùng', 
'005', '20/08/1962', N'222 Nguyễn Văn Cừ TPHCM', N'Nam', 40000, NULL, null) /*006*/

insert into NHANVIEN values(N'Lê', N'Thị', N'Nhàn', 
'001', '01/02/1967', N'291 Hồ Văn Huê TPHCM', N'Nữ', 43000, NULL, null)/*006*/

insert into NHANVIEN values(N'Nguyễn', N'Mạnh', N'Hùng', 
'004', '04/03/1967', N'95 Bà Rịa Vũng Tàu', N'Nam', 38000, NULL, null)/*005*/

insert into NHANVIEN values(N'Trần', N'Thanh', N'Tâm', 
'003', '04/05/1957', N'34 Mai Thị Lựu TPHCM', N'Nam', 25000, NULL, null) /*005*/

insert into NHANVIEN values(N'Bùi', N'Thúy', N'Bư', 
'007', '11/03/1954', N'332 Nguyễn Thái Học TPHCM', N'Nam', 25000, NULL, null)/*001*/

insert into NHANVIEN values(N'Trần', N'Hồng', N'Quang', 
'008', '01/09/1967', N'80 Lê Hồng Phong TPHCM', N'Nam', 25000, NULL, null) /*001*/

insert into NHANVIEN values(N'Đinh', N'Bá', N'Tiến', 
'009', '12/01/1960', N'119 Cống Quỳnh TPHCM', N'Nam', 30000, NULL, null) /*005*/

insert into NHANVIEN values(N'Dang',N'Xuan',N'Khanh','011','29-11-2004',N'Quang Tri',N'Nam',31000,null,null)



-- nhap du lieu cho PHONGBAN

insert into PHONGBAN values(N'Nghiên Cứu', 5, '005', '22/05/1987')
insert into PHONGBAN values(N'Diều Hành', 4, '008', '01/01/1985')
insert into PHONGBAN values(N'Quản Lý', 1, '006', '19/06/1971')


--cap nhat du lieu cho bang DIADIEM_PHG

insert into DIADIEM_PHG values( 1,'TP HCM')
insert into DIADIEM_PHG values( 4,'HA NOI')
insert into DIADIEM_PHG values( 5,'VUNG TAU')


--cap nhat du lieu cho bang DEAN
insert into DEAN values(N'Sản phẩm X', 1, 'VUNG TAU', 5)
insert into DEAN values(N'Sản phẩm Y', 2, 'NHA TRANG', 5)
insert into DEAN values(N'Sản phẩm Z', 3, 'TP HCM', 5)
insert into DEAN values(N'Tin học hóa', 10, 'HA NOI', 4)
insert into DEAN values(N'Cap Quang', 20, 'TP HCM', 1)
insert into DEAN values(N'Đào Tạo', 30, 'HA NOI', 4)

--cap nhat du lieu cho bang THANNHAN
insert into THANNHAN values('005', N'Quang', N'Nữ', '05/04/1976', N'Con gái')
insert into THANNHAN values('005', N'Khang', N'Nam', '25/10/1973', N'Con trai')
insert into THANNHAN values('005', N'Dương', N'Nữ', '03/05/1948', N'Vợ chồng')
insert into THANNHAN values('001', N'Đăng', N'Nam', '19/02/1932', N'Vợ chồng')
insert into THANNHAN values('009', N'Duy', N'Nam', '01/01/1978', N'Con trai')
insert into THANNHAN values('009', N'Châu', N'Nữ', '30/12/1978', N'Con gái')
insert into THANNHAN values('009', N'Phương', N'Nữ', '05/05/1957', N'Vợ chồng')


--chen du lieu cho bang PHANCONG
insert into PHANCONG values('009', 1, 32)
insert into PHANCONG values('009', 2, 8)
insert into PHANCONG values('004', 3, 40)
insert into PHANCONG values('003', 1, 20)
insert into PHANCONG values('003', 2, 20)
insert into PHANCONG values('008', 10,35)
insert into PHANCONG values('008', 30,5)
insert into PHANCONG values('001', 30,20)
insert into PHANCONG values('001', 20,15)
insert into PHANCONG values('006', 20,30)
insert into PHANCONG values('005', 3, 10)
insert into PHANCONG values('005', 10,10)
insert into PHANCONG values('005', 20,10)
insert into PHANCONG values('007', 30,30)
insert into PHANCONG values('007', 10,10)



