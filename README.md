# Seminario DOCSO UCM
Materiales utilizados en las dos sesiones sobre extracción de datos del seminario sobre técnicas cuantitativas digitales para la investigación del Doctorado en Ciencias Sociales de la Universidad Católica del Maule. 

## Preparación

Durante la primera sesión utilizaremos {rvest} y otros paquetes que son parte de lo que se conoce como [Tidyverse](https://www.tidyverse.org/), un conjunto de paquetes diseñados para el trabajo en ciencia de datos. Además, es necesario instalar {janitor}, {writexl} y {beepr}. Todos están disponibles en CRAN, por lo que puedes utilizar la función `install.packages()` para obtenerlos:

```
install.packages("tidyverse")
install.packages("beepr")
install.packages("janitor")
install.packages("writexl")
```

## Atajos de teclado útiles

Los siguientes atajos de teclado serán útiles al explorar las páginas web que _escrapearemos_.

| Acción | Windows / Linux | Mac |
|---|---|---|
| Ver el código fuente de una página | ctrl +  u | command + u|
| Abrir el panel de desarrollo | F12<br/>ctrl + shift + i | F12<br/>option + command +i |
| Abrir el panel de desarrollo con la opción de selección activada | ctrl + shift + c | option/ctrl + command + c |

Existe una extensión de Google Chrome que se llama [SelectorGadget](https://chromewebstore.google.com/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb?hl=es) que puede resultar de utilidad. 

## Estructura de nuestro directorio de trabajo

El directorio de en que guardaremos los materiales tendrá dos subcarpetas: una para los datos y otra para el código. Todo el código que escribamos asumirá esa estructura de carpetas (y que no se usó tilde en el nombre de la carpeta para el código). Para mantener todo en orden, convertiremos nuestro directorio de trabajo en un "proyecto" de RStudio. En el caso de [posit.cloud]([posit.cloud/](https://posit.cloud/)), su espacio de trabajo es ya un proyecto, por lo que no tendrán que hacer el paso adicional de crear uno.


```
📂 taller-extraccion-datos
    |
    |-- 📁 codigo
    |-- 📁 datos
    |-- 🔵 taller-extraccion-datos.Rproj
```


## Sitios web de ejemplo

A lo largo de la sesión revisaremos algunos sitios web a modo de ejemplo o para discutir algunas ideas. Dejaremos acá los enlaces para que sea más fácil revisarlos. 

:link: [Un sitio web](https://programminghistorian.org/es/lecciones/)

:link: [Sitio web estático (tablas)](https://es.wikipedia.org/wiki/Anexo:%C3%81lbumes_musicales_m%C3%A1s_vendidos)

:link: [Sitio web dinámico (tablas)](https://www.camara.cl/transparencia/asesoriasexternasgral.aspx)

:link: [Sitio web estático (paginación)](https://www.minciencia.gob.cl/noticias)

:link: [Sitio web dinámico (paginación)](https://www.emol.com/)

:link: [Condiciones de uso](https://www.amazon.com/-/es/gp/help/customer/display.html?nodeId=508088&ref_=footer_cou) 

:link: [Licenciamiento y uso del contenido 1](https://www.biobiochile.cl/)

:link: [Licenciamiento y uso del contenido 2](https://prensa.presidencia.cl/)

:link: [robots.txt 1](https://wikipedia.org/)

:link: [robots.txt 2](https://www.oas.org/)


## Actividades

Durante el taller realizaremos algunos ejercicios para poner en práctica lo aprendido. Iremos escribiendo el código "en vivo" en la clase. 

### Ejercicio 1: extraer una tabla

:link: [Página web](https://www.worldometers.info/world-population/population-by-country/) 

:page_facing_up: [Código](https://raw.githubusercontent.com/rivaquiroga/seminario-docso-ucm-2025/refs/heads/main/codigo/1_extraccion-tabla.R)


### Ejercicio 2: extraer texto

:link: [Página web](https://www.minciencia.gob.cl/noticias/minciencia-abre-concursos-con-mas-de-1000-millones-para-proyectos-que-comuniquen-las-ciencias-y-los-conocimientos/)

:page_facing_up: [Código](https://raw.githubusercontent.com/rivaquiroga/seminario-docso-ucm-2025/refs/heads/main/codigo/2_extraccion-texto.R)

### Ejercicio 3: extraer enlaces y crear funciones

:link: [Página web](https://www.minciencia.gob.cl/noticias)

:page_facing_up: Código

