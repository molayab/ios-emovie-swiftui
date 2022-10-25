#  eMovie

This is an example application about how to use SwiftUI and MVVM consuming remote HTTPs services with the URLSession. The networking is using cache layer provided by the OS via URLSessionConfiguration and parsing is done using Codable protocol as main serialization layer. The project uses await/async for concurreny propouses and its all done using Combine.

This project assumes some extra work that couldn't be done for time reasons, it includes: 
 - Authorization token MUST be stored on a secure way, using external repositories or using macros avoiding hardcoding.
 - Unit testings should have greater coverage.
 - UITest could be done in the futher iteraction.
 - Stubs could be use for testing parsing layer.
 
 ## ¿En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito?
 
 Single Responsability o Responsabilidad unica es uno de los 5 principios SOLID que nos permiten contruir software de forma modular y escalable. El principio en concreto dictamina que cada artefacto que sea construido por el desarrollo debe tener uno y solo un objectivo, en este orden de ideas, evitamos tener un artefcato software en el cual se mezclan diferentes logicas no relacionadas. Un ejemplo de ello es WebServiceRepository, en el consolidamos toda la responsabilidad de la abstraccion de URLSession, este solo existe por este proposito y no se acopla a otros repositorios en la app.
 
## ¿Qué características tiene, según su opinión, un “buen” código o código limpio?
  
Un buen codigo es aquel que busca mantener los principios SOLID lo mas correctamente posible, un codigo donde todos los artefactos sean de responsabilidad unica, donde podamos inyectar todas sus dependencias, y garantizar asi un alta testeabilidad del mismo. Es importante simepre tener definidas interfaces o protocolos que nos permitan hacer una segragacion de interfaces y poder cambiar clases o definiciones concretas sin realizar mayores cambios. Un aspecto importante tambien es el correcto uso de las herramientas de concurrencia que el OS nos permita en cada caso.


