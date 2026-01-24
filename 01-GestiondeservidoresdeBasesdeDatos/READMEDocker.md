# Guía de Instalación de Docker

## Introducción

El presente documento describe los pasos necesarios para descargar e instalar Docker, una plataforma que permite crear, ejecutar y administrar aplicaciones dentro de contenedores. Docker es ampliamente utilizado en el desarrollo de software y en la administración de entornos de bases de datos y servidores.

---

## ¿Qué es Docker?

Docker es una plataforma de contenedores que permite empaquetar aplicaciones junto con sus dependencias, garantizando que se ejecuten de la misma manera en distintos entornos. Facilita el despliegue, la portabilidad y la escalabilidad de aplicaciones.

---

## Descarga de Docker

1. Abrir un navegador web.
2. Acceder al sitio oficial de Docker:
   https://www.docker.com/products/docker-desktop
3. Hacer clic en el botón **Download Docker Desktop**.
4. Seleccionar la versión correspondiente al sistema operativo.
5. Esperar a que el instalador se descargue correctamente.

## Descarga de Docker
![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20105030.png)

## Instalación de Docker Desktop

1. Abrir el archivo descargado del instalador de Docker Desktop.
2. Aceptar los términos y condiciones del software.
3. Seleccionar las opciones de instalación recomendadas.
4. Hacer clic en **Install** para iniciar el proceso.
5. Esperar a que la instalación finalice.
6. Reiniciar el equipo si el sistema lo solicita.

## Inicio de Docker

1. Abrir Docker Desktop desde el menú Inicio.
2. Esperar a que Docker se inicialice correctamente.
3. Verificar que el icono de Docker se muestre activo en la barra de tareas.

## Verificación de la instalación

Para comprobar que Docker se instaló correctamente:

1. Abrir la terminal o PowerShell.
2. Ejecutar el siguiente comando:

```bash
docker --version
```

## Creación de un contenedor en Docker

Una vez instalado Docker, es posible crear y ejecutar contenedores a partir de imágenes disponibles en Docker Hub. A continuación, se describen los pasos básicos para crear un contenedor utilizando Docker.

---

## Verificación del estado de Docker

Antes de crear un contenedor, es necesario verificar que Docker se encuentre en ejecución.

1. Abrir la terminal o PowerShell.
2. Ejecutar el siguiente comando:

```bash
docker info
```
## Descarga de una imagen desde Docker Hub

Docker utiliza imágenes como base para crear contenedores. Para descargar una imagen oficial, se ejecuta el siguiente comando:
```
docker pull nombre_imagen
```
Este comando descarga la imagen seleccionada desde Docker Hub.
## Creación y ejecución de un contenedor

Para crear y ejecutar un contenedor a partir de una imagen, se utiliza el siguiente comando:

```
docker run nombre_imagen
```
Este comando crea un contenedor y lo ejecuta de manera inmediata.

## Creación y ejecución de un contenedor

Para crear y ejecutar un contenedor a partir de una imagen, se utiliza el siguiente comando:

```
docker run nombre_imagen
```
Este comando crea un contenedor y lo ejecuta de manera inmediata.

## Ejecución de un contenedor en segundo plano

Para ejecutar un contenedor en segundo plano (modo desacoplado), se utiliza el parámetro -d:
```
docker run -d nombre_imagen
```
## Asignación de nombre al contenedor

Para facilitar la identificación del contenedor, se puede asignar un nombre:
```
docker run --name nombre_contenedor nombre_imagen
```
## Visualización de contenedores

Para listar los contenedores en ejecución:

```
docker ps
```
Para listar todos los contenedores (activos e inactivos):

```
docker ps -a
```
## Detención de un contenedor

Para detener un contenedor en ejecución:
```
docker stop nombre_contenedor
```
## Eliminación de un contenedor

Para eliminar un contenedor:
```
docker rm nombre_contenedor
```

## Docker con contenedores
![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20110757.png)

## Video de clase [INSTALACION Docker](https://www.canva.com/design/DAG_KE55rzA/Jgilg2LCDyr0Ij6CkRdFxg/edit?utm_content=DAG_KE55rzA&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton).

## Conclusión

Docker es una herramienta fundamental para la creación y gestión de entornos de desarrollo basados en contenedores. Mediante esta guía se describieron los pasos necesarios para su descarga, instalación y verificación, permitiendo al usuario comenzar a trabajar con Docker de manera adecuada.

## Tabla de comandos básicos de Docker

| Comando | Descripción |
|--------|-------------|
| `docker --version` | Muestra la versión instalada de Docker. |
| `docker info` | Muestra información general sobre el estado de Docker. |
| `docker pull nombre_imagen` | Descarga una imagen desde Docker Hub. |
| `docker images` | Lista las imágenes disponibles en el sistema. |
| `docker run nombre_imagen` | Crea y ejecuta un contenedor a partir de una imagen. |
| `docker run -d nombre_imagen` | Ejecuta un contenedor en segundo plano. |
| `docker run --name nombre_contenedor nombre_imagen` | Crea un contenedor asignándole un nombre. |
| `docker ps` | Muestra los contenedores en ejecución. |
| `docker ps -a` | Muestra todos los contenedores, activos e inactivos. |
| `docker stop nombre_contenedor` | Detiene un contenedor en ejecución. |
| `docker start nombre_contenedor` | Inicia un contenedor detenido. |
| `docker restart nombre_contenedor` | Reinicia un contenedor. |
| `docker rm nombre_contenedor` | Elimina un contenedor. |
| `docker rmi nombre_imagen` | Elimina una imagen. |

