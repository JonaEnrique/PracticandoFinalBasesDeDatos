CREATE DATABASE ej1GUIA

CREATE TABLE Almacen(
	Nro int NOT NULL PRIMARY KEY,
	Responsable varchar(100)
)

CREATE TABLE Articulo(
	CodArt int NOT NULL PRIMARY KEY,
	Descripcion varchar(100),
	Precio float
)

CREATE TABLE Material(
	CodMat int NOT NULL PRIMARY KEY,
	Descripcion varchar(100)
)

CREATE TABLE Proveedor(
	CodProv int NOT NULL PRIMARY KEY,
	Nombre varchar(20),
	Domicilio varchar(15),
	Ciudad varchar(15)
)

CREATE TABLE Tiene(
	Nro_almacen int NOT NULL,
	CodArt_articulo int NOT NULL,
	CONSTRAINT PKTIENE PRIMARY KEY(Nro_almacen, CodArt_articulo),
	CONSTRAINT FKALMACEN FOREIGN KEY(Nro_almacen) REFERENCES Almacen(Nro),
	CONSTRAINT FKARTICULO FOREIGN KEY(CodArt_articulo) REFERENCES Articulo(CodArt)
)

CREATE TABLE CompuestoPor(
	CodArt_articulo int NOT NULL,
	CodMat_material int NOT NULL,
	CONSTRAINT PKCOMPUESTOPOR PRIMARY KEY(CodArt_articulo, CodMat_material),
	CONSTRAINT FKARTICULO_CompPor FOREIGN KEY(CodArt_articulo) REFERENCES Articulo(CodArt),
	CONSTRAINT FKMATERIAL FOREIGN KEY(CodMat_material) REFERENCES Material(CodMat)
)

CREATE TABLE ProvistoPor(
	CodMat_material int NOT NULL,
	CodProv_proveedor int NOT NULL,
	CONSTRAINT PKPROVISTOPOR PRIMARY KEY(CodMat_material, CodProv_proveedor),
	CONSTRAINT FKMATERIAL_ProvPor FOREIGN KEY(CodMat_material) REFERENCES Material(CodMat),
	CONSTRAINT FKPROVEEDOR FOREIGN KEY(CodProv_proveedor) REFERENCES Proveedor(CodProv)
)

INSERT INTO Almacen (Nro, Responsable) VALUES
(1, 'Martín Gómez'),
(2, 'Carlos López'),
(3, 'Ana Pérez'),
(4, 'Laura Ramírez');

INSERT INTO Articulo (CodArt, Descripcion, Precio) VALUES
(101, 'Artículo A', 50.0),
(102, 'Artículo B', 120.0),
(103, 'Artículo C', 200.0),
(104, 'Artículo D', 15.0),
(105, 'Artículo E', 8.0);

INSERT INTO Material (CodMat, Descripcion) VALUES
(201, 'Material M1'),
(202, 'Material M2'),
(203, 'Material M3'),
(204, 'Material M4'),
(205, 'Material M5');

INSERT INTO Proveedor (CodProv, Nombre, Domicilio, Ciudad) VALUES
(301, 'Juan Pérez', 'Calle 1', 'La Plata'),
(302, 'Ana López', 'Calle 2', 'Pergamino'),
(303, 'Carlos Sánchez', 'Calle 3', 'Rosario'),
(304, 'María Díaz', 'Calle 4', 'Capital Federal'),
(305, 'Pedro Gómez', 'Calle 5', 'Capital Federal');


INSERT INTO Tiene (Nro_almacen, CodArt_articulo) VALUES
(1, 101),
(1, 102),
(2, 101),
(2, 104),
(3, 102),
(3, 103),
(4, 104),
(4, 105);


INSERT INTO CompuestoPor (CodArt_articulo, CodMat_material) VALUES
(101, 201),
(102, 202),
(102, 203),
(103, 201),
(103, 204),
(104, 205);

INSERT INTO ProvistoPor (CodMat_material, CodProv_proveedor) VALUES
(201, 301),
(201, 302),
(202, 302),
(203, 303),
(204, 304),
(205, 305);

DELETE ProvistoPor

--1
SELECT Nombre
FROM Proveedor
WHERE Ciudad = 'La Plata'

--2
SELECT CodArt
FROM Articulo
WHERE Precio < 10

--3
SELECT Responsable
FROM Almacen

--4
SELECT CodMat_material
FROM ProvistoPor PP
WHERE CodProv_proveedor = 301 AND
		NOT EXISTS(SELECT CodMat_material
				   FROM ProvistoPor
				   WHERE CodProv_proveedor = 302 AND PP.CodMat_material = CodMat_material)

SELECT CodMat_material
FROM ProvistoPor PP
WHERE CodProv_proveedor = 301 AND 
		CodMat_material NOT IN(SELECT CodMat_material
							   FROM ProvistoPor
							   WHERE CodProv_proveedor = 302)

--5
SELECT Nro_almacen
FROM Tiene T INNER JOIN Articulo Art ON T.CodArt_articulo = Art.CodArt
WHERE Art.Descripcion = 'Artículo A'

--6
