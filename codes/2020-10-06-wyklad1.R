2+2

### tworzymy obiekt aby zapisać wynik działania 2+2
### <- to jest symbol przypisania
### przyposanie z symbolem <- nie powoduje wyświetlenia obiektu w konsoli
## konsolę czyścimy skrótem ctrl + l (MacOS: control + l)

wynik <- 2+100
wynik

## możemy obiekt o nazwie wynik wykorzystywać dalej

rezultat_analizy <- 2*wynik + 109/wynik + sqrt(wynik)
rezultat_analizy

## wczytamy plik o nazwie nsp2011-cudzoziemcy.csv do R
dane <- read.csv2(file = "data-raw/nsp2011-cudzoziemcy.csv", encoding = "UTF-8")

### wyświetla pierwsze 6 wierszy
head(dane)

