# Los paquetes que vamos a utilizar

library(rvest)
library(dplyr)
library(purrr)
library(readr)

# Convertir en una función el código de extracción de noticias

extraer_noticias <- function(url_noticia){
    Sys.sleep(3)
  
  html_noticia <- read_html(url_noticia)
  
  texto_noticia <- html_noticia |> 
    html_element("section.pt-14") |> 
    html_text2() |> 
    stringr::str_remove("\nComparte:\n")
  
  return(texto_noticia)
  
}

# Probar la función:

extraer_noticias("https://www.minciencia.gob.cl/noticias/cientificos-academicos-y-representantes-publicos-y-privados-presentan-propuestas-para-medir-la-sustentabilidad-en-la-actividad-silvoagropecuaria/")


# Vamos a importar la tabla con las urls de las noticias:

tabla_noticias <- read_csv("datos/noticias-minciencia.csv") |> 
  slice(1:10)

# vamos a probar la función con una url de la tabla
extraer_noticias(tabla_noticias$url[2])

# Ahora vamos a iterar para que la función extraer_noticias se aplique a todas las urls de la tabla


map(tabla_noticias$url[1:3], extraer_noticias) # por defecto, me devuelve una lista

texto_noticias <- map_chr(tabla_noticias$url, extraer_noticias) # map_chr me devuelve una cadena de caracter

tabla_completa <- tabla_noticias |> 
  mutate(texto_noticia = texto_noticias)

writexl::write_xlsx(tabla_completa, "datos/texto-10-noticias.xlsx")
