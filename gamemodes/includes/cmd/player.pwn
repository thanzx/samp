
#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>
CMD:login(playerid){
 
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 2034.9489,1538.9166,10.8203)){
 
        if (!IsPlayerInAnyVehicle(playerid))
        {
            if(playerData[playerid][pLogin] == 1) return SendClientMessage(playerid, -1, "คุณได้รับของเด็กใหม่ไปแล้ว..");
            new ran = random(4);
            if(ran == 0){
 
                playerData[playerid][pLogin] = 1;
                SetPlayerSkin(playerid, 22);
                playerData[playerid][pModel] = 22;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                UpdatePlayer(playerid, "Model", playerData[playerid][pModel],"d");
                SendClientMessage(playerid, -1, "คุณได้รับ สกิน 22 แล้ว ....");
                return 1;
            }
            if(ran == 1){
 
                playerData[playerid][pLogin] = 1;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                SendClientMessage(playerid, -1, "คุณได้ไม่ได้รับอะไรเลย ....");
            }
            if(ran == 2){
 
                playerData[playerid][pLogin] = 1;
                GivePlayerMoney(playerid, 5000);
                playerData[playerid][Money] += 5000;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                UpdatePlayer(playerid, "Money", playerData[playerid][Money],"d");
                SendClientMessage(playerid, -1, "คุณได้รับ เงิน จำนวน  5000 บาท  แล้ว ....");
            }
            if(ran == 3){
                playerData[playerid][pLogin] = 1;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                SendClientMessage(playerid, -1, "คุณได้ไม่ได้รับอะไรเลย ....");
            }
            return 1;
        }
        else{
 
            SendClientMessage(playerid, -1, "คุณต้องไม่อยู่บนรถ...");
        }
    }
    return 1;
}
 
 
CMD:givemoeny(playerid, params[]){
 
    new id, amont, str[256];
    
    if(sscanf(params,"id", id, amont)) return SendClientMessage(playerid, -1, "[วิธีใช้คำสั่ง] /giveitemmoney [ID] [amont]");
    
    if(IsPlayerConnected(id)){
    
        playerData[id][Money] += amont;
        GivePlayerMoney(id, amont);
        UpdatePlayer(playerid, "Money", playerData[playerid][Money],"d");
        
        format(str, 256, "คุณ%s ได้เสกเงินจำนวน  %d บาท ให้กับ %s",ReturnPlayerName(playerid), amont, ReturnPlayerName(id));
        
        SendClientMessage(playerid, -1, str);
        
        format(str, 256, "คุณ%s ได้รับเงินจำนวน  %d บาท จาก %s",ReturnPlayerName(id), amont, ReturnPlayerName(playerid));
        SendClientMessage(playerid, -1, str);
    }
    else {
        SendClientMessage(playerid, -1, "ผู้เล่นคนนี้ไม่ได้ออนไลน์");
    }
    return 1;
}
 
 
CMD:givelevel(playerid, params[]){
    
//วิธีการทำ Setค่า
    new id, amont, str[256];
    
    if(sscanf(params,"id", id, amont)) return SendClientMessage(playerid, -1, "[วิธีใช้คำสั่ง] /giveitemmoney [ID] [amont]");
    
    if(IsPlayerConnected(id)){ //ส่วนตัวนี้เอาไว้เซ็ตว่ามีใครออน ถ้าไม่มีออนก็จะขึ้น ผู้เล่นคนนี้ไม่ได้ออนไลน์
    
        playerData[id][pLevel] += amont; //ตัวนี้เอาไว้ Set ค่า
        UpdatePlayer(playerid, "Level", playerData[playerid][pLevel],"d");// ส่วนตัวนี้เอาไว้อัพเดทค่า
        
        format(str, 256, "คุณ%s ได้เสก Level จำนวน  %d เวล ให้กับ %s",ReturnPlayerName(playerid), amont, ReturnPlayerName(id));
        
        SendClientMessage(playerid, -1, str);
        
        format(str, 256, "คุณ%s ได้รับ Level จำนวน  %d บาท จาก แอดมิน %s",ReturnPlayerName(id), amont, ReturnPlayerName(playerid));
        SendClientMessage(playerid, -1, str);
    }
    else {
        SendClientMessage(playerid, -1, "ผู้เล่นคนนี้ไม่ได้ออนไลน์");
    }
    return 1;
 
}



CMD:giveredmoney(playerid, params[]){

	new userid, ammo, str[256];
	if(playerData[playerid][pAdmin] <5) return SendClientMessage(playerid, -1, "คุณไม่ใช่แอดมิน");
	if(sscanf(params, "dd", userid,ammo)) return SendClientMessage(playerid, -1, "[วิธีใช้คำสั่ง] /giveredmoney [ID] [amont]");
	if(IsPlayerConnected(userid)){

		playerData[userid][pRedMoney] += ammo;
		UpdatePlayer(userid, "Redmoney", playerData[userid][pRedMoney],"d");
		format(str, 256, "คุณ%s ได้เสก เงิน จำนวน  %d  ให้กับ %s",ReturnPlayerName(playerid), ammo, ReturnPlayerName(userid));

        SendClientMessage(playerid, -1, str);
		return 1;
	}

	else{
	    SendClientMessage(playerid, -1, "ไอดีนี้ยังไม่ได้ออนไลน์");
	}
	return 1;
}


CMD:givefood(playerid, params[]){


	new userid, type, amont, string[256];
	if(sscanf(params, "ddd", userid, type, amont)) return SendClientMessage(playerid, -1, "[วิธีใช้คำสั่ง] /giveredmoney [ID] [type] [amont]");

	if(IsPlayerConnected(userid)){
	
	    switch(type){
	    
	        case 1:{//ค่าอาหาร
	        
				playerData[userid][pHungry] = amont;
				format(string, sizeof(string), "คุณ: %s ได้ทำการปรับค่าอาหารให้กับ %s จำนวน %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "คุณ: %s ได้ทำการปรับค่าอาหารให้กับ %s จำนวน %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(userid, -1, string);
                UpdateFood(playerid);
			}
			case 2:{//ค่าน้ำ
			
				playerData[userid][pWater] = amont;
				format(string, sizeof(string), "คุณ: %s ได้ทำการปรับค่าน้ำให้กับ %s จำนวน %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "คุณ: %s ได้ทำการปรับค่าน้ำให้กับ %s จำนวน %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(userid, -1, string);
                UpdateFood(playerid);
			}
	    }
	}
	else SendClientMessage(playerid, -1, "ไอดีนี้ยังไม่ได้ออนไลน์");
	return 1;
}



forward UpdateFood(playerid);
public UpdateFood(playerid){

	new query[256];
    mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `Hungry` = '%f',`Water` = '%f' WHERE `ID` = %d",
    playerData[playerid][pHungry],playerData[playerid][pWater],playerData[playerid][ID]);
    mysql_tquery(Database, query);
	return 1;
}










