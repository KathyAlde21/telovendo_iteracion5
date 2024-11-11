-- Te lo vendo - Iteracion 5 - Kathy Alderete

-- Parte 1: Crear entorno de trabajo
-- 	A)Crear una base de datos //
CREATE DATABASE telovendo_iteracion5;

-- 	B) Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada. //
-- usuario: telovendo
-- imagen en carpeta

-- // -----------------------------------------------------------------------------------------------
-- Parte 2: Crear dos tablas.
-- C) La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido, contraseña, zona
	-- horaria (por defecto UTC-3), género y teléfono de contacto).
    
CREATE TABLE usuarios(
	id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(40) NOT NULL,
    apellido_usuario VARCHAR(40) NOT NULL,
    contrasena VARCHAR(30) NOT NULL,
    zona_horaria VARCHAR(6) DEFAULT '-03:00',
    genero VARCHAR(20),
    telefono VARCHAR(20) NOT NULL,
    UNIQUE(id_usuario)
);
    
-- D) La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a la
	-- plataforma (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la fecha-hora actual))
CREATE TABLE usuarios_date(
	id_ingreso INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha_hora_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP(),
    fk_id_usuario INT,
    UNIQUE(id_ingreso, fk_id_usuario)
);
  
-- // -----------------------------------------------------------------------------------------------
-- Parte 3: Modificación de la tabla
-- E) Modifique el UTC por defecto.Desde UTC-3 a UTC-2.
ALTER TABLE usuarios
MODIFY COLUMN zona_horaria VARCHAR(6) DEFAULT '-02:00';

-- // -----------------------------------------------------------------------------------------------
-- Parte 4: Creación de registros.
-- F) Para cada tabla crea 8 registros.

INSERT INTO usuarios (nombre_usuario, apellido_usuario, contrasena, zona_horaria, genero, telefono)
VALUES ('Marcelo', 'Torres', 'pass123', '-02:00', 'Masculino', 1122334455), -- 1
  ('Lucía', 'Ramírez', 'pass456', '-02:00', 'Femenino', 2233445566), -- 2
  ('Javier', 'Sánchez', 'pass789', '-02:00', 'Masculino', 3344556677), -- 3
  ('Elena', 'Díaz', 'pass321', '-02:00', 'Femenino', 4455667788), -- 4
  ('Fernando', 'Morales', 'pass654', '-02:00', 'Masculino', 5566778899), -- 5
  ('Isabel', 'Vega', 'pass987', '-02:00', 'Femenino', 6677889900), -- 6
  ('Andrés', 'Castro', 'pass159', '-02:00', 'Masculino', 7788990011), -- 7
  ('Natalia', 'Rojas', 'pass753', '-02:00', 'Femenino', 8899001122); -- 8

INSERT INTO  usuarios_date (fk_id_usuario)
VALUES (1),
  (2),
  (3),
  (4),
  (5),
  (6),
  (7),
  (8);

-- // -----------------------------------------------------------------------------------------------
-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?

-- id_usuario y id_ingreso => ambas son primary key tipo numero y aunque no son nulas por defecto, 
							-- prefiero incluirlo en el texto igual
-- nombre_usuario y apellido_usuario => ambos son varchar porque deberian ser letras pero al final nunca se
									-- sabe, estan con not null para obligar a registrar los datos minimos de cada usuario
-- contrasena => puede ser alfanumerica e incluir simbolos, pero ademas debe ser de ingreso obligatorio y por
			-- eso not null
-- zona_horaria => dado que incluye numero y simbolo la mejor opcion es varchar y con tope de 6 ya que no
				-- tendra mas caracteres que eso
-- genero => dado que no todas las personas quieren informarlo quedo como dato opcional
-- telefono => aunque en este caso ingrese numeros, es posible que por ej se use un +56 y para evitar
			-- conflictos la mejor opcion es un varchar
-- fecha_hora_ingreso => utilice la forma de ingresar fecha y hora de forma automatica
-- fk_id_usuario => utilice int porque debe ser igual que el id que estoy llamando


-- // -----------------------------------------------------------------------------------------------
-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo
-- electronico)
CREATE TABLE contactos(
	id_contacto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_id_usuario INT,
    numero_telefono VARCHAR(20) NOT NULL,
    correo_electronico VARCHAR(45) NOT NULL
    );

-- // -----------------------------------------------------------------------------------------------
-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
-- tabla Contactos.

ALTER TABLE usuarios
RENAME COLUMN telefono TO id_telefono; -- ok

ALTER TABLE usuarios
ADD CONSTRAINT UNIQUE (id_telefono); -- ok

ALTER TABLE contactos
RENAME COLUMN numero_telefono TO fk_numero_telefono; -- ok

-- // ---
ALTER TABLE contactos
ADD CONSTRAINT fk_numero_telefono
FOREIGN KEY (fk_numero_telefono) REFERENCES usuarios(id_telefono); -- ok

