--Cài đặt lược đồ quan hệ vào trong hệ quản trị CSDL SQL Server – nhập liệu mỗi bảng ít nhất 5 ---record.
CREATE DATABASE CDMHXanh
ON PRIMARY (
    NAME = CDMHXanh_data,
    FILENAME = 'D:\CDMHXanh_data.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
LOG ON (
    NAME = CDMHXanh_log,
    FILENAME = 'D:\CDMHXanh_log.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB
);
GO

USE CDMHXanh
GO
-- 1. KHOA
CREATE TABLE KHOA (
    MaKhoa CHAR(10) PRIMARY KEY,
    TenKhoa NVARCHAR(50)
);

-- 2. SINH_VIEN
CREATE TABLE SINH_VIEN (
    MaSV CHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(50),
    MaKhoa CHAR(10),
    DuocKhenThuong BIT,
    FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)
);

-- 3. GIAO_VIEN
CREATE TABLE GIAO_VIEN (
    MaGV CHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(50),
    MaKhoa CHAR(10),
    FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)
);

-- 4. DIA_BAN
CREATE TABLE DIA_BAN (
    MaDB CHAR(10) PRIMARY KEY,
    TenDiaBan NVARCHAR(50),
    NamThucHien INT
);

-- 5. XA
CREATE TABLE XA (
    MaXa CHAR(10) PRIMARY KEY,
    TenXa NVARCHAR(50),
    MaDB CHAR(10),
    FOREIGN KEY (MaDB) REFERENCES DIA_BAN(MaDB)
);

-- 6. GIAM_SAT
CREATE TABLE GIAM_SAT (
    MaXa CHAR(10),
    MaGV CHAR(10),
    PRIMARY KEY (MaXa, MaGV),
    FOREIGN KEY (MaXa) REFERENCES XA(MaXa),
    FOREIGN KEY (MaGV) REFERENCES GIAO_VIEN(MaGV)
);

-- 7. AP
CREATE TABLE AP (
    MaAp CHAR(10) PRIMARY KEY,
    TenAp NVARCHAR(50),
    MaXa CHAR(10),
    FOREIGN KEY (MaXa) REFERENCES XA(MaXa)
);

-- 8. NHA_DAN
CREATE TABLE NHA_DAN (
    MaNha CHAR(10) PRIMARY KEY,
    DiaChi NVARCHAR(100),
    MaAp CHAR(10),
    FOREIGN KEY (MaAp) REFERENCES AP(MaAp)
);

-- 9. NHOM
CREATE TABLE NHOM (
    MaNhom CHAR(10) PRIMARY KEY,
    MaNha CHAR(10),
    TruongNhom CHAR(10),
    FOREIGN KEY (MaNha) REFERENCES NHA_DAN(MaNha),
    FOREIGN KEY (TruongNhom) REFERENCES SINH_VIEN(MaSV)
);

-- 10. NHOM_THANHVIEN
CREATE TABLE NHOM_THANHVIEN (
    MaNhom CHAR(10),
    MaSV CHAR(10),
    PRIMARY KEY (MaNhom, MaSV),
    FOREIGN KEY (MaNhom) REFERENCES NHOM(MaNhom),
    FOREIGN KEY (MaSV) REFERENCES SINH_VIEN(MaSV)
);

-- 11. CONG_VIEC
CREATE TABLE CONG_VIEC (
    MaCV CHAR(10) PRIMARY KEY,
    TenCV NVARCHAR(100),
    MaAp CHAR(10),
    Buoi NVARCHAR(10),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    FOREIGN KEY (MaAp) REFERENCES AP(MaAp)
);

-- 12. PHAN_CONG_CONG_VIEC
CREATE TABLE PHAN_CONG_CONG_VIEC (
    MaCV CHAR(10),
    MaNhom CHAR(10),
    MaGV CHAR(10),
    NgayThucHien DATE,
    PRIMARY KEY (MaCV, MaNhom),
    FOREIGN KEY (MaCV) REFERENCES CONG_VIEC(MaCV),
    FOREIGN KEY (MaNhom) REFERENCES NHOM(MaNhom),
    FOREIGN KEY (MaGV) REFERENCES GIAO_VIEN(MaGV)
);

-- 13. KHEN_THUONG
CREATE TABLE KHEN_THUONG (
    MaSV CHAR(10),
    MaDB CHAR(10),
    SoTien MONEY,
    LyDo NVARCHAR(100),
    PRIMARY KEY (MaSV, MaDB),
    FOREIGN KEY (MaSV) REFERENCES SINH_VIEN(MaSV),
    FOREIGN KEY (MaDB) REFERENCES DIA_BAN(MaDB)
);
---Nhập liệu 5 liệu vào mỗi bảng 
1. KHOA
INSERT INTO KHOA VALUES
('K001', N'CNTT'),
('K002', N'Kinh tế'),
('K003', N'Xây dựng'),
('K004', N'Nông nghiệp'),
('K005', N'Y tế');
2. SINH_VIEN
INSERT INTO SINH_VIEN VALUES
('SV001', N'Nguyễn Văn An', 'K001', 1),
('SV002', N'Lê Thị Bình', 'K002', 0),
('SV003', N'Trần Văn Cường', 'K003', 1),
('SV004', N'Phạm Thị Dung', 'K001', 0),
('SV005', N'Võ Văn Nam', 'K004', 1);
 3. GIAO_VIEN
INSERT INTO GIAO_VIEN VALUES
('GV001', N'Thầy Hải', 'K001'),
('GV002', N'Cô Lan', 'K002'),
('GV003', N'Thầy Nam', 'K003'),
('GV004', N'Cô Hằng', 'K004'),
('GV005', N'Thầy Bình', 'K005');
4. DIA_BAN
INSERT INTO DIA_BAN VALUES
('DB001', N'Huyện A', 2023),
('DB002', N'Huyện B', 2024),
('DB003', N'Huyện C', 2023),
('DB004', N'Huyện D', 2025),
('DB005', N'Huyện E', 2022);
5. XA
INSERT INTO XA VALUES
('XA01', N'Xã 1', 'DB001'),
('XA02', N'Xã 2', 'DB002'),
('XA03', N'Xã 3', 'DB003'),
('XA04', N'Xã 4', 'DB004'),
('XA05', N'Xã 5', 'DB005');
6. GIAM_SAT
INSERT INTO GIAM_SAT VALUES
('XA01', 'GV001'),
('XA02', 'GV002'),
('XA03', 'GV003'),
('XA04', 'GV004'),
('XA05', 'GV005');
7. AP
INSERT INTO AP VALUES
('AP01', N'Ấp A', 'XA01'),
('AP02', N'Ấp B', 'XA02'),
('AP03', N'Ấp C', 'XA03'),
('AP04', N'Ấp D', 'XA04'),
('AP05', N'Ấp E', 'XA05');
8. NHA_DAN
INSERT INTO NHA_DAN VALUES
('NHA01', N'Ấp A, Xã 1', 'AP01'),
('NHA02', N'Ấp B, Xã 2', 'AP02'),
('NHA03', N'Ấp C, Xã 3', 'AP03'),
('NHA04', N'Ấp D, Xã 4', 'AP04'),
('NHA05', N'Ấp E, Xã 5', 'AP05');
 9. NHOM
INSERT INTO NHOM VALUES
('N001', 'NHA01', 'SV001'),
('N002', 'NHA02', 'SV002'),
('N003', 'NHA03', 'SV003'),
('N004', 'NHA04', 'SV004'),
('N005', 'NHA05', 'SV005');
10. NHOM_THANHVIEN
INSERT INTO NHOM_THANHVIEN VALUES
('N001', 'SV001'),
('N001', 'SV002'),
('N002', 'SV003'),
('N003', 'SV004'),
('N005', 'SV005');
11. CONG_VIEC
INSERT INTO CONG_VIEC VALUES
('CV001', N'Sơn nhà', 'AP01', N'Sáng', '2024-07-01', '2024-07-02'),
('CV002', N'Vệ sinh môi trường', 'AP02', N'Chiều', '2024-07-03', '2024-07-04'),
('CV003', N'Sửa ống nước', 'AP03', N'Sáng', '2024-07-05', '2024-07-05'),
('CV004', N'Tuyên truyền y tế', 'AP04', N'Chiều', '2024-07-06', '2024-07-06'),
('CV005', N'Tặng quà', 'AP05', N'Sáng', '2024-07-07', '2024-07-07');
12. PHAN_CONG_CONG_VIEC
INSERT INTO PHAN_CONG_CONG_VIEC VALUES
('CV001', 'N001', 'GV001', '2024-07-01'),
('CV002', 'N002', 'GV002', '2024-07-03'),
('CV003', 'N003', 'GV003', '2024-07-05'),
('CV004', 'N004', 'GV004', '2024-07-06'),
('CV005', 'N005', 'GV005', '2024-07-07');
13. KHEN_THUONG
INSERT INTO KHEN_THUONG VALUES
('SV001', 'DB001', 500000, N'Tích cực'),
('SV002', 'DB002', 400000, N'Nỗ lực tốt'),
('SV003', 'DB003', 300000, N'Hỗ trợ nhiệt tình'),
('SV004', 'DB004', 450000, N'Gương mẫu'),
('SV005', 'DB005', 600000, N'Hoàn thành xuất sắc');



1. Truy vấn kết nối nhiều bảng (JOIN)
Câu hỏi: Liệt kê danh sách sinh viên tham gia nhóm tại một xã cụ thể (ví dụ: xã có MaXa = 'XA01'), bao gồm thông tin mã sinh viên, họ tên, tên nhóm, và tên xã.
SELECT SV.MaSV, SV.HoTen, N.MaNhom AS TenNhom, X.TenXa
FROM SINH_VIEN SV
JOIN NHOM_THANHVIEN NTV ON SV.MaSV = NTV.MaSV
JOIN NHOM N ON NTV.MaNhom = N.MaNhom
JOIN NHA_DAN ND ON N.MaNha = ND.MaNha
JOIN AP A ON ND.MaAp = A.MaAp
JOIN XA X ON A.MaXa = X.MaXa
WHERE X.MaXa = 'XA01';
2. Truy vấn kết nối nhiều bảng (JOIN)
Câu hỏi: Hiển thị danh sách công việc do các nhóm có trưởng nhóm thuộc khoa 'CNTT' thực hiện, bao gồm tên công việc, tên ấp, tên nhóm, và tên trưởng nhóm.
SELECT CV.TenCV, A.TenAp, N.MaNhom AS TenNhom, SV.HoTen AS TruongNhom
FROM CONG_VIEC CV
JOIN AP A ON CV.MaAp = A.MaAp
JOIN PHAN_CONG_CONG_VIEC PCCV ON CV.MaCV = PCCV.MaCV
JOIN NHOM N ON PCCV.MaNhom = N.MaNhom
JOIN SINH_VIEN SV ON N.TruongNhom = SV.MaSV
WHERE SV.MaKhoa = 'K001';
3. Truy vấn cập nhật (UPDATE)
Câu hỏi: Cập nhật trạng thái DuocKhenThuong thành 1 cho tất cả sinh viên thuộc khoa 'CNTT' tham gia chiến dịch tại địa bàn 'DB001'.
UPDATE SINH_VIEN 
SET DuocKhenThuong = 1 
WHERE MaSV IN ( 
	SELECT NTV.MaSV 
	FROM NHOM_THANHVIEN NTV 
	JOIN NHOM N ON NTV.MaNhom = N.MaNhom 
	JOIN PHAN_CONG_CONG_VIEC PCCV ON PCCV.MaNhom = N.MaNhom 
	JOIN GIAO_VIEN GV ON PCCV.MaGV = GV.MaGV 
	JOIN CONG_VIEC CV ON PCCV.MaCV = CV.MaCV 
	JOIN AP ON CV.MaAp = AP.MaAp 
	JOIN SINH_VIEN SV2 ON SV2.MaSV = NTV.MaSV 
	WHERE GV.MaKhoa = 'K001' AND AP.TenAp LIKE N'Ấp A%' AND NTV.MaSV <> N.TruongNhom AND SV2.MaKhoa = 'K004' );
4. Truy vấn cập nhật (UPDATE)
Câu hỏi: Cập nhật ngày kết thúc của công việc 'CV001' thành '2024-07-03' nếu công việc này thuộc ấp 'AP01'.
UPDATE CONG_VIEC
SET NgayKetThuc = '2024-07-03'
WHERE MaCV = 'CV001' AND MaAp = 'AP01';
5. Truy vấn xóa (DELETE)
Câu hỏi: Xóa các bản ghi phân công công việc cho nhóm 'N001' trong ngày '2024-07-01'.
DELETE FROM PHAN_CONG_CONG_VIEC
WHERE MaNhom = 'N001' AND NgayThucHien = '2024-07-01';
6. Truy vấn xóa (DELETE)
Câu hỏi: Xóa tất cả thông tin khen thưởng của sinh viên thuộc địa bàn 'DB002'.
DELETE FROM KHEN_THUONG
WHERE MaDB = 'DB002';
7. Truy vấn GROUP BY
Câu hỏi: Thống kê số lượng công việc được phân công cho mỗi nhóm thuộc các khoa trong năm 2023, bao gồm tên khoa, tên nhóm, và số công việc, chỉ hiển thị các nhóm có ít nhất 2 công việc, sắp xếp theo số công việc giảm dần.
SELECT K.TenKhoa, N.MaNhom AS TenNhom, COUNT(PCCV.MaCV) AS SoLuongCongViec
FROM KHOA K
JOIN SINH_VIEN SV ON K.MaKhoa = SV.MaKhoa
JOIN NHOM N ON SV.MaSV = N.TruongNhom
JOIN PHAN_CONG_CONG_VIEC PCCV ON N.MaNhom = PCCV.MaNhom
JOIN CONG_VIEC CV ON PCCV.MaCV = CV.MaCV
JOIN AP A ON CV.MaAp = A.MaAp
JOIN XA X ON A.MaXa = X.MaXa
JOIN DIA_BAN DB ON X.MaDB = DB.MaDB
WHERE DB.NamThucHien = 2023
GROUP BY K.TenKhoa, N.MaNhom
HAVING COUNT(PCCV.MaCV) >= 2
ORDER BY SoLuongCongViec DESC;
8. Truy vấn GROUP BY
Câu hỏi: Tính tổng số tiền khen thưởng và số lượng sinh viên được khen thưởng cho mỗi loại công việc trong năm 2023, chỉ hiển thị các loại công việc có tổng số tiền khen thưởng trên 500000, sắp xếp theo tổng số tiền giảm dần.
SELECT CV.TenCV, COUNT(DISTINCT KT.MaSV) AS SoSinhVienKhenThuong, SUM(KT.SoTien) AS TongSoTien
FROM CONG_VIEC CV
JOIN PHAN_CONG_CONG_VIEC PCCV ON CV.MaCV = PCCV.MaCV
JOIN NHOM N ON PCCV.MaNhom = N.MaNhom
JOIN NHOM_THANHVIEN NTV ON N.MaNhom = NTV.MaNhom
JOIN KHEN_THUONG KT ON NTV.MaSV = KT.MaSV
JOIN DIA_BAN DB ON KT.MaDB = DB.MaDB
WHERE DB.NamThucHien = 2023
GROUP BY CV.TenCV
HAVING SUM(KT.SoTien) > 500000
ORDER BY TongSoTien DESC;
9. Truy vấn con (SUBQUERY)
Câu hỏi: Liệt kê thông tin sinh viên (mã, họ tên) thuộc các nhóm đã thực hiện ít nhất 1 công việc tại địa bàn 'DB001' trong năm 2023.
SELECT SV.MaSV, SV.HoTen
FROM SINH_VIEN SV
WHERE SV.MaSV IN (
    SELECT NTV.MaSV
    FROM NHOM_THANHVIEN NTV
    JOIN PHAN_CONG_CONG_VIEC PCCV ON NTV.MaNhom = PCCV.MaNhom
    JOIN CONG_VIEC CV ON PCCV.MaCV = CV.MaCV
    JOIN AP A ON CV.MaAp = A.MaAp
    JOIN XA X ON A.MaXa = X.MaXa
    JOIN DIA_BAN DB ON X.MaDB = DB.MaDB
    WHERE DB.MaDB = 'DB001' AND DB.NamThucHien = 2023
    GROUP BY NTV.MaNhom, NTV.MaSV
    HAVING COUNT(PCCV.MaCV) >= 1
);
10. Truy vấn con (SUBQUERY)
Câu hỏi: Tìm các công việc được thực hiện bởi các nhóm có ít nhất 3 thành viên thuộc khoa 'CNTT'.
SELECT CV.MaCV, CV.TenCV, A.TenAp
FROM CONG_VIEC CV
JOIN AP A ON CV.MaAp = A.MaAp
JOIN PHAN_CONG_CONG_VIEC PCCV ON CV.MaCV = PCCV.MaCV
WHERE PCCV.MaNhom IN (
    SELECT NTV.MaNhom
    FROM NHOM_THANHVIEN NTV
    JOIN SINH_VIEN SV ON NTV.MaSV = SV.MaSV
    WHERE SV.MaKhoa = 'K001'
    GROUP BY NTV.MaNhom
    HAVING COUNT(NTV.MaSV) >= 3
);
11. Truy vấn bất kỳ
Câu hỏi: Tìm các nhóm đã thực hiện ít nhất 3 công việc kéo dài hơn 1 ngày (tức là công việc có ngày bắt đầu và ngày kết thúc khác nhau), hiển thị mã nhóm, tên nhóm, họ tên trưởng nhóm, sắp xếp theo số công việc giảm dần.
SELECT N.MaNhom, N.MaNhom AS TenNhom, SV.HoTen AS TruongNhom, 
       COUNT(DISTINCT PCCV.MaCV) AS SoCongViecKeoDai
FROM NHOM N
JOIN SINH_VIEN SV ON N.TruongNhom = SV.MaSV
JOIN PHAN_CONG_CONG_VIEC PCCV ON N.MaNhom = PCCV.MaNhom
JOIN CONG_VIEC CV ON PCCV.MaCV = CV.MaCV
WHERE DATEDIFF(day, CV.NgayBatDau, CV.NgayKetThuc) > 1
GROUP BY N.MaNhom, SV.HoTen
HAVING COUNT(DISTINCT PCCV.MaCV) >= 3
ORDER BY SoCongViecKeoDai DESC;
12. Truy vấn bất kỳ
Câu hỏi: Liệt kê các giáo viên giám sát xã có tổng số công việc được phân công ít nhất 1 trong năm 2023 tại địa bàn 'DB002'.
SELECT GV.MaGV, GV.HoTen, COUNT(PCCV.MaCV) AS SoCongViec
FROM GIAO_VIEN GV
JOIN PHAN_CONG_CONG_VIEC PCCV ON GV.MaGV = PCCV.MaGV
JOIN CONG_VIEC CV ON PCCV.MaCV = CV.MaCV
JOIN AP A ON CV.MaAp = A.MaAp
JOIN XA X ON A.MaXa = X.MaXa
JOIN DIA_BAN DB ON X.MaDB = DB.MaDB
WHERE DB.MaDB = 'DB002' AND DB.NamThucHien = 2023
GROUP BY GV.MaGV, GV.HoTen
HAVING COUNT(PCCV.MaCV) >= 1
ORDER BY SoCongViec DESC;

--Câu hỏi cá nhân 
Phạm Vũ Như Quỳnh
Câu 1: Liệt kê tên sinh viên, tên khoa mà sinh viên đó thuộc về và trạng thái khen thưởng (Có/Không).
SELECT SV.HoTen, K.TenKhoa, 
	CASE WHEN SV.DuocKhenThuong = 1 THEN N'Có' 
ELSE N'Không' END AS TrangThaiKhenThuong 
FROM SINH_VIEN SV 
JOIN KHOA K ON SV.MaKhoa = K.MaKhoa;
Câu 2: Danh sách giáo viên giám sát trên từng xã, kèm tên địa bàn và năm thực hiện.
SELECT GV.HoTen AS GiaoVien, XA.TenXa, DB.TenDiaBan, DB.NamThucHien 
FROM GIAM_SAT GS 
JOIN GIAO_VIEN GV ON GS.MaGV = GV.MaGV 
JOIN XA ON GS.MaXa = XA.MaXa 
JOIN DIA_BAN DB ON XA.MaDB = DB.MaDB;
Câu 3: Liệt kê nhóm và tổng số thành viên của từng nhóm. Sql
SELECT N.MaNhom, COUNT(NTV.MaSV) AS SoLuongThanhVien 
FROM NHOM N 
LEFT JOIN NHOM_THANHVIEN NTV ON N.MaNhom = NTV.MaNhom G
ROUP BY N.MaNhom;
Câu 4: Liệt kê công việc diễn ra trong tháng 7/2024.
SELECT TenCV, NgayBatDau, NgayKetThuc 
FROM CONG_VIEC 
WHERE MONTH(NgayBatDau) = 7 AND YEAR(NgayBatDau) = 2024;
Câu 5: Liệt kê tên sinh viên có tham gia nhóm và tên trưởng nhóm của nhóm đó.
SELECT SV.HoTen AS ThanhVien, SVTruong.HoTen AS TruongNhom 
FROM NHOM_THANHVIEN NTV 
JOIN SINH_VIEN SV ON NTV.MaSV = SV.MaSV 
JOIN NHOM N ON NTV.MaNhom = N.MaNhom 
JOIN SINH_VIEN SVTruong ON N.TruongNhom = SVTruong.MaSV;
Huỳnh Văn Thiên 
Câu 1: Tìm các sinh viên thuộc nhóm đã tham gia công việc 'Sơn nhà'.
SELECT DISTINCT SV.HoTen
FROM CONG_VIEC CV
JOIN PHAN_CONG_CONG_VIEC PC ON CV.MaCV = PC.MaCV
JOIN NHOM_THANHVIEN NT ON PC.MaNhom = NT.MaNhom
JOIN SINH_VIEN SV ON SV.MaSV = NT.MaSV
WHERE CV.TenCV = N'Sơn nhà';
Câu 2:  Liệt kê sinh viên là trưởng nhóm nhưng không có tên trong bảng thành viên nhóm.
SELECT SV.HoTen
FROM NHOM N
JOIN SINH_VIEN SV ON N.TruongNhom = SV.MaSV
WHERE NOT EXISTS (
    SELECT 1 
    FROM NHOM_THANHVIEN NT 
    WHERE NT.MaSV = SV.MaSV
);
Câu 3: Tìm các nhóm có trưởng nhóm là sinh viên được khen thưởng và có ít nhất 3 thành viên trong nhóm.
SELECT N.MaNhom, N.TruongNhom
FROM NHOM N
JOIN SINH_VIEN SV ON N.TruongNhom = SV.MaSV
JOIN KHEN_THUONG KT ON KT.MaSV = SV.MaSV
JOIN NHOM_THANHVIEN NT ON N.MaNhom = NT.MaNhom
GROUP BY N.MaNhom, N.TruongNhom
HAVING COUNT(NT.MaSV) >= 3 AND COUNT(KT.MaSV) > 0;
Câu 4: Tìm giáo viên giám sát các xã tại địa bàn có tên chứa chữ "A".
SELECT g.HoTen, x.TenXa, d.TenDiaBan
FROM GIAO_VIEN g
JOIN GIAM_SAT gs ON g.MaGV = gs.MaGV
JOIN XA x ON gs.MaXa = x.MaXa
JOIN DIA_BAN d ON x.MaDB = d.MaDB
WHERE d.TenDiaBan LIKE N'%A%';
Câu 5: Tìm những công việc có số lượng sinh viên tham gia vượt quá 5 người trong một ngày và có ít nhất 2 giáo viên giám sát.
SELECT CV.TenCV, PC.NgayThucHien, COUNT(DISTINCT NT.MaSV) AS SoSinhVien, COUNT(DISTINCT PC.MaGV) AS SoGiaoVien
FROM CONG_VIEC CV
JOIN PHAN_CONG_CONG_VIEC PC ON CV.MaCV = PC.MaCV
JOIN NHOM_THANHVIEN NT ON NT.MaNhom = PC.MaNhom
JOIN SINH_VIEN SV ON NT.MaSV = SV.MaSV
WHERE PC.NgayThucHien = '2024-07-01'
GROUP BY CV.TenCV, PC.NgayThucHien
HAVING COUNT(DISTINCT NT.MaSV) > 5 AND COUNT(DISTINCT PC.MaGV) >= 2;
Nguyễn Thị Thùy Trang 
Câu 1: Liệt kê các công việc và nhóm tham gia các công việc đó trong từng ngày thực hiện.
SELECT cv.TenCV, n.MaNhom, pc.NgayThucHien
FROM CONG_VIEC cv
JOIN PHAN_CONG_CONG_VIEC pc ON cv.MaCV = pc.MaCV
JOIN NHOM n ON pc.MaNhom = n.MaNhom
ORDER BY cv.TenCV, pc.NgayThucHien;
Câu 2: Liệt kê các giáo viên đã giám sát các xã có tổng số sinh viên tham gia từ 10 trở lên trong năm 2024.
SELECT GV.HoTen, X.TenXa, COUNT(DISTINCT SV.MaSV) AS SoSinhVien
FROM GIAM_SAT GS
JOIN GIAO_VIEN GV ON GS.MaGV = GV.MaGV
JOIN XA X ON GS.MaXa = X.MaXa
JOIN DIA_BAN DB ON X.MaDB = DB.MaDB  JOIN SINH_VIEN SV ON X.MaXa = SV.MaKhoa
WHERE DB.NamThucHien = 2024  
GROUP BY GV.HoTen, X.TenXa
HAVING COUNT(DISTINCT SV.MaSV) >= 10;
Câu 3: Hiển thị tên các xã có hơn 1 công việc được thực hiện trong đó.
SELECT X.TenXa, COUNT(CV.MaCV) AS SoCongViec
FROM CONG_VIEC CV
JOIN AP A ON CV.MaAp = A.MaAp
JOIN XA X ON A.MaXa = X.MaXa
GROUP BY X.TenXa
HAVING COUNT(CV.MaCV) > 1;
Câu 4: Tìm các công việc được phân công cho các nhóm từ "Ấp A" đến "Ấp D".
SELECT cv.TenCV, a.TenAp
FROM CONG_VIEC cv
JOIN PHAN_CONG_CONG_VIEC pc ON cv.MaCV = pc.MaCV
JOIN NHOM n ON pc.MaNhom = n.MaNhom
JOIN NHA_DAN nd ON n.MaNha = nd.MaNha
JOIN AP a ON nd.MaAp = a.MaAp
WHERE a.TenAp IN (N'Ấp A', N'Ấp B', N'Ấp C', N'Ấp D');
Câu 5: Tìm các ấp có ít nhất 3 sinh viên tham gia trong các nhóm khác nhau và có công việc được phân công vào buổi sáng.
SELECT AP.TenAp, COUNT(DISTINCT NT.MaSV) AS SoSinhVien
FROM AP
JOIN XA X ON AP.MaXa = X.MaXa
JOIN NHOM N ON N.MaNha = AP.MaAp
JOIN NHOM_THANHVIEN NT ON N.MaNhom = NT.MaNhom
JOIN PHAN_CONG_CONG_VIEC PC ON N.MaNhom = PC.MaNhom
JOIN CONG_VIEC CV ON PC.MaCV = CV.MaCV
WHERE CV.Buoi = N'Sáng'
GROUP BY AP.TenAp
HAVING COUNT(DISTINCT NT.MaSV) >= 3;
Nguyễn Thị Trương Hiền
Câu 1: Danh sách ấp có ít nhất một công việc được phân công.
SELECT DISTINCT A.TenAp 
FROM CONG_VIEC CV 
JOIN PHAN_CONG_CONG_VIEC PCCV ON CV.MaCV = PCCV.MaCV 
JOIN AP A ON CV.MaAp = A.MaAp;
Câu 2: Tổng số tiền khen thưởng theo từng địa bàn.
SELECT DB.TenDiaBan, SUM(KT.SoTien) AS TongTienThuong 
FROM KHEN_THUONG KT 
JOIN DIA_BAN DB ON KT.MaDB = DB.MaDB 
GROUP BY DB.TenDiaBan;
Câu 3: Liệt kê giáo viên có phân công công việc vào buổi sáng.
SELECT DISTINCT GV.HoTen 
FROM PHAN_CONG_CONG_VIEC PCCV 
JOIN CONG_VIEC CV ON PCCV.MaCV = CV.MaCV 
JOIN GIAO_VIEN GV ON PCCV.MaGV = GV.MaGV 
WHERE CV.Buoi = N'Sáng';
Câu 4: Danh sách sinh viên chưa được khen thưởng.
SELECT HoTen 
FROM SINH_VIEN 
WHERE DuocKhenThuong = 0;
Câu 5: Công việc nào có số ngày thực hiện dài nhất.
SELECT TOP 1 TenCV, DATEDIFF(DAY, NgayBatDau, NgayKetThuc) AS SoNgay 
FROM CONG_VIEC 
ORDER BY SoNgay DESC;
Nguyễn Trần Ái Minh 
Câu 1: Liệt kê nhóm không có thành viên (chỉ trưởng nhóm).
SELECT N.MaNhom 
FROM NHOM N LEFT 
JOIN NHOM_THANHVIEN NTV ON N.MaNhom = NTV.MaNhom 
GROUP BY N.MaNhom 
HAVING COUNT(NTV.MaSV) = 0;
Câu 2: Danh sách xã có giáo viên giám sát thuộc khoa CNTT.
SELECT DISTINCT XA.TenXa 
FROM GIAM_SAT GS 
JOIN GIAO_VIEN GV ON GS.MaGV = GV.MaGV 
JOIN XA ON GS.MaXa = XA.MaXa 
WHERE GV.MaKhoa = 'K001';
Câu 3: Liệt kê địa bàn có ít nhất 2 công việc thuộc buổi sáng.
SELECT DB.TenDiaBan 
FROM CONG_VIEC CV 
JOIN AP A ON CV.MaAp = A.MaAp 
JOIN XA ON A.MaXa = XA.MaXa 
JOIN DIA_BAN DB ON XA.MaDB = DB.MaDB 
WHERE CV.Buoi = N'Sáng' 
GROUP BY DB.TenDiaBan 
HAVING COUNT(*) >= 2;
Câu 4: Liệt kê tên sinh viên, tên nhóm, tổng số công việc nhóm đó đã thực hiện.
SELECT SV.HoTen, N.MaNhom, COUNT(DISTINCT PCCV.MaCV) AS SoCongViec 
FROM NHOM_THANHVIEN NTV 
JOIN SINH_VIEN SV ON NTV.MaSV = SV.MaSV 
JOIN NHOM N ON NTV.MaNhom = N.MaNhom 
LEFT JOIN PHAN_CONG_CONG_VIEC PCCV ON N.MaNhom = PCCV.MaNhom 
GROUP BY SV.HoTen, N.MaNhom;
Câu 5: Liệt kê danh sách sinh viên chưa tham gia nhóm nào nhưng vẫn được khen thưởng.
SELECT SV.HoTen 
FROM SINH_VIEN SV 
LEFT JOIN NHOM_THANHVIEN NTV ON SV.MaSV = NTV.MaSV 
JOIN KHEN_THUONG KT ON SV.MaSV = KT.MaSV 
WHERE NTV.MaSV IS NULL;

