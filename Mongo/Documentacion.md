# 💖 Reporte: MongoDB ✨

## ✨ Introducción

MongoDB es un sistema de base de datos NoSQL orientado a documentos. A diferencia de las bases de datos relacionales (SQL), no utiliza tablas, sino colecciones y documentos, lo que permite trabajar con datos de forma más flexible 🌸.

En este reporte se presentan los conceptos básicos, comandos principales, inserción de datos, consultas y actualización de documentos en MongoDB 💖. También se muestra su uso práctico mediante ejemplos claros.

---

## ✨ Acceso a MongoDB desde Docker

### 💻 Sintaxis
```bash
docker exec -it <id_contenedor> mongosh -u <usuario> -p <password> --authenticationDatabase admin
```

### 🌸 Ejemplo
```bash
docker exec -it 1b44 mongosh -u admin -p admin123 --authenticationDatabase admin
```

---

# 💖 Conceptos básicos

## ✨ ¿Qué es un documento?

Un documento es la unidad básica de información en MongoDB 🌸. Está compuesto por pares clave-valor con estructura tipo JSON (BSON), lo que permite almacenar datos de forma flexible.

### 💻 Sintaxis
```json
{ "campo": "valor" }
```

```bash
{
  "nombre": "Aylin",
  "edad": 21,
  "carrera": "TI"
}
```

🔹 Equivalente en SQL: fila 💖

---

# 💖 ¿Qué es una colección?

Una colección es un conjunto de documentos dentro de una base de datos 🌸.

### 💻 Sintaxis
```mongodb
db.createCollection("nombre_coleccion")
```

🔹 Equivalente en SQL: tabla 💖

---

## ✨ Comandos básicos

### 💻 Sintaxis general
```mongodb
show dbs
use nombreBD
show collections
db.createCollection("nombre")
```

Estos comandos permiten gestionar bases de datos y colecciones de manera sencilla 💖.

---

## 💖 Comandos de MongoDB

| Comando                         | Descripción                      |
| ------------------------------- | -------------------------------- |
| `db`                            | Muestra la base de datos actual  |
| `show dbs`                      | Muestra las bases de datos       |
| `use nombreBD`                  | Cambia o crea una base de datos  |
| `show collections`              | Muestra colecciones              |
| `db.createCollection("nombre")` | Crea colección                   |
| `db.collection.insertOne({})`   | Inserta documento                |
| `db.collection.find({})`        | Consulta documentos              |

---

# 💖 Inserción de datos

## ✨ Sintaxis
```mongodb
db.coleccion.insertOne({ campo: valor })
db.coleccion.insertMany([ { }, { } ])
```

## Insertar un documento
```shell
db.coleccion.insertOne({
    nombre: "Oscar"
});
```

## Insertar múltiples documentos
```shell
db.Empleados.insertMany([
    {
        nombre: "Dulce",
        edad: 19,
        apellido: "Corona Fria",
        aficiones: ["Programacion", "Party", "Sweaters"]
    },
    {
        nombre: "Israel",
        edad: 30,
        hobbies: ["leer", "trabajar"],
        cv: {
            numLibros: 80,
            publicaciones: 24
        }
    }
]);
```

---

# 💖 Consultas en MongoDB

## ✨ Sintaxis
```mongodb
db.coleccion.find({})
db.coleccion.find({ campo: valor })
```

Seleccionar todos los documentos
```shell
db.libros.find();
```

## Consultas con condiciones
```shell
db.libros.find({ editorial: "Biblio" });

db.libros.find({ precio: 25 });

db.libros.find({
    precio: { $eq: 25 }
});
```

---

# 💖 Operadores de comparación

## ✨ Sintaxis
```mongodb
{ campo: { $operador: valor } }
```

| Operador | Descripción         |
| -------- | ------------------- |
| `$eq`    | Igual               |
| `$gt`    | Mayor que           |
| `$gte`   | Mayor o igual       |
| `$lt`    | Menor que           |
| `$lte`   | Menor o igual       |
| `$in`    | Busca en arreglo    |
| `$ne`    | Diferente           |
| `$nin`   | No coincide         |

---

## 💖 Ejemplo de colección: Libros
``` shell
db.libros.insertMany([
    { _id: 1, titulo: "El Aleph", editorial: "Planeta", precio: 20, cantidad: 50 },
    { _id: 2, titulo: "Martin Fierro", editorial: "Siglo XXI", precio: 50, cantidad: 12 },
    { _id: 3, titulo: "Aprenda PHP", editorial: "Siglo XXI", precio: 50, cantidad: 20 },
    { _id: 4, titulo: "Java en 10 minutos", editorial: "Siglo XXI", precio: 45, cantidad: 1 },
    { _id: 5, titulo: "Python para torpes", editorial: "Planeta", precio: 25, cantidad: 14 }
]);
```

---

# 💖 Consultas con operadores

# Mayor o igual a 20
```shell
db.libros.find({
    cantidad: { $gte: 20 }
});
```

# Menor a 5
```shell
db.libros.find({
    cantidad: { $lt: 5 }
});
```

# Uso de $in
```shell
db.libros.find({
    editorial: { $in: ["Biblio", "Planeta"] }
});
```

---

# 💖 Operadores logicos 

## ✨ Sintaxis
```mongodb
db.coleccion.find({
    $and: [ {condicion1}, {condicion2} ]
})

db.coleccion.find({
    $or: [ {condicion1}, {condicion2} ]
})
```

| Operador  | Descripción           |
| --------- | --------------------- |
| `$and`    | Todas las condiciones |
| `$or`     | Alguna condición      |
| `$not`    | Niega condición       |
| `$exists` | Verifica existencia   |

# Ejemplo AND
```shell
db.libros.find({
    precio: { $gt: 25 },
    cantidad: { $lt: 15 }
});
```

# Ejemplo OR
```shell
db.libros.find({
    $or: [
        { precio: { $gt: 25 } },
        { cantidad: { $lt: 15 } }
    ]
});
```

---

# 💖 Actualización de documentos

## ✨ Sintaxis
```shell
db.coleccion.updateOne(
    { filtro },
    { $set: { campo: valor } }
);
```

## Ejemplo
```shell
db.libros.updateOne(
    { _id: 1 },
    {
        $set: { autor: "Borjes" }
    }
);
```

---

# 💖 Proyección de campos

## ✨ Sintaxis
```shell
db.coleccion.find({}, { campo: 1 })
```

```shell
db.libros.find({}, { titulo: 1 });

db.libros.find({}, { titulo: 1, autor: 1 });

db.libros.find(
    { editorial: "Planeta" },
    { titulo: 1, autor: 1 }
);
```

---

# 💖 Ventajas de MongoDB vs SQL

🌸 Flexibilidad (no requiere esquema fijo)  
🌸 Manejo de datos complejos (arreglos y objetos)  
🌸 Rendimiento en grandes volúmenes  
🌸 Escalabilidad  
🌸 Facilidad de uso  

---

## 💔 Desventajas de MongoDB

🌸 No es ideal para relaciones complejas  
🌸 Puede consumir más espacio  
🌸 Menor control estructurado  

---

## 💖 ¿Cuándo usar MongoDB?

🌸 Grandes volúmenes de datos  
🌸 Datos que cambian constantemente  
🌸 Aplicaciones web modernas  
🌸 Sistemas que requieren flexibilidad  

---

## 💖 Conclusión ✨

MongoDB es una base de datos moderna, flexible y eficiente 🌸. Permite trabajar con datos de forma sencilla y adaptarse a diferentes necesidades.

Sin embargo, es importante elegirla correctamente dependiendo del tipo de sistema, ya que no siempre sustituye a las bases de datos relacionales 💖.

---

## 💌 Nota final

Pd. GRACIAS, es un buen profe. SQL se me dificultó un poco, pero estudié más y practiqué bastante. Puede ver mis repasos y notas en la carpeta de examen en mi Git.  

Disfrute sus vacaciones 🐄✨