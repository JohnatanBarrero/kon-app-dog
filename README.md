# konfio_app_dog

Flutter Technical Test: Dog App
Descripción
Este es un proyecto de prueba técnica en Flutter que tiene como objetivo demostrar la implementación de diversas funcionalidades y buenas prácticas en el desarrollo de aplicaciones móviles. La app muestra una lista de perros ("dogs") y permite la interacción con una API externa. Se implementan principios de Clean Architecture, manejo de estados, persistencia de datos, y pruebas unitarias, entre otras funcionalidades adicionales.

Funcionalidades Implementadas
1. Llamada a la API
Se realiza una llamada a la API para obtener los datos de los perros, que son cargados y mostrados en la interfaz de usuario.


2. Carga de la Paleta de Colores
La aplicación carga dinámicamente una paleta de colores para personalizar la apariencia de la interfaz, proporcionando una experiencia visual atractiva y coherente.


3. Carga de la Lista de "Dogs"
Los datos de los perros se cargan y se muestran en una lista, siguiendo el diseño proporcionado en los requisitos del proyecto.


4. Persistencia de Base de Datos
Se implementa la persistencia local de los datos utilizando una base de datos para almacenar la lista de perros, garantizando la disponibilidad de los datos incluso sin conexión a internet.


5. Arquitectura con Clean Architecture
Se sigue la arquitectura de Clean Architecture para garantizar una estructura de código escalable, mantenible y modular. La lógica de negocio, la capa de datos y la capa de presentación están claramente separadas.


6. Pruebas Unitarias
Se implementan pruebas unitarias para verificar el correcto funcionamiento de las funcionalidades clave de la aplicación y asegurar su fiabilidad.


Funcionalidades Adicionales
7. Splash Screen
Se agrega un Splash Screen al inicio de la aplicación para mejorar la experiencia del usuario al cargar la app.
![image](https://github.com/user-attachments/assets/a4afada6-f3b2-4135-8a55-4ef702546c5b)



8. Modo Oscuro y Claro con guardado en preferencias de usuario
Se implementa la lógica para cambiar entre el modo oscuro y modo claro, se mantiene asi abras o cierres la app por medio de shared preferences, mejorando la accesibilidad y la experiencia visual del usuario.
![image](https://github.com/user-attachments/assets/67c64f6d-dc05-4e88-8239-8eee8a3df1ff)
![image](https://github.com/user-attachments/assets/0231d6f5-567b-4b28-9784-2c30ac051d70)



10. Manejo de Ambientes
La aplicación maneja diferentes ambientes de configuración (desarrollo, certificación y producción), asegurando que el comportamiento de la app sea adecuado según el entorno.
Se escoge el ambiente desde desde dropdown como lo muestra la imagen.
![image](https://github.com/user-attachments/assets/4ff8143e-797d-4515-ba26-a2f12f3cb98e)



12. Icono de la Aplicación
Se agrega el icono de la aplicación para las plataformas Android e iOS, siguiendo las mejores prácticas de cada plataforma.
![image](https://github.com/user-attachments/assets/bbb4e835-fcbd-4c12-a914-63b1e350ba88)


Instalación
Para ejecutar el proyecto localmente, sigue estos pasos:

Clona el repositorio:

bash
Copiar
Editar
git clone [https://github.com/JohnatanBarrero/kon-app-dog.git](https://github.com/JohnatanBarrero/kon-app-dog.git)
Navega al directorio del proyecto:

bash
Copiar
Editar
cd nombre-del-repositorio
Instala las dependencias:

bash
Copiar
Editar
flutter pub get
Ejecuta la aplicación en un emulador o dispositivo físico:

bash
Copiar
Editar
flutter run
Tecnologías Utilizadas
Este proyecto está desarrollado utilizando las siguientes tecnologías:

Flutter: Framework para desarrollo de aplicaciones móviles.
Dart: Lenguaje de programación utilizado en Flutter.
SQLite: Base de datos local para persistencia de datos.
Clean Architecture: Arquitectura de software para separar responsabilidades.
JUnit: Framework de pruebas unitarias para Dart/Flutter.
Contribuciones
Si deseas contribuir al proyecto, sigue estos pasos:

Forkea el repositorio.
Crea una nueva rama (git checkout -b feature/nueva-funcionalidad).
Realiza los cambios y haz commit (git commit -am 'Agrega nueva funcionalidad').
Envía un Pull Request para revisarlo.
Licencia
Este proyecto está licenciado bajo la Licencia MIT - ver el archivo LICENSE para más detalles.
