## csv, txt, csv2 (;) -- read.csv, read.table, read.csv2, readLines
## xls, xlsx -- trzeba doinstalować pakiet (readxl, openxlsx)
#### readxl - wczytanie plików xls i xlsx
#### openxlsx - wczytanie i zapis plików xlsx

### instalacja pakietów
install.packages("readxl")
install.packages("openxlsx")

### uruchomienie pakietów
library(readxl)
library(openxlsx)

### użyjemy pakietu readxl i dwóch funkcji excel_sheets() i  read_excel()
excel_sheets(path = "data-raw/importowanie/Data_DoingBusiness.xlsx")
doing_business <- read_excel(path = "data-raw/importowanie/Data_DoingBusiness.xlsx", 
                             sheet = 1,
                             skip = 1)
head(doing_business) ## pierwsze 6 wierszy
tail(doing_business) ## wyświetla 6 ostatnich wierszy
dim(doing_business) ## liczbę wierszy i liczbę kolumn
nrow(doing_business) ## liczba wierszy
ncol(doing_business) ## liczba kolumn
summary(doing_business) ## dla wszystkich kolumn zwraca statystyki opisowe

## jak możemy wybrać określone wiersze lub kolumny
doing_business[1, ] ## zbiór[wiersze, kolumny]
doing_business[1:3, ]
doing_business[c(1, 5, 10), ] ## c() -- tworzenie wektora
indeksy <- seq(from = 2, to = nrow(doing_business), by = 2) ## sekwencja parzystych wierszy
doing_business[indeksy, ]

zbior_nowy <- doing_business[-c(1,2,5), ] ## usunięcie 1, 2 i 5 wiersza i utworzenie nowego zbioru danych (data.frame)

## wybierane kolumn
### pierwszy sposób wyboru kolumn
doing_business[, 1]
doing_business[, 1:4]
doing_business[1:4, 1:4]
### drugi sposób (wybranie jeden kolumny)
doing_business$`Getting electricity: Time (days)`
### trzeci sposób
doing_business[, c("Getting electricity: Time (days)")]
doing_business[, "Getting electricity: Time (days)"]

### zmieniamy nazwy kolumn
names(doing_business)[1] <- "country" ## zamieniam pierwszy element wektora na country
names(doing_business) <- c("country", "permits_time", "contract_cost", "contract_time",
                           "permits_procedure", "tax", "electricity", "registration",
                           "insolvency", "start")

### nazwy kolumn -- krótkie, informatywne, bez spacji, małe litery, bez polskich znaków
doing_business

### czy występuje zależnosć miedzy permits_time, contract_cost i contract_time
cor(doing_business[, 2:4], method = "pearson") ## zakłada związek liniowy
cor(doing_business[, 2:4], method = "spearman") ## nie zakłada takiego związku (w odniesieniu do oryginalnych danych)

## jak utworzyć wykres rozrzutu (ang. scatter plot)
plot(doing_business[, 2:3]) ## dla 3 i więcej matrix scatter plot
plot(doing_business[, 2:4]) ## dla 3 i więcej matrix scatter plot

### exploratory data analysis (eksploracyjna analiza danych)
## scatter plot -- funkcja plot(x1, x2, ...)
## histogram -- funkcja hist(x1)

hist(x = doing_business$permits_time,
     main = "Rozkład zmiennej permits time",
     xlab = "Permits",
     ylab = "Częstość", 
     breaks = "fd")

## wykres pudełkowy (boxplot) -- funkcja boxplot(x1)
boxplot(x = doing_business$permits_time)
### gruba, czarna kreska w środku pudełka to mediana
### dół pudełka to Q1
### góra pudełka to Q3
### wąsy są tworzone tak:
#### góra = Q3 + 1.5*R; R = Q3-Q1
#### dół = Q1 - 1.5*R

### tworzymy nową zmienną, która będzie pierwszą literą nazwy kraju

doing_business$group <- substring(doing_business$country, 1, 1)
doing_business$group

boxplot(permits_time ~ group, data = doing_business)

### zapisujemy dane do nowego pliku MS Excel 
write.xlsx(x = doing_business, file = "data/doing_business.xlsx")





