#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>


forward LoadPlayer(playerid);
public LoadPlayer(playerid){
    
    
    cache_get_value_name_int(0, "Money", playerData[playerid][Money]);
    GivePlayerMoney(playerid, playerData[playerid][Money]);
    cache_get_value_name_int(0, "Admins", playerData[playerid][pAdmin]);
    cache_get_value_name_int(0, "Model",playerData[playerid][pModel]);
 
    cache_get_value_name_float(0, "PosX",playerData[playerid][PosX]);
    cache_get_value_name_float(0, "PosY",playerData[playerid][PosY]);
    cache_get_value_name_float(0, "PosZ",playerData[playerid][PosZ]);
    cache_get_value_name_float(0, "PosA",playerData[playerid][PosA]);
    
    cache_get_value_name_int(0, "Login",playerData[playerid][pLogin]);
    cache_get_value_name_int(0, "RedMoney",playerData[playerid][pRedMoney]);
    
    cache_get_value_name_float(0, "Hungry",playerData[playerid][pHungry]);
    cache_get_value_name_float(0, "Water",playerData[playerid][pWater]);
    cache_get_value_name_int(0, "maxitem",playerData[playerid][MaxItem]);
    cache_get_value_name_int(0, "itemamount",playerData[playerid][ItemAmount]);
    new query[256];
    mysql_format(Database, query, sizeof(query), "SELECT * FROM `Inventory` WHERE `invOwner` = '%d'", playerData[playerid][ID]);
	mysql_tquery(Database, query, "Inventory_Load", "d", playerid);

    PlayerSaveTime[playerid] = 1;
    SpawnPlayer(playerid);
    return 1;
}
 
 
SetupPlayerTable()
{
    mysql_tquery(Database, "\n\
    CREATE TABLE IF NOT EXISTS `players`\n\
    (`ID` int(11) NOT NULL AUTO_INCREMENT,\n\
    `Username` varchar(64) NOT NULL,\n\
    `Password` char(128) NOT NULL,\n\
    `Money` int(11) NOT NULL DEFAULT '0',\n\
    `Admins` int(11) NOT NULL DEFAULT '0',\n\
    `Model` int(11) NOT NULL DEFAULT '0',\n\
    `PosX` float NOT NULL DEFAULT '0',\n\
    `PosY` float NOT NULL DEFAULT '0',\n\
    `PosZ` float NOT NULL DEFAULT '0',\n\
    `PosA` float NOT NULL DEFAULT '0',\n\
    `Login` int(11) NOT NULL DEFAULT '0',\n\
    `pLevel` int(11) NOT NULL DEFAULT '0',\n\
    `RedMoeny` int(11) NOT NULL DEFAULT '0',\n\
    `Hungry` float NOT NULL DEFAULT '0',\n\
    `Water` float NOT NULL DEFAULT '0',\n\
    `maxitem` float NOT NULL DEFAULT '0',\n\
    `itemamount` float NOT NULL DEFAULT '0',\n\
    PRIMARY KEY (`ID`), UNIQUE KEY `Username` (`Username`))");
    return 1;
}
