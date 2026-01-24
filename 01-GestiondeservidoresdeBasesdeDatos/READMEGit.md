# Manual de Instalación y Configuración de Git

## Introducción

Este repositorio contiene un manual básico que describe los pasos necesarios para descargar, instalar y configurar Git, así como el proceso para crear una cuenta en GitHub. El documento tiene como objetivo servir como guía introductoria para estudiantes que comienzan a trabajar con sistemas de control de versiones.

---

## ¿Qué es Git?

Git es un sistema de control de versiones distribuido que permite registrar y administrar los cambios realizados en archivos y proyectos. Es ampliamente utilizado en el desarrollo de software, ya que facilita el trabajo colaborativo, el control de versiones y la recuperación de información.

---

## Requisitos previos

Antes de iniciar con la instalación, se recomienda contar con:

- Computadora con sistema operativo Windows, macOS o Linux  
- Conexión a internet  
- Navegador web actualizado  

---

## Descarga de Git

1. Abrir un navegador web.  
2. Acceder al sitio oficial de Git: https://git-scm.com  
3. Hacer clic en el botón **Download**.  
4. Esperar a que se descargue automáticamente el instalador correspondiente al sistema operativo.

## Descarga de Git 
![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20085911.png "This is a sample image.")
---

## Instalación de Git en Windows

1. Abrir el archivo descargado.  
2. Aceptar los términos de la licencia.  
3. Seleccionar la carpeta de instalación (se recomienda dejar la predeterminada).  
4. Mantener las opciones de instalación por defecto.  
5. Seleccionar un editor de texto (por ejemplo, Visual Studio Code).  
6. Permitir el uso de Git desde la línea de comandos.  
7. Finalizar la instalación.

## Figuras 2 Instalación de Git  
![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20090448.png) 

---

## Verificación de la instalación

1. Abrir Git Bash.  
2. Ejecutar el siguiente comando:

```bash
git --version
```
## Figura 3 Verificaion de Instalación de Git  

![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20092452.png)  

## Configuración inicial de Git

Para identificar los cambios realizados por el usuario dentro de los proyectos, es necesario configurar el nombre de usuario y el correo electrónico. Esta configuración se establece de forma global mediante los siguientes comandos ejecutados en Git Bash:

```
git config --global user.name "Nombre del usuario"
git config --global user.email "correo@ejemplo.com"
```
## Establece como editor predeterminado a git 
visual studio code

```
git config --global core.editor “code  -- wait”
```
## Creación de una cuenta en GitHub

GitHub es una plataforma que permite alojar repositorios Git y colaborar en proyectos de desarrollo de software.

## Pasos para crear la cuenta:

* Acceder a https://github.com

* Hacer clic en Sign up.

* Registrar correo electrónico, nombre de usuario y contraseña.

* Completar el proceso de verificación solicitado.

* Confirmar el correo electrónico.

## Figura 4 Crear cuenta de Git  

![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20093359.png) 


## Conexión de Git con GitHub

Para poder enviar y administrar proyectos locales en GitHub, es necesario vincular Git con la cuenta de GitHub del usuario. A continuación, se describen los pasos básicos para realizar esta conexión de manera correcta.

---

### Creación de un repositorio en GitHub

1. Ingresar a https://github.com e iniciar sesión.
2. Hacer clic en el botón **New repository**.
3. Asignar un nombre al repositorio.
4. Seleccionar la opción de repositorio **público** o **privado** según se requiera.
5. No inicializar el repositorio con README, ya que el proyecto ya existe de forma local.
6. Hacer clic en **Create repository**.

## Figura 4 Cuenta ya creada  

![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20093822.png) 

---

### Enlace del repositorio local con GitHub

1. Abrir Git Bash en la carpeta del proyecto.
2. Ejecutar el siguiente comando para establecer la conexión con el repositorio remoto:

```bash
git remote add origin https://github.com/usuario/nombre-repositorio.git
```
Verificar que el repositorio remoto se haya agregado correctamente con el comando:

```
git remote -v
```
## Video de clase [INSTALACION Y CUENTA GIT](https://www.canva.com/design/DAG_KfbFLrg/D-UN_ZoWU6WcSgD_JSmpKA/edit?utm_content=DAG_KfbFLrg&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton).
## Conclusión

Git es una herramienta fundamental en el desarrollo de software moderno. Mediante este manual se describieron los pasos básicos para su descarga, instalación y configuración, así como la creación de una cuenta en GitHub. Con ello, el usuario queda preparado para comenzar a trabajar con repositorios y control de versiones.

## Tabla de comandos

## Primeros comandos de Git

| Comando | Descripción |
|--------|-------------|
| `git --version` | Muestra la versión instalada de Git. |
| `git help` | Muestra la ayuda general de Git. |
| `git help commit` | Muestra la ayuda específica del comando `commit`. |
| `git config --global user.name "usuario"` | Configura de forma global el nombre de usuario. |
| `git config --global user.email "correo"` | Establece de forma global el correo electrónico del usuario. |
| `git config --global core.editor "code --wait"` | Establece Visual Studio Code como editor predeterminado de Git. |
| `git config --global -e` | Muestra y permite editar todas las configuraciones globales de Git. |

---

## Primer repositorio

| Comando | Descripción |
|--------|-------------|
| `git init` | Inicializa un repositorio Git en el proyecto. |
| `ls -a` | Muestra los archivos ocultos, incluyendo la carpeta `.git`. |
| `git status` | Muestra el estado del repositorio, los commits y la rama activa. |
| `git add .` | Agrega todos los archivos al área de preparación (stage). |
| `git reset nombre_archivo` | Retira un archivo del área de preparación. |
| `git commit -m "Nombre del commit"` | Crea un commit con un mensaje descriptivo. |
| `git config --global core.autocrlf true` | Estandariza los saltos de línea en sistemas Windows. |
| `git checkout -- .` | Restaura los archivos al estado del último commit. |

---

## Cambiar nombre de la rama master a main

| Comando | Descripción |
|--------|-------------|
| `git branch` | Muestra la rama en la que se está trabajando. |
| `git branch -m master main` | Cambia el nombre de la rama `master` a `main`. |
| `git config --global init.defaultBranch main` | Establece `main` como rama predeterminada de forma global. |
| `git commit -am "Texto"` | Agrega al stage y realiza el commit en un solo paso (solo archivos ya rastreados). |
| `git log` | Muestra el historial de commits del repositorio. |
