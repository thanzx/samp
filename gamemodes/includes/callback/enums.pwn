


#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>

new CheckLogin[MAX_PLAYERS];
new PlayerSaveTime[MAX_PLAYERS];
//Logoserver & TextDraw ForPlayer
new Text:Logoserver[2];
new PlayerText:Showmoney[MAX_PLAYERS][1];

//ค่าอาหาร
new Text:BoxFood[6];
new PlayerText:vaulFood[MAX_PLAYERS][2];

//นี่คือแปรของตัว
 
enum PlayerData 
{
    ID,
    Password[129],
    pAdmin,
    Money,
    pModel,
    Float:PosX,
    Float:PosY,
    Float:PosZ,
    Float:PosA,
    pLogin,
    pLevel,
    pRedMoney,
    Float:pHungry,
    Float:pWater,
    MaxItem,
    ItemSelect,
    ItemOfferID,
    ItemAmount,
};
 
new playerData[MAX_PLAYERS][PlayerData];















