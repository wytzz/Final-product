# Final Report Voorraadbeheer voor horecagelegenheden

## Applicatie beschrijving
Deze applicatie maakt voorraadbeheer voor horecagelegenheden inzichtelijk en makkelijk aanpasbaar.

## Technisch design
![alt text](https://github.com/wytzz/Final-product/blob/master/doc/Voorraadbeheer%20app%20final.png)

### [IntroductionViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/IntroductionViewController.swift)
Deze controller wordt alleen gebruikt voor een unwind functie vanaf de LoginViewController, SignupViewController en de AccountViewController.

### [SignUpViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/SignUpViewController.swift)
In deze View Controller kan er een account worden aangemaakt, deze wordt op een database op Firebase gezet. Er is dubbele wachtwoordcheck. Wanneer er een veld niet juist wordt ingevuld komt er een melding met uitleg waarom er niet geregistreerd kan worden.


### [LoginViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/LoginViewController.swift)
Buiten de View Controller zitten enkele extensions die het mogelijk maken om de tekstkleur van de tekstvelden in de SignUpViewController en LoginViewController aan te passen. In de View Controller kan worden ingelogd met controle van Firebase. Wanneer er onjuist wordt ingelogd komt er een melding met uitleg. De View Controller geeft het email adres door aan de AccountViewController en de StockTableViewController die wordt gebruikt om een aparte voorraad aan te maken per account.


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
In de StockTableViewController zijn alle producten in voorraad te zien. De producten worden van de rester database opgehaald via fetchProducts uit de ProductController. Wanneer een product schaars is (hoeveelheid bij een melding is hoger dan de huidige hoeveelheid), is de achtergrondkleur van de cel lichtrood en de tekst wit. Via een zoek balk kan er naar bepaalde producten gezocht worden. Wanneer de zoek balk wordt aangeklikt verschijnt er een scopebar die de producten kan filteren op schaarsheid of niet. Producten kunnen verwijderd worden door in de cel van het product van rechts naar links te swipen of via de editbutton linksboven. Via de plusbutton rechtsboven gaat men naar de AddToStockTableViewController waar een product kan worden toegevoegd. Wanneer er op een cel gedrukt wordt gaat men ook naar de AddToStockTableViewController waar de details te zien zijn en waar het product kan worden aangepast. In de cel kan de hoeveelheid van het product aangepast worden via de stepper. De hoeveelheid wordt veranderd in de rester database via valuestepperchangedQuantity() wanneer de pagina verdwijnt (viewWillDisappear). Onderin kan via de Tab Bar naar de AccountViewController gaan.

### [StockTableViewCell](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/StockTableViewCell.swift)
In de StockTableViewCell zijn de outlets van de labels voor de productnaam, hoeveelheid en hoeveelheidtype en een stepper beschreven. Daarnaast is er een action voor de stepper. Via deze outlets en actions wordt het label van de hoeveelheid gekoppeld aan de stepper. Dit zorgt er voor dat het hoeveelheidslabel veranderd wanneer de stepper wordt aangedrukt en de waarde van de stepper gelijk staat met die van het label van de hoeveelheid. Verder maakt deze Table View Cel het mogelijk om in de StockTableViewController de waardes uit de cel te halen of die er juist in te voegen.

### [AccountViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/AccountViewController.swift)
In deze View Controller kan er worden uitgelogd en is het emailadres en het aantal producten te zien.


### [AddToStockTableViewController](https://github.com/wytzz/Final-product/blob/master/Voorraadbeheer/Voorraadbeheer/AddToStockTableViewController.swift)
Via deze Table View Controller kan er een product worden toegevoegd of  zijn de details van een bestaand product te zien. Wanneer er een product wordt toegevoegd moet er een naam, hoeveelheid, melding bij hoeveelheid en type hoeveelheid gegeven worden. Het is optioneel om notities bij te voegen. Wanneer de eerste vier niet juist zijn ingevoerd verschijnt er een melding. Als alles wel juist is ingevoerd wordt het product toegevoegd aan de rester database via de addProduct functie en gaat men terug naar de StockTableViewController waar het nieuwe product ook te zien is. Wanneer er een bestaand product gedetailleerd wordt laten zien is het exact hetzelfde als een nieuw volledig ingevuld product. Het bestaande product kan worden aangepast waarna het via de changeProduct functie wordt aangepast in de rester database.


## Challenges
Ik heb me verkeken hoeveel tijd er in gaat zitten om een applicatie uit je hoofd zo functioneel mogelijk te maken zonder errors. De applicaties die in bij App Studios gemaakt werden kostte mij niet ontzettend veel tijd waardoor ik had gedacht dat het ontwerp wat ik mijn hoofd had gemakkelijk werkelijkheid kon maken gezien de tijd. Helaas liep ik voornamelijk tegen problemen op die te maken hadden met data ophalen, aanmaken en verwijderden. Lange tijd werkte de stepper in de TableView niet waarmee er snel producthoeveelheden konden worden aangepast. Verder heb ik problemen gehad met de zoek balk en scope bar. Dit heeft mij ook veel tijd gekost aangezien ik met geen mogelijkheid de tekstkleur of achtergrondkleur van de zoekbalk kon aanpassen. Ik heb naar mijn weten alle opties geprobeerd die StackOverFlow aangaf, helaas met geen resultaat. Door deze problemen heb ik geen extra's meer kunnen toevoegen aan deze toch simpele applicatie wat vooraf wel het plan was. Verder heb ik getwijfeld hoe de toevoeg pagina in te vullen. Ik heb twee keer gewisseld tussen een TableViewController of een ViewController met het oog op de opmaak. Uiteindelijk heb ik gekozen voor een TableViewController omdat het de applicatie en de opmaak simpel en overzichtelijk houd. 

Wanneer ik meer tijd had gehad was uiteraard de tekst of achtergrondkleur van de zoekbalk wit. Daarnaast was er waarschijnlijk een View Controller gekomen waar eerst de details van een product wordt laten zien voordat het aangepast kan worden. Het toevoegen van producten was ook makkelijker geweest met een API die een lijst van producten had waardoor producten sneller konden worden toegevoegd. Tot slot had de applicatie daadwerkelijk gebruikt kunnen worden wanneer de producten in een Firebase database werden toegevoegd. Desalniettemin is deze applicatie buitengewoon handig voor horecagelegenheden. Uit eigen ervaring weet ik dat voornamelijk keukenpersoneel tegen problemen oploopt wat betreft schaarsheid van producten of het ordenen de voorraad.



