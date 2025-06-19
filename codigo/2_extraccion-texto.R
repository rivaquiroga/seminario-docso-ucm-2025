# Paquetes que vamos a utilizar

library(rvest)
library(dplyr)
library(readr)

# Paso 0: encontrar la etiqueta o clase que contiene a los datos que quiero: section pt-14

# Paso 1: traer el código fuente de la página a mi sesión de R

url_noticia <- "https://www.minciencia.gob.cl/noticias/minciencia-abre-concursos-con-mas-de-1000-millones-para-proyectos-que-comuniquen-las-ciencias-y-los-conocimientos/"

html_noticia <- read_html(url_noticia)

# Paso 2: sacar los datos de la sección del código fuente que nos interesa y darle el formato indicado

texto_noticia <- html_noticia |> 
  html_element("section.pt-14") |> 
  html_text2() |> 
  stringr::str_remove("\nComparte:\n")

# Paso 3: guardar en un archivo de texto

write_file(texto_noticia, "datos/ejemplo-noticia.txt")
