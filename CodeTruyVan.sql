SELECT * from NHANVIEN WHERE PHG=5 and PHAI=N'Nam'
SELECT MANV,HOVN AS HO,TENLOT AS 'TEN LOT',TENNV as TEN from NHANVIEN where PHG=5 and PHAI=N'Nam'

select DISTINCT LUONG FROM NHANVIEN 

SELECT MANV,HOVN,TENLOT,TENNV FROM NHANVIEN,PHONGBAN WHERE TENPHG=N'Nghiên cứu' and PHG=MAPHG

select manv,tennv,luong from NHANVIEN where LUONG between 20000 and 30000

select manv,TENLOT+ tennv as 'ten day du' from NHANVIEN where  'ten day du' like N'%N%'

select MADA,PHONG,TRPHG,NGSINH,DCHI from DEAN,PHONGBAN,NHANVIEN 
select TENNV,MADA,PHONG,TRPHG,NGSINH,DCHI from DEAN,PHONGBAN,NHANVIEN where DDIEM_DA='HA NOI' and PHONG=MAPHG and TRPHG=MANV

select HOVN,TENLOT,TENNV,MANV,TENDA,THOIGIAN,PHANCONG.MADA from DEAN,PHANCONG,NHANVIEN where TENDA=N'Sản Phẩm X' and THOIGIAN>10 and MANV=MA_NVIEN


select MADA from PHANCONG, NHANVIEN where MA_NVIEN=MANV and HOVN=N'Nguyễn' union select MADA from PHANCONG,NHANVIEN,PHONGBAN
where HOVN=N'Nguyễn' and MANV=TRPHG and TRPHG=MA_NVIEN

select NV.MANV,NV.TENNV from NHANVIEN NV
where NV.PHG=(
			select PB.MAPHG
			from PHONGBAN PB
			where PB.TENPHG=N'Nghiên cứu'
			)

--
select MANV, TENNV from NHANVIEN where PHG IN
(
	select MAPHG from DIADIEM_PHG where DIADIEM='TP HCM'
)
SELECT MANV, TENNV 
FROM NHANVIEN, DIADIEM_PHG
WHERE DIADIEM='TP HCM' AND PHG=MAPHG
--

SELECT * 
FROM NHANVIEN
WHERE MANV IN (SELECT MA_NVIEN FROM THANNHAN)
AND MANV IN (SELECT TRPHG FROM PHONGBAN)


select MANV,TENNV
from NHANVIEN
where exists (
	(
	select *
	from PHONGBAN 
	where TENPHG=N'Nghiên cứu' and MAPHG=PHG
	)


--Phép kết(join)

select TENDA,TENPHG,TENNV,NG_NHANCHUC from (DEAN join PHONGBAN on dean.PHONG=phongban.MAPHG) 
			join NHANVIEN on TRPHG=MANV
where DDIEM_DA='HA NOI'

/*Cho biết các mã đề án có
- Nhân viên với họ là ‘Nguyen’ tham gia hoặc,
- Trưởng phòng chủ trì đề án đó với họ là ‘Nguyen’*/

select MADA from NHANVIEN,PHANCONG where HOVN=N'Nguyễn' and MANV=MA_NVIEN
union 
select MADA from PHONGBAN,DEAN,NHANVIEN where HOVN=N'Nguyễn' and MANV=TRPHG and MAPHG=phong
 

/*Tìm nhân viên có người thân cùng tên và cùng giới
tính*/
select*from NHANVIEN,THANNHAN where  MANV=MA_NVIEN and NHANVIEN.PHAI=THANNHAN.PHAI and TENNV=TENTN 

select MANV,TENNV from nhanvien,PHONGBAN where PHG in(
													select MAPHG from DIADIEM_PHG where DIADIEM=N'TPHCM'
													)
--Tìm những nhân viên không có thân nhân nào
select *from NHANVIEN where MANV not in( 
									   select MA_NVIEN from THANNHAN 
									   )				
/*Tìm những nhân viên có lương lớn hơn lương của
ít nhất một nhân viên phòng 4*/
--cach1
select* from NHANVIEN where LUONG > any(
									select LUONG from NHANVIEN where PHG=4 ) 

--cach2
select *from NHANVIEN nv1 where exists(
								select *from NHANVIEN nv2 where nv1.luong>nv2.luong and nv2.PHG=4)

select max(luong) as LươngMax from NHANVIEN
select count(*) manv   from nhanvien
--Cho biết số lượng nhân viên của từng phòng ban
SELECT PHG, COUNT(*) AS SL_NV
FROM NHANVIEN
GROUP BY PHG

--Với mỗi nhân viên cho biết mã số, họ tên, số lượng
--đề án và tổng thời gian mà họ tham gia
select MANV,TENNV, count(*)DEAN , sum(thoigian) as Thoigianthamgia 
from nhanvien,phancong where MANV=MA_NVIEN group by MANV,TENNV
--Cho biết những nhân viên tham gia từ 2 đề án trở len
SELECT MA_NVIEN
FROM PHANCONG
GROUP BY MA_NVIEN
HAVING COUNT(*) >= 2
/*Cho biết những phòng ban (TENPHG) có lương
trung bình của các nhân viên lớn lơn 20000*/
select TENPHG,AVG(Luong) as LuongTB from PHONGBAN,NHANVIEN where MAPHG=PHG group by TENPHG HAVING AVG(LUONG)>30000
--Tìm 3 nhân viên có lương cao nhất

SELECT TENNV
FROM NHANVIEN NV1
WHERE 2 >= (
SELECT COUNT(*)
FROM NHANVIEN NV2
WHERE NV2.LUONG>NV1.LUONG )

--Tìm tên các nhân viên được phân công làm tất cả các đồ án
select HOVN,TENNV from nhanvien,phancong
where MANV=MA_NVIEN
group by HOVN,TENNV
HAVING COUNT(*)=(
                select count(*) from DEAN)
						
--Tìm mã và tên các nhân viên làm việc tại phòng 'Nghien cuu'
select manv,tennv,TENPHG from nhanvien inner join phongban on nhanvien.phg=phongban.maphg where TENPHG=N'Nghiên cứu'

/*Cho biết họ tên nhân viên và tên phòng ban mà họ
là trưởng phòng nếu có*/
select HOVN,tennv,TENPHG from nhanvien left join phongban on nhanvien.phg=PHONGBAN.MAPHG and TRPHG=MANV
/*Tìm họ tên các nhân viên và tên các đề án nhân
viên tham gia nếu có*/

SELECT nv.hovn, nv.tennv, da.tenda
FROM nhanvien nv
JOIN PHANCONG pc ON nv.MANV = pc.MA_NVIEN
LEFT JOIN DEAN da ON pc.mada = da.MADA;


--insert
insert into PHONGBAN values(N'English Falcuty', 9, '007', '2002-12-12')
insert into PHONGBAN values(N'Quản Lý', 1, '006', '19/06/1971')

--Tìm các nhân viên làm việc ở phòng số 4
select *from nhanvien where phg=4
--Tìm các nhân viên có mức lương trên 30000
select *from nhanvien where luong>30000
/*Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên có mức lương
trên 30,000 ở phòng 5*/
select *from nhanvien where (luong>25000 and phg=4) or (luong>30000 and phg=5) 
--Cho biết họ tên đầy đủ của các nhân viên ở TP HCM
select hovn+tenlot+tennv as HOVATEN, DCHI from NHANVIEN where DCHI like '%TPHCM%'
--Cho biết ngày sinh và địa chỉ của nhân viên Dinh Ba Tien
select NGSINH,DCHI from nhanvien where HOVN=N'Đinh' and TENLOT=N'Bá' and TENNV=N'Tiến'


                              --Truy vấn có sử dụng phép kết--
--10. Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng
select TENPHG,DIADIEM from phongban  join DIADIEM_PHG on phongban.MAPHG=DIADIEM_PHG.MAPHG
--11. Tìm tên những người trưởng phòng của từng phòng ban
select TENNV,TENPHG from phongban join nhanvien on phongban.TRPHG=nhanvien.MANV
--12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghiên cứu".
 --+cach1
select TENNV,DCHI,TENPHG from phongban join nhanvien on phongban.MAPHG=nhanvien.PHG where TENPHG=N'nghiên cứu'
 --+cach2
select TENNV,DCHI,TENPHG from nhanvien join (select MAPHG,TENPHG from PHONGBAN where TENPHG=N'nghiên cứu') as T on T.MAPHG=NHANVIEN.PHG 
/*13. Với mỗi đề án ở Hà Nội, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của
trưởng phòng của phòng ban chủ trì đề án đó.*/
select TENDA,TENPHG,HOVN+''+TENNV as HoTen ,NG_NHANCHUC from
						 DEAN da join PHONGBAN pb on da.PHONG=pb.MAPHG 
						join NHANVIEN on pb.TRPHG=NHANVIEN.MANV where DA.DDIEM_DA=N'Ha Noi'

--Tìm tên những nữ nhân viên và tên người thân của họ
select nv.tennv,nv.PHAI from nhanvien nv join THANNHAN nt on nv.MANV=nt.MA_NVIEN where nv.PHAI=N'Nữ'
--Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý trực tiếp của nhân viên đó
select nv1.HOVN+' '+nv1.TENNV as' Họ tên NV',nv2.HOVN+' '+nv2.TENNV as' Họ tên NQL' from NHANVIEN nv1 join NHANVIEN nv2 
on nv1.MA_NQL=nv2.MANV
/*17. Tên những nhân viên phòng số 5 có tham gia vào đề án "San pham Y" và nhân viên này do
"Nguyen Thanh Tung" quản lý trực tiếp*/

select nv1.*,TENDA,nv2.HOVN+' '+nv2.TENLOT+' '+nv2.TENNV as 'Họ và tên NQL' from nhanvien nv1 join DEAN da on nv1.PHG=da.PHONG
						 join nhanvien nv2 on nv1.MA_NQL=nv2.MANV
						 where nv1.PHG=5 and da.TENDA=N'Sản Phẩm Y' and nv2.HOVN+' '+nv2.TENLOT+' '+nv2.TENNV=N'Nguyễn Thanh Tùng'
--Cho biết tên các đề án mà nhân viên Đinh Bá Tiến đã tham gia
SELECT nv.HOVN+' '+nv.TENLOT+' '+nv.TENNV AS 'HO VA TEN',TENDA FROM NHANVIEN NV JOIN DEAN DA ON NV.PHG=DA.PHONG
WHERE nv.HOVN+' '+nv.TENLOT+' '+nv.TENNV=N'Đinh Bá Tiến'

--19. Cho biết số lượng đề án của công ty
select count(*)mada from dean 
--20. Cho biết số lượng đề án do phòng ‘Nghiên Cứu’ chủ trì
select TENPHG,count(*)mada from phongban pb join dean da on pb.MAPHG=da.PHONG 
where pb.TENPHG=N'Nghiên Cứu'
group by TENPHG
--21. Cho biết lương trung bình của các nữ nhân viên
select avg(luong) from nhanvien where PHAI=N'Nữ' 
--25. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
select tennv,MANV,count(*)TENTN from THANNHAN tn join NHANVIEN nv on nv.MANV=tn.MA_NVIEN
group by tennv,MANV
--26. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia
select nv.HOVN+' '+nv.TENLOT+' '+nv.TENNV AS hoten, count(*)MADA from nhanvien nv join DEAN da on nv.PHG=da.PHONG 
group by nv.HOVN+' '+nv.TENLOT+' '+nv.TENNV
--29. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
select TENPHG,count(*)MANV from nhanvien nv join phongban pb on nv.PHG=pb.MAPHG 
group by TENPHG
HAVING avg(luong)>30000
--31. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì
select TENPHG,nv.HOVN+' '+nv.TENLOT+' '+nv.TENNV as'TRUONG PHONG',count(*)MADA from phongban pb join dean da on pb.MAPHG=da.PHONG
join nhanvien nv on nv.MANV=pb.TRPHG
GROUP BY TENPHG,nv.HOVN+' '+nv.TENLOT+' '+nv.TENNV
/*37. Cho biết danh sách các đề án (MADA) có: nhân công với họ (HONV) là ‘Dinh’ hoặc , có
người trưởng phòng chủ trì đề án với họ (HONV) là ‘Dinh’ */
select MADA from dean where PHONG=(
							select PHG from NHANVIEN nv where nv.HOVN=N'Đinh'
							union select pb.MAPHG from PHONGBAN pb join nhanvien nv1 on nv1.MANV=pb.TRPHG where nv1.HOVN=N'Đinh'   
											)
--38. Danh sách những nhân viên (HONV, TENLOT, TENNV) có trên 2 thân nhân
select hovn,TENLOT,TENNV,count(*)TENTN from NHANVIEN nv join THANNHAN TN ON NV.MANV=TN.MA_NVIEN
GROUP BY hovn,TENLOT,TENNV
having count(TENTN) > 2
--39. Danh sách những nhân viên (HONV, TENLOT, TENNV) không có thân nhân nào.
select hovn, tenlot,tennv, manv from nhanvien where manv not in (select MA_NVIEN  from thannhan ) 
--Danh sách những trưởng phòng (HONV, TENLOT, TENNV) có tối thiểu một thân nhân
select hovn,tenlot,tennv,manv from NHANVIEN nv where exists (select *from THANNHAN where manv=MA_NVIEN)
--Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu"
select hovn,tenlot,tennv,manv,luong from NHANVIEN nv where nv.LUONG>(
															  select avg(luong)from phongban pb join NHANVIEN nv2 on
															  nv2.PHG=pb.MAPHG where pb.TENPHG=N'Nghiên cứu')
--43. Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất.

--Cách 1:
select TENPHG,HOVN,TENLOT,TENNV from nhanvien join PHONGBAN on nhanvien.MANV=PHONGBAN.TRPHG where PHONGBAN.TENPHG in (
select pb.TENPHG from NHANVIEN nv join PHONGBAN pb on nv.PHG=pb.MAPHG 
group by pb.TENPHG
having count(nv.MANV) =(
			SELECT TOP 1 
                COUNT(MANV) AS SLNV
            FROM 
                NHANVIEN
            GROUP BY 
                PHG
            ORDER BY 
                COUNT(MANV) DESC)
)
--Cách 2
with MaxSLNV as(
	select top 1 phongban.MAPHG,count(nhanvien.MANV) as SLNV from NHANVIEN  join PHONGBAN  on PHG=MAPHG
	group by MAPHG
	ORDER BY COUNT (NHANVIEN.PHG) DESC
)
select TENPHG,HOVN,TENLOT,TENNV from nhanvien join PHONGBAN on nhanvien.MANV=PHONGBAN.TRPHG where PHONGBAN.TENPHG in (
select pb.TENPHG from NHANVIEN nv join PHONGBAN pb on nv.PHG=pb.MAPHG 
group by pb.TENPHG
having count(nv.MANV) =(
select MaxSLNV.SLNV from MaxSLNV  )
)
------------------
SELECT MANV FROM NHANVIEN
EXCEPT
SELECT MA_NVIEN AS MANV FROM THANNHAN
-------------------

SELECT MA_NVIEN
FROM PHANCONG
GROUP BY MA_NVIEN
------------
------------ Cho biết những phòng ban (TENPHG) có lương trung bình của các nhân viên lớn lơn 40000-----------
select nv.* from phongban pb join NHANVIEN nv on pb.MAPHG=nv.PHG where nv.LUONG>40000 
/*42. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung
bình của phòng "Nghiên cứu"*/
select nv.HOVN,nv.TENLOT,nv.TENNV,LUONG from NHANVIEN nv where nv.LUONG>(
select avg(luong) from phongban pb join NHANVIEN nv on pb.TENPHG=N'Nghiên cứu')
--44. Cho biết danh sách các mã đề án mà nhân viên có mã là 009 chưa làm.
select mada from DEAN da where da.MADA not in
						(select PHANCONG.MADA from nhanvien join PHANCONG on NHANVIEN.MANV=PHANCONG.MA_NVIEN
						where NHANVIEN.MANV=009)
/*
46. Tìm họ tên (HONV, TENLOT, TENNV) và địa chỉ (DCHI) của những nhân viên làm việc
cho một đề án ở ‘TP HCM’ nhưng phòng ban mà họ trực thuộc lại không tọa lạc ở thành phố
‘TP HCM’
*/
select HOVN,TENLOT,TENNV,DCHI,PHG from nhanvien nv where nv.PHG in(
select nv.PHG from DEAN da join NHANVIEN nv on da.PHONG=nv.PHG where da.DDIEM_DA=N'TP HCM')
and nv.PHG not in (select PHG from  DIADIEM_PHG dd join (PHONGBAN pb join NHANVIEN nv on nv.PHG=pb.MAPHG) on dd.MAPHG=pb.MAPHG 
where dd.DIADIEM=N'TPHCM')


--48. Danh sách những nhân viên (HONV, TENLOT, TENNV) làm việc trong mọi đề án của công ty
select HOVN,TENLOT,TENNV from NHANVIEN nv where nv.MANV in(
	select MA_NVIEN from PHANCONG pc 
	group by MA_NVIEN
	having count(*) =( 
	select count(*) from DEAN)
)

--50. Tìm những nhân viên (HONV, TENLOT, TENNV) được phân công tất cả đề án mà nhân viên ‘Đinh Bá Tiến’ làm việc
	
select distinct nv.HOVN,nv.TENLOT,nv.TENNV,nv.MANV from nhanvien nv join phancong pc on nv.MANV=pc.MA_NVIEN where not exists(
	(select MADA from PHANCONG pc join nhanvien nv on nv.MANV=pc.MA_NVIEN
	where nv.HOVN=N'Đinh' and nv.TENLOT=N'Bá' and nv.TENNV=N'Tiến') 
	except
	(select pc1.MADA from NHANVIEN nv1 join PHANCONG pc1 on nv1.MANV=pc1.MA_NVIEN where nv.HOVN=nv1.HOVN
																		and nv.TENLOT=nv1.TENLOT and nv.TENNV=nv1.TENNV)
	)
--52. Cho biết danh sách nhân viên tham gia vào tất cả các đề án ở TP HCM
select nv.* from nhanvien nv join PHANCONG pc on nv.MANV=pc.MA_NVIEN where not exists 
(
	(select da.MADA from dean da where da.DDIEM_DA=N'TP HCM')
	 except
	(select pc1.MADA from nhanvien nv1 join PHANCONG pc1 on nv1.MANV=pc1.MA_NVIEN where 
	 nv.MANV=nv1.MANV)
)



--select Hoten from GIANGVIEN
--WHERE  MaGiangVien=(
--					select MaGiangVien
--					from MUON_TRA mt join THIETBI tb on tb.MaThietBi=mt.MaThietBi
--					where tb.MaThietBi=N'Đèn Chiếu' and mt.GiangDuong=N'Giảng Đường H')
/*
a>
select Hoten from GIANGVIEN
WHERE  MaGiangVien=(
					select MaGiangVien
					from MUON_TRA mt join THIETBI tb on tb.MaThietBi=mt.MaThietBi
					where tb.TenTien Chiếu' and mt.GiangDuong=N'Giảng Đường H')
				  
b>
select MT.MaGiangVien
from MUON_TRA MT
where MT.MaGiangVien=(
	select GV.MaGiangVien
	from GiangVien GV join KHOA K on GV.makhoa=k.makhoa
	where K.tenkhoa=N'Công nghệ Thông tin' and mathietbi='Micro_01'
)
intersect
select MT.MaGiangVien
from MUON_TRA MT
where MT.MaGiangVien=(
	select GV.MaGiangVien
	from GiangVien GV join KHOA K on GV.makhoa=k.makhoa
	where K.tenkhoa=N'Công nghệ Thông tin' and mathietbi='Remote_05'
)

c>
select MT.MaThietBi
from GIANGVIEN GV join KHOA K on GV.makhoa=k.makhoa join MUON_TRA mt on GV.MaGiangVien=MT.MaGiangVien
where MT.TinhTrangTra=N'Hỏng' and K.TenKhoa=N'Điện

d>
(select MT.mathietbi from MUON_TRA MT)
except
(select MT.mathietbi from MUON_TRA MT where MT.NgayMuon='07-10-2022')

e>
select GV.HoTen
from GiangVien GV join MUON_TRA MT
	 on GV.MaGiangVien=MT.MaGiangVien
where MT.NgayMuon='05-12-2022'
	  and MT.mathietbi=(select MaThietBi from THIETBI where TenThietBi='Micro')
	  and MT.TinhTrang=N'Hỏng'
	  and GV.MaGiangVien=(select MaGiangVien from GIANGVIENGV GV join KHOA K
						  on K.makhoa=GV.makhoa where K.tenkhoa=N'Điện')
f>
delete from THIETBI where TinhTrang=N'Hỏng'

g>
select tenkhoa
from giangvien gv join khoa k on k.makhoa=gv.makhoa
group by tenkhoa
having count(magiangvien) in (
						  select count(magiangvien)
						  from giangvien gv join KHOA K on K.MaKhoa=GV.MAKhoa
						  group by K.MaKhoa
						  ORDER BY count(MaGiangVien) DESC
						  )
						D
*/
--53. Cho biết phòng ban chủ trì tất cả các đề án ở TP HCM
select *from PHONGBAN pb
where 
not exists
(
	select*from dean da
	where da.DDIEM_DA=N'TP HCM'
	and
	not exists(
			   select*from dean as da2
			   where da2.MADA=da.MADA
			   and  da2.PHONG=pb.MAPHG )
)




