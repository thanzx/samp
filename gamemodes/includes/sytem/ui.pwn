#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>


ptask TImerFood[120*1000](playerid) 
{
    new Float:health;
    GetPlayerHealth(playerid, health);
    if(IsPlayerConnected(playerid)){

        if(playerData[playerid][pHungry] <= 40){
            SetPlayerHealth(playerid, health - 5.0);
            SendClientMessage(playerid, -1, "[ระบบ]: คุณมีค่าอาหารต่ำกว่า 40%");
        }
        if(playerData[playerid][pWater] <= 20){
            SendClientMessage(playerid, -1, "[ระบบ]: คุณมีค่าอาหารต่ำกว่า 20%");
            SetPlayerHealth(playerid, health - 2.5);
        }
        playerData[playerid][pHungry] -= 5.0;
        playerData[playerid][pWater] -= 10.0;
        UpdateFood(playerid);
    }
    else{
        SendClientMessage(playerid, -1, "คุณยังไม่ได้ล็อกอิน ค่าน้ำอาหารคุณจะไม่ลด");
    }
    return 1;
}