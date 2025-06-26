# Los paquetes que vamos a utilizar

library(rvest)
library(dplyr)
library(readr)
library(lubridate)
library(purrr)

# Paso 1: Guardar la url en un objeto y leer el código fuente de esa página

url_noticias <- "https://www.minciencia.gob.cl/noticias/?p=1"

html_noticias <- read_html(url_noticias)

# Paso 2: Extrer los elementos que nos interesan

titulares <- html_noticias  |> 
  html_elements("h3") |> 
  html_text2()
