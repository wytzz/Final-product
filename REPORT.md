# Final Report Voorraadbeheer voor horecagelegenheden

## Applicatie beschrijving
Deze applicatie maakt het gebruik van voorraden voor horecagelegenheden inzichtelijk 

## Technisch design
![alt text](https://github.com/wytzz/Final-product/blob/master/doc/Voorraadbeheer%20app%20final.png)

### [IntroductionViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/IntroductionViewController.swift)
Deze controller wordt alleen gebruikt voor een unwind functie vanaf de LoginViewController, SignupViewController en de AccountViewController.

### [SignUpViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/SignUpViewController.swift)
In deze View Controller kan er een account worden aangemaakt, deze wordt op een database op Firebase gezet. Er is dubbele wachtwoordcheck. Wanneer er een veld niet juist wordt ingevuld komt er een melding met uitleg waarom er niet geregistreed kan worden.


### [LoginViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/LoginViewController.swift)
Buiten de View Controller zitten enkele extensions die het mogelijk maken om de textkleur van de textfields in de SignUpViewController en LoginViewController aan te passen. In de View Controller kan worden ingelogd met controle van Firbase. Wanneer er onjuist wordt ingelogd komt er een melding met uitleg. De View Controller geeft het emailadres door aan de AccountViewController en de StockTableViewController die wordt gebruikt om een aparte voorraad aan te maken per account.


### [Products](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/Products.swift)
In products is een struct aangemaakt voor ieder product. Het bevat:
- ID
- Productnaam
- Hoeveelheid
- Type hoeveelheid (kg, liters, gram, stuks enz.)
- Melding bij hoeveelheid
- Schaarsheid product 

### [ProductController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/ProductController.swift)
In de productcontroller is de functie fetchProducts geschreven die de producten van de rester database ophaalt.

### [StockTableViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/StockTableViewController.swift)
In de StockTableViewController zijn alle producten te zien van de voorraad. De producten worden van de rester Database opgehaald via fetchProducts uit de ProductController. Wanneer een product schaars is (hoeveelheid bij een melding is hoger dan de huidige hoeveelheid), is de achtergrondkleur van de cel lichtrood en de tekst wit. Via een zoekbalk kan er naar bepaalde producten gezocht worden. Wanneer de zoekbalk wordt aangeklikt verschijnt er een scopebar  die de producten kan filteren op schaarsheid of niet. Producten kunnen verwijderd worden door in de cel van het product van rechts naar links te swipen of via de editbutton linksboven. Via de plusbutton rechtsboven gaat men naar de AddToStockTableViewController waar een product kan worden toegevoegd. In de cell kan de hoeveelheid van het product aangepast worden via de stepper. De hoeveelheid wordt veranderd in de rester database via valuestepperchangedQuantity() wanneer de pagina verdwijnt (viewWillDisappear). Onderin kan via de Tab Bar naar de AccountViewController gaan.

### [StockTableViewCell](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/StockTableViewCell.swift)


### [AccountViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/AccountViewController.swift)
In deze View Controller kan er worden uitgelogd en is het emailadres en het aantal producten te zien.


### [AddToStockTableViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/AddToStockTableViewController.swift)


## Challenges
Clearly describe challenges that your have met during development. Document all important changes that your have made with regard to your design document (from the PROCESS.md). Here, we can see how much you have learned in the past month.

Defend your decisions by writing an argument of a most a single paragraph. Why was it good to do it different than you thought before? Are there trade-offs for your current solution? In an ideal world, given much more time, would you choose another solution?

