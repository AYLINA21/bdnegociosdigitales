# Terminos para los que vienen de sql 

Mongo es una base de datos no sql no usa tablas si no archivos jeison, tambien se le conoce como base de datos de documentos 

sql | MongoDb
Base de datos | Base de datos
tabla | colecciones
fila | documento
columnas | campos 
joins | integrados en documentos 

------Tabla en sql----
columna -----> | id | nombre | edad 
fila -----> | 1 | chapulin | 30

{
"id" : 1 ,
"nombre": "chapulin"        ---------> esto es un documento 
"edad": 30
}

{
    "id" : 2
    "nombre" : "Alino Jordan"              --------> esto es otro documento
}
