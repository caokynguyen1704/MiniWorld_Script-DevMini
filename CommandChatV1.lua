-- sản phẩm thuộc về DevMini
--Không được chỉnh sửa mà ghi bất kỳ nguồn khác nào ngoài DevMini


--khi dùng script chat //help


local Chat = class.Chat.new()
local Player = class.Player.new()
local Actor = class.Actor.new()
local World = class.World.new()
on=0

function randomPlayer()
     _,id_random=World:randomOnePlayer(1)
     return id_random
end
function allPlayer(i)
     _,_,arrayID=World:getAllPlayers(-1)
     return arrayID[i]
end
function totalPlayer()
     _,total=World:getPlayerTotal(-1)
     return total
end

function command(devMW)
    _,id_host=Player:getHostUin()
    s=devMW.content
    idPlayer=devMW.eventobjid
    _,namePlayer=Player:getNickname(devMW.eventobjid)
    if devMW.eventobjid==id_host then
        if on==0 then
            Chat:sendSystemMsg("------------------------v1.0-------------------------", id_host)
            Chat:sendSystemMsg("||Bạn đang ở chế độ Command by Chat||", id_host)
            Chat:sendSystemMsg("------------------------------------------------------", id_host)
            on=1
        else
            local t = {}                   
            local i = 1
            local aa
            while 1 do
                strlen=#s
                if i==1 then
                    xuly=string.find(s, " ")
                        if xuly==nil then
                            t[i]=s
                            break
                        else
                            aa=string.sub(s, 1, xuly-1) 
                            t[1]=aa
                            s=string.sub(s, xuly+1,strlen)
                        end
                else
                    xuly=string.find(s, " ")
                    if xuly==nil then
                        t[i]=s
                        break
                    else
                        aa=string.sub(s, 1, xuly-1) 
                        t[i]=aa
                        s=string.sub(s, xuly+1,strlen)
                    end
                end
                i=i+1
            end
            
            
	        if t[1]=="//kill" then
	            if t[2]=="@s" then
	        	    Actor:killSelf(idPlayer)
	        	    Chat:sendSystemMsg("Bạn đã tự kill chính mình", id_host)
	        	elseif t[2]=="@r" then
	        	    random1=randomPlayer()
	        	    Actor:killSelf(random1)
	        	    _,name_player=Player:getNickname(random1)
	        	    Chat:sendSystemMsg("Bạn đã kill ["..name_player.."]", id_host)
	        	elseif t[2]=="@a" then
	        	    totalPlayer1=totalPlayer()
	        	    for i=1,totalPlayer1 do
	        	        Actor:killSelf(allPlayer(i))
	        	        _,name_player=Player:getNickname(allPlayer(i))
	        	        Chat:sendSystemMsg("Bạn đã kill ["..name_player.."]", id_host)
	        	    end
	        	else 
	        	    id_player=1000000000+t[2]
	        	    Actor:killSelf(id_player)
	        	    _,name_player=Player:getNickname(id_player)
	        	    Chat:sendSystemMsg("Bạn đã kill ".."["..name_player.."]", id_host)
	        	end
	        end


            if t[1]=="//cho" then
                _,nameItem=Item:getItemName(t[3])
	            if t[2]=="@s" then
	        	    Player:gainItems(idPlayer, t[3], t[4], 2)
	        	    Chat:sendSystemMsg("Bạn đã tự cho chính mình"..t[4].."x ["..nameItem.."]", id_host)
	        	elseif t[2]=="@r" then
	        	    random1=randomPlayer()
	        	    Player:gainItems(random1, t[3], t[4], 2)
	        	    _,name_player=Player:getNickname(random1)
	        	    Chat:sendSystemMsg("Bạn đã cho ["..name_player.."] "..t[4].."x ["..nameItem.."]", id_host)
	        	elseif t[2]=="@a" then
	        	    totalPlayer1=totalPlayer()
	        	    for i=1,totalPlayer1 do
	        	        Player:gainItems(allPlayer(i), t[3], t[4], 2)
	        	        _,name_player=Player:getNickname(allPlayer(i))
	        	        Chat:sendSystemMsg("Bạn đã cho ["..name_player.."] "..t[4].."x ["..nameItem.."]", id_host)
	        	    end
	        	else 
	        	    id_player=1000000000+t[2]
	        	    Player:gainItems(id_player, t[3], t[4], 2)
	        	    _,name_player=Player:getNickname(id_player)
	        	    Chat:sendSystemMsg("Bạn đã cho ["..name_player.."] "..t[4].."x ["..nameItem.."]", id_host)
	        	end
            end
        
            if t[1]=="//thongtin" then 
                totalPlayer1=totalPlayer()
                
                for i=1,totalPlayer1 do
                    _,name_player=Player:getNickname(allPlayer(i))
                    _,Hp= Actor:getHP(allPlayer(i))
                    _,x,y,z=Actor:getPosition(allPlayer(i))
                    id_player=allPlayer(i)-1000000000
                    Chat:sendSystemMsg("---["..name_player.."]---["..id_player.."]---",id_host)
                    Chat:sendSystemMsg("---[Máu] ---["..Hp.."]---",id_host)
                    Chat:sendSystemMsg("---[Vị Trí] ---["..x.."]["..y.."]["..z.."]",id_host)
                    Chat:sendSystemMsg("----------------------------------------",id_host)
                end
            end
            
            if t[1]=="//dichchuyen" then
                if t[3]=="@s" then 
                    _,x,y,z=Actor:getPosition(idPlayer)
                    t[3]=x+0.5
                    t[4]=y+0.5
                    t[5]=z+0.5
                elseif t[3]=="@r" then
                    random1=randomPlayer()
                    _,x,y,z=Actor:getPosition(random1)
                    t[3]=x+0.5
                    t[4]=y+0.5
                    t[5]=z+0.5
                end
                if t[2]=="@s" then
	        	    Actor:setPosition(idPlayer, t[3], t[4], t[5])
	        	    Chat:sendSystemMsg("Bạn đã tự dịch chuyển mình", id_host)
	        	elseif t[2]=="@r" then
	        	    random1=randomPlayer()
	        	    Actor:setPosition(random1, t[3], t[4], t[5])
	        	    _,name_player=Player:getNickname(random1)
	        	    Chat:sendSystemMsg("Bạn đã dịch chuyển ["..name_player.."]", id_host)
	        	elseif t[2]=="@a" then
	        	    totalPlayer1=totalPlayer()
	        	    for i=1,totalPlayer1 do
	        	        Actor:setPosition(allPlayer(i), t[3], t[4], t[5])
	        	        _,name_player=Player:getNickname(allPlayer(i))
	        	        Chat:sendSystemMsg("Bạn đã dịch chuyển ["..name_player.."]", id_host)
	        	    end
	        	else 
	        	    id_player=1000000000+t[2]
	        	    Actor:setPosition(id_player, t[3], t[4], t[5])
	        	    _,name_player=Player:getNickname(id_player)
	        	    Chat:sendSystemMsg("Bạn đã dịch chuyển ["..name_player.."]", id_host)
	        	end
            end
        	
        	if t[1]=="//traid" then
        	    _,nameItem=Item:getItemName(t[2])
        	    Chat:sendSystemMsg("Vật phẩm mang id ["..t[2].."] là ["..nameItem.."]", id_host)
        	end
            
            if t[1]=="//summon" then
                if t[3]=="@s" then 
                    _,x,y,z=Actor:getPosition(idPlayer)
                    t[3]=x+0.5
                    t[4]=y+0.5
                    t[5]=z+0.5
                elseif t[3]=="@r" then
                    random1=randomPlayer()
                    _,x,y,z=Actor:getPosition(random1)
                    t[3]=x+0.5
                    t[4]=y+0.5
                    t[5]=z+0.5
                end
                World:spawnCreature(t[3], t[4], t[5], t[2], 1)
                Chat:sendSystemMsg("Đã triệu hồi", id_host)
            end
            
            if t[1]=="//effect" then
                if t[2]=="@s" then
	        	    Actor:addBuff(idPlayer, t[3], t[4], t[5])
	        	    Chat:sendSystemMsg("Bạn đã nhận hiệu ứng trong "..t[5].."mili giây", id_host)
	        	elseif t[2]=="@r" then
	        	    random1=randomPlayer()
	        	    _,name_player=Player:getNickname(random1)
	        	    Actor:addBuff(random1, t[3], t[4], t[5])
	        	    Chat:sendSystemMsg(name.." đã nhận hiệu ứng trong "..t[5].."mili giây", id_host)
	        	elseif t[2]=="@a" then
	        	    totalPlayer1=totalPlayer()
	        	    for i=1,totalPlayer1 do
	        	        _,name_player=Player:getNickname(allPlayer(i))
	        	        Actor:addBuff(allPlayer(i), t[3], t[4], t[5])
	        	        Chat:sendSystemMsg(name.." đã nhận hiệu ứng trong "..t[5].."mili giây", id_host)
	        	    end
	        	else 
	        	    id_player=1000000000+t[2]
	        	    Actor:setPosition(id_player, t[3], t[4], t[5])
	        	    Actor:addBuff(id_player, t[3], t[4], t[5])
	        	    Chat:sendSystemMsg(name.." đã nhận hiệu ứng trong "..t[5].."mili giây", id_host)
	        	end
            end
        	
        	if (t[1]=="//help")and(t[2]==nil) then
        	    
        	   Chat:sendSystemMsg("Hiện tại có các lệnh: kill, traid, effect, summon, cho, thongtin, dichchuyen\n Để xem help chi tiết chat //help tên lệh \n vd: //help traid \n @a : tất cả ngưởi chơi \n @s : Chính mình \n @r : Người chơi ngẫu nhiên", id_host)
        	   Chat:sendSystemMsg("Các giá trị này vừa là id vừa là vị trí",id_host)
        	elseif t[1]=="//help" then
        	    if t[2]=="traid" then
        	        Game:msgBox("LỆNH:\n //traid id_vật_phẩm \n Chuyển id của vật phẩm thành tên\n VD: //traid 104")
        	    elseif t[2]=="kill" then
    	            Game:msgBox("LỆNH \n //kill id_người _chơi \n Kill người chơi \n VD: //kill @r \n //kill 1234567")
    	       elseif t[2]=="effect" then
    	           Game:msgBox("LỆNH \n //effect id_người_chơi id_buff lv_buff thời_gian \n VD: //effect @s 1123 2 500")
    	       elseif t[2]=="cho" then 
    	           Game:msgBox("LỆNH\n //cho id_người_nhận id_vật_phẩm số_lượng \n VD: //cho @r 104 20 \n Cho người chơi ngẫu nhiên 20 vật phẩm 104 ")
    	       elseif t[2]=="summon" then
    	           Game:msgBox("LỆNH \n //summon id_vật_triêu_hồi vị_trí \n VD: //summon 1123 @a \n Triệu hồi sinh vật 1123 tới vị trí của tất cả người chơi \n luư ý: Vị_trí là tọa độ không phải id")
    	       elseif t[2]=="dichchuyen" then
    	           Game:msgBox("LỆNH\n //dichchuyen id_người_chơi vị_trí")
    	       end
        	end
        end
    end       
end
ScriptSupportEvent:registerEvent([=[Player.InputContent]=], command)