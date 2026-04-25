<p align="center">
  <img src="https://github.com/FacuLL/tuganado/assets/69525757/9172891c-8994-4e8d-b962-a35f19580581" width="200px" />
</p>

# Tu ganado
Aplicación móvil para la administración de tambos. Realizado en la Escuela Agropecuaria de Tres Arroyos como proyecto final de monografía de Damian Girado. Permite agregar y eliminar vacas y registros de ordeñe. Visualizar los datos en tablas y gráficos.

Programas necesarios para el despliegue: [NodeJS](https://nodejs.org/en/download), [Git](https://git-scm.com/downloads), [MySQL](https://dev.mysql.com/downloads/mysql/).

## Backend
Se utilizó NestJS con TypeORM y MySQL como base de datos.

### ¿Cómo desplegar?

1. Instalar MYSQL y configurar el servicio en la máquina. Puede descargarlo desde [aquí](https://dev.mysql.com/downloads/mysql/).

2. Clonar el repositorio y acceder al backend.

```console
  git clone https://github.com/FacuLL/tuganado
  cd backend
```

3. Crear un archivo en ./backend llamado ".env". Ingresar alli la configuración de la base de datos. Utilizar el archivo ".env.example" para guiarse.

4. Instalar dependencias

```console
  npm i -g @nestjs/cli
  npm install
```
   
5. Iniciar servidor

```console
  npm run dev
```

## Frontend
Se utilizó Ionic con AngularJS. Para los gráficos se utilizó chart.js.

### ¿Cómo desplegar?

1. Clonar el repositorio y acceder al frontend.

```console
  git clone https://github.com/FacuLL/tuganado
  cd frontend
```

2. Instalar dependencias

```console
  npm install -g @ionic/cli
  npm install
```
   
3. Iniciar servidor

```console
  ionic serve
```

3. Acceder desde el navegador ingresando a http://localhost:8100

## Galería

<p align="center">
  <img src="https://github.com/FacuLL/tuganado/assets/69525757/caa9fa3d-21ff-44f6-b901-7f8ff62c4f88" height="300px" />
  <img src="https://github.com/FacuLL/tuganado/assets/69525757/05a0d075-8a4c-449f-806e-28f8532bf834" height="300px" />
  <img src="https://github.com/FacuLL/tuganado/assets/69525757/5b2f5b3e-c50a-4677-a196-d6aa0c3b30e7" height="300px" />
  <img src="https://github.com/FacuLL/tuganado/assets/69525757/05816e24-44f8-4739-86c8-58416b1a71d9" height="300px" />
</p>
