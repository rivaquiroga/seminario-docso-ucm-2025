# Los paquetes que vamos a utilizar

library(rvest)
library(dplyr)
library(readr)
library(janitor)
library(stringr)
library(writexl)

# Paso 0: buscar en el código fuente de la página el elemento que contiene la sección que nos interesa extraer. En este caso era "table".

# Paso 1: traer a R el código fuente de la página

url_tabla <- "https://www.worldometers.info/world-population/population-by-country/"

html_tabla <- read_html(url_tabla)

# Paso 2: extraer los datos que me interesan del elemento que identifiqué antes ("table")

tabla_poblacion <- html_tabla |>  # |> se hace con Ctrl Mayúscula M / %>% 
  html_element("table") |> 
  html_table() |> 
  clean_names()

# Limpiar un poco nuestros datos

# La función parse_number del paquete readr nos permite extraer solo el valor numérico de una cadena de caracteres:
parse_number("US$ 100")
parse_number("17.20%")
parse_number("-0.23%")
parse_number("−0.23%")
parse_number("-0.23%")
parse_number("0,34", locale = locale(decimal_mark = ","))

# Si yo quisiera cambiar las columnas de a una, lo podría hacer así:

tabla_poblacion |> 
  mutate(population_2025 = parse_number(population_2025))

# Cuando quiero convertir varias columnas al mismo tiempo, puedo usar la función mutate en conjunto con across

poblacion_2025 <- tabla_poblacion |> 
  mutate(across(population_2025:world_share, ~str_replace(., "−", "-"))) |> 
  mutate(across(population_2025:world_share, parse_number)) |> 
  rename(ranking = number, yearly_change_percent = yearly_change, world_share_percent = world_share)

#Podemos guardar ahora nuestros datos

write_xlsx(poblacion_2025, "datos/poblacion_2025.xlsx")

