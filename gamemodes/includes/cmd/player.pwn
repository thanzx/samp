
#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>
CMD:login(playerid){
 
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 2034.9489,1538.9166,10.8203)){
 
        if (!IsPlayerInAnyVehicle(playerid))
        {
            if(playerData[playerid][pLogin] == 1) return SendClientMessage(playerid, -1, "�س���Ѻ�ͧ�����������..");
            new ran = random(4);
            if(ran == 0){
 
                playerData[playerid][pLogin] = 1;
                SetPlayerSkin(playerid, 22);
                playerData[playerid][pModel] = 22;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                UpdatePlayer(playerid, "Model", playerData[playerid][pModel],"d");
                SendClientMessage(playerid, -1, "�س���Ѻ ʡԹ 22 ���� ....");
                return 1;
            }
            if(ran == 1){
 
                playerData[playerid][pLogin] = 1;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                SendClientMessage(playerid, -1, "�س��������Ѻ������� ....");
            }
            if(ran == 2){
 
                playerData[playerid][pLogin] = 1;
                GivePlayerMoney(playerid, 5000);
                playerData[playerid][Money] += 5000;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                UpdatePlayer(playerid, "Money", playerData[playerid][Money],"d");
                SendClientMessage(playerid, -1, "�س���Ѻ �Թ �ӹǹ  5000 �ҷ  ���� ....");
            }
            if(ran == 3){
                playerData[playerid][pLogin] = 1;
                UpdatePlayer(playerid, "Login", playerData[playerid][pLogin],"d");
                SendClientMessage(playerid, -1, "�س��������Ѻ������� ....");
            }
            return 1;
        }
        else{
 
            SendClientMessage(playerid, -1, "�س��ͧ������躹ö...");
        }
    }
    return 1;
}
 
 
CMD:givemoeny(playerid, params[]){
 
    new id, amont, str[256];
    
    if(sscanf(params,"id", id, amont)) return SendClientMessage(playerid, -1, "[�Ը�������] /giveitemmoney [ID] [amont]");
    
    if(IsPlayerConnected(id)){
    
        playerData[id][Money] += amont;
        GivePlayerMoney(id, amont);
        UpdatePlayer(playerid, "Money", playerData[playerid][Money],"d");
        
        format(str, 256, "�س%s ���ʡ�Թ�ӹǹ  %d �ҷ ���Ѻ %s",ReturnPlayerName(playerid), amont, ReturnPlayerName(id));
        
        SendClientMessage(playerid, -1, str);
        
        format(str, 256, "�س%s ���Ѻ�Թ�ӹǹ  %d �ҷ �ҡ %s",ReturnPlayerName(id), amont, ReturnPlayerName(playerid));
        SendClientMessage(playerid, -1, str);
    }
    else {
        SendClientMessage(playerid, -1, "�����蹤����������͹�Ź�");
    }
    return 1;
}
 
 
CMD:givelevel(playerid, params[]){
    
//�Ըա�÷� Set���
    new id, amont, str[256];
    
    if(sscanf(params,"id", id, amont)) return SendClientMessage(playerid, -1, "[�Ը�������] /giveitemmoney [ID] [amont]");
    
    if(IsPlayerConnected(id)){ //��ǹ��ǹ������������������͹ ���������͹��Т�� �����蹤����������͹�Ź�
    
        playerData[id][pLevel] += amont; //��ǹ�������� Set ���
        UpdatePlayer(playerid, "Level", playerData[playerid][pLevel],"d");// ��ǹ��ǹ���������Ѿഷ���
        
        format(str, 256, "�س%s ���ʡ Level �ӹǹ  %d ��� ���Ѻ %s",ReturnPlayerName(playerid), amont, ReturnPlayerName(id));
        
        SendClientMessage(playerid, -1, str);
        
        format(str, 256, "�س%s ���Ѻ Level �ӹǹ  %d �ҷ �ҡ �ʹ�Թ %s",ReturnPlayerName(id), amont, ReturnPlayerName(playerid));
        SendClientMessage(playerid, -1, str);
    }
    else {
        SendClientMessage(playerid, -1, "�����蹤����������͹�Ź�");
    }
    return 1;
 
}



CMD:giveredmoney(playerid, params[]){

	new userid, ammo, str[256];
	if(playerData[playerid][pAdmin] <5) return SendClientMessage(playerid, -1, "�س������ʹ�Թ");
	if(sscanf(params, "dd", userid,ammo)) return SendClientMessage(playerid, -1, "[�Ը�������] /giveredmoney [ID] [amont]");
	if(IsPlayerConnected(userid)){

		playerData[userid][pRedMoney] += ammo;
		UpdatePlayer(userid, "Redmoney", playerData[userid][pRedMoney],"d");
		format(str, 256, "�س%s ���ʡ �Թ �ӹǹ  %d  ���Ѻ %s",ReturnPlayerName(playerid), ammo, ReturnPlayerName(userid));

        SendClientMessage(playerid, -1, str);
		return 1;
	}

	else{
	    SendClientMessage(playerid, -1, "�ʹչ���ѧ������͹�Ź�");
	}
	return 1;
}


CMD:givefood(playerid, params[]){


	new userid, type, amont, string[256];
	if(sscanf(params, "ddd", userid, type, amont)) return SendClientMessage(playerid, -1, "[�Ը�������] /giveredmoney [ID] [type] [amont]");

	if(IsPlayerConnected(userid)){
	
	    switch(type){
	    
	        case 1:{//��������
	        
				playerData[userid][pHungry] = amont;
				format(string, sizeof(string), "�س: %s ��ӡ�û�Ѻ�����������Ѻ %s �ӹǹ %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "�س: %s ��ӡ�û�Ѻ�����������Ѻ %s �ӹǹ %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(userid, -1, string);
                UpdateFood(playerid);
			}
			case 2:{//��ҹ��
			
				playerData[userid][pWater] = amont;
				format(string, sizeof(string), "�س: %s ��ӡ�û�Ѻ��ҹ�����Ѻ %s �ӹǹ %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(playerid, -1, string);
                format(string, sizeof(string), "�س: %s ��ӡ�û�Ѻ��ҹ�����Ѻ %s �ӹǹ %d", ReturnPlayerName(playerid), ReturnPlayerName(userid), amont);
                SendClientMessage(userid, -1, string);
                UpdateFood(playerid);
			}
	    }
	}
	else SendClientMessage(playerid, -1, "�ʹչ���ѧ������͹�Ź�");
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










