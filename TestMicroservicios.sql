create database PruebaTest;
use PruebaTest;

create table Usuarios (
	iduser int identity (1,1) not null, 
	nombre varchar (50) not null,
	direccion varchar(100) not null,
	telefono numeric(10) not null,
	contraseña varbinary(8000) not null,
	estado bit not null,
	primary key (iduser));

create table tipoCuentas (
idtipo int identity (1, 1) not null,
nombreTipo varchar (20) not null,
primary key (idtipo)
);

create table CuentaUsuario (
	idcuenta int identity (1, 1) not null,
	numeroCuenta numeric (6) not null,
	tipo int not null,
	saldoInicial float not null,
	estado bit not null,
	cliente int not null,
	foreign key (cliente) REFERENCES usuarios (iduser),
	foreign key (tipo) REFERENCES tipoCuentas (idtipo));

create procedure RevisarCuentaUsuarioSP 
@numcuenta numeric(20)
as
begin
select Usuarios.nombre, CuentaUsuario.cliente, tipoCuentas.nombreTipo, CuentaUsuario.saldoInicial
from Usuarios inner join CuentaUsuario on Usuarios.iduser = CuentaUsuario.cliente
inner join tipoCuentas on CuentaUsuario.tipo = tipoCuentas.idtipo
where CuentaUsuario.numeroCuenta = @numcuenta
end

create procedure RevisarEstadoCuentaSP
as
@numcuenta numeric(20),
@fechaInicio date
@fechaFin date
as
begin
select Usuarios.nombre, CuentaUsuario.cliente, tipoCuentas.nombreTipo, CuentaUsuario.saldoInicial
from Usuarios inner join CuentaUsuario on Usuarios.iduser = CuentaUsuario.cliente
inner join tipoCuentas on CuentaUsuario.tipo = tipoCuentas.idtipo
where CuentaUsuario.numeroCuenta = @numcuenta
end


insert into usuarios values ('Jose Lema', 'Otavalo sn y principal', 098254785, ENCRYPTBYPASSPHRASE('password', '1234'), 1);
insert into usuarios values ('Marianela Montalvo', 'Amazonas y NNUU', 097548965, ENCRYPTBYPASSPHRASE('password', '5678'), 1);
insert into usuarios values ('Juan Osorio', '13 junio y Equinoccial', 098874587, ENCRYPTBYPASSPHRASE('password', '1245'), 1);

insert into tipoCuentas Values ('Ahorro');
insert into tipoCuentas Values ('Corriente');

insert into CuentaUsuario values (478758, 1, 2000, 1, 1)
insert into CuentaUsuario values (225487, 2, 100, 1, 2)
insert into CuentaUsuario values (495878, 1, 0, 1, 3)
insert into CuentaUsuario values (496825, 1, 540, 1, 2)


select * from usuarios
select * from tipoCuentas
select * from CuentaUsuario
drop table usuarios