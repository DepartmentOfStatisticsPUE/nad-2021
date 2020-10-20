## wczytamy plik CSV wyeksportowany z pliku PDF

delko <- read.csv(file = "data-raw/importowanie/delko-tab1.csv", 
                  header = FALSE, ## czy jest wiersz z nazwami kolumn
                  skip = 23, ## ile wierszy ma przeskoczyć czyli zacznie wczytywać od 25 wiersza
                  nrows = 17) ## ile wierszy ma wczytać 
head(delko)
tail(delko, n = 3)

## wczytujemy dane ze strony HTML (wczytamy tabelę)

install.packages("rvest")
library(rvest)
library(readxl)

nbp_link <- "https://www.nbp.pl/home.aspx?f=/kursy/kursya.html"
nbp_strona <- read_html(nbp_link)
nbp_tabela <- html_table(nbp_strona, fill = TRUE)
str(nbp_tabela,1)
nbp_tabela[[43]] ## obiekt typu lista

## vector -- numeric, character, logic -- tworzymy z funkcją c
## matrix -- numeric, character -- matrix
## data.frame -- mix type, 
## list -- najbardziej pojemny obiekt

class(nbp_tabela)
class(nbp_link)
class(nbp_strona)

lista <- list(b = c(12,124,151),
              lista = list(c = c(124124, 214, 33)))

lista$lista$c
lista[[2]][[1]]

### tworzymy tabliczkę mnożenia z wykorzystaniem R -- wykorzystamy kilka sposobów

#### pierwszy sposób to funkcja outer
outer(X = 1:5, Y = 1:5)

### drugi sposób przez wykorzystanie pętli
tabliczka <- matrix(data = 0, nrow = 5, ncol = 5) ## macierz, która będzie przetrzymywała wyniki

for (i in 1:5) {
  for (j in 1:5) {
    tabliczka[i, j] <- i*j ## dla elementu i (wiersz) i elementu j (kolumna) przetrzymujemy wynik i*j
  }
}

tabliczka


## ćwiczenie polegające na wczytaniu danych z wielu plików excela o takiej samej strukturze

lista_plikow <- list.files(path = "data-raw/importowanie/",  ## ścieżka do plików
                           pattern = "xlsx$", ## jakie pliki nas interesują
                           full.names = T)

excele <- list() ## pusty obiekt typu lista o nazwie excele
for (plik in lista_plikow) {
  excele[[plik]] <- read_excel(path = plik, 
                               sheet = 1,
                               skip = 1)
}

str(excele,1)
excele[[4]]
tabele_razem <- do.call("rbind", excele) ## łączę dane w jedną dużą tabelę


## statystyki opisowe -- klasyczne i pozycyjne

mean(tabliczka)
mean(tabliczka, trim = 0.05)
sd(tabliczka)
sum(tabliczka)
median(tabliczka)
quantile(tabliczka, probs = c(0.25, 0.5, 0.75))
quantile(tabliczka, probs = c(0.01, 0.99))
summary(tabliczka)

colMeans(tabliczka) 
rowMeans(tabliczka)

apply(tabliczka, 1, median) ## dla każdego wiersza policz medianę
apply(tabliczka, 2, median) ## dla każdej kolumny policz medianę

for (i in 1:5) {
  print(mean(tabliczka[, i]))
}

## dodatkowe pakiety: matrixStats -- colMedians, colSds; psych -- kurtosis, skewness
install.packages("quantmod") ## pakiet do pobierania danych finansowych
library(quantmod)

#### pobieramy dane dla APPLE
apple_dane <- getSymbols(Symbols = "AAPL", from = "2017-01-01", auto.assign = FALSE)
head(apple_dane)
tail(apple_dane)
chart_Series(apple_dane)
chart_Series(apple_dane["2020-02/2020-03"])


spolki_it <- getSymbols(Symbols = c("AAPL", "NFLX", "AMZN"), from = "2020-01-01", auto.assign = TRUE)
chart_Series(AMZN)

## zapisuje do ramki danych
spolki_it <- list()
for (i in c("AAPL", "NFLX", "AMZN")) {
  spolki_it[[i]] <- getSymbols(Symbols = i, from = "2020-01-01", auto.assign= FALSE)
}


