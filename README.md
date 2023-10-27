# RecipesNavigator

![image](https://github.com/sdykae/RecipesNavigator/assets/50224521/01af0846-4fe0-4647-b8ae-2d1b4eaa1b8d)
![image](https://github.com/sdykae/RecipesNavigator/assets/50224521/2fc618ae-26a6-41eb-b605-f2609a9125bf)

![image](https://github.com/sdykae/RecipesNavigator/assets/50224521/f990c712-e8da-4649-9d8e-164bd75fc27f)
![image](https://github.com/sdykae/RecipesNavigator/assets/50224521/8d926120-f698-4c79-8970-0677c422d4d5)

## Solución de arquitectura
![Architecture](https://github.com/sdykae/RecipesNavigator/assets/50224521/3ba43795-980c-4df9-b156-18f0ff12d53a)


- Para el desarrollo se uso una aproximacion de la Arquitectura Clean, Modular y MVVM para la UI
- Se uso TDD para el paquete Recipes que separa la logica de negocio con la implementacion de la UI
- Recipes Package (Swift Package) 100 Coverage Test
- No usamos dependencias externas
- Tests EndToEnd de API
- Separacion de responsabilidades en Recipes Package:
  - Se uso una Arquitectura Modular que evita generar dependencias o referencias de modulos privados que ayuda a la testabilidad y separacion de responsabilidades aplicando SOLID y extensa Inversion de Dependencias
  - Test Target Mac para una mejor performance
  - Tests para prevenir memory leaks
  - Tests no dependientes de Implementacion
  - Recipes Package puede usarse para Diferentes tipos de App con targets diferentes a IOS como WatchOs o Mac

- Se procedio Realizando la metodologia TDD que implica Crear una logica basica para los componentes iniciales (Recipe Loader Generico) y procedimentalmente se agregaron casos de prueba que incrementaban y mejoraban la funcionalidad hasta obtener un producto final que se modulariza
![image](https://github.com/sdykae/RecipesNavigator/assets/50224521/7163c93b-be12-4070-8206-5931e9091ceb)

