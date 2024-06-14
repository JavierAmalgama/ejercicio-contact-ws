## Libreta de Direcciones

API estilo REST para implementar ejercicio de libreta de direcciones.

### Qué se debe hacer

Se espera que se realice lo siguiente:

 - Sección de login por email y contraseña.
 - Tabla de contactos paginada.
 - Poder filtrar contactos utilizando el parámetro `filter` de la API.
 - Crear contactos nuevos.
 - Ver detalles del contacto.
 - Editar contactos.
 - Eliminar contactos.
 - NO es necesario realizar un diseño del sitio, alcanza simplemente con tablas y formularios.

La creación y edición de contactos incluye:
 - La posibilida de subir un "avatar" para el contacto.
 - Selección de país y estado a partir de los datos brindados por el web service.

Tiempo esperado de realización: 5 horas.

### Usuarios de prueba

Para probar se dispone de 10 usuarios:

 - Email: `userN@domain.com`, donde N es un número del 1 al 10.
 - Contraseña: `S0mePassw0rd!`

El usuario `user1@domain.com` posee 100 contactos en su libreta de direcciones.

### Login

 - El login es [OAuth 2.0](https://tools.ietf.org/html/rfc6749) estándar, utilizando **Resource Owner Password Credentials Grant**.
 - Endpoint para obtener el token: `/oauth/token`.

### Formato estándar de respuesta

Cuando se responde con un solo recurso, el formato de respuesta es el siguiente:

```javascript
{
	"response": { ... } // Recurso serializado
}
```

Cuando se responde con un listado de recursos, los mismos se paginan, y el formato de respuesta es el siguiente:

```javascript
{
	"response": [
		{ ... }, // Recurso serializado
		{ ... }, // Recurso serializado
		{ ... }, // Recurso serializado
		...
	],
	"count": 10, // Recursos en esta página
	"pagination": {
		"current": 1, // Página actual
		"previous": null, // Página anterior o null si no hay
		"next": 2, // Página siguiente o null si no hay
		"per_page": 10, // Recursos por página
		"pages": 12, // Cantidad total de páginas
		"count": 120, // Cantidad total de recursos
	}
}
```

### Parámetros estándar

Para el caso de recursos paginados se pueden utilizar los siguientes parámetros estándar

 - `page`: Página a obtener.
 - `per`: Elementos por página a mostrar, valores posibles: 10, 25, 50 y 100.
 - `filter`: Filtra elementos por nombre o email, según aplique.

### Errores

En caso de error se devuelve el código HTTP adecuado e información del error como JSON:

```javascript
{
	"error": "codigo_error",
	"error_description": "Descripción del error"
}
```

Si hay errores de validación del recurso que se está creando o actualizando se devuelve el código HTTP 422,
y la respuesta JSON con más información:

```javascript
{
	"error": "invalid_resource",
	"error_description": "The current resource was deemed invalid.",
	"messages": {
		"nombre_campo": [
			"Mensaje de error 1",
			"Mensaje de error 2",
			...
		],
		// Ejemplo:
		"name": [
			"can't be blank",
			"is too short (minimum is 3 characters)"
		],
		"email": [
			"invalid format"
		]
	}
}
```

### Usuarios

 - GET `/v1/users/:id`: Obtiene el usuario identificado por `id`, donde `id` puede ser:
   - El número de ID del usuario.
	- El código especial `me`, identificando al usuario logueado.

```javascript
{
	"id": 1,
	"email": "user1@domain.com"
}
```

### Contactos

 - GET `/v1/users/:user_id/contacts`: Obtiene todos los contactos de la libreta de direcciones.
 - POST `/v1/users/:user_id/contacts`: Agrega un contacto a la libreta de direcciones.
 - PATCH `/v1/users/:user_id/contacts/:contact_id`: Modifica un contacto de la libreta de direcciones.
 - GET `/v1/users/:user_id/contacts/:contact_id`: Obtiene un contacto específico de la libreta de direcciones.
 - DELETE `/v1/users/:user_id/contacts/:contact_id`: Elimina un contacto de la libreta de direcciones.

```javascript
{
	"id": 1,
	"name": "Alguna Persona",
	"email": "algun@email.com",
	"phone1": "011 - 555 - 5555",
	"phone2": "+54 11 - 1234 - 5555",
	"birthdate": "1976/12/03",
	"address": "Av. Falsa 123",
	"state": {
		"id": 1,
		"name": "Buenos Aires"
	},
	"country": {
		"id": 1,
		"name": "Argentina"
	},
	"avatar": "/path/a/la/imagen.jpg"
}
```

Cualquiera de los parámetros puede ser null.

Para crear o modificar un contacto hay que tener en cuenta que el país no se establece explicitamente (queda ligado al estado),
y el estado se pasa como un ID utilizando el parámetro `state_id`.

Ejemplo:

```
PATCH /v1/users/1/contacts/34

name=Nombre&state_id=23
```

### Países

 - GET `/v1/countries`: Obtiene el listado de todos los países.

```javascript
{
	"id": 1,
	"name": "Argentina"
}
```

### Estados

 - GET `/v1/countries/:country_id/states`: Obtiene el listado de todos los estados del país.

```javascript
{
	"id": 1,
	"name": "Buenos Aires"
}
```
