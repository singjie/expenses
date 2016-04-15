# Expenses

This script is used to parse CITIBANK credit card statement output(CSV).

It will group them into different categories based on a predefined list of merchants.

## To Run
Download CSV activity from Citibank Internet Banking portal.

```
./script.rb <file.csv> [<other_file.csv>]

// OR

ls *.csv | ./script.rb 
```

## Sample Output
```
Month: 02/2015:
================================================
[IT]: $13.00
--- DRI*Adobe Sales          Shannon, Co. IE - $13.00
[FOOD]: $592.28
--- SUSHI EXPRESS - SELETAR  SINGAPORE    SG - $40.61
--- MCDONALD'S RESTAURANTS   SINGAPORE    SG - $20.10
--- SUSHI EXPRESS - SELETAR  SINGAPORE    SG - $35.31
--- WHITE BEEHOON RESTN@PU   SINGAPORE    SG - $94.16
--- PIZZA HUT - PUNGGOL SAFRASINGAPORE    SG - $48.80
[DESERT]: $0.00
[BABY_MEDICAL]: $0.00
[BABY]: $181.50
--- BABY KINGDOM (83) PTE    SINGAPORE    SG - $169.00
--- MOTHERCARE-SELETAR MAL   SINGAPORE    SG - $12.50
[BOOKS]: $22.27
--- AMAZON SERVICES-KINDLE   USD 15.99 USD 15.99 - $22.27
[ECOMMERCE]: $8.50
--- Shopee - Singapore       SINGAPORE    SG - $2.50
--- Shopee - Singapore       SINGAPORE    SG - $6.00
[MOVIES]: $0.00
[BILLS]: $0.00
[INSURANCE]: $0.00
[PETROL]: $0.00
[HOME]: $0.00
[CAR]: $90.00
--- EZ-LINK PTE LTD          SINGAPORE    SG - $30.00
--- EZ-LINK PTE LTD          SINGAPORE    SG - $30.00
--- EZ-LINK PTE LTD          SINGAPORE    SG - $30.00
[GROCERIES]: $26.60
--- SHENG SIONG - SS-1A      SINGAPORE    SG - $8.00
--- FAIRPRICE FINEST-WATER   SINGAPORE    SG - $18.60
[FASHION]: $0.00
[MISC]: $30.00
--- ACRA                     SINGAPORE    SG - $30.00
Total: $1718.06

```
