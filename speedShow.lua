-- Kỳ Kỳ -DevMini
-- phiên bản 1
lenBar=13
function CreateTimer_F(p)
	local result=MiniTimer:isExist(1)
	if result~=0 then
		local result2,id=MiniTimer:createTimer("showSpeed",nil,true)
	end
end
function GetSpeed_F(p)
    color="#G"
    local lastMotion=_G[p.eventobjid]
	local codeMotion=p.playermotion
	if codeMotion==1 then 
	    _G[p.eventobjid]=codeMotion
	elseif codeMotion==2 then
	    _G[p.eventobjid]=codeMotion
	end
	local codeSpeed=10
	local k,m=1,1
	if codeMotion==0 then
		speed,m=0,0
	elseif codeMotion==1 then
		codeSpeed,m=10,1
		color="#G"
	elseif codeMotion==2 then
		codeSpeed,m=11,2
		color="#R"
	elseif codeMotion==32 then 
	    if lastMotion==1 then
	        codeSpeed,m=10,1
	        color="#G"
	    elseif lastMotion==2 then
		    codeSpeed,m=11,2
		    color="#R"
		end
	end
	local result,x,y,z=Actor:getPosition(p.eventobjid)
	local densityOfPlace=Block:isLiquidBlock(x,y,z)
	local result,value=Player:getAttr(p.eventobjid,codeSpeed)
	if densityOfPlace==0 then
		k=1/3
	end
	speed=value*k*m
	--Timer Zone--
	cEmpty='▒'
	cFull='█'
	
	_,MaxSpeed=Player:getAttr(p.eventobjid,11)
	MaxSpeed=MaxSpeed*2
	OneChar=MaxSpeed/lenBar
	iFull=speed/OneChar
	local StringBar=""
	local lenFull=0
	if m>0 then
    	lenFull=math.ceil(iFull)-1-math.random(0,2)
    	for i=1,lenFull do
    		StringBar=StringBar..cFull
    	end
    end
	for i=1,lenBar-lenFull do
		StringBar=StringBar..cEmpty
	end
	_G[p.eventobjid.."color"]=color
	_G[p.eventobjid.."run"]=true
	_G[p.eventobjid.."speed"]=speed
    _G[p.eventobjid.."value"]=math.ceil(iFull)-1
    local result,name=Player:getNickname(p.eventobjid)
	MiniTimer:showTimerTips({p.eventobjid},1,"\n["..name.."]\t\t#R"..speed.." KM/H\n"..color..StringBar.."\n",true)
	
end
function SetRandom_F(p)
    if 	_G[p.eventobjid.."run"] then
    local result,name=Player:getNickname(p.eventobjid)
    local ranSpeed=math.random(0,2)
    local nowFull=_G[p.eventobjid.."value"]
    local nowColor=_G[p.eventobjid.."color"]
    local nowSpeed=_G[p.eventobjid.."speed"]-ranSpeed
    if nowSpeed<0 then
        nowSpeed=0 
    end 
    cEmpty='▒'
	cFull='█'
	local StringBar=""
	local lenFull=nowFull-ranSpeed
	for i=1,lenFull do
		StringBar=StringBar..cFull
	end
	for i=1,lenBar-lenFull do
		StringBar=StringBar..cEmpty
	end
	MiniTimer:showTimerTips({p.eventobjid},1,"\n["..name.."]\t#R"..nowSpeed.." KM/H\n"..nowColor..StringBar.."\n",true)
	end
end
ScriptSupportEvent:registerEvent([=[Player.MotionStateChange]=],GetSpeed_F)
ScriptSupportEvent:registerEvent([=[Game.Start]=],CreateTimer_F)
ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=],SetRandom_F)




