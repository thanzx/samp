


#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_timers>     
#include <YSI_Data\y_iterate>

new PlayerName[MAX_PLAYERS][30];

new Text:showboxredmoney[3];
new PlayerText:ShowPlayerRedMoney[MAX_PLAYERS][1];

hook OnGameModeInit(){

    //3DTEXT
    Create3DTextLabel("รับของเด็กใหม่ \nกด N",0x80FF00FF, 2034.9489,1538.9166,10.820, 20,0 ,0);
    
    //Pickup
    CreatePickup(1239, 23,2034.9489,1538.9166,10.8203, -0);
    
    
    Logoserver[0] = TextDrawCreate(516.000000, 425.000000, "Banana");
    TextDrawFont(Logoserver[0], 1);
    TextDrawLetterSize(Logoserver[0], 0.600000, 2.000000);
    TextDrawTextSize(Logoserver[0], 400.000000, 17.000000);
    TextDrawSetOutline(Logoserver[0], 1);
    TextDrawSetShadow(Logoserver[0], 0);
    TextDrawAlignment(Logoserver[0], 1);
    TextDrawColor(Logoserver[0], -65281);
    TextDrawBackgroundColor(Logoserver[0], 255);
    TextDrawBoxColor(Logoserver[0], -65486);
    TextDrawUseBox(Logoserver[0], 0);
    TextDrawSetProportional(Logoserver[0], 1);
    TextDrawSetSelectable(Logoserver[0], 0);
 
    Logoserver[1] = TextDrawCreate(596.000000, 426.000000, "City");
    TextDrawFont(Logoserver[1], 1);
    TextDrawLetterSize(Logoserver[1], 0.600000, 2.000000);
    TextDrawTextSize(Logoserver[1], 400.000000, 17.000000);
    TextDrawSetOutline(Logoserver[1], 1);
    TextDrawSetShadow(Logoserver[1], 0);
    TextDrawAlignment(Logoserver[1], 1);
    TextDrawColor(Logoserver[1], 852308735);
    TextDrawBackgroundColor(Logoserver[1], 255);
    TextDrawBoxColor(Logoserver[1], 50);
    TextDrawUseBox(Logoserver[1], 0);
    TextDrawSetProportional(Logoserver[1], 1);
    TextDrawSetSelectable(Logoserver[1], 0);
    
    
    
    //โชว์เงินแดง
    showboxredmoney[0] = TextDrawCreate(559.000000, 202.000000, "_");
	TextDrawFont(showboxredmoney[0], 1);
	TextDrawLetterSize(showboxredmoney[0], 0.600000, 1.300004);
	TextDrawTextSize(showboxredmoney[0], 298.500000, 75.000000);
	TextDrawSetOutline(showboxredmoney[0], 1);
	TextDrawSetShadow(showboxredmoney[0], 0);
	TextDrawAlignment(showboxredmoney[0], 2);
	TextDrawColor(showboxredmoney[0], -1);
	TextDrawBackgroundColor(showboxredmoney[0], 255);
	TextDrawBoxColor(showboxredmoney[0], 255);
	TextDrawUseBox(showboxredmoney[0], 1);
	TextDrawSetProportional(showboxredmoney[0], 1);
	TextDrawSetSelectable(showboxredmoney[0], 0);

	showboxredmoney[1] = TextDrawCreate(530.000000, 203.000000, "_");
	TextDrawFont(showboxredmoney[1], 1);
	TextDrawLetterSize(showboxredmoney[1], 0.600000, 1.100003);
	TextDrawTextSize(showboxredmoney[1], 298.500000, 14.500000);
	TextDrawSetOutline(showboxredmoney[1], 1);
	TextDrawSetShadow(showboxredmoney[1], 0);
	TextDrawAlignment(showboxredmoney[1], 2);
	TextDrawColor(showboxredmoney[1], -1);
	TextDrawBackgroundColor(showboxredmoney[1], 255);
	TextDrawBoxColor(showboxredmoney[1], -16776961);
	TextDrawUseBox(showboxredmoney[1], 1);
	TextDrawSetProportional(showboxredmoney[1], 1);
	TextDrawSetSelectable(showboxredmoney[1], 0);

	showboxredmoney[2] = TextDrawCreate(524.000000, 199.000000, "$");
	TextDrawFont(showboxredmoney[2], 2);
	TextDrawLetterSize(showboxredmoney[2], 0.504166, 1.600000);
	TextDrawTextSize(showboxredmoney[2], 400.000000, 17.000000);
	TextDrawSetOutline(showboxredmoney[2], 1);
	TextDrawSetShadow(showboxredmoney[2], 0);
	TextDrawAlignment(showboxredmoney[2], 1);
	TextDrawColor(showboxredmoney[2], -1);
	TextDrawBackgroundColor(showboxredmoney[2], 255);
	TextDrawBoxColor(showboxredmoney[2], 50);
	TextDrawUseBox(showboxredmoney[2], 0);
	TextDrawSetProportional(showboxredmoney[2], 1);
	TextDrawSetSelectable(showboxredmoney[2], 0);

	//ค่าอาหาร
    BoxFood[0] = TextDrawCreate(595.000000, 330.000000, "_");
	TextDrawFont(BoxFood[0], 1);
	TextDrawLetterSize(BoxFood[0], 0.600000, 1.100003);
	TextDrawTextSize(BoxFood[0], 298.500000, 56.500000);
	TextDrawSetOutline(BoxFood[0], 1);
	TextDrawSetShadow(BoxFood[0], 0);
	TextDrawAlignment(BoxFood[0], 2);
	TextDrawColor(BoxFood[0], -1);
	TextDrawBackgroundColor(BoxFood[0], 255);
	TextDrawBoxColor(BoxFood[0], 255);
	TextDrawUseBox(BoxFood[0], 1);
	TextDrawSetProportional(BoxFood[0], 1);
	TextDrawSetSelectable(BoxFood[0], 0);

	BoxFood[1] = TextDrawCreate(595.000000, 349.000000, "_");
	TextDrawFont(BoxFood[1], 1);
	TextDrawLetterSize(BoxFood[1], 0.600000, 1.100003);
	TextDrawTextSize(BoxFood[1], 298.500000, 56.500000);
	TextDrawSetOutline(BoxFood[1], 1);
	TextDrawSetShadow(BoxFood[1], 0);
	TextDrawAlignment(BoxFood[1], 2);
	TextDrawColor(BoxFood[1], -1);
	TextDrawBackgroundColor(BoxFood[1], 255);
	TextDrawBoxColor(BoxFood[1], 255);
	TextDrawUseBox(BoxFood[1], 1);
	TextDrawSetProportional(BoxFood[1], 1);
	TextDrawSetSelectable(BoxFood[1], 0);

	BoxFood[2] = TextDrawCreate(577.000000, 332.000000, "_");
	TextDrawFont(BoxFood[2], 2);
	TextDrawLetterSize(BoxFood[2], 0.600000, 0.750002);
	TextDrawTextSize(BoxFood[2], 298.500000, 17.000000);
	TextDrawSetOutline(BoxFood[2], 1);
	TextDrawSetShadow(BoxFood[2], 0);
	TextDrawAlignment(BoxFood[2], 2);
	TextDrawColor(BoxFood[2], -1);
	TextDrawBackgroundColor(BoxFood[2], 255);
	TextDrawBoxColor(BoxFood[2], -16776961);
	TextDrawUseBox(BoxFood[2], 1);
	TextDrawSetProportional(BoxFood[2], 1);
	TextDrawSetSelectable(BoxFood[2], 0);

	BoxFood[3] = TextDrawCreate(577.000000, 350.000000, "_");
	TextDrawFont(BoxFood[3], 2);
	TextDrawLetterSize(BoxFood[3], 0.600000, 0.750002);
	TextDrawTextSize(BoxFood[3], 298.500000, 17.000000);
	TextDrawSetOutline(BoxFood[3], 1);
	TextDrawSetShadow(BoxFood[3], 0);
	TextDrawAlignment(BoxFood[3], 2);
	TextDrawColor(BoxFood[3], -1);
	TextDrawBackgroundColor(BoxFood[3], 255);
	TextDrawBoxColor(BoxFood[3], -16776961);
	TextDrawUseBox(BoxFood[3], 1);
	TextDrawSetProportional(BoxFood[3], 1);
	TextDrawSetSelectable(BoxFood[3], 0);

	BoxFood[4] = TextDrawCreate(570.000000, 329.000000, "HUD:radar_diner");
	TextDrawFont(BoxFood[4], 4);
	TextDrawLetterSize(BoxFood[4], 0.600000, 2.000000);
	TextDrawTextSize(BoxFood[4], 13.000000, 10.500000);
	TextDrawSetOutline(BoxFood[4], 1);
	TextDrawSetShadow(BoxFood[4], 0);
	TextDrawAlignment(BoxFood[4], 1);
	TextDrawColor(BoxFood[4], -1);
	TextDrawBackgroundColor(BoxFood[4], 255);
	TextDrawBoxColor(BoxFood[4], 50);
	TextDrawUseBox(BoxFood[4], 1);
	TextDrawSetProportional(BoxFood[4], 1);
	TextDrawSetSelectable(BoxFood[4], 0);

	BoxFood[5] = TextDrawCreate(570.000000, 348.000000, "HUD:radar_datedrink");
	TextDrawFont(BoxFood[5], 4);
	TextDrawLetterSize(BoxFood[5], 0.600000, 2.000000);
	TextDrawTextSize(BoxFood[5], 13.000000, 10.500000);
	TextDrawSetOutline(BoxFood[5], 1);
	TextDrawSetShadow(BoxFood[5], 0);
	TextDrawAlignment(BoxFood[5], 1);
	TextDrawColor(BoxFood[5], -1);
	TextDrawBackgroundColor(BoxFood[5], 255);
	TextDrawBoxColor(BoxFood[5], 50);
	TextDrawUseBox(BoxFood[5], 1);
	TextDrawSetProportional(BoxFood[5], 1);
	TextDrawSetSelectable(BoxFood[5], 0);
    return 1;
}
public OnGameModeExit(){
    
    TextDrawDestroy(Logoserver[0]);
    TextDrawDestroy(Logoserver[1]);
    return 1;
}
 
public OnPlayerConnect(playerid){
 
    ShowPlayerTextDraw(playerid);
    new query[140];
    GetPlayerName(playerid, PlayerName[playerid], 30); 
    mysql_format(Database, query, sizeof(query), "SELECT `Password`, `ID` FROM `players` WHERE `Username` = '%e' LIMIT 0, 1", PlayerName[playerid]); // We are selecting the password and the ID from the player's name
    mysql_tquery(Database, query, "CheckPlayer", "i", playerid);
 
    playerData[playerid][Money] = 0;
    PlayerSaveTime[playerid] = 0;
    playerData[playerid][pAdmin] = 0;
    playerData[playerid][pModel] = 0;
    playerData[playerid][MaxItem] = 10;
	playerData[playerid][ItemAmount] = 20;
	playerData[playerid][ItemSelect] = 0;
	playerData[playerid][ItemOfferID] = INVALID_PLAYER_ID;
    CheckLogin[playerid] = 0;
    return 1;
}
 
 
 
stock ShowPlayerTextDraw(playerid){
 
    PlayerTextDrawHide(playerid, Showmoney[playerid][0]);
    
    Showmoney[playerid][0] = CreatePlayerTextDraw(playerid, 552.000000, 103.000000, "$00000000");
    PlayerTextDrawFont(playerid, Showmoney[playerid][0], 3);
    PlayerTextDrawLetterSize(playerid, Showmoney[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, Showmoney[playerid][0], 450.500000, 118.500000);
    PlayerTextDrawSetOutline(playerid, Showmoney[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, Showmoney[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, Showmoney[playerid][0], 2);
    PlayerTextDrawColor(playerid, Showmoney[playerid][0], 16777215);
    PlayerTextDrawBackgroundColor(playerid, Showmoney[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, Showmoney[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, Showmoney[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, Showmoney[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, Showmoney[playerid][0], 0);
 
 
 	//โชว์Textเงินแดง
 	ShowPlayerRedMoney[playerid][0] = CreatePlayerTextDraw(playerid, 547.000000, 200.000000, "9999999");
	PlayerTextDrawFont(playerid, ShowPlayerRedMoney[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, ShowPlayerRedMoney[playerid][0], 0.245832, 1.449998);
	PlayerTextDrawTextSize(playerid, ShowPlayerRedMoney[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ShowPlayerRedMoney[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, ShowPlayerRedMoney[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, ShowPlayerRedMoney[playerid][0], 1);
	PlayerTextDrawColor(playerid, ShowPlayerRedMoney[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, ShowPlayerRedMoney[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, ShowPlayerRedMoney[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, ShowPlayerRedMoney[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, ShowPlayerRedMoney[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, ShowPlayerRedMoney[playerid][0], 0);


	//ค่าอาหาร
	vaulFood[playerid][0] = CreatePlayerTextDraw(playerid, 618.000000, 326.000000, "100%");
	PlayerTextDrawFont(playerid, vaulFood[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, vaulFood[playerid][0], 0.220833, 1.649999);
	PlayerTextDrawTextSize(playerid, vaulFood[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, vaulFood[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, vaulFood[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, vaulFood[playerid][0], 3);
	PlayerTextDrawColor(playerid, vaulFood[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, vaulFood[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, vaulFood[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, vaulFood[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, vaulFood[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, vaulFood[playerid][0], 0);

	vaulFood[playerid][1] = CreatePlayerTextDraw(playerid, 618.000000, 345.000000, "100%");
	PlayerTextDrawFont(playerid, vaulFood[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, vaulFood[playerid][1], 0.220833, 1.649999);
	PlayerTextDrawTextSize(playerid, vaulFood[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, vaulFood[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, vaulFood[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, vaulFood[playerid][1], 3);
	PlayerTextDrawColor(playerid, vaulFood[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, vaulFood[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, vaulFood[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, vaulFood[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, vaulFood[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, vaulFood[playerid][1], 0);
    return 1;
}
 
public OnPlayerDisconnect(playerid, reason){
 
    new query[2566];
    if(CheckLogin[playerid] == 1){
        GetPlayerPos(playerid, playerData[playerid][PosX],playerData[playerid][PosY],playerData[playerid][PosZ]);
        GetPlayerFacingAngle(playerid, playerData[playerid][PosA]);
 
        mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `PosX` = '%f',`PosY` = '%f',`PosZ` = '%f',`PosA` = '%f' WHERE `ID` = '%d'",
        playerData[playerid][PosX],playerData[playerid][PosY],playerData[playerid][PosZ],playerData[playerid][PosA],playerData[playerid][ID]);
        mysql_tquery(Database, query); 
        SavePlayer(playerid);
    }
    
    

    return 1;
}
public OnPlayerSpawn(playerid)
{
    TextDrawShowForPlayer(playerid, Logoserver[0]);
    TextDrawShowForPlayer(playerid, Logoserver[1]);
    PlayerTextDrawShow(playerid, Showmoney[playerid][0]);
    
    
    //โชว์เฃินแดง
    TextDrawShowForPlayer(playerid, showboxredmoney[0]);
	TextDrawShowForPlayer(playerid, showboxredmoney[1]);
	TextDrawShowForPlayer(playerid, showboxredmoney[2]);
    PlayerTextDrawShow(playerid, ShowPlayerRedMoney[playerid][0]);
    
    //ค่าอาหาร
    PlayerTextDrawShow(playerid, vaulFood[playerid][0]);
	PlayerTextDrawShow(playerid, vaulFood[playerid][1]);

	for(new i = 0; i <6; i++) TextDrawShowForPlayer(playerid, BoxFood[i]);
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    SetPlayerSkin(playerid, playerData[playerid][pModel]);
    SetPlayerPos(playerid,playerData[playerid][PosX],playerData[playerid][PosY],playerData[playerid][PosZ]);
    SetPlayerFacingAngle(playerid, playerData[playerid][PosA]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
     
    return 1;
}
forward CheckPlayer(playerid);
public CheckPlayer(playerid){
    new rows, string[150];
    cache_get_row_count(rows);
    if(rows) {
        cache_get_value_name(0, "Password", playerData[playerid][Password], 129);
        cache_get_value_name_int(0, "ID", playerData[playerid][ID]);
        format(string, sizeof(string), "{FFFFFF}คุณมีบัญชีในเซิร์ฟเวอร์แล้ว\n\nกรุณาใส่รหัสผ่านด้านล่าง\nเพื่อทำการล้อกอินเข้าสู่เซิร์ฟเวอร์");
        Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "({FFFFFF}{00FF13}ล็อกอิน{00FF13}{FFFFFF})", string, "ล็อกอิน", "");
    }
    else {
        format(string, sizeof(string), "{FFFFFF}คุณยังไม่มีบัญชีในเซิร์ฟเวอร์\n\nกรุณาใส่รหัสผ่านด้านล่าง\nเพื่อทำการสมัครสมาชิก ในเซิร์ฟเวอร์");
        Dialog_Show(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "({FFFFFF}{FF0000}สมัคร{FF0000}{FFFFFF})", string, "สมัคร", "");
    }
    return 1;
}
 
//--> ล็อกอิน
Dialog:DIALOG_LOGIN(playerid, response, listitem, inputtext[]){
    if(!response)
        return Kick(playerid); 
    new query[100];
    if(!strcmp(inputtext, playerData[playerid][Password])) {
        mysql_format(Database, query, sizeof(query), "SELECT * FROM `players` WHERE `Username` = '%e' LIMIT 0, 1", PlayerName[playerid]);
        mysql_tquery(Database, query, "LoadPlayer", "i", playerid);
        CheckLogin[playerid] = true;
    }
    else {
        Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "{FF0000}Wrong Password!\n{FFFFFF}Type your correct password below to continue and sign in to your account", "Login", "Exit");
        
    }
    return 1;
}
 
//--> สมัคร
Dialog:DIALOG_REGISTER(playerid, response, listitem, inputtext[]){
    if(!response)
        return Kick(playerid);
    if(strlen(inputtext) < 3){
       SendClientMessage(playerid, 0xFF0000, "คุณใส่รหัสผ่านผิด ห้ามใส่ผิดเกิน 3 รอบ");
       return CheckPlayer(playerid);
    }
    new query[300];
    format(playerData[playerid][Password], 64, inputtext);
    mysql_format(Database, query, sizeof(query), "INSERT INTO `players` (`Username`, `Password`, `Money`, `Admins`, `model`,`PosX`,`PosY`,`PosZ`,`PosA`,`maxitem`,itemamount) VALUES ('%e','%e', 1000, 0, 22, 2003.3595,1543.9191,13.5859,274.7725,10,50)", PlayerName[playerid], playerData[playerid][Password]);
    mysql_pquery(Database, query, "RegisterPlayer", "i", playerid);
    return 1;
}
 

 
forward SavePlayer(playerid);
public SavePlayer(playerid){
    new query[2048];
    
    mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `Money` = '%d',`Admins` = '%d',`Model` = '%d' WHERE `ID` = '%d'",
    playerData[playerid][Money],
    playerData[playerid][pAdmin],
    playerData[playerid][pModel],
    playerData[playerid][ID]);
    mysql_tquery(Database, query); 
 
    return 1;
}
 
//--> เวลาผู้เล่นสมัครสมาชิกมาเสร็จ
forward RegisterPlayer(playerid);
public RegisterPlayer(playerid){
    new string[150];
    playerData[playerid][ID] = cache_insert_id();
    printf("ID ใหม่ได้สมัครเข้ามาแล้ว SQL ID : %d", playerData[playerid][ID]);
    cache_get_value_name(0, "Password", playerData[playerid][Password], 129);
    cache_get_value_name_int(0, "ID", playerData[playerid][ID]);
    format(string, sizeof(string), "{FFFFFF}คุณมีบัญชีในเซิร์ฟเวอร์แล้ว\n\nกรุณาใส่รหัสผ่านด้านล่าง\nเพื่อทำการล้อกอินเข้าสู่เซิร์ฟเวอร์");
    Dialog_Show(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "({FFFFFF}{00FF13}ล็อกอิน{00FF13}{FFFFFF})", string, "ล็อกอิน", "");
    return 1;
}
 
stock UpdatePlayer(playerid, const field_name[], const set[], const type[])
{
    new query[256];
    if(!strcmp(type, "d", true))
    {
        mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `%s` = '%d' WHERE `ID` = '%d'",field_name,set, playerData[playerid][ID]);
    
    }
    else if(!strcmp(type, "s", true))
    {
        mysql_format(Database, query, sizeof(query), "UPDATE `players` SET `%s` = '%s' WHERE `ID` = '%d'",field_name,set, playerData[playerid][ID]);
    }
    mysql_tquery(Database, query);
}
 
 
 
 
 
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (PRESSED(KEY_NO))
    {
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
    }
    return 1;
}
 
public OnPlayerUpdate(playerid){
 
    new string[256];
    
    format(string, 256, "$%d", playerData[playerid][Money]);
    PlayerTextDrawSetString(playerid, Showmoney[playerid][0], string);
    
    //โชว์เงิน
    format(string, 256, "%d", playerData[playerid][pRedMoney]);
    PlayerTextDrawSetString(playerid, ShowPlayerRedMoney[playerid][0], string);

    if(playerData[playerid][pHungry] <= 0) playerData[playerid][pHungry] = 0.0;
    if(playerData[playerid][pWater] <= 0) playerData[playerid][pWater] = 0.0;

	format(string, sizeof(string), "%.1f", playerData[playerid][pHungry]);
	PlayerTextDrawSetString(playerid, vaulFood[playerid][0], string);
	
	format(string, sizeof(string), "%.1f", playerData[playerid][pWater]);
	PlayerTextDrawSetString(playerid, vaulFood[playerid][1], string);

    return 1;
}




















