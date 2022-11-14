﻿use QLGV 

create table KHOA
(
	MAKHOA varchar(4) primary key,
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA CHAR(4)
)

create table MONHOC
(
	MAMH varchar(10)primary key,
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4) foreign key references KHOA(MAKHOA)	
)

create table GIAOVIEN
(
	MAGV char(4)primary key,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4) foreign key references KHOA(MAKHOA)	
)

create table HOCVIEN
(
	MAHV char(5) primary key,
	HO varchar(40),
	TEN varchar(10),
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3)
)

create table LOP
(
	MALOP char(3)primary key,
	TENLOP varchar(40),
	SISO tinyint,
	TRGLOP char(5) foreign key references HOCVIEN(MAHV),
	MAGVCN char(4) foreign key references GIAOVIEN(MAGV)

)

 drop table LOP

create table GIANGDAY
(
	MALOP char(3) foreign key references LOP(MALOP),
	MAMH varchar(10) foreign key references MONHOC(MAMH),
	constraint PK_GIANGDAY PRIMARY KEY (MALOP, MAMH),
	MAGV char(4) foreign key references GIAOVIEN(MAGV),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime

)

create table KETQUATHI
(
	MAHV char(5) foreign key references HOCVIEN(MAHV),
	MAMH varchar(10) foreign key references MONHOC(MAMH),
	LANTHI tinyint,
	constraint PK_KETQUATHI PRIMARY KEY (MAHV,MAMH ,LANTHI),
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10)

)

create table DIEUKIEN
(
	MAMH varchar(10) foreign key references MONHOC(MAMH),
	MAMH_TRUOC varchar(10) foreign key references MONHOC(MAMH),
	constraint PK_DIEUKIEN primary key (MAMH,MAMH_TRUOC)
)

alter table KHOA add constraint TRGKHOA foreign key (TRGKHOA) references GIAOVIEN(MAGV)

alter table HOCVIEN add constraint MALOP foreign key (MALOP) references LOP(MALOP)

--cau 1

alter table HOCVIEN add DIEMTB float
alter table HOCVIEN add GHICHU varchar(20)
alter table HOCVIEN add XEPLOAI varchar(10)

--cau 2

 alter table HOCVIEN add constraint MAHV_CHECK check (MAHV like 'K[0-9][0-9][0-9][0-9]')

--cau 3

alter table HOCVIEN add constraint GTHV check(GIOITINH='Nam' or GIOITINH='Nu' )
alter table GIAOVIEN add constraint GTGV check(GIOITINH='Nam' or GIOITINH='Nu' )

--cau 4

alter table KETQUATHI add constraint checkdiem check((DIEM between 0 and 10) and right(cast(DIEM as float),3) like '.__')
--cau 5
alter table KETQUATHI add constraint KQ check ((KQUA ='Dat' and DIEM between 5 and 10) or (KQUA ='Khong dat' and DIEM <5))

--cau 6

alter table KETQUATHI add constraint LT check(LANTHI <=3)

--cau 7

alter table GIANGDAY add constraint HK check(HOCKY between 1 and 3)

--cau 8

alter table GIAOVIEN add constraint HV check(HOCVI = 'CN' or HOCVI = 'KS' or HOCVI = 'Ths' or HOCVI = 'TS' or HOCVI = 'PTS' )

ALTER TABLE KHOA NOCHECK CONSTRAINT ALL
ALTER TABLE LOP NOCHECK CONSTRAINT ALL
ALTER TABLE MONHOC NOCHECK CONSTRAINT ALL
ALTER TABLE DIEUKIEN NOCHECK CONSTRAINT ALL
ALTER TABLE GIAOVIEN NOCHECK CONSTRAINT ALL
ALTER TABLE HOCVIEN NOCHECK CONSTRAINT ALL
ALTER TABLE GIANGDAY NOCHECK CONSTRAINT ALL
ALTER TABLE KETQUATHI NOCHECK CONSTRAINT ALL

-- Nhập dữ liệu cho KHOA --
insert into KHOA values('KHMT','Khoa hoc may tinh','6/7/2005','GV01')
insert into KHOA values('HTTT','He thong thong tin','6/7/2005','GV02')
insert into KHOA values('CNPM','Cong nghe phan mem','6/7/2005','GV04')
insert into KHOA values('MTT','Mang va truyen thong','10/20/2005','GV03')
insert into KHOA values('KTMT','Ky thuat may tinh','12/20/2005','')

-- Nhập dữ liệu cho GIAOVIEN --
insert into GIAOVIEN values('GV01','Ho Thanh Son','PTS','GS','Nam','5/2/1950','1/11/2004',5.00,2250000,'KHMT')
insert into GIAOVIEN values('GV02','Tran Tam Thanh','TS','PGS','Nam','12/17/1965','4/20/2004',4.50,2025000,'HTTT')
insert into GIAOVIEN values('GV03','Do Nghiem Phung','TS','GS','Nu','8/1/1950','9/23/2004',4.00,1800000,'CNPM')
insert into GIAOVIEN values('GV04','Tran Nam Son','TS','PGS','Nam','2/22/1961','1/12/2005',4.50,2025000,'KTMT')
insert into GIAOVIEN values('GV05','Mai Thanh Danh','ThS','GV','Nam','3/12/1958','1/12/2005',3.00,1350000,'HTTT')
insert into GIAOVIEN values('GV06','Tran Doan Hung','TS','GV','Nam','3/11/1953','1/12/2005',4.50,2025000,'KHMT')
insert into GIAOVIEN values('GV07','Nguyen Minh Tien','ThS','GV','Nam','11/23/1971','3/1/2005',4.00,1800000,'KHMT')
insert into GIAOVIEN values('GV08','Le Thi Tran','KS','','Nu','3/26/1974','3/1/2005',1.69,760500,'KHMT')
insert into GIAOVIEN values('GV09','Nguyen To Lan','ThS','GV','Nu','12/31/1966','3/1/2005',4.00,1800000,'HTTT')
insert into GIAOVIEN values('GV10','Le Tran Anh Loan','KS','','Nu','7/17/1972','3/1/2005',1.86,837000,'CNPM')
insert into GIAOVIEN values('GV11','Ho Thanh Tung','CN','GV','Nam','1/12/1980','5/15/2005',2.67,1201500,'MTT')
insert into GIAOVIEN values('GV12','Tran Van Anh','CN','','Nu','3/29/1981','5/15/2005',1.69,760500,'CNPM')
insert into GIAOVIEN values('GV13','Nguyen Linh Dan','CN','','Nu','5/23/1980','5/15/2005',1.69,760500,'KTMT')
insert into GIAOVIEN values('GV14','Truong Minh Chau','ThS','GV','Nu','11/30/1976','5/15/2005',3.00,1350000,'MTT')
insert into GIAOVIEN values('GV15','Le Ha Thanh','ThS','GV','Nam','5/4/1978','5/15/2005',3.00,1350000,'KHMT')
 
-- Nhập dữ liệu cho MONHOC --
insert into MONHOC values('THDC','Tin hoc dai cuong',4,1,'KHMT')
insert into MONHOC values('CTRR','Cau truc roi rac',5,0,'KHMT')
insert into MONHOC values('CSDL','Co so du lieu',3,1,'HTTT')
insert into MONHOC values('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT')
insert into MONHOC values('PTTKTT','Phan tich thiet ke thuat toan',3,0,'KHMT')
insert into MONHOC values('DHMT','Do hoa may tinh',3,1,'KHMT')
insert into MONHOC values('KTMT','Kien truc may tinh',3,0,'KTMT')
insert into MONHOC values('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT')
insert into MONHOC values('PTTKHTTT','Phan tich thiet ke he thong thong tin',4,1,'HTTT')
insert into MONHOC values('HDH','He dieu hanh',4,0,'KTMT')
insert into MONHOC values('NMCNPM','Nhap mon cong nghe phan mem',3,0,'CNPM')
insert into MONHOC values('LTCFW','Lap trinh C for win',3,1,'CNPM')
insert into MONHOC values('LTHDT','Lap trinh huong doi tuong',3,1,'CNPM')

-- Nhập dữ liệu cho LOP --
insert into LOP values('K11','Lop 1 khoa 1','K1108',11,'GV07')
insert into LOP values('K12','Lop 2 khoa 1','K1205',12,'GV09')
insert into LOP values('K13','Lop 3 khoa 1','K1305',12,'GV14')

-- Nhập dữ liệu cho HOCVIEN --
insert into HOCVIEN values('K1101','Nguyen Van','A','1/27/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1102','Tran Ngoc','Han','3/1/1986','Nu','Kien Giang','K11')
insert into HOCVIEN values('K1103','Ha Duy','Lap','4/18/1986','Nam','Nghe An','K11')
insert into HOCVIEN values('K1104','Tran Ngoc','Linh','3/30/1986','Nu','Tay Ninh','K11')
insert into HOCVIEN values('K1105','Tran Minh','Long','2/27/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1106','Le Nhat','Minh','1/24/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1107','Nguyen Nhu','Nhut','1/27/1986','Nam','Ha Noi','K11')
insert into HOCVIEN values('K1108','Nguyen Manh','Tam','2/27/1986','Nam','Kien Giang','K11')
insert into HOCVIEN values('K1109','Phan Thi Thanh','Tam','1/27/1986','Nu','Vinh Long','K11')
insert into HOCVIEN values('K1110','Le Hoai','Thuong','2/5/1986','Nu','Can Tho','K11')
insert into HOCVIEN values('K1111','Le Ha','Vinh','12/25/1986','Nam','Vinh Long','K11')
insert into HOCVIEN values('K1201','Nguyen Van','B','2/11/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1202','Nguyen Thi Kim','Duyen','1/18/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1203','Tran Thi Kim','Duyen','9/17/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1204','Truong My','Hanh','5/19/1986','Nu','Dong Nai','K12')
insert into HOCVIEN values('K1205','Nguyen Thanh','Nam','4/17/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1206','Nguyen Thi Truc','Thanh','3/4/1986','Nu','Kien Giang','K12')
insert into HOCVIEN values('K1207','Tran Thi Bich','Thuy','2/8/1986','Nu','Nghe An','K12')
insert into HOCVIEN values('K1208','Huynh Thi Kim','Trieu','4/8/1986','Nu','Tay Ninh','K12')
insert into HOCVIEN values('K1209','Pham Thanh','Trieu','2/23/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1210','Ngo Thanh','Tuan','2/14/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1211','Do Thi','Xuan','3/9/1986','Nu','Ha Noi','K12')
insert into HOCVIEN values('K1212','Le Thi Phi','Yen','3/12/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1301','Nguyen Thi Kim','Cuc','6/9/1986','Nu','Kien Giang','K13')
insert into HOCVIEN values('K1302','Truong Thi My','Hien','3/18/1986','Nu','Nghe An','K13')
insert into HOCVIEN values('K1303','Le Duc','Hien','3/12/1986','Nam','Tay Ninh','K13')
insert into HOCVIEN values('K1304','Le Quang','Hien','4/18/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1305','Le Thi','Huong','3/27/1986','Nu','TpHCM','K13')
insert into HOCVIEN values('K1306','Nguyen Thai','Huu','3/30/1986','Nam','Ha Noi','K13')
insert into HOCVIEN values('K1307','Tran Minh','Man','5/28/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1308','Nguyen Hieu','Nghia','4/8/1986','Nam','Kien Giang','K13')
insert into HOCVIEN values('K1309','Nguyen Trung','Nghia','1/18/1987','Nam','Nghe An','K13')
insert into HOCVIEN values('K1310','Tran Thi Hong','Tham','4/22/1986','Nu','Tay Ninh','K13')
insert into HOCVIEN values('K1311','Tran Minh','Thuc','4/4/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1312','Nguyen Thi Kim','Yen','9/7/1986','Nu','TpHCM','K13')

-- Nhập dữ liệu cho GIANGDAY --
insert into GIANGDAY values('K11','THDC','GV07',1,2006,'1/2/2006','5/12/2006')
insert into GIANGDAY values('K12','THDC','GV06',1,2006,'1/2/2006','5/12/2006')
insert into GIANGDAY values('K13','THDC','GV15',1,2006,'1/2/2006','5/12/2006')
insert into GIANGDAY values('K11','CTRR','GV02',1,2006,'1/9/2006','5/17/2006')
insert into GIANGDAY values('K12','CTRR','GV02',1,2006,'1/9/2006','5/17/2006')
insert into GIANGDAY values('K13','CTRR','GV08',1,2006,'1/9/2006','5/17/2006')
insert into GIANGDAY values('K11','CSDL','GV05',2,2006,'6/1/2006','7/15/2006')
insert into GIANGDAY values('K12','CSDL','GV09',2,2006,'6/1/2006','7/15/2006')
insert into GIANGDAY values('K13','CTDLGT','GV15',2,2006,'6/1/2006','7/15/2006')
insert into GIANGDAY values('K13','CSDL','GV05',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K13','DHMT','GV07',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K11','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K12','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K11','HDH','GV04',1,2007,'1/2/2007','2/18/2007')
insert into GIANGDAY values('K12','HDH','GV04',1,2007,'1/2/2007','3/20/2007')
insert into GIANGDAY values('K11','DHMT','GV07',1,2007,'2/18/2007','3/20/2007')

-- NHẬP DỮ LIỆU CHO DIEUKIEN --
insert into DIEUKIEN values('CSDL','CTRR')
insert into DIEUKIEN values('CSDL','CTDLGT')
insert into DIEUKIEN values('CTDLGT','THDC')
insert into DIEUKIEN values('PTTKTT','THDC')
insert into DIEUKIEN values('PTTKTT','CTDLGT')
insert into DIEUKIEN values('DHMT','THDC')
insert into DIEUKIEN values('LTHDT','THDC')
insert into DIEUKIEN values('PTTKHTTT','CSDL')

-- Nhập dữ liệu cho KETQUATHI --
insert into KETQUATHI values('K1101','CSDL',1,'7/20/2006',10.00,'Dat')
insert into KETQUATHI values('K1101','CTDLGT',1,'12/28/2006',9.00,'Dat')
insert into KETQUATHI values('K1101','THDC',1,'5/20/2006',9.00,'Dat')
insert into KETQUATHI values('K1101','CTRR',1,'5/13/2006',9.50,'Dat')
insert into KETQUATHI values('K1102','CSDL',1,'7/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1102','CSDL',2,'7/27/2006',4.25,'Khong Dat')
insert into KETQUATHI values('K1102','CSDL',3,'8/10/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1102','CTDLGT',1,'12/28/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1102','CTDLGT',2,'1/5/2007',4.00,'Khong Dat')
insert into KETQUATHI values('K1102','CTDLGT',3,'1/15/2007',6.00,'Dat')
insert into KETQUATHI values('K1102','THDC',1,'5/20/2006',5.00,'Dat')
insert into KETQUATHI values('K1102','CTRR',1,'5/13/2006',7.00,'Dat')
insert into KETQUATHI values('K1103','CSDL',1,'7/20/2006',3.50,'Khong Dat')
insert into KETQUATHI values('K1103','CSDL',2,'7/27/2006',8.25,'Dat')
insert into KETQUATHI values('K1103','CTDLGT',1,'12/28/2006',7.00,'Dat')
insert into KETQUATHI values('K1103','THDC',1,'5/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1103','CTRR',1,'5/13/2006',6.50,'Dat')
insert into KETQUATHI values('K1104','CSDL',1,'7/20/2006',3.75,'Khong Dat')
insert into KETQUATHI values('K1104','CTDLGT',1,'12/28/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1104','THDC',1,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1104','CTRR',1,'5/13/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1104','CTRR',2,'5/20/2006',3.50,'Khong Dat')
insert into KETQUATHI values('K1104','CTRR',3,'6/30/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1201','CSDL',1,'7/20/2006',6.00,'Dat')
insert into KETQUATHI values('K1201','CTDLGT',1,'12/28/2006',5.00,'Dat')
insert into KETQUATHI values('K1201','THDC',1,'5/20/2006',8.50,'Dat')
insert into KETQUATHI values('K1201','CTRR',1,'5/13/2006',9.00,'Dat')
insert into KETQUATHI values('K1202','CSDL',1,'7/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1202','CTDLGT',1,'12/28/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTDLGT',2,'1/5/2007',5.00,'Dat')
insert into KETQUATHI values('K1202','THDC',1,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','THDC',2,'5/27/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTRR',1,'5/13/2006',3.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTRR',2,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTRR',3,'6/30/2006',6.25,'Dat')
insert into KETQUATHI values('K1203','CSDL',1,'7/20/2006',9.25,'Dat')
insert into KETQUATHI values('K1203','CTDLGT',1,'12/28/2006',9.50,'Dat')
insert into KETQUATHI values('K1203','THDC',1,'5/20/2006',10.00,'Dat')
insert into KETQUATHI values('K1203','CTRR',1,'5/13/2006',10.00,'Dat')
insert into KETQUATHI values('K1204','CSDL',1,'7/20/2006',8.50,'Dat')
insert into KETQUATHI values('K1204','CTDLGT',1,'12/28/2006',6.75,'Dat')
insert into KETQUATHI values('K1204','THDC',1,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1204','CTRR',1,'5/13/2006',6.00,'Dat')
insert into KETQUATHI values('K1301','CSDL',1,'12/20/2006',4.25,'Khong Dat')
insert into KETQUATHI values('K1301','CTDLGT',1,'7/25/2006',8.00,'Dat')
insert into KETQUATHI values('K1301','THDC',1,'5/20/2006',7.75,'Dat')
insert into KETQUATHI values('K1301','CTRR',1,'5/13/2006',8.00,'Dat')
insert into KETQUATHI values('K1302','CSDL',1,'12/20/2006',6.75,'Dat')
insert into KETQUATHI values('K1302','CTDLGT',1,'7/25/2006',5.00,'Dat')
insert into KETQUATHI values('K1302','THDC',1,'5/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1302','CTRR',1,'5/13/2006',8.50,'Dat')
insert into KETQUATHI values('K1303','CSDL',1,'12/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1303','CTDLGT',1,'7/25/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1303','CTDLGT',2,'8/7/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1303','CTDLGT',3,'8/15/2006',4.25,'Khong Dat')
insert into KETQUATHI values('K1303','THDC',1,'5/20/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1303','CTRR',1,'5/13/2006',3.25,'Khong Dat')
insert into KETQUATHI values('K1303','CTRR',2,'5/20/2006',5.00,'Dat')
insert into KETQUATHI values('K1304','CSDL',1,'12/20/2006',7.75,'Dat')
insert into KETQUATHI values('K1304','CTDLGT',1,'7/25/2006',9.75,'Dat')
insert into KETQUATHI values('K1304','THDC',1,'5/20/2006',5.50,'Dat')
insert into KETQUATHI values('K1304','CTRR',1,'5/13/2006',5.00,'Dat')
insert into KETQUATHI values('K1305','CSDL',1,'12/20/2006',9.25,'Dat')
insert into KETQUATHI values('K1305','CTDLGT',1,'7/25/2006',10.00,'Dat')
insert into KETQUATHI values('K1305','THDC',1,'5/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1305','CTRR',1,'5/13/2006',10.00,'Dat')

--Phan I 
--Cau 11

alter table HOCVIEN add constraint check_tuoi check (year(getdate()) - year(NGSINH) >=18)

--Cau 12

alter table GIANGDAY add constraint check_ngay check( TUNGAY < DENNGAY)

--Cau 13 

alter table GIAOVIEN add constraint check_giaovien check(year(NGVL) - year(NGSINH) >=22)

--Cau 14

alter table MONHOC add constraint check_tinchi check (abs(TCLT - TCTH) <=5)

--Phan III
--Cau 1

select MAHV, HO,TEN, NGSINH, HOCVIEN.MALOP from HOCVIEN, LOP where HOCVIEN.MAHV=LOP.TRGLOP;

--Cau 2

select HOCVIEN.MAHV, HO, TEN, LANTHI, DIEM from HOCVIEN, KETQUATHI where KETQUATHI.MAHV=HOCVIEN.MAHV and MAMH='CTRR' and MALOP='K12'

--Cau 3

select HOCVIEN.MAHV, HO, TEN, TENMH from KETQUATHI, HOCVIEN, MONHOC where KETQUATHI.MAMH=MONHOC.MAMH and KETQUATHI.MAHV=HOCVIEN.MAHV and LANTHI=1 and KQUA='Dat'

--Cau 4

select HOCVIEN.MAHV, HO, TEN from KETQUATHI, HOCVIEN where  KETQUATHI.MAHV=HOCVIEN.MAHV and LANTHI=1 and KQUA='Khong Dat' and MAMH='CTRR' and MALOP='K11'

--Cau 5

select distinct HV.MAHV, HV.HO, HV.TEN 
from HOCVIEN HV join KETQUATHI KQ on HV.MAHV =KQ.MAHV
where HV.MALOP like 'K%' and KQ.MAMH='CTRR'
except
select distinct HV.MAHV, HV.HO, HV.TEN
from HOCVIEN HV join KETQUATHI KQ on HV.MAHV =KQ.MAHV
where HV.MALOP like 'K%' and KQ.MAMH='CTRR' and KQ.KQUA='Dat'

--Phan II
--Cau 1

update GIAOVIEN set HESO=0.2+HESO where MAGV in (select TRGKHOA from KHOA)

--Cau 2

UPDATE HOCVIEN SET DIEMTB =
(
	SELECT AVG(DIEM)
	FROM KETQUATHI
	WHERE LANTHI = (SELECT MAX(LANTHI) FROM KETQUATHI WHERE HOCVIEN.MAHV = KETQUATHI.MAHV GROUP BY MAHV)
	GROUP BY MAHV
	HAVING MAHV = HOCVIEN.MAHV
)

--Cau 3

update HOCVIEN set GHICHU='Cam thi'
where MAHV in
(
	select MAHV from KETQUATHI where LANTHI = 3 and DIEM <5
)

--Cau 4

update HOCVIEN set XEPLOAI =
(
	case 
		when DIEMTB >=9 then 'XS'
		when DIEMTB <9 and DIEMTB >=8 then 'G'
		when DIEMTB <8 and DIEMTB >=6.5 then 'K'
		when DIEMTB <6.5 and DIEMTB >=5 then 'TB'
		when DIEMTB <5 then 'Y'
	end
)

--Phan III

--Cau 6

select distinct TENMH from MONHOC, GIANGDAY, GIAOVIEN 
where 
MONHOC.MAMH=GIANGDAY.MAMH and 
GIAOVIEN.MAGV=GIANGDAY.MAGV and
GIAOVIEN.HOTEN='Tran Tam Thanh' and 
HOCKY=1 and NAM=2006

--Cau 7

select MONHOC.MAMH, TENMH from LOP, MONHOC, GIANGDAY
where
MONHOC.MAMH=GIANGDAY.MAMH and 
GIANGDAY.MAGV=LOP.MAGVCN and
LOP.MALOP='K11' and
HOCKY=1 and NAM=2006

--Cau 8

select distinct HO+' ' +TEN from LOP, MONHOC, GIANGDAY, GIAOVIEN, HOCVIEN
where
MONHOC.MAMH=GIANGDAY.MAMH and 
LOP.TRGLOP=HOCVIEN.MAHV and
GIANGDAY.MALOP=LOP.MALOP and
GIAOVIEN.MAGV=GIANGDAY.MAGV and
HOTEN='Nguyen To Lan' and
TENMH='Co so du lieu'

--Cau 9

select  MONHOCTRUOC.MAMH, MONHOCTRUOC.TENMH from MONHOC, MONHOC as MONHOCTRUOC, DIEUKIEN
where 
MONHOC.MAMH=DIEUKIEN.MAMH and
MONHOCTRUOC.MAMH=DIEUKIEN.MAMH_TRUOC and
MONHOC.TENMH='Co so du lieu'

--Cau 10

select MONHOC.MAMH, MONHOC.TENMH from MONHOC, MONHOC as MONHOCTRUOC, DIEUKIEN
where 
MONHOC.MAMH=DIEUKIEN.MAMH and
MONHOCTRUOC.MAMH=DIEUKIEN.MAMH_TRUOC and
MONHOCTRUOC.TENMH='Cau truc roi rac'

--Cau 11  

select HOTEN from GIANGDAY, MONHOC, GIAOVIEN
where 

GIANGDAY.MAMH=MONHOC.MAMH and
GIANGDAY.MAGV=GIAOVIEN.MAGV and
MONHOC.MAMH='CTRR' and HOCKY=1 and NAM=2006 and
MALOP='K11' 

intersect 

select HOTEN from GIANGDAY, MONHOC, GIAOVIEN
where 

GIANGDAY.MAMH=MONHOC.MAMH and
GIANGDAY.MAGV=GIAOVIEN.MAGV and
MONHOC.MAMH='CTRR' and HOCKY=1 and NAM=2006 and
MALOP='K12' 

--Cau 12

select HOCVIEN.MAHV, HO+' '+TEN from HOCVIEN , KETQUATHI
where 
HOCVIEN.MAHV=KETQUATHI.MAHV and
MAMH='CSDL' and LANTHI=1 and KQUA='Khong Dat'
and not exists 
(select *from KETQUATHI
where 
HOCVIEN.MAHV=KETQUATHI.MAHV and LANTHI>1)

--Cau 13

select MAGV, HOTEN from GIAOVIEN where MAGV not in (select MAGV from GIANGDAY)

--Cau 14

select MAGV, HOTEN from GIAOVIEN
where not exists
(
select *from MONHOC
where MONHOC.MAKHOA=GIAOVIEN.MAKHOA
and not exists 
(
select *from GIANGDAY
where GIANGDAY.MAMH=MONHOC.MAMH and GIANGDAY.MAGV=GIAOVIEN.MAGV
)
)

--Cau 15

select distinct HO+' ' +TEN from HOCVIEN, KETQUATHI
where
HOCVIEN.MAHV=KETQUATHI.MAHV and
MALOP='K11' and

((LANTHI=2 and DIEM=5 and MAMH='CTRR')

or 

HOCVIEN.MAHV in
(
select distinct MAHV
from KETQUATHI
where KQUA='Khong Dat' 
group by MAHV, MAMH
having count(*) >=3
))

--Cau 16

select HOTEN from GIAOVIEN, GIANGDAY
where 
GIAOVIEN.MAGV=GIANGDAY.MAGV and
MAMH='CTRR'
group by GIAOVIEN.MAGV, HOCKY,HOTEN
having count(*)>=2

--Cau 17

select HO+' '+TEN, DIEM as caonhat from HOCVIEN, KETQUATHI
where 
HOCVIEN.MAHV=KETQUATHI.MAHV and
MAMH='CSDL' and
LANTHI =
(
select max(LANTHI) from KETQUATHI
where
MAMH='CSDL' and KETQUATHI.MAHV=HOCVIEN.MAHV
group by MAHV
)

--Cau 18

SELECT HO+' '+TEN,DIEM FROM HOCVIEN,KETQUATHI,MONHOC
WHERE
HOCVIEN.MAHV=KETQUATHI.MAHV and
KETQUATHI.MAMH=MONHOC.MAMH
AND TENMH = 'Co So Du Lieu'
AND DIEM = 
(
SELECT MAX(DIEM) 
FROM KETQUATHI, MONHOC
WHERE
KETQUATHI.MAMH=MONHOC.MAMH
AND MAHV = HOCVIEN.MAHV
AND TENMH = 'Co So Du Lieu'
GROUP BY MAHV
)

--Cau 19

select MAKHOA, TENKHOA from KHOA where NGTLAP = (select min(NGTLAP) from KHOA)

--Cau 20

select count(HOCHAM) SoLuong from GIAOVIEN where HOCHAM='GS' or HOCHAM='PGS'

--Cau 21

select MAKHOA, HOCVI, count(*) SoLuong from GIAOVIEN group by MAKHOA, HOCVI order by MAKHOA

--Cau 22

select MAMH, KQUA, count(*) SoLuong from KETQUATHI group by MAMH, KQUA order by MAMH

--Cau 23

select GIAOVIEN.MAGV, HOTEN from GIANGDAY, GIAOVIEN, LOP where GIANGDAY.MALOP=LOP.MALOP and GIANGDAY.MAGV=GIAOVIEN.MAGV and GIAOVIEN.MAGV=LOP.MAGVCN

--Cau 24

select HO+' '+TEN HoTen from LOP, HOCVIEN where HOCVIEN.MAHV=LOP.TRGLOP and LOP.SISO = (select max(SISO) from LOP)

--Cau 25

select HO+' '+TEN  HoTen from HOCVIEN, LOP, KETQUATHI where HOCVIEN.MAHV=LOP.TRGLOP and HOCVIEN.MAHV=KETQUATHI.MAHV and KQUA='Khong Dat' group by TRGLOP, HO, TEN having count(*)>=3

--Cau 26

select HOCVIEN.MAHV, HO+' '+TEN HoTen from HOCVIEN, KETQUATHI where HOCVIEN.MAHV=KETQUATHI.MAHV and DIEM >=9 group by HOCVIEN.MAHV, HO, TEN having count(*) >= all(select count(*) from KETQUATHI where DIEM >=9 group by MAHV)

--Cau 27

--Cau 28

select MAGV, count(distinct MAMH) 'So mon hoc' , count(distinct MALOP) 'So lop' from GIANGDAY group by MAGV








