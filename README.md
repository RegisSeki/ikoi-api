# Lemoney
Code challenge

## Ruby Version
2.6.4

## Rails Version
6.0.3.2

## Postgres
PostgreSQL 10.12

### Propose
This project is a code challenge from Lemoney.
Following the specifications at INSTRUCTIONS.pdf file that are not here, because contain restrict informations. Ask for Lemoney tech team member of the file.

###  Solution
The project is an REST API to register offers that are coming from especified advertiser.
This offers are for the user can buy products and earn lemoney cashback :).

The solution was separeted on 2 modules:
* ***Admin Interface***
* ***User interface***

### Admin Interface
In this module the administrator have to control the Advertisers and Offers.

#### Advertiser routes

***Register a new Advertiser***
* ***POST*** /api/v1/admin/advertisers

  * ***payload_example:***```{"name":"advertiser_name", "url":"https://advertiser-name.com"}```
  * ***needed_parameters:*** name, url
  * ***parameters_validation:*** name: unique, url: should be a valid url

***Retrieve all the Advertisers***
* ***GET*** /api/v1/admin/advertisers

***Retrieve a single Advertiser***
* ***GET*** /api/v1/admin/advertisers/id

  * ***needed_parameters:*** id
  * ***parameters_validation:*** id: must exist

***Update an Advertiser***
* ***PUT*** /api/v1/admin/advertisers/advertiser_id

  * ***payload_example:***```{"name":"advertiser_name_updated", "url":"https://advertiser-name_updated.com"}```
  * ***needed_parameters:*** id
  * ***parameters_validation:*** advertiser_id: should exist, name: unique, url: should be a valid url

#### Offer routes

***Register a new Offer***
* ***POST*** /api/v1/admin/offers

  * ***payload_example:***```{"advertiser_id":"advertiser_id", "url":"https://offer.com", "description":"Any", "starts_at":"2020-07-26 00:00:00", "ends_at":"2020-08-26", "premium":"true"}```
  * ***needed_parameters:*** advertiser_id, url, description, starts_at
  * ***optional_parameters:*** ends_at (define the day that this offer will end), premium (appear first at user list ordering)
  * ***parameters_validation:*** advertiser_id: should exist, url: should be a valid url, description: less than 500 characteres, starts_at: yyyy-mm-dd hh:mm:ss

***Retrieve all the Offers***
* ***GET*** /api/v1/admin/offers

***Update a new Offer***
* ***PUT*** /api/v1/admin/offers/offer_id

  * ***payload_example:***```{"url":"https://offer-updated.com", "description":"Any updated", "starts_at":"2020-07-26 00:00:00", "ends_at":"2020-08-26", "premium":"true"}```
  * ***needed_parameters:*** advertiser_id
  * ***optional_parameters:*** ends_at (define the day that this offer will end), premium (appear first at user list ordering)
  * ***parameters_validation:*** advertiser_id: should exist, url: should be a valid url, description: less than 500 characteres, starts_at: yyyy-mm-dd hh:mm:ss

***Delete an Offer***
* ***DELETE*** /api/v1/admin/offers/id
  * ***needed_parameters:*** offer_id
  * ***parameters_validation:*** offer_id: should exist

### User Interface

#### Offer route

***Retrieve all enabled Offers***
* ***GET*** /api/v1/offers

### About the rules to an offer to be showed at the user offer list
*extracted from the INSTRUCTIONS.pdf*

1. when created, state = disabled
2. when current time ≥ starts at, state = enabled
3. when current time ≤ ends at, state = disabled
4. when ends at is blank it is never disabled
5. when the admin clicks on ’disable’ it should become disabled regardless
of time
6. You should only list active offers (state=enabled). Premium offers should ap-
pear on top.

To solve this rules the trick is at starts_at, ands_at and premium offers values

1. To enable an offer the starts_at should be less than the time at the server at the moment of the request and the ends_at should be greater; The administrator have to control enabled and disabled offers by this 2 rules. To do that just update the offer with the proper date and time at starts_at and ends_at.
2. If it have no ends_at and the starts_at is less than the server request time, this offer will always appear.
3. When the premium value is true, the offer will always appear on the top.

### Installation
#### To run the project locally:
- Install the apropriate Ruby version
- Clone the project
- Bundle install run ```bundle install```
- Run the migration run ```rails db:migrate```
- Up the server run ```rails server```
- Enjoy the features

##### To Run the tests RSPEC
At the project folder run ```rspec```

This project is hosted at heroku on https://rts-lemoney-api.herokuapp.com/ .
All the get routes are free to access, the others need the login and password.
Fell free to use all the get routes, if necessary ask the keys to me on regis.seki@gmail.com.

Made by [Regis Seki](https://github.com/RegisSeki)
Last updated: July 2020

