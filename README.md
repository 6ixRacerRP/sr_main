# sr_main
sr_main is a mini framework using the FiveM framework to deliver a racing roleplay server. Currently complete with:

* A user interface using the Chromium Embedded Framework that allows for players to create, load and delete characters.
* Queries and inserts to an SQL database to save character attributes such as *name, appearance, and money".
* Ties each character to a steamid in the database for concurrent use by a steam account.

Instructions for starting your own local server are here: https://docs.fivem.net/docs/server-manual/setting-up-a-server/

To get sr_main running on your server, add `ensure sr_main` to your server.cfg and clone this repository to your `server-data/resources/` folder.
