# 💖 Reporte: MongoDB ✨

## ✨ Introducción

MongoDB es un sistema de base de datos NoSQL orientado a documentos. A diferencia de las bases de datos relacionales (SQL), no utiliza tablas, sino colecciones y documentos, lo que permite trabajar con datos de forma más flexible 🌸.

En este reporte se presentan los conceptos básicos, comandos principales, inserción de datos, consultas y actualización de documentos en MongoDB 💖.

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

Un documento es la unidad básica de información en MongoDB. Está formado por pares clave-valor en formato JSON (BSON) 🌸.

### 💻 Sintaxis

```json
{
  "campo": "valor"
}
```

### 🌸 Ejemplo

```json
{
  "nombre": "Aylin",
  "edad": 21,
  "carrera": "TI"
}
```

🔹 Equivalente en SQL:  
Un documento es una **fila (registro)** 💖

---

## ✨ ¿Qué es una colección?

Una colección es un conjunto de documentos dentro de una base de datos 🌸.

### 💻 Sintaxis

```mongodb
db.createCollection("nombre_coleccion")
```

### 🌸 Ejemplo

```mongodb
db.createCollection("Empleados")
```

🔹 Equivalente en SQL:  
Una colección es una **tabla** 💖

---

## ✨ Comparación MongoDB vs SQL

| MongoDB       | SQL           |
| ------------- | ------------- |
| Base de datos | Base de datos |
| Colección     | Tabla         |
| Documento     | Fila          |
| Campo         | Columna       |

---

## 💖 Comandos básicos de MongoDB

| Comando                         | Descripción                      |
| ------------------------------- | -------------------------------- |
| `db`                            | Ver base actual                  |
| `show dbs`                      | Mostrar bases                   |
| `use nombreBD`                  | Cambiar/crear BD                |
| `show collections`              | Ver colecciones                 |
| `db.createCollection("nombre")` | Crear colección                 |
| `db.collection.insertOne({})`   | Insertar documento              |
| `db.collection.find({})`        | Consultar documentos            |

---

# 💖 Inserción de datos

## ✨ Insertar un documento

### 💻 Sintaxis

```mongodb
db.coleccion.insertOne({ campo: valor })
```

### 🌸 Ejemplo

```mongodb
db.coleccion.insertOne({
    nombre: "Oscar"
});
```

---

## ✨ Insertar múltiples documentos

### 💻 Sintaxis

```mongodb
db.coleccion.insertMany([
    { campo: valor },
    { campo: valor }
])
```

### 🌸 Ejemplo

```mongodb
db.Empleados.insertMany([
    {
        nombre: "Dulce",
        edad: 19
    },
    {
        nombre: "Israel",
        edad: 30
    }
]);
```

---

# 💖 Consultas en MongoDB

## ✨ Seleccionar todos los documentos

### 💻 Sintaxis

```mongodb
db.coleccion.find({})
```

### 🌸 Ejemplo

```mongodb
db.libros.find();
```

---

## ✨ Consultas con condiciones

### 💻 Sintaxis

```mongodb
db.coleccion.find({ campo: valor })
```

### 🌸 Ejemplo

```mongodb
db.libros.find({ editorial: "Biblio" });

db.libros.find({ precio: 25 });

db.libros.find({
    precio: { $eq: 25 }
});
```

---

# 💖 Operadores de comparación

| Operador | Descripción         |
| -------- | ------------------- |
| `$eq`    | Igual               |
| `$gt`    | Mayor que           |
| `$gte`   | Mayor o igual       |
| `$lt`    | Menor que           |
| `$lte`   | Menor o igual       |
| `$in`    | En arreglo          |
| `$ne`    | Diferente           |
| `$nin`   | No coincide         |

---

## 💖 Ejemplo de colección: Libros

```mongodb
db.libros.insertMany([
    { _id: 1, titulo: "El Aleph", precio: 20, cantidad: 50 },
    { _id: 2, titulo: "Martin Fierro", precio: 50, cantidad: 12 }
]);
```

---

# 💖 Consultas con operadores

## ✨ Mayor o igual

### 💻 Sintaxis

```mongodb
{ campo: { $gte: valor } }
```

### 🌸 Ejemplo

```mongodb
db.libros.find({
    cantidad: { $gte: 20 }
});
```

---

## ✨ Menor que

### 💻 Sintaxis

```mongodb
{ campo: { $lt: valor } }
```

### 🌸 Ejemplo

```mongodb
db.libros.find({
    cantidad: { $lt: 5 }
});
```

---

## ✨ Uso de $in

### 💻 Sintaxis

```mongodb
{ campo: { $in: [valores] } }
```

### 🌸 Ejemplo

```mongodb
db.libros.find({
    editorial: { $in: ["Biblio", "Planeta"] }
});
```

---

# 💖 Operadores lógicos

| Operador  | Descripción           |
| --------- | --------------------- |
| `$and`    | Todas las condiciones |
| `$or`     | Alguna condición      |
| `$not`    | Niega condición       |
| `$exists` | Verifica existencia   |

---

## ✨ Ejemplo AND

### 💻 Sintaxis

```mongodb
db.coleccion.find({
    $and: [ {condicion1}, {condicion2} ]
})
```

### 🌸 Ejemplo

```mongodb
db.libros.find({
    precio: { $gt: 25 },
    cantidad: { $lt: 15 }
});
```

---

## ✨ Ejemplo OR

### 💻 Sintaxis

```mongodb
db.coleccion.find({
    $or: [ {condicion1}, {condicion2} ]
})
```

### 🌸 Ejemplo

```mongodb
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

```mongodb
db.coleccion.updateOne(
    { filtro },
    { $set: { campo: valor } }
)
```

## 🌸 Ejemplo

```mongodb
db.libros.updateOne(
    { _id: 1 },
    {
        $set: { autor: "Borges" }
    }
);
```

---

# 💖 Proyección de campos

## ✨ Sintaxis

```mongodb
db.coleccion.find({}, { campo: 1 })
```

## 🌸 Ejemplo

```mongodb
db.libros.find({}, { titulo: 1 });

db.libros.find({}, { titulo: 1, autor: 1 });
```

---

# 💖 Ventajas de MongoDB vs SQL

🌸 1. Flexibilidad → no requiere esquema fijo  
🌸 2. Datos complejos → soporta arreglos y objetos  
🌸 3. Rendimiento → rápido en grandes volúmenes  
🌸 4. Escalabilidad → crece fácilmente  
🌸 5. Facilidad → sintaxis sencilla tipo JSON  

---

## 💔 Desventajas de MongoDB

🌸 No es ideal para relaciones complejas  
🌸 Puede consumir más espacio  
🌸 Menor control estructurado que SQL  
🌸 Consultas complejas pueden ser más difíciles  

---

## 💖 ¿Cuándo usar MongoDB?

🌸 Cuando hay grandes volúmenes de datos  
🌸 Cuando los datos cambian constantemente  
🌸 Cuando se necesita flexibilidad  
🌸 En aplicaciones web modernas  

---

## 💖 Conclusión ✨

MongoDB representa una alternativa moderna a las bases de datos tradicionales, destacando por su flexibilidad y capacidad de adaptación 🌸. Es ideal para aplicaciones dinámicas y escalables.

Sin embargo, es importante considerar sus limitaciones y elegirla correctamente según las necesidades del sistema 💖.

Pd. GRACIAS es buen profe pero sql se me dificulto mucho, si estudie más y practique, puede ver mis miles de repasos y notas en la carpeta de examen en mi git Disfrute sus Vacaciones 🐄 