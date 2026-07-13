local a={cache={}::any}do do local function b()local c=game:GetService('UserInputService');
local d=game:GetService('TextService');
local e=game:GetService('CoreGui');
local f=game:GetService('Teams');
local g=game:GetService('Players');
local h=game:GetService('RunService')
local i=game:GetService('TweenService');
local j=game:GetService('Lighting');
local k=h.RenderStepped;
local l=g.LocalPlayer;
local m=l:GetMouse();

local n=protectgui or(syn and syn.protect_gui)or(function()end);

local o=Instance.new('ScreenGui');
n(o);
o.ZIndexBehavior=Enum.ZIndexBehavior.Global;
o.Parent=e;

local p={};
local q={};

getgenv().Toggles=p;
getgenv().Options=q;

local r={
Registry={};
RegistryMap={};

HudRegistry={};

FontColor=Color3.fromRGB(255,255,255);
MainColor=Color3.fromRGB(28,28,28);
BackgroundColor=Color3.fromRGB(20,20,20);
AccentColor=Color3.fromRGB(0,85,255);
OutlineColor=Color3.fromRGB(50,50,50);
RiskColor=Color3.fromRGB(255,50,50),

Black=Color3.new(0,0,0);

Font=Enum.Font.Code,
FontSize=14,

OpenedFrames={};
DependencyBoxes={};

Signals={};
ScreenGui=o;

Toggled=false;
WireframeDrag=true;
UseBlur=false;
BlurSize=15;

KeybindMode='All';

NotifyConfig={
Alignment='Left';
BarSide='Left';
PositionX=0;
PositionY=40;
};
};

r.KeyPickerList={};

r.BlurEffect=Instance.new("BlurEffect")
r.BlurEffect.Name="LinoriaBlur"
r.BlurEffect.Size=0
r.BlurEffect.Enabled=false
pcall(function()r.BlurEffect.Parent=j end)

function r:UpdateBlur()
if r.UseBlur then
if r.Toggled then
r.BlurEffect.Enabled=true
i:Create(r.BlurEffect,TweenInfo.new(0.2,Enum.EasingStyle.Linear),{Size=r.BlurSize}):Play()
end
else
local s=i:Create(r.BlurEffect,TweenInfo.new(0.2,Enum.EasingStyle.Linear),{Size=0})
s:Play()

task.delay(0.2,function()
if not r.UseBlur then
r.BlurEffect.Enabled=false
end
end)
end
end

function r:SetFontSize(s)
r.FontSize=s
for t,u in pairs(o:GetDescendants())do
if u:IsA("TextLabel")or u:IsA("TextBox")or u:IsA("TextButton")then
local v=u:GetAttribute("FontSizeOffset")
if v then
u.TextSize=s+v
end
end
end
local t=e:FindFirstChild("LinoriaMobileUI")
if t then
for u,v in pairs(t:GetDescendants())do
if v:IsA("TextLabel")or v:IsA("TextBox")or v:IsA("TextButton")then
local w=v:GetAttribute("FontSizeOffset")
if w then
v.TextSize=s+w
end
end
end
end
end

local s=0
local t=0

table.insert(r.Signals,k:Connect(function(u)
s=s+u

if s>=(1/60)then
s=0

t=t+(1/400);
if t>1 then
t=0;
end;

r.CurrentRainbowHue=t;
r.CurrentRainbowColor=Color3.fromHSV(t,0.8,1);
end
end))

local function u()
local v=g:GetPlayers();
for w=1,#v do
v[w]=v[w].Name;
end;
table.sort(v,function(w,x)return w<x end);

return v
end;

local function v()
local w=f:GetTeams();
for x=1,#w do
w[x]=w[x].Name;
end;
table.sort(w,function(x,y)return x<y end);

return w
end;

function r:SafeCallback(w,...)
if(not w)then
return
end;
if not r.NotifyOnError then
return w(...)
end;

local x,y=pcall(w,...);
if not x then
local z,A=y:find(":%d+: ");
if not A then
return r:Notify(y)
end;
return r:Notify(y:sub(A+1),3)
end;
end;

function r:AttemptSave()
if r.SaveManager then
r.SaveManager:Save();
end;
end;

function r:Create(w,x)
local y=w;
if type(w)=='string'then
y=Instance.new(w);
end;
for z,A in next,x do
y[z]=A;
end;

if y:IsA("TextLabel")or y:IsA("TextBox")or y:IsA("TextButton")then
if x.TextSize then
y:SetAttribute("FontSizeOffset",x.TextSize-r.FontSize)
else
y:SetAttribute("FontSizeOffset",0)
end
end

return y
end;

function r:ApplyTextStroke(w)
w.TextStrokeTransparency=1;

r:Create('UIStroke',{
Color=Color3.new(0,0,0);
Thickness=1;
LineJoinMode=Enum.LineJoinMode.Miter;
Parent=w;
});
end;

function r:ApplyGlow(w)

end;

function r:CreateLabel(w,x)
local y=r:Create('TextLabel',{
BackgroundTransparency=1;
Font=r.Font;
TextColor3=r.FontColor;
TextSize=r.FontSize+2;
TextStrokeTransparency=0;
});
r:ApplyTextStroke(y);

r:AddToRegistry(y,{
TextColor3='FontColor';
},x);
return r:Create(y,w)
end;

function r:MakeDraggable(w,x,y)
w.Active=true;
w.InputBegan:Connect(function(z)
if z.UserInputType==Enum.UserInputType.MouseButton1 or z.UserInputType==Enum.UserInputType.Touch then
local A=w.Position
local B=z.Position

if(B.Y-w.AbsolutePosition.Y)>(x or 40)then
return
end

local C=true
local D=false
local E=nil
local F,G

F=c.InputChanged:Connect(function(H)
if H.UserInputType==Enum.UserInputType.MouseMovement or H==z then
local I=H.Position-B

if y and r.WireframeDrag then
if not D and I.Magnitude>2 then
D=true

E=r:Create("Frame",{
Size=w.Size,
Position=w.Position,
AnchorPoint=w.AnchorPoint,
BackgroundTransparency=1,
Active=false,
ZIndex=100000,
Parent=o
})

r:Create("UIStroke",{
Color=Color3.fromRGB(255,255,255),
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=E
})
end

if D and E then
E.Position=UDim2.new(
A.X.Scale,A.X.Offset+I.X,
A.Y.Scale,A.Y.Offset+I.Y
)
end
else
w.Position=UDim2.new(
A.X.Scale,A.X.Offset+I.X,
A.Y.Scale,A.Y.Offset+I.Y
)
end
end
end)

G=c.InputEnded:Connect(function(H)
if H==z or H.UserInputType==Enum.UserInputType.Touch then
C=false
F:Disconnect()
G:Disconnect()

if y and r.WireframeDrag and D and E then
w.Position=E.Position

E:Destroy()
E=nil
end
end
end)
end
end)
end;

function r:MakeResizable(w,x,y)
x=x or Vector2.new(400,300)
y=y or Vector2.new(1400,1000)

local z=r:Create('TextButton',{
Name='ResizeGrip',
Text='',
AutoButtonColor=false,
BackgroundTransparency=1,
Size=UDim2.fromOffset(16,16),
Position=UDim2.new(1,-4,1,-4),
AnchorPoint=Vector2.new(1,1),
ZIndex=25,
Parent=w,
})

local A=r:CreateLabel({
BackgroundTransparency=1,
Size=UDim2.fromOffset(16,16),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
Text='*',
TextColor3=r.OutlineColor,
TextSize=r.FontSize+2,
ZIndex=26,
Parent=z,
})
r:AddToRegistry(A,{
TextColor3='OutlineColor',
})

z.InputBegan:Connect(function(B)
if B.UserInputType~=Enum.UserInputType.MouseButton1
and B.UserInputType~=Enum.UserInputType.Touch then
return
end

local C=w.Size
local D=B.Position
local E=false
local F=nil
local G,H

G=c.InputChanged:Connect(function(I)
if I.UserInputType~=Enum.UserInputType.MouseMovement and I~=B then
return
end

local J=I.Position-D
if J.Magnitude<=2 then return end
E=true

local K=math.clamp(C.X.Offset+J.X,x.X,y.X)
local L=math.clamp(C.Y.Offset+J.Y,x.Y,y.Y)
local M=UDim2.fromOffset(K,L)

if r.WireframeDrag then
if not F then
F=r:Create('Frame',{
Size=w.Size,
Position=w.Position,
AnchorPoint=w.AnchorPoint,
BackgroundTransparency=1,
Active=false,
ZIndex=100000,
Parent=o,
})
r:Create('UIStroke',{
Color=Color3.fromRGB(255,255,255),
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=F,
})
end
F.Size=M
F.Position=w.Position
else
w.Size=M
end
end)

H=c.InputEnded:Connect(function(I)
if I~=B and I.UserInputType~=Enum.UserInputType.Touch then
return
end

G:Disconnect()
H:Disconnect()

if r.WireframeDrag and E and F then
w.Size=F.Size
F:Destroy()
end
end)
end)
end;

function r:AddToolTip(w,x)
local y,z=r:GetTextBounds(w,r.Font,r.FontSize);
local A=r:Create('Frame',{
BackgroundColor3=r.MainColor,
BorderColor3=r.OutlineColor,

Size=UDim2.fromOffset(y+5,z+4),
ZIndex=100,
Parent=r.ScreenGui,

Visible=false,
})

local B=r:CreateLabel({
Position=UDim2.fromOffset(3,1),
Size=UDim2.fromOffset(y,z);
TextSize=r.FontSize;
Text=w,
TextColor3=r.FontColor,
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=A.ZIndex+1,

Parent=A;
});
r:AddToRegistry(A,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
r:AddToRegistry(B,{
TextColor3='FontColor',
});
local C=false

x.MouseEnter:Connect(function()
if r:MouseIsOverOpenedFrame()then
return
end

C=true

A.Position=UDim2.fromOffset(m.X+15,m.Y+12)
A.Visible=true

while C do
h.Heartbeat:Wait()
A.Position=UDim2.fromOffset(m.X+15,m.Y+12)
end
end)

x.MouseLeave:Connect(function()
C=false
A.Visible=false
end)
end

function r:OnHighlight(w,x,y,z)
w.MouseEnter:Connect(function()
local A=r.RegistryMap[x];

for B,C in next,y do
x[B]=r[C]or C;

if A and A.Properties[B]then
A.Properties[B]=C;
end;
end;
end)

w.MouseLeave:Connect(function()
local A=r.RegistryMap[x];

for B,C in next,z do
x[B]=r[C]or C;

if A and A.Properties[B]then
A.Properties[B]=C;
end;
end;
end)
end;

function r:MouseIsOverOpenedFrame()
for w,x in next,r.OpenedFrames do
local y,z=w.AbsolutePosition,w.AbsoluteSize;
if m.X>=y.X and m.X<=y.X+z.X
and m.Y>=y.Y and m.Y<=y.Y+z.Y then

return true
end;
end;
end;

function r:IsMouseOverFrame(w)
local x,y=w.AbsolutePosition,w.AbsoluteSize;
if m.X>=x.X and m.X<=x.X+y.X
and m.Y>=x.Y and m.Y<=x.Y+y.Y then

return true
end;
end;

function r:UpdateDependencyBoxes()
for w,x in next,r.DependencyBoxes do
x:Update();
end;
end;

function r:MapValue(w,x,y,z,A)
return(1-((w-x)/(y-x)))*z+((w-x)/(y-x))*A
end;

function r:GetTextBounds(w,x,y,z)
local A=d:GetTextSize(w,y,x,z or Vector2.new(1920,1080))
return A.X,A.Y
end;

function r:GetDarkerColor(w)
local x,y,z=Color3.toHSV(w);
return Color3.fromHSV(x,y,z/1.5)
end;

r.AccentColorDark=r:GetDarkerColor(r.AccentColor);

function r:AddToRegistry(w,x,y)
local z=#r.Registry+1;
local A={
Instance=w;
Properties=x;
Idx=z;
};

table.insert(r.Registry,A);
r.RegistryMap[w]=A;

if y then
table.insert(r.HudRegistry,A);
end;
end;

function r:RemoveFromRegistry(w)
local x=r.RegistryMap[w];

if x then
for y=#r.Registry,1,-1 do
if r.Registry[y]==x then
table.remove(r.Registry,y);
end;
end;

for y=#r.HudRegistry,1,-1 do
if r.HudRegistry[y]==x then
table.remove(r.HudRegistry,y);
end;
end;

r.RegistryMap[w]=nil;
end;
end;

function r:UpdateColorsUsingRegistry()
for w,x in next,r.Registry do
for y,z in next,x.Properties do
if type(z)=='string'then
x.Instance[y]=r[z];
elseif type(z)=='function'then
x.Instance[y]=z()
end
end;
end;
end;

function r:GiveSignal(w)
table.insert(r.Signals,w)
end

function r:Unload()
for w=#r.Signals,1,-1 do
local x=table.remove(r.Signals,w)
x:Disconnect()
end

if r.OnUnload then
r.OnUnload()
end

if r.BlurEffect then
r.BlurEffect:Destroy()
end

o:Destroy()
end

function r:OnUnload(w)
r.OnUnload=w
end

r:GiveSignal(o.DescendantRemoving:Connect(function(w)
if r.RegistryMap[w]then
r:RemoveFromRegistry(w);
end;
end))

local w={};
do
local x={};

function x:AddColorPicker(y,z)
local A=self.TextLabel;
assert(z.Default,'AddColorPicker: Missing default value.');

local B={
Value=z.Default;
Transparency=z.Transparency or 0;
Type='ColorPicker';
Title=type(z.Title)=='string'and z.Title or'Color picker',
Callback=z.Callback or function(B)end;
};

function B:SetHSVFromRGB(C)
local D,E,F=Color3.toHSV(C);
B.Hue=D;
B.Sat=E;
B.Vib=F;
end;

B:SetHSVFromRGB(B.Value);
local C=r:Create('Frame',{
BackgroundColor3=B.Value;
BorderColor3=r:GetDarkerColor(B.Value);
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(0,28,0,14);
ZIndex=6;
Parent=A;
});
local D=r:Create('ImageLabel',{
BorderSizePixel=0;
Size=UDim2.new(0,27,0,13);
ZIndex=5;
Image='http://www.roblox.com/asset/?id=12977615774';
Visible=not not z.Transparency;
Parent=C;
});

local E=r:Create('Frame',{
Name='Color';
BackgroundColor3=Color3.new(1,1,1);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(C.AbsolutePosition.X,C.AbsolutePosition.Y+18),
Size=UDim2.fromOffset(230,z.Transparency and 271 or 253);
Visible=false;
ZIndex=15;
Parent=o,
});
C:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
E.Position=UDim2.fromOffset(C.AbsolutePosition.X,C.AbsolutePosition.Y+18);
end)

local F=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=16;
Parent=E;
});
local G=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,0,2);
ZIndex=17;
Parent=F;
});
local H=r:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,4,0,25);
Size=UDim2.new(0,200,0,200);
ZIndex=17;
Parent=F;
});
local I=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Parent=H;
});
local J=r:Create('ImageLabel',{
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Image='rbxassetid://4155801252';
Parent=I;
});
local K=r:Create('ImageLabel',{
AnchorPoint=Vector2.new(0.5,0.5);
Size=UDim2.new(0,6,0,6);
BackgroundTransparency=1;
Image='http://www.roblox.com/asset/?id=9619665977';
ImageColor3=Color3.new(0,0,0);
ZIndex=19;
Parent=J;
});
local L=r:Create('ImageLabel',{
Size=UDim2.new(0,K.Size.X.Offset-2,0,K.Size.Y.Offset-2);
Position=UDim2.new(0,1,0,1);
BackgroundTransparency=1;
Image='http://www.roblox.com/asset/?id=9619665977';
ZIndex=20;
Parent=K;
})

local M=r:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,208,0,25);
Size=UDim2.new(0,15,0,200);
ZIndex=17;
Parent=F;
});

local N=r:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Parent=M;
});
local O=r:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
AnchorPoint=Vector2.new(0,0.5);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,0,0,1);
ZIndex=18;
Parent=N;
});

local P=r:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(4,228),
Size=UDim2.new(0.5,-6,0,20),
ZIndex=18,
Parent=F;
});
local Q=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=18,
Parent=P;
});
r:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=Q;
});

local R=r:Create('TextBox',{
BackgroundTransparency=1;
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);
Font=r.Font;
PlaceholderColor3=Color3.fromRGB(190,190,190);
PlaceholderText='Hex color',
Text='#FFFFFF',
TextColor3=r.FontColor;
TextSize=r.FontSize;
TextStrokeTransparency=0;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=20,
Parent=Q;
});

r:ApplyTextStroke(R);

local S=r:Create(P:Clone(),{
Position=UDim2.new(0.5,2,0,228),
Size=UDim2.new(0.5,-6,0,20),
Parent=F
});
local T=r:Create(S.Frame:FindFirstChild('TextBox'),{
Text='255, 255, 255',
PlaceholderText='RGB color',
TextColor3=r.FontColor
});
local U,V,W;

if z.Transparency then
U=r:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(4,251);
Size=UDim2.new(1,-8,0,15);
ZIndex=19;
Parent=F;
});
V=r:Create('Frame',{
BackgroundColor3=B.Value;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=19;
Parent=U;
});
r:AddToRegistry(V,{BorderColor3='OutlineColor'});

r:Create('ImageLabel',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,0);
Image='http://www.roblox.com/asset/?id=12978095818';
ZIndex=20;
Parent=V;
});
W=r:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
AnchorPoint=Vector2.new(0.5,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,1,1,0);
ZIndex=21;
Parent=V;
});
end;

local X=r:CreateLabel({
Size=UDim2.new(1,0,0,14);
Position=UDim2.fromOffset(5,5);
TextXAlignment=Enum.TextXAlignment.Left;
TextSize=r.FontSize;
Text=B.Title,
TextWrapped=false;
ZIndex=16;
Parent=F;
});
local Y={}
do
Y.Options={}
Y.Container=r:Create('Frame',{
BorderColor3=Color3.new(),
ZIndex=14,
Visible=false,
Parent=o
})

Y.Inner=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.fromScale(1,1);
ZIndex=15;
Parent=Y.Container;
});
r:Create('UIListLayout',{
Name='Layout',
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=Y.Inner;
});
r:Create('UIPadding',{
Name='Padding',
PaddingLeft=UDim.new(0,4),
Parent=Y.Inner,
});
local function Z()
Y.Container.Position=UDim2.fromOffset(
(C.AbsolutePosition.X+C.AbsoluteSize.X)+4,
C.AbsolutePosition.Y+1
)
end

local function _()
local aa=60
for ab,ac in next,Y.Inner:GetChildren()do
if ac:IsA('TextLabel')then
aa=math.max(aa,ac.TextBounds.X)
end
end

Y.Container.Size=UDim2.fromOffset(
aa+8,
Y.Inner.Layout.AbsoluteContentSize.Y+4
)
end

C:GetPropertyChangedSignal('AbsolutePosition'):Connect(Z)
Y.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(_)

task.spawn(Z)
task.spawn(_)

r:AddToRegistry(Y.Inner,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});

function Y:Show()
self.Container.Visible=true
end

function Y:Hide()
self.Container.Visible=false
end

function Y:AddOption(aa,ab)
if type(ab)~='function'then
ab=function()end
end

local ac=r:CreateLabel({
Active=false;
Size=UDim2.new(1,0,0,15);
TextSize=r.FontSize-1;
Text=aa;
ZIndex=16;
Parent=self.Inner;
TextXAlignment=Enum.TextXAlignment.Left,
});
r:OnHighlight(ac,ac,
{TextColor3='AccentColor'},
{TextColor3='FontColor'}
);
ac.InputBegan:Connect(function(ad)
if ad.UserInputType~=Enum.UserInputType.MouseButton1 and ad.UserInputType~=Enum.UserInputType.Touch then
return
end

ab()
end)
end

Y:AddOption('Copy color',function()
r.ColorClipboard=B.Value
r:Notify('Copied color!',2)
end)

Y:AddOption('Paste color',function()
if not r.ColorClipboard then
return r:Notify('You have not copied a color!',2)
end
B:SetValueRGB(r.ColorClipboard)
end)


Y:AddOption('Copy HEX',function()
pcall(setclipboard,B.Value:ToHex())
r:Notify('Copied hex code to clipboard!',2)
end)

Y:AddOption('Copy RGB',function()
pcall(setclipboard,table.concat({math.floor(B.Value.R*255),math.floor(B.Value.G*255),math.floor(B.Value.B*255)},', '))
r:Notify('Copied RGB values to clipboard!',2)
end)

end

r:AddToRegistry(F,{BackgroundColor3='BackgroundColor';BorderColor3='OutlineColor';});
r:AddToRegistry(G,{BackgroundColor3='AccentColor';});
r:AddToRegistry(I,{BackgroundColor3='BackgroundColor';BorderColor3='OutlineColor';});
r:AddToRegistry(Q,{BackgroundColor3='MainColor';BorderColor3='OutlineColor';});
r:AddToRegistry(S.Frame,{BackgroundColor3='MainColor';BorderColor3='OutlineColor';});
r:AddToRegistry(T,{TextColor3='FontColor',});
r:AddToRegistry(R,{TextColor3='FontColor',});

local aa={};
for ab=0,1,0.1 do
table.insert(aa,ColorSequenceKeypoint.new(ab,Color3.fromHSV(ab,1,1)));
end;

local ab=r:Create('UIGradient',{
Color=ColorSequence.new(aa);
Rotation=90;
Parent=N;
});
R.FocusLost:Connect(function(ac)
if ac then
local ad,Z=pcall(Color3.fromHex,R.Text)
if ad and typeof(Z)=='Color3'then
B.Hue,B.Sat,B.Vib=Color3.toHSV(Z)
end
end

B:Display()
end)

T.FocusLost:Connect(function(ac)
if ac then
local ad,Z,_=T.Text:match('(%d+),%s*(%d+),%s*(%d+)')
if ad and Z and _ then
B.Hue,B.Sat,B.Vib=Color3.toHSV(Color3.fromRGB(ad,Z,_))
end
end

B:Display()
end)

function B:Display()
B.Value=Color3.fromHSV(B.Hue,B.Sat,B.Vib);
J.BackgroundColor3=Color3.fromHSV(B.Hue,1,1);

r:Create(C,{
BackgroundColor3=B.Value;
BackgroundTransparency=B.Transparency;
BorderColor3=r:GetDarkerColor(B.Value);
});
if V then
V.BackgroundColor3=B.Value;
W.Position=UDim2.new(1-B.Transparency,0,0,0);
end;

K.Position=UDim2.new(B.Sat,0,1-B.Vib,0);
O.Position=UDim2.new(0,0,B.Hue,0);

R.Text='#'..B.Value:ToHex()
T.Text=table.concat({math.floor(B.Value.R*255),math.floor(B.Value.G*255),math.floor(B.Value.B*255)},', ')

r:SafeCallback(B.Callback,B.Value);
r:SafeCallback(B.Changed,B.Value);
end;

function B:OnChanged(ac)
B.Changed=ac;
ac(B.Value)
end;

function B:Show()
for ac,ad in next,r.OpenedFrames do
if ac.Name=='Color'then
ac.Visible=false;
r.OpenedFrames[ac]=nil;
end;
end;

E.Visible=true;
r.OpenedFrames[E]=true;
end;
function B:Hide()
E.Visible=false;
r.OpenedFrames[E]=nil;
end;
function B:SetValue(ac,ad)
local Z=Color3.fromHSV(ac[1],ac[2],ac[3]);
B.Transparency=ad or 0;
B:SetHSVFromRGB(Z);
B:Display();
end;

function B:SetValueRGB(ac,ad)
B.Transparency=ad or 0;
B:SetHSVFromRGB(ac);
B:Display();
end;

J.InputBegan:Connect(function(ac)
if ac.UserInputType==Enum.UserInputType.MouseButton1 or ac.UserInputType==Enum.UserInputType.Touch then
local function ad(Z,_)
local ae=J.AbsolutePosition.X;
local af=ae+J.AbsoluteSize.X;
local ag=math.clamp(Z,ae,af);

local ah=J.AbsolutePosition.Y;
local ai=ah+J.AbsoluteSize.Y;
local aj=math.clamp(_,ah,ai);

B.Sat=(ag-ae)/(af-ae);
B.Vib=1-((aj-ah)/(ai-ah));
B:Display();
end

ad(ac.Position.X,ac.Position.Y)

local ae=c.InputChanged:Connect(function(ae)
if ae.UserInputType==Enum.UserInputType.MouseMovement or ae==ac then
ad(ae.Position.X,ae.Position.Y)
end
end)

local af
af=c.InputEnded:Connect(function(ag)
if ag==ac or ag.UserInputType==Enum.UserInputType.Touch then
ae:Disconnect()
af:Disconnect()
r:AttemptSave()
end
end)
end
end);
N.InputBegan:Connect(function(ac)
if ac.UserInputType==Enum.UserInputType.MouseButton1 or ac.UserInputType==Enum.UserInputType.Touch then
local function ad(ae)
local af=N.AbsolutePosition.Y;
local ag=af+N.AbsoluteSize.Y;
local ah=math.clamp(ae,af,ag);

B.Hue=((ah-af)/(ag-af));
B:Display();
end

ad(ac.Position.Y)

local ae=c.InputChanged:Connect(function(ae)
if ae.UserInputType==Enum.UserInputType.MouseMovement or ae==ac then
ad(ae.Position.Y)
end
end)

local af
af=c.InputEnded:Connect(function(ag)
if ag==ac or ag.UserInputType==Enum.UserInputType.Touch then
ae:Disconnect()
af:Disconnect()
r:AttemptSave()
end
end)
end
end);
C.InputBegan:Connect(function(ac)
if(ac.UserInputType==Enum.UserInputType.MouseButton1 or ac.UserInputType==Enum.UserInputType.Touch)and not r:MouseIsOverOpenedFrame()then
if E.Visible then
B:Hide()
else
Y:Hide()
B:Show()
end;
elseif ac.UserInputType==Enum.UserInputType.MouseButton2 and not r:MouseIsOverOpenedFrame()then
Y:Show()
B:Hide()
end
end);

if V then
V.InputBegan:Connect(function(ac)
if ac.UserInputType==Enum.UserInputType.MouseButton1 or ac.UserInputType==Enum.UserInputType.Touch then
local function ad(ae)
local af=V.AbsolutePosition.X;
local ag=af+V.AbsoluteSize.X;
local ah=math.clamp(ae,af,ag);

B.Transparency=1-((ah-af)/(ag-af));
B:Display();
end

ad(ac.Position.X)

local ae=c.InputChanged:Connect(function(ae)
if ae.UserInputType==Enum.UserInputType.MouseMovement or ae==ac then
ad(ae.Position.X)
end
end)

local af
af=c.InputEnded:Connect(function(ag)
if ag==ac or ag.UserInputType==Enum.UserInputType.Touch then
ae:Disconnect()
af:Disconnect()
r:AttemptSave()
end
end)
end
end);
end;

r:GiveSignal(c.InputBegan:Connect(function(ac)
if(ac.UserInputType==Enum.UserInputType.MouseButton1 or ac.UserInputType==Enum.UserInputType.Touch)then
local ad,ae=E.AbsolutePosition,E.AbsoluteSize;
local af=C.AbsolutePosition;
local ag=C.AbsoluteSize;

if m.X<ad.X or m.X>ad.X+ae.X
or m.Y<af.Y or m.Y>ad.Y+ae.Y then

if not(m.X>=af.X and m.X<=af.X+ag.X
and m.Y>=af.Y and m.Y<=af.Y+ag.Y)then
B:Hide();
end
end;

if not r:IsMouseOverFrame(Y.Container)then
Y:Hide()
end
end;

if ac.UserInputType==Enum.UserInputType.MouseButton2 and Y.Container.Visible then
if not r:IsMouseOverFrame(Y.Container)and not r:IsMouseOverFrame(C)then
Y:Hide()
end
end
end))

function B:GetTransparency()
return B.Transparency
end;

function B:OnTransparencyChanged(ac)
B.TransparencyChanged=ac;
ac(B.Transparency);
end;

local ac=B.Display;
B.Display=function(ad)
ac(ad);
r:SafeCallback(B.TransparencyChanged,B.Transparency);
end;

B:Display();
B.DisplayFrame=C

q[y]=B;

return self
end;

function x:AddColorPickerAlpha(aa,ab)
ab=ab or{};
if ab.Transparency==nil then
ab.Transparency=0;
end;
return x.AddColorPicker(self,aa,ab)
end;

function x:AddKeyPicker(aa,ab)
local ac=self;
local ad=self.TextLabel;
local ae=self.Container;

assert(ab.Default,'AddKeyPicker: Missing default value.');

local af={
Value=ab.Default;
Toggled=false;
Mode=ab.Mode or'Toggle';
Type='KeyPicker';
Callback=ab.Callback or function(af)end;
ChangedCallback=ab.ChangedCallback or function(af)end;

SyncToggleState=ab.SyncToggleState or false;
};
if af.SyncToggleState then
ab.Modes={'Toggle'}
ab.Mode='Toggle'
end

local ag=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,28,0,15);
ZIndex=6;
Parent=ad;
});
local ah=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=7;
Parent=ag;
});
r:AddToRegistry(ah,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local ai=r:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=r.FontSize-1;
Text=ab.Default;
TextWrapped=true;
ZIndex=8;
Parent=ah;
});
local aj=r:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(ad.AbsolutePosition.X+ad.AbsoluteSize.X+4,ad.AbsolutePosition.Y+1);
Size=UDim2.new(0,60,0,45+2);
Visible=false;
ZIndex=14;
Parent=o;
});
ad:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
aj.Position=UDim2.fromOffset(ad.AbsolutePosition.X+ad.AbsoluteSize.X+4,ad.AbsolutePosition.Y+1);
end);
local y=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=15;
Parent=aj;
});
r:AddToRegistry(y,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=y;
});
local z=r:Create('Frame',{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,18),
Visible=false,
ZIndex=110,
Parent=r.KeybindContainer,
})

local A=r:CreateLabel({
Position=UDim2.new(0,2,0,0),
Size=UDim2.new(1,-4,1,0),
TextSize=r.FontSize-1,
TextXAlignment=Enum.TextXAlignment.Left,
ZIndex=111,
Parent=z,
},true)

local B=ab.Modes or{'Always','Toggle','Hold'};
local C={};

for D,E in next,B do
local F={};
local G=r:CreateLabel({
Active=false;
Size=UDim2.new(1,0,0,15);
TextSize=r.FontSize-1;
Text=E;
ZIndex=16;
Parent=y;
});
function F:Select()
for H,I in next,C do
I:Deselect();
end;

af.Mode=E;

G.TextColor3=r.AccentColor;
r.RegistryMap[G].Properties.TextColor3='AccentColor';

aj.Visible=false;
end;
function F:Deselect()
af.Mode=nil;
G.TextColor3=r.FontColor;
r.RegistryMap[G].Properties.TextColor3='FontColor';
end;

G.InputBegan:Connect(function(H)
if(H.UserInputType==Enum.UserInputType.MouseButton1 or H.UserInputType==Enum.UserInputType.Touch)then
F:Select();
r:AttemptSave();
end;
end);
if E==af.Mode then
F:Select();
end;

C[E]=F;
end;

function af:Update()
if ab.NoUI then
return
end;

local D=af:GetState();

local E=(af.Value=='None')and'...'or af.Value
A.Text=string.format('[%s] %s (%s)',E,ab.Text,af.Mode);
local F=r.KeybindMode or'All'
if F=='Active'then
z.Visible=D==true
elseif F=='Toggled'then
local G=false
if ac and ac.Type=='Toggle'then
G=ac.Value==true
elseif af.SyncToggleState and ac then
G=ac.Value==true
else
G=true
end
z.Visible=G
else
z.Visible=true
end

A.TextColor3=D and r.AccentColor or r.FontColor;
r.RegistryMap[A].Properties.TextColor3=D and'AccentColor'or'FontColor';

local G=0
local H=0

for I,J in next,r.KeybindContainer:GetChildren()do
if J:IsA('Frame')and J.Visible then
G=G+18;
local K=J:FindFirstChildOfClass('TextLabel')
if K and(K.TextBounds.X+20>H)then
H=K.TextBounds.X+20
end
end;
end;

r.KeybindFrame.Size=UDim2.new(0,math.max(H+10+15,210),0,G+23)
end;
function af:GetState()
if af.Mode=='Always'then
return true
elseif af.Mode=='Hold'then
if af.Value=='None'then
return false
end

local D=af.Value;
if D=='MB1'or D=='MB2'or D=='Touch'then
return D=='MB1'and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
or D=='MB2'and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
or D=='Touch'and true
else
return c:IsKeyDown(Enum.KeyCode[af.Value])
end;
else
return af.Toggled
end;
end;

function af:SetValue(D)
local E,F=D[1],D[2];
ai.Text=E;
af.Value=E;
C[F]:Select();
af:Update();
end;

function af:OnClick(D)
af.Clicked=D
end

function af:OnChanged(D)
af.Changed=D
D(af.Value)
end

if ac.Addons then
table.insert(ac.Addons,af)
table.insert(r.KeyPickerList,af)
end

function af:DoClick()
if ac.Type=='Toggle'and af.SyncToggleState then
ac:SetValue(not ac.Value)
end

r:SafeCallback(af.Callback,af.Toggled)
r:SafeCallback(af.Clicked,af.Toggled)
end

local D=false;
ag.InputBegan:Connect(function(E)
if(E.UserInputType==Enum.UserInputType.MouseButton1 or E.UserInputType==Enum.UserInputType.Touch)and not r:MouseIsOverOpenedFrame()then
D=true;

ai.Text='';

local F;
local G='';

task.spawn(function()
while(not F)do
if G=='...'then
G='';
end;

G=G..'.';
ai.Text=G;

wait(0.4);
end;
end);

wait(0.2);

local H;
H=c.InputBegan:Connect(function(I)
local J;

if I.UserInputType==Enum.UserInputType.Keyboard then
J=I.KeyCode.Name;
elseif I.UserInputType==Enum.UserInputType.MouseButton1 then
J='MB1';
elseif I.UserInputType==Enum.UserInputType.MouseButton2 then
J='MB2';
elseif I.UserInputType==Enum.UserInputType.Touch then
J='Touch';
end;

F=true;
D=false;

ai.Text=J;
af.Value=J;
r:SafeCallback(af.ChangedCallback,I.KeyCode or I.UserInputType)
r:SafeCallback(af.Changed,I.KeyCode or I.UserInputType)

r:AttemptSave();
H:Disconnect();
end);
elseif E.UserInputType==Enum.UserInputType.MouseButton2 and not r:MouseIsOverOpenedFrame()then
aj.Visible=true;
end;
end);

r:GiveSignal(c.InputBegan:Connect(function(E)
if(not D)then
if af.Mode=='Toggle'then
local F=af.Value;

if F=='MB1'or F=='MB2'or F=='Touch'then
if F=='MB1'and E.UserInputType==Enum.UserInputType.MouseButton1
or F=='MB2'and E.UserInputType==Enum.UserInputType.MouseButton2
or F=='Touch'and E.UserInputType==Enum.UserInputType.Touch then
af.Toggled=not af.Toggled
af:DoClick()
end;
elseif E.UserInputType==Enum.UserInputType.Keyboard then
if E.KeyCode.Name==F then
af.Toggled=not af.Toggled;
af:DoClick()
end;
end;
end;

af:Update();
end;
if(E.UserInputType==Enum.UserInputType.MouseButton1 or E.UserInputType==Enum.UserInputType.Touch)then
local F,G=aj.AbsolutePosition,aj.AbsoluteSize;
if m.X<F.X or m.X>F.X+G.X
or m.Y<(F.Y-20-1)or m.Y>F.Y+G.Y then

aj.Visible=false;
end;
end;
end))

r:GiveSignal(c.InputEnded:Connect(function(E)
if(not D)then
af:Update();
end;
end))

af:Update();
q[aa]=af;

return self
end;

w.__index=x;
w.__namecall=function(aa,ab,...)
return x[ab](...)
end;
end;

local aa={};

do
local ab={};
function ab:AddBlank(ac)
local ad=self;
local ae=ad.Container;
r:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,0,ac);
ZIndex=1;
Parent=ae;
});
end;

function ab:AddRow(ac)
local ad=self
local ae=ad.Container

local af=type(ac)=='number'and math.max(1,ac)or 2

local ag=r:Create('Frame',{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
ZIndex=1,
Parent=ae
})

r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Horizontal,
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,8),
Parent=ag
})

local ah={}

for ai=1,af do
local aj={Type='Groupbox'}

local x=r:Create('Frame',{
BackgroundTransparency=1,
Size=UDim2.new(1/af,-((af-1)*8)/af,1,0),
ZIndex=1,
Parent=ag
})

local y=r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical,
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,4),
Parent=x
})

aj.Container=x
setmetatable(aj,aa)

function aj:Resize()
local z=0
for A,B in next,ag:GetChildren()do
if B:IsA('Frame')then
local C=B:FindFirstChildOfClass('UIListLayout')
if C and C.AbsoluteContentSize.Y>z then
z=C.AbsoluteContentSize.Y
end
end
end
ag.Size=UDim2.new(1,0,0,z)
if ad.Resize then
ad:Resize()
end
end

y:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
aj:Resize()
end)

table.insert(ah,aj)
end

ad:AddBlank(1)
if ad.Resize then ad:Resize()end

return unpack(ah)
end;
function ab:AddLabel(ac,ad)
local ae={};

local af=self;
local ag=af.Container;

local ah=r:CreateLabel({
Size=UDim2.new(1,-4,0,15);
TextSize=r.FontSize;
Text=ac;
RichText=true;
TextWrapped=ad or false,
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=ag;
});
if ad then
local ai=select(2,r:GetTextBounds(ac,r.Font,r.FontSize,Vector2.new(ah.AbsoluteSize.X,math.huge)))
ah.Size=UDim2.new(1,-4,0,ai)
else
r:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Right;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=ah;
});
end

ae.TextLabel=ah;
ae.Container=ag;
function ae:SetText(ai)
ah.Text=ai

if ad then
local aj=select(2,r:GetTextBounds(ai,r.Font,r.FontSize,Vector2.new(ah.AbsoluteSize.X,math.huge)))
ah.Size=UDim2.new(1,-4,0,aj)
end

af:Resize();
end

if(not ad)then
setmetatable(ae,w);
end

af:AddBlank(5);
af:Resize();

return ae
end;
function ab:AddButton(...)
local ac={};
local function ad(ae,af,...)
local ag=select(1,...)
if type(ag)=='table'then
af.Text=ag.Text
af.Func=ag.Func
af.DoubleClick=ag.DoubleClick
af.Tooltip=ag.Tooltip
else
af.Text=select(1,...)
af.Func=select(2,...)
end

assert(type(af.Func)=='function','AddButton: `Func` callback is missing.');
end

ad('Button',ac,...)

local ae=self;
local af=ae.Container;

local function ag(ah)
local ai=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
});
local aj=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=ai;
});
local x=r:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=r.FontSize;
Text=ah.Text;
ZIndex=6;
Parent=aj;
});

r:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=aj;
});
r:AddToRegistry(ai,{
BorderColor3='Black';
});
r:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
r:OnHighlight(ai,ai,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
return ai,aj,x
end

local function ah(ai)
local function aj(x,y,z)
local A=Instance.new('BindableEvent')
local B=x:Once(function(...)

if type(z)=='function'and z(...)then
A:Fire(true)
else
A:Fire(false)
end
end)
task.delay(y,function()
B:disconnect()
A:Fire(false)
end)
return A.Event:Wait()
end

local function x(y)
if r:MouseIsOverOpenedFrame()then
return false
end

if y.UserInputType~=Enum.UserInputType.MouseButton1 and y.UserInputType~=Enum.UserInputType.Touch then
return false
end

return true
end

ai.Outer.InputBegan:Connect(function(y)
if not x(y)then return end

if ai.Locked then return end

if ai.DoubleClick then
r:RemoveFromRegistry(ai.Label)
r:AddToRegistry(ai.Label,{TextColor3='AccentColor'})

ai.Label.TextColor3=r.AccentColor
ai.Label.Text='Are you sure?'
ai.Locked=true

local z=aj(ai.Outer.InputBegan,0.5,x)

r:RemoveFromRegistry(ai.Label)
r:AddToRegistry(ai.Label,{TextColor3='FontColor'})

ai.Label.TextColor3=r.FontColor
ai.Label.Text=ai.Text
task.defer(rawset,ai,'Locked',false)

if z then
r:SafeCallback(ai.Func)
end

return
end

r:SafeCallback(ai.Func);
end)
end

ac.Outer,ac.Inner,ac.Label=ag(ac)
ac.Outer.Parent=af

ah(ac)

function ac:AddTooltip(ai)
if type(ai)=='string'then
r:AddToolTip(ai,self.Outer)
end
return self
end

function ac:AddButton(...)
local ai={}

ad('SubButton',ai,...)

self.Outer.Size=UDim2.new(0.5,-2,0,20)

ai.Outer,ai.Inner,ai.Label=ag(ai)

ai.Outer.Position=UDim2.new(1,3,0,0)
ai.Outer.Size=UDim2.fromOffset(self.Outer.AbsoluteSize.X-2,self.Outer.AbsoluteSize.Y)
ai.Outer.Parent=self.Outer

function ai:AddTooltip(aj)
if type(aj)=='string'then
r:AddToolTip(aj,self.Outer)
end
return ai
end

if type(ai.Tooltip)=='string'then
ai:AddTooltip(ai.Tooltip)
end

ah(ai)
return ai
end

if type(ac.Tooltip)=='string'then
ac:AddTooltip(ac.Tooltip)
end

ae:AddBlank(5);
ae:Resize();

return ac
end;

function ab:AddDivider()
local ac=self;
local ad=self.Container

local ae={
Type='Divider',
}

ac:AddBlank(2);
local af=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,5);
ZIndex=5;
Parent=ad;
});
local ag=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=af;
});
r:AddToRegistry(af,{
BorderColor3='Black';
});
r:AddToRegistry(ag,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
ac:AddBlank(9);
ac:Resize();
end

function ab:AddInput(ac,ad)
assert(ad.Text,'AddInput: Missing `Text` string.')

local ae={
Value=ad.Default or'';
Numeric=ad.Numeric or false;
Finished=ad.Finished or false;
Type='Input';
Callback=ad.Callback or function(ae)end;
};
local af=self;
local ag=af.Container;

local ah=r:CreateLabel({
Size=UDim2.new(1,0,0,15);
TextSize=r.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=ag;
});

af:AddBlank(1);

local ai=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
Parent=ag;
});
local aj=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=ai;
});
r:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
r:OnHighlight(ai,ai,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
if type(ad.Tooltip)=='string'then
r:AddToolTip(ad.Tooltip,ai)
end

r:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=aj;
});
local x=r:Create('Frame',{
BackgroundTransparency=1;
ClipsDescendants=true;

Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);

ZIndex=7;
Parent=aj;
})

local y=r:Create('TextBox',{
BackgroundTransparency=1;

Position=UDim2.fromOffset(0,0),
Size=UDim2.fromScale(5,1),

Font=r.Font;
PlaceholderColor3=Color3.fromRGB(190,190,190);
PlaceholderText=ad.Placeholder or'';

Text=ad.Default or'';
TextColor3=r.FontColor;
TextSize=r.FontSize;
TextStrokeTransparency=0;
TextXAlignment=Enum.TextXAlignment.Left;

ZIndex=7;
Parent=x;
});

r:ApplyTextStroke(y);
function ae:SetValue(z)
if ad.MaxLength and#z>ad.MaxLength then
z=z:sub(1,ad.MaxLength);
end;

if ae.Numeric then
if(not tonumber(z))and z:len()>0 then
z=ae.Value
end
end

ae.Value=z;
y.Text=z;

r:SafeCallback(ae.Callback,ae.Value);
r:SafeCallback(ae.Changed,ae.Value);
end;

if ae.Finished then
y.FocusLost:Connect(function(z)
if not z then return end

ae:SetValue(y.Text);
r:AttemptSave();
end)
else
y:GetPropertyChangedSignal('Text'):Connect(function()
ae:SetValue(y.Text);
r:AttemptSave();
end);
end

local function z()
local A=2
local B=x.AbsoluteSize.X

if not y:IsFocused()or y.TextBounds.X<=B-2*A then
y.Position=UDim2.new(0,A,0,0)
else
local C=y.CursorPosition
if C~=-1 then
local D=string.sub(y.Text,1,C-1)
local E=d:GetTextSize(D,y.TextSize,y.Font,Vector2.new(math.huge,math.huge)).X

local F=y.Position.X.Offset+E

if F<A then
y.Position=UDim2.fromOffset(A-E,0)
elseif F>B-A-1 then
y.Position=UDim2.fromOffset(B-E-A-1,0)
end
end
end
end

task.spawn(z)

y:GetPropertyChangedSignal('Text'):Connect(z)
y:GetPropertyChangedSignal('CursorPosition'):Connect(z)
y.FocusLost:Connect(z)
y.Focused:Connect(z)

r:AddToRegistry(y,{
TextColor3='FontColor';
});

function ae:OnChanged(A)
ae.Changed=A;
A(ae.Value);
end;

af:AddBlank(5);
af:Resize();

q[ac]=ae;

return ae
end;

function ab:AddToggle(ac,ad)
assert(ad.Text,'AddInput: Missing `Text` string.')

local ae={
Value=ad.Default or false;
Type='Toggle';

Callback=ad.Callback or function(ae)end;
Addons={},
Risky=ad.Risky,
};
local af=self;
local ah=af.Container;

local ai=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,13,0,13);
ZIndex=5;
Parent=ah;
});
r:AddToRegistry(ai,{
BorderColor3='Black';
});
local aj=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=ai;
});
r:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
local x=r:Create("UIGradient",{
Rotation=90,
Parent=aj,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185)),
}),
})

r:AddToRegistry(aj,{
BackgroundColor3="MainColor",
BorderColor3="OutlineColor",
})
local y=r:CreateLabel({
Size=UDim2.new(0,216,1,0);
Position=UDim2.new(1,6,0,0);
TextSize=r.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=6;
Parent=aj;
});
r:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Right;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=y;
});
local z=r:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(0,170,1,0);
ZIndex=8;
Parent=ai;
});
r:OnHighlight(z,ai,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
function ae:UpdateColors()
ae:Display();
end;
if type(ad.Tooltip)=='string'then
r:AddToolTip(ad.Tooltip,z)
end

local A

function ae:Display()
local B,C,D

if ae.Disabled then
y.TextColor3=r.DisabledTextColor
B=ae.Value and r.DisabledAccentColor or r.MainColor
C=r.DisabledOutlineColor
r.RegistryMap[aj].Properties.BackgroundColor3=ae.Value and"DisabledAccentColor"or"MainColor"
r.RegistryMap[aj].Properties.BorderColor3="DisabledOutlineColor"
r.RegistryMap[y].Properties.TextColor3="DisabledTextColor"
else
D=ae.Risky and r.RiskColor or Color3.new(1,1,1)
y.TextColor3=D
B=ae.Value and r.AccentColor or r.MainColor
C=ae.Value and r.AccentColorDark or r.OutlineColor
r.RegistryMap[aj].Properties.BackgroundColor3=ae.Value and"AccentColor"or"MainColor"
r.RegistryMap[aj].Properties.BorderColor3=ae.Value and"AccentColorDark"or"OutlineColor"
r.RegistryMap[y].Properties.TextColor3=ae.Risky and"RiskColor"or nil
end

if A then A:Cancel()end
A=i:Create(
aj,
TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
{BackgroundColor3=B,BorderColor3=C}
)
A:Play()
end

function ae:OnChanged(B)
ae.Changed=B;
B(ae.Value);
end;

function ae:SetValue(B)
B=(not not B);
ae.Value=B;
ae:Display();

for C,D in next,ae.Addons do
if D.Type=='KeyPicker'and D.SyncToggleState then
D.Toggled=B
D:Update()
end
end

r:SafeCallback(ae.Callback,ae.Value);
r:SafeCallback(ae.Changed,ae.Value);
r:UpdateDependencyBoxes();
end;
z.InputBegan:Connect(function(B)
if(B.UserInputType==Enum.UserInputType.MouseButton1 or B.UserInputType==Enum.UserInputType.Touch)and not r:MouseIsOverOpenedFrame()then
ae:SetValue(not ae.Value)
r:AttemptSave();
end;
end);
if ae.Risky then
r:RemoveFromRegistry(y)
y.TextColor3=r.RiskColor
r:AddToRegistry(y,{TextColor3='RiskColor'})
end

ae:Display();
af:AddBlank(ad.BlankSize or 5+2);
af:Resize();

ae.TextLabel=y;
ae.Container=ah;
setmetatable(ae,w);

p[ac]=ae;

r:UpdateDependencyBoxes();

return ae
end;

function ab:AddSlider(ac,ad)
assert(ad.Default,'AddSlider: Missing default value.');
assert(ad.Text,'AddSlider: Missing slider text.');
assert(ad.Min,'AddSlider: Missing minimum value.');
assert(ad.Max,'AddSlider: Missing maximum value.');
assert(ad.Rounding,'AddSlider: Missing rounding value.');
local ae={
Value=ad.Default;
Min=ad.Min;
Max=ad.Max;
Rounding=ad.Rounding;
MaxSize=232;
Type='Slider';
Callback=ad.Callback or function(ae)end;
};

local af=self;
local ah=af.Container;
if not ad.Compact then
r:CreateLabel({
Size=UDim2.new(1,0,0,10);
TextSize=r.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
TextYAlignment=Enum.TextYAlignment.Bottom;
ZIndex=5;
Parent=ah;
});
af:AddBlank(3);
end

local ai=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,13);
ZIndex=5;
Parent=ah;
});
r:AddToRegistry(ai,{
BorderColor3='Black';
});
local aj=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=ai;
});
r:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});

local x=r:Create("UIGradient",{
Rotation=90,
Parent=aj,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,r.MainColor),
}),
});
r:AddToRegistry(x,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,r.MainColor),
})
end
});

local y=r:Create("UIGradient",{
Rotation=90,
Parent=aj,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185)),
}),
})

r:AddToRegistry(aj,{
BackgroundColor3="MainColor",
BorderColor3="OutlineColor",
})


local z=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderColor3=r.AccentColorDark;
Size=UDim2.new(0,0,1,0);
ZIndex=7;
Parent=aj;
});
r:AddToRegistry(z,{
BackgroundColor3='AccentColor';
BorderColor3='AccentColorDark';
});

local A=r:Create("UIGradient",{
Rotation=90,
Parent=z,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,r.AccentColor),
}),
});
r:AddToRegistry(A,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,r.AccentColor),
})
end
});

local B=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
BackgroundTransparency=1;
Position=UDim2.new(1,0,0,0);
Size=UDim2.new(0,1,1,0);
ZIndex=8;
Parent=z;
});

local C=r:Create("UIGradient",{
Rotation=90,
Parent=z,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185)),
}),
})

r:AddToRegistry(z,{
BackgroundColor3="AccentColor",
BorderColor3="AccentColorDark",
})

local D=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(1,0,0,0);
Size=UDim2.new(0,1,1,0);
ZIndex=8;
Parent=z;
});

r:AddToRegistry(D,{
BackgroundColor3='AccentColor';
});
local E=r:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=r.FontSize;
Text='Infinite';
ZIndex=9;
Parent=aj;
});
r:OnHighlight(ai,ai,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
if type(ad.Tooltip)=='string'then
r:AddToolTip(ad.Tooltip,ai)
end

function ae:UpdateColors()
z.BackgroundColor3=r.AccentColor;
z.BorderColor3=r.AccentColorDark;
end;

function ae:Display()
local F=ad.Suffix or'';
if ad.Compact then
E.Text=ad.Text..': '..ae.Value..F
elseif ad.HideMax then
E.Text=string.format('%s',ae.Value..F)
else
E.Text=string.format('%s/%s',ae.Value..F,ae.Max..F);
end

local G=math.ceil(r:MapValue(ae.Value,ae.Min,ae.Max,0,ae.MaxSize));
z.Size=UDim2.new(0,G,1,0);

D.Visible=not(G==ae.MaxSize or G==0);
end;
function ae:OnChanged(F)
ae.Changed=F;
F(ae.Value);
end;
local function F(G)
if ae.Rounding==0 then
return math.floor(G)
end;


return tonumber(string.format('%.'..ae.Rounding..'f',G))
end;
function ae:GetValueFromXOffset(G)
return F(r:MapValue(G,0,ae.MaxSize,ae.Min,ae.Max))
end;
function ae:SetValue(G)
local H=tonumber(G);
if(not H)then
return
end;

H=math.clamp(H,ae.Min,ae.Max);

ae.Value=H;
ae:Display();

r:SafeCallback(ae.Callback,ae.Value);
r:SafeCallback(ae.Changed,ae.Value);
end;
aj.InputBegan:Connect(function(G)
if(G.UserInputType==Enum.UserInputType.MouseButton1 or G.UserInputType==Enum.UserInputType.Touch)and not r:MouseIsOverOpenedFrame()then

local function H(I)
local J=z.AbsolutePosition.X

local K=I-J
local L=math.clamp(K,0,ae.MaxSize)

local M=ae:GetValueFromXOffset(L);
local N=ae.Value;

ae.Value=M;

ae:Display();

if M~=N then
r:SafeCallback(ae.Callback,ae.Value);
r:SafeCallback(ae.Changed,ae.Value);
end;
end

H(G.Position.X)

local I=c.InputChanged:Connect(function(I)
if I.UserInputType==Enum.UserInputType.MouseMovement or I==G then
H(I.Position.X)
end
end)

local J
J=c.InputEnded:Connect(function(K)
if K==G or K.UserInputType==Enum.UserInputType.Touch then
I:Disconnect()
J:Disconnect()
r:AttemptSave()
end
end)
end;
end);

ae:Display();
af:AddBlank(ad.BlankSize or 6);
af:Resize();

q[ac]=ae;

return ae
end;
function ab:AddDropdown(ac,ad)
if ad.SpecialType=='Player'then
ad.Values=u();
ad.AllowNull=true;
elseif ad.SpecialType=='Team'then
ad.Values=v();
ad.AllowNull=true;
end;

assert(ad.Values,'AddDropdown: Missing dropdown value list.');
assert(ad.AllowNull or ad.Default,'AddDropdown: Missing default value. Pass `AllowNull` as true if this was intentional.')

if(not ad.Text)then
ad.Compact=true;
end;

local ae={
Values=ad.Values;
Value=ad.Multi and{};
Multi=ad.Multi;
Type='Dropdown';
SpecialType=ad.SpecialType;
Callback=ad.Callback or function(ae)end;
};

local af=self;
local ah=af.Container;

local ai=0;
if not ad.Compact then
local aj=r:CreateLabel({
Size=UDim2.new(1,0,0,10);
TextSize=r.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
TextYAlignment=Enum.TextYAlignment.Bottom;
ZIndex=5;
Parent=ah;
});
af:AddBlank(3);
end

for aj,x in next,ah:GetChildren()do
if not x:IsA('UIListLayout')then
ai=ai+x.Size.Y.Offset;
end;
end;

local aj=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
Parent=ah;
});
r:AddToRegistry(aj,{
BorderColor3='Black';
});
local x=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=aj;
});
r:AddToRegistry(x,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
r:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=x;
});

local z=r:Create('ImageLabel',{
AnchorPoint=Vector2.new(0,0.5);
BackgroundTransparency=1;
Position=UDim2.new(1,-16,0.5,0);
Size=UDim2.new(0,12,0,12);
Image='http://www.roblox.com/asset/?id=6282522798';
ZIndex=8;
Parent=x;
});
local A=r:CreateLabel({
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);
TextSize=r.FontSize;
Text='--';
TextXAlignment=Enum.TextXAlignment.Left;
TextWrapped=true;
ZIndex=7;
Parent=x;
});
r:OnHighlight(aj,aj,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
if type(ad.Tooltip)=='string'then
r:AddToolTip(ad.Tooltip,aj)
end

local C=8;
local D=r:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
ZIndex=20;
Visible=false;
Parent=o;
});
local function E()
D.Position=UDim2.fromOffset(aj.AbsolutePosition.X,aj.AbsolutePosition.Y+aj.Size.Y.Offset+1);
end;

local function F(G)
D.Size=UDim2.fromOffset(aj.AbsoluteSize.X,G or(C*20+2))
end;
E();
F();

aj:GetPropertyChangedSignal('AbsolutePosition'):Connect(E);

local G=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=21;
Parent=D;
});
r:AddToRegistry(G,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
local H=r:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
CanvasSize=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ZIndex=21;
Parent=G;

TopImage='rbxasset://textures/ui/Scroll/scroll-middle.png',
BottomImage='rbxasset://textures/ui/Scroll/scroll-middle.png',

ScrollBarThickness=3,
ScrollBarImageColor3=r.AccentColor,
});
r:AddToRegistry(H,{
ScrollBarImageColor3='AccentColor'
})

r:Create('UIListLayout',{
Padding=UDim.new(0,0);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=H;
});
function ae:Display()
local I=ae.Values;
local J='';

if ad.Multi then
for K,L in next,I do
if ae.Value[L]then
J=J..L..', ';
end;
end;

J=J:sub(1,#J-2);
else
J=ae.Value or'';
end;

A.Text=(J==''and'--'or J);
end;
function ae:GetActiveValues()
if ad.Multi then
local I={};
for J,K in next,ae.Value do
table.insert(I,J);
end;

return I
else
return ae.Value and 1 or 0
end;
end;

function ae:BuildDropdownList()
local I=ae.Values;
local J={};

for K,L in next,H:GetChildren()do
if not L:IsA('UIListLayout')then
L:Destroy();
end;
end;

local K=0;

for L,M in next,I do
local N={};
K=K+1;

local O=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Middle;
Size=UDim2.new(1,-1,0,20);
ZIndex=23;
Active=true,
Parent=H;
});
r:AddToRegistry(O,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
local P=r:CreateLabel({
Active=false;
Size=UDim2.new(1,-6,1,0);
Position=UDim2.new(0,6,0,0);
TextSize=r.FontSize;
Text=M;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=25;
Parent=O;
});

r:OnHighlight(O,O,
{BorderColor3='AccentColor',ZIndex=24},
{BorderColor3='OutlineColor',ZIndex=23}
);
local Q;

if ad.Multi then
Q=ae.Value[M];
else
Q=ae.Value==M;
end;

function N:UpdateButton()
if ad.Multi then
Q=ae.Value[M];
else
Q=ae.Value==M;
end;

P.TextColor3=Q and r.AccentColor or r.FontColor;
r.RegistryMap[P].Properties.TextColor3=Q and'AccentColor'or'FontColor';
end;
P.InputBegan:Connect(function(R)
if(R.UserInputType==Enum.UserInputType.MouseButton1 or R.UserInputType==Enum.UserInputType.Touch)then
local S=not Q;

if ae:GetActiveValues()==1 and(not S)and(not ad.AllowNull)then
else
if ad.Multi then
Q=S;

if Q then
ae.Value[M]=true;
else
ae.Value[M]=nil;
end;
else
Q=S;

if Q then
ae.Value=M;
else
ae.Value=nil;
end;

for T,U in next,J do
U:UpdateButton();
end;
end;

N:UpdateButton();
ae:Display();

r:SafeCallback(ae.Callback,ae.Value);
r:SafeCallback(ae.Changed,ae.Value);

r:AttemptSave();
end;
end;
end);

N:UpdateButton();
ae:Display();

J[O]=N;
end;
H.CanvasSize=UDim2.fromOffset(0,(K*20)+1);

local L=math.clamp(K*20,0,C*20)+1;
F(L);
end;

function ae:SetValues(I)
if I then
ae.Values=I;
end;

ae:BuildDropdownList();
end;

function ae:OpenDropdown()
D.Visible=true;
r.OpenedFrames[D]=true;
z.Rotation=180;
end;

function ae:CloseDropdown()
D.Visible=false;
r.OpenedFrames[D]=nil;
z.Rotation=0;
end;

function ae:OnChanged(I)
ae.Changed=I;
I(ae.Value);
end;

function ae:SetValue(I)
if ae.Multi then
local J={};
for K,L in next,I do
if table.find(ae.Values,K)then
J[K]=true
end;
end;

ae.Value=J;
else
if(not I)then
ae.Value=nil;
elseif table.find(ae.Values,I)then
ae.Value=I;
end;
end;

ae:BuildDropdownList();

r:SafeCallback(ae.Callback,ae.Value);
r:SafeCallback(ae.Changed,ae.Value);
end;

aj.InputBegan:Connect(function(I)
if(I.UserInputType==Enum.UserInputType.MouseButton1 or I.UserInputType==Enum.UserInputType.Touch)and not r:MouseIsOverOpenedFrame()then
if D.Visible then
ae:CloseDropdown();
else
ae:OpenDropdown();
end;
end;
end);
c.InputBegan:Connect(function(I)
if(I.UserInputType==Enum.UserInputType.MouseButton1 or I.UserInputType==Enum.UserInputType.Touch)then
local J,K=D.AbsolutePosition,D.AbsoluteSize;

if m.X<J.X or m.X>J.X+K.X
or m.Y<(J.Y-20-1)or m.Y>J.Y+K.Y then

ae:CloseDropdown();
end;
end;
end);
ae:BuildDropdownList();
ae:Display();

local I={}

if type(ad.Default)=='string'then
local J=table.find(ae.Values,ad.Default)
if J then
table.insert(I,J)
end
elseif type(ad.Default)=='table'then
for J,K in next,ad.Default do
local L=table.find(ae.Values,K)
if L then
table.insert(I,L)
end
end
elseif type(ad.Default)=='number'and ae.Values[ad.Default]~=nil then
table.insert(I,ad.Default)
end

if next(I)then
for J=1,#I do
local K=I[J]
if ad.Multi then
ae.Value[ae.Values[K] ]=true
else
ae.Value=ae.Values[K];
end

if(not ad.Multi)then break end
end

ae:BuildDropdownList();
ae:Display();
end

af:AddBlank(ad.BlankSize or 5);
af:Resize();

q[ac]=ae;

return ae
end;
function ab:AddDependencyBox()
local ac={
Dependencies={};
};

local ad=self;
local ae=ad.Container;

local af=r:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,0,0);
Visible=false;
Parent=ae;
});
local ah=r:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,0);
Visible=true;
Parent=af;
});
local ai=r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=ah;
});
function ac:Resize()
af.Size=UDim2.new(1,0,0,ai.AbsoluteContentSize.Y);
ad:Resize();
end;

ai:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
ac:Resize();
end);
af:GetPropertyChangedSignal('Visible'):Connect(function()
ac:Resize();
end);
function ac:Update()
for aj,x in next,ac.Dependencies do
local z=x[1];
local A=x[2];

if z.Type=='Toggle'and z.Value~=A then
af.Visible=false;
ac:Resize();
return
end;
end;

af.Visible=true;
ac:Resize();
end;

function ac:SetupDependencies(aj)
for x,z in next,aj do
assert(type(z)=='table','SetupDependencies: Dependency is not of type `table`.');
assert(z[1],'SetupDependencies: Dependency is missing element argument.');
assert(z[2]~=nil,'SetupDependencies: Dependency is missing value argument.');
end;

ac.Dependencies=aj;
ac:Update();
end;

ac.Container=ah;

setmetatable(ac,aa);

table.insert(r.DependencyBoxes,ac);

return ac
end;

aa.__index=ab;
aa.__namecall=function(ac,ad,...)
return ab[ad](...)
end;
end;
do
r.NotificationArea=r:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,r.NotifyConfig.PositionX,0,r.NotifyConfig.PositionY);
Size=UDim2.new(0,300,1,-r.NotifyConfig.PositionY);
ZIndex=100;
Parent=o;
});
r.NotifLayout=r:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=r.NotificationArea;
});
local function ab()
local ac=r.NotifyConfig
local ad=r.NotificationArea
local ae=r.NotifLayout

ad.Position=UDim2.new(0,ac.PositionX,0,ac.PositionY)
ad.Size=UDim2.new(0,300,1,-ac.PositionY)

local af=ac.Alignment or'Left'
if af=='Left'then
ae.HorizontalAlignment=Enum.HorizontalAlignment.Left
ad.AnchorPoint=Vector2.new(0,0)
elseif af=='Right'then
ae.HorizontalAlignment=Enum.HorizontalAlignment.Right
ad.AnchorPoint=Vector2.new(0,0)
elseif af=='Center'then
ae.HorizontalAlignment=Enum.HorizontalAlignment.Center
ad.AnchorPoint=Vector2.new(0,0)
end
end
r.UpdateNotifAlignment=ab
ab()

local ac=r:Create('Frame',{
AnchorPoint=Vector2.new(0.5,0);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0.5,0,0,8);
Size=UDim2.new(0,213,0,20);
ZIndex=200;
Visible=false;
Parent=o;
});

local ad=r:Create("ImageLabel",{
Parent=ac,
ImageColor3=r.AccentColor,
ScaleType=Enum.ScaleType.Slice,
BorderColor3=Color3.fromRGB(0,0,0),
BackgroundColor3=Color3.fromRGB(255,255,255),
Image="http://www.roblox.com/asset/?id=18245826428",
BackgroundTransparency=1,
ImageTransparency=0.8,
Position=UDim2.new(0,-20,0,-20),
Size=UDim2.new(1,40,1,40),
ZIndex=1,
BorderSizePixel=0,
SliceCenter=Rect.new(Vector2.new(21,21),Vector2.new(79,79)),
})

r:AddToRegistry(ad,{
ImageColor3="AccentColor",
})

local ae=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.AccentColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=201;
Parent=ac;
});
r:AddToRegistry(ae,{
BorderColor3='AccentColor';
});
local af=r:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,1,-2);
ZIndex=202;
Parent=ae;
});
local ah=r:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,r:GetDarkerColor(r.MainColor)),
ColorSequenceKeypoint.new(1,r.MainColor),
});
Rotation=-90;
Parent=af;
});
r:AddToRegistry(ah,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,r:GetDarkerColor(r.MainColor)),
ColorSequenceKeypoint.new(1,r.MainColor),
})
end
});
local ai=r:CreateLabel({
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-4,1,0);
TextSize=r.FontSize;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=203;
Parent=af;
});
r.Watermark=ac;
r.WatermarkText=ai;
r:MakeDraggable(r.Watermark);

local aj=r:Create('Frame',{
AnchorPoint=Vector2.new(0,0.5);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,10,0.5,0);
Size=UDim2.new(0,210,0,100);
Visible=false;
ZIndex=100;
Parent=o;
});
r:ApplyGlow(aj);

local x=r:Create("ImageLabel",{
Parent=aj,
ImageColor3=r.AccentColor,
ScaleType=Enum.ScaleType.Slice,
BorderColor3=Color3.fromRGB(0,0,0),
BackgroundColor3=Color3.fromRGB(255,255,255),
Image="http://www.roblox.com/asset/?id=18245826428",
BackgroundTransparency=1,
ImageTransparency=0.8,
Position=UDim2.new(0,-20,0,-20),
Size=UDim2.new(1,40,1,40),
ZIndex=1,
BorderSizePixel=0,
SliceCenter=Rect.new(Vector2.new(21,21),Vector2.new(79,79)),
})

r:AddToRegistry(x,{
ImageColor3="AccentColor",
})

local z=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=101;
Parent=aj;
});
r:AddToRegistry(z,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
},true);
local A=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,0,15);
Size=UDim2.new(1,0,0,2);
ZIndex=102;
Parent=z;
});
r:AddToRegistry(A,{
BackgroundColor3='AccentColor';
},true);
local C=r:Create("ImageLabel",{
Parent=A,
ImageColor3=r.AccentColor,
ScaleType=Enum.ScaleType.Slice,
BorderColor3=Color3.fromRGB(0,0,0),
BackgroundColor3=Color3.fromRGB(255,255,255),
Image="http://www.roblox.com/asset/?id=18245826428",
BackgroundTransparency=1,
ImageTransparency=0.8,
Position=UDim2.new(0,0,0,-2),
Size=UDim2.new(1,0,0,8),
ZIndex=101,
BorderSizePixel=0,
SliceCenter=Rect.new(Vector2.new(21,21),Vector2.new(79,79)),
})

r:AddToRegistry(C,{
ImageColor3="AccentColor",
})

local D=r:CreateLabel({
Size=UDim2.new(1,0,0,20);
Position=UDim2.fromOffset(69,-3),
TextXAlignment=Enum.TextXAlignment.Left,

Text='Keybinds';
ZIndex=104;
Parent=z;
});
local E=r:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,-20);
Position=UDim2.new(0,0,0,20);
ZIndex=998;
Parent=z;
});
r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=E;
});
r:Create('UIPadding',{
PaddingLeft=UDim.new(0,5),
Parent=E,
})

r.KeybindFrame=aj;
r.KeybindContainer=E;
r:MakeDraggable(aj);
end;

function r:SetKeybindMode(ab)
assert(ab=='All'or ab=='Active'or ab=='Toggled',
"SetKeybindMode: Mode must be 'All', 'Active', or 'Toggled'")
r.KeybindMode=ab
r:RefreshKeybinds()
end

function r:RefreshKeybinds()
for ab,ac in ipairs(r.KeyPickerList)do
if not ac.NoUI then
pcall(function()ac:Update()end)
end
end
end

function r:SetWatermarkVisibility(ab)
r.Watermark.Visible=ab;
end;

function r:SetWatermark(ab)
local ac,ad=r:GetTextBounds(ab,r.Font,r.FontSize);
local ae=r.Watermark.Position.Y
r.Watermark.AnchorPoint=Vector2.new(0.5,0)
r.Watermark.Size=UDim2.new(0,ac+15,0,(ad*1.5)+3);
r.Watermark.Position=UDim2.new(0.5,0,ae.Scale,ae.Offset)
r:SetWatermarkVisibility(true)

r.WatermarkText.Text=ab;
end;
function r:Notify(ab,ac)
local ad=r.NotifyConfig
local ae=ad.BarSide or'Left'
local af=ad.Alignment or'Left'

local ah,ai=r:GetTextBounds(ab,r.Font,r.FontSize)
ai=ai+7

local aj=3
local x=3

local z=(ae=='Left')and 1 or 1
local A=(ae=='Top')and x or 1
local C=(ae=='Left'or ae=='Right')and-2 or-2
local D=(ae=='Top'or ae=='Bottom')and-(x+1)or-2

local E=(ae=='Left')and aj+2 or 4
local F=(ae=='Left'or ae=='Right')and-(aj+4)or-4

local G=Vector2.new(0,0)
local H=0
if af=='Center'then
G=Vector2.new(0.5,0)
H=0
elseif af=='Right'then
G=Vector2.new(1,0)
H=0
end

local I=r:Create('Frame',{
BackgroundTransparency=1;
AnchorPoint=G;
BorderColor3=Color3.new(0,0,0);
Position=(af=='Center')
and UDim2.new(0.5,0,0,0)
or(af=='Right'and UDim2.new(1,0,0,0)or UDim2.new(0,0,0,0));
Size=UDim2.new(0,0,0,ai);
ClipsDescendants=true;
ZIndex=100;
Parent=r.NotificationArea;
});
local J=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=101;
Parent=I;
});
r:AddToRegistry(J,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
},true);
local K=r:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Position=UDim2.new(0,z,0,A);
Size=UDim2.new(1,C,1,D);
ZIndex=102;
Parent=J;
});
local L=r:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,r:GetDarkerColor(r.MainColor)),
ColorSequenceKeypoint.new(1,r.MainColor),
});
Rotation=-90;
Parent=K;
});
r:AddToRegistry(L,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,r:GetDarkerColor(r.MainColor)),
ColorSequenceKeypoint.new(1,r.MainColor),
})
end
});
local M=r:CreateLabel({
Position=UDim2.new(0,E,0,0);
Size=UDim2.new(1,F,1,0);
Text=ab;
TextXAlignment=(af=='Center')
and Enum.TextXAlignment.Center
or Enum.TextXAlignment.Left;
TextSize=r.FontSize;
ZIndex=103;
Parent=K;
});
local N=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
ZIndex=104;
Parent=I;
});
if ae=='Left'then
N.Position=UDim2.new(0,-1,0,-1)
N.Size=UDim2.new(0,aj,1,2)
elseif ae=='Right'then
N.Position=UDim2.new(1,-aj+1,0,-1)
N.Size=UDim2.new(0,aj,1,2)
elseif ae=='Top'then
N.Position=UDim2.new(0,-1,0,-1)
N.Size=UDim2.new(1,2,0,x)
elseif ae=='Bottom'then
N.Position=UDim2.new(0,-1,1,-x+1)
N.Size=UDim2.new(1,2,0,x)
end

r:AddToRegistry(N,{
BackgroundColor3='AccentColor';
},true);
local O=ah+8+4
if ae=='Left'or ae=='Right'then
O=O+aj
end
pcall(I.TweenSize,I,
UDim2.new(0,O,0,ai),'Out','Quad',0.4,true);
task.spawn(function()
wait(ac or 5);
pcall(I.TweenSize,I,
UDim2.new(0,0,0,ai),'Out','Quad',0.4,true);
wait(0.4);
I:Destroy();
end);
end;

function r:CreateWindow(...)
local ab={...}
local ac={AnchorPoint=Vector2.zero}

if type(...)=='table'then
ac=...;
else
ac.Title=ab[1]
ac.AutoShow=ab[2]or false;
end

if type(ac.Title)~='string'then ac.Title='No title'end
if type(ac.TabPadding)~='number'then ac.TabPadding=0 end
if type(ac.MenuFadeTime)~='number'then ac.MenuFadeTime=0.2 end

if typeof(ac.Size)~='UDim2'then ac.Size=UDim2.fromOffset(550,600)end
if typeof(ac.Position)~='UDim2'then ac.Position=UDim2.fromOffset(175,50)end

if c.TouchEnabled then
local ad=workspace.CurrentCamera.ViewportSize
local ae=math.min(ac.Size.X.Offset,ad.X-20)

local af=math.min(ac.Size.Y.Offset,ad.Y-60)
ac.Size=UDim2.fromOffset(ae,af)
end

if ac.Center then
ac.AnchorPoint=Vector2.new(0.5,0.5)
ac.Position=UDim2.fromScale(0.5,0.5)
end

if ac.WireframeDrag~=nil then
r.WireframeDrag=ac.WireframeDrag
end

local ad={
Tabs={};
};

local ae=r:Create('Frame',{
AnchorPoint=ac.AnchorPoint,
BackgroundTransparency=1,
BorderSizePixel=0;
Position=ac.Position,
Size=ac.Size,
Visible=false;
ZIndex=1;
Parent=o;
});
r:MakeDraggable(ae,25,true);

local af=r:Create("ImageLabel",{
Parent=ae,
ImageColor3=r.AccentColor,
ScaleType=Enum.ScaleType.Slice,
BorderColor3=Color3.fromRGB(0,0,0),
BackgroundColor3=Color3.fromRGB(255,255,255),
Image="http://www.roblox.com/asset/?id=18245826428",
BackgroundTransparency=1,
ImageTransparency=0.8,
Position=UDim2.new(0,-20,0,-20),
Size=UDim2.new(1,40,1,40),
ZIndex=1,
BorderSizePixel=0,
SliceCenter=Rect.new(Vector2.new(21,21),Vector2.new(79,79)),
})

r:AddToRegistry(af,{
ImageColor3="AccentColor",
})

if ac.Resizable then
r:MakeResizable(ae,ac.MinSize,ac.MaxSize)
end

local ah=r:Create('Frame',{
Name="Inner",
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,1,-2);
ZIndex=1;
Parent=ae;
});
r:AddToRegistry(ah,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
local ai=r:CreateLabel({
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,0,25);
Text=ac.Title or'';
RichText=true;
TextXAlignment=Enum.TextXAlignment.Center;
ZIndex=1;
Parent=ah;
});
local aj=r:Create('ImageLabel',{
BackgroundTransparency=1;
Position=UDim2.new(0,2,0,-2);
Size=UDim2.new(0,28,0,28);
Image='rbxassetid://125779171427078';
ZIndex=2;
Parent=ah;
});
local x=r:CreateLabel({
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-7,0,0),
Size=UDim2.new(0,0,0,25),
Text='Loading...',
TextColor3=r.AccentColor,
TextXAlignment=Enum.TextXAlignment.Right,
ZIndex=1,
Parent=ah;
});
r:AddToRegistry(x,{
TextColor3='AccentColor';
});
task.spawn(function()
local z,A=pcall(function()
return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
end)
if z and A and A.Name then
x.Text="Wild Horse Islands"
else
x.Text="Wild Horse Islands"

end
end)


local z=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
Position=UDim2.new(0,8,0,25);
Size=UDim2.new(1,-16,0,29);
ZIndex=1;
Parent=ah;
});
r:AddToRegistry(z,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local A=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=1;
Parent=z;
});
r:AddToRegistry(A,{
BackgroundColor3='BackgroundColor';
});
local C=r:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,4,0,4);
Size=UDim2.new(1,-8,1,-8);
ZIndex=1;
Parent=A;
});
local D=r:Create('UIListLayout',{
Padding=UDim.new(0,ac.TabPadding);
FillDirection=Enum.FillDirection.Horizontal;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=C;
});
local E=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
Position=UDim2.new(0,8,0,58);
Size=UDim2.new(1,-16,1,-66);
ZIndex=1;
Parent=ah;
});
r:AddToRegistry(E,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local F=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
BorderMode=Enum.BorderMode.Inset;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ZIndex=1;
Parent=E;
});
r:AddToRegistry(F,{
BackgroundColor3='BackgroundColor';
});
local G=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=r.OutlineColor;
Position=UDim2.new(0,8,0,8);
Size=UDim2.new(1,-16,1,-16);
ZIndex=2;
Parent=F;
});
r:AddToRegistry(G,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
function ad:SetWindowTitle(H)
ai.Text=H;
end;
function ad:AddTab(H)
local I={
Groupboxes={};
Tabboxes={};
};

local J=r:GetTextBounds(H,r.Font,r.FontSize+2);
local K=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
Size=UDim2.new(0,J+8+4,1,0);
ZIndex=1;
Parent=C;
});
r:AddToRegistry(K,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local L=r:CreateLabel({
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,-1);
Text=H;
ZIndex=1;
Parent=K;
});
local M=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,0,2);
Visible=false;
ZIndex=4;
Parent=K;
});
r:AddToRegistry(M,{BackgroundColor3='AccentColor'});

local N=r:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(0,0,0,0);
Visible=false;
Parent=K;
});
local O=r:Create('Frame',{
Name='TabFrame',
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
Visible=false;
ZIndex=2;
Parent=G;
});
local P=r:Create("UIGradient",{
Rotation=-90,
Parent=O,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185)),
}),
})
local Q=r:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
Position=UDim2.new(0,8-1,0,8-1);
Size=UDim2.new(0.5,-12+2,1,-16);
CanvasSize=UDim2.new(0,0,0,0);
BottomImage='';
TopImage='';
ScrollBarThickness=0;
ZIndex=2;
Parent=O;
});
local R=r:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
Position=UDim2.new(0.5,4+1,0,8-1);
Size=UDim2.new(0.5,-12+2,1,-16);
CanvasSize=UDim2.new(0,0,0,0);
BottomImage='';
TopImage='';
ScrollBarThickness=0;
ZIndex=2;
Parent=O;
});
r:Create('UIListLayout',{
Padding=UDim.new(0,8);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
HorizontalAlignment=Enum.HorizontalAlignment.Center;
Parent=Q;
});
r:Create('UIListLayout',{
Padding=UDim.new(0,8);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
HorizontalAlignment=Enum.HorizontalAlignment.Center;
Parent=R;
});
for S,T in next,{Q,R}do
T:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
T.CanvasSize=UDim2.fromOffset(0,T.UIListLayout.AbsoluteContentSize.Y);
end);
end;

function I:ShowTab()
for S,T in next,ad.Tabs do
T:HideTab();
end;

N.BackgroundTransparency=0;
K.BackgroundColor3=r.MainColor;
r.RegistryMap[K].Properties.BackgroundColor3='MainColor';
O.Visible=true;
M.Visible=true;
end;
function I:HideTab()
N.BackgroundTransparency=1;
K.BackgroundColor3=r.BackgroundColor;
r.RegistryMap[K].Properties.BackgroundColor3='BackgroundColor';
O.Visible=false;
M.Visible=false;
end;
function I:SetLayoutOrder(S)
K.LayoutOrder=S;
D:ApplyLayout();
end;
function I:AddGroupbox(S)
local T={};
local U=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,0,507+2);
ZIndex=2;
Parent=S.Side==1 and Q or R;
});
r:AddToRegistry(U,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local V=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-2,1,-2);
Position=UDim2.new(0,1,0,1);
ZIndex=4;
Parent=U;
});
r:AddToRegistry(V,{
BackgroundColor3='BackgroundColor';
});
local W=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,0,2);
ZIndex=5;
Parent=V;
});
r:AddToRegistry(W,{
BackgroundColor3='AccentColor';
});
local X=r:CreateLabel({
Size=UDim2.new(1,0,0,18);
Position=UDim2.new(0,4,0,2);
TextSize=r.FontSize;
Text=S.Name;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=V;
});
local Y=r:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,4,0,20);
Size=UDim2.new(1,-4,1,-20);
ZIndex=1;
Parent=V;
});
r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=Y;
});
function T:Resize()
local Z=0;
for _,ak in next,T.Container:GetChildren()do
if(not ak:IsA('UIListLayout'))and ak.Visible then
Z=Z+ak.Size.Y.Offset;
end;
end;

U.Size=UDim2.new(1,0,0,20+Z+2+2);
end;

T.Container=Y;
setmetatable(T,aa);
T:AddBlank(3);
T:Resize();

I.Groupboxes[S.Name]=T;

return T
end;

function I:AddLeftGroupbox(ak)
return I:AddGroupbox({Side=1;Name=ak;})
end;

function I:AddRightGroupbox(ak)
return I:AddGroupbox({Side=2;Name=ak;})
end;

function I:AddTabbox(ak)
local S={
Tabs={};
};

local T=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=r.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,0,0);
ZIndex=2;
Parent=ak.Side==1 and Q or R;
});
r:AddToRegistry(T,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local U=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderColor3=Color3.new(0.109804,0.109804,0.129412);
Size=UDim2.new(1,-2,1,-2);
Position=UDim2.new(0,1,0,1);
ZIndex=4;
Parent=T;
});
r:AddToRegistry(U,{
BackgroundColor3='BackgroundColor';
});
local V=r:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,1);
Size=UDim2.new(1,0,0,18);
ZIndex=5;
Parent=U;
});
r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Left;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=V;
});
function S:AddTab(W)
local X={};
local Y=r:Create('Frame',{
BackgroundColor3=r.MainColor;
BorderColor3=Color3.new(0.109804,0.109804,0.129412);
Size=UDim2.new(0.5,0,1,0);
ZIndex=6;
Parent=V;
});
r:AddToRegistry(Y,{
BackgroundColor3='MainColor';
});
local Z=r:Create('Frame',{
BackgroundColor3=r.AccentColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,0,2);
Visible=false;
ZIndex=10;
Parent=Y;
});
r:AddToRegistry(Z,{
BackgroundColor3='AccentColor';
});
local _=r:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=r.FontSize;
Text=W;
TextXAlignment=Enum.TextXAlignment.Center;
ZIndex=7;
Parent=Y;
});
local al=r:Create('Frame',{
BackgroundColor3=r.BackgroundColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,1,0);
Size=UDim2.new(1,0,0,1);
Visible=false;
ZIndex=9;
Parent=Y;
});
r:AddToRegistry(al,{
BackgroundColor3='BackgroundColor';
});
local am=r:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,4,0,20);
Size=UDim2.new(1,-4,1,-20);
ZIndex=1;
Visible=false;
Parent=U;
});
r:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=am;
});
function X:Show()
for an,ao in next,S.Tabs do
ao:Hide();
end;

am.Visible=true;
al.Visible=true;
Z.Visible=true;

Y.BackgroundColor3=r.BackgroundColor;
r.RegistryMap[Y].Properties.BackgroundColor3='BackgroundColor';

X:Resize();
end;
function X:Hide()
am.Visible=false;
al.Visible=false;
Z.Visible=false;

Y.BackgroundColor3=r.MainColor;
r.RegistryMap[Y].Properties.BackgroundColor3='MainColor';
end;
function X:Resize()
local an=0;
for ao,ap in next,S.Tabs do
an=an+1;
end;

for ao,ap in next,V:GetChildren()do
if not ap:IsA('UIListLayout')then
ap.Size=UDim2.new(1/an,0,1,0);
end;
end;

if(not am.Visible)then
return
end;

local ao=0;

for ap,aq in next,X.Container:GetChildren()do
if(not aq:IsA('UIListLayout'))and aq.Visible then
ao=ao+aq.Size.Y.Offset;
end;
end;

T.Size=UDim2.new(1,0,0,20+ao+2+2);
end;
Y.InputBegan:Connect(function(an)
if(an.UserInputType==Enum.UserInputType.MouseButton1 or an.UserInputType==Enum.UserInputType.Touch)and not r:MouseIsOverOpenedFrame()then
X:Show();
X:Resize();
end;
end);

X.Container=am;
S.Tabs[W]=X;

setmetatable(X,aa);

X:AddBlank(3);
X:Resize();

if#V:GetChildren()==2 then
X:Show();
end;

return X
end;

I.Tabboxes[ak.Name or'']=S;

return S
end;
function I:AddLeftTabbox(ak)
return I:AddTabbox({Name=ak,Side=1;})
end;

function I:AddRightTabbox(ak)
return I:AddTabbox({Name=ak,Side=2;})
end;

K.InputBegan:Connect(function(ak)
if(ak.UserInputType==Enum.UserInputType.MouseButton1 or ak.UserInputType==Enum.UserInputType.Touch)then
I:ShowTab();
end;
end);
if#G:GetChildren()==1 then
I:ShowTab();
end;
ad.Tabs[H]=I;
return I
end;

local ak=r:Create('TextButton',{
BackgroundTransparency=1;
Size=UDim2.new(0,0,0,0);
Visible=true;
Text='';
Modal=false;
Parent=o;
});
function r:Toggle()
r.Toggled=not r.Toggled;
ak.Modal=r.Toggled;
ae.Visible=r.Toggled;
if r.Toggled then
task.spawn(function()
local al=c.MouseIconEnabled;

local am=Drawing.new('Triangle');
am.Thickness=1;
am.Filled=true;
am.Visible=true;

local an=Drawing.new('Triangle');
an.Thickness=1;
an.Filled=false;
an.Color=Color3.new(0,0,0);
an.Visible=true;

while r.Toggled and o.Parent do
c.MouseIconEnabled=false;

local ao=c:GetMouseLocation();

am.Color=r.AccentColor;

am.PointA=Vector2.new(ao.X,ao.Y);
am.PointB=Vector2.new(ao.X+16,ao.Y+6);
am.PointC=Vector2.new(ao.X+6,ao.Y+16);
an.PointA=am.PointA;
an.PointB=am.PointB;
an.PointC=am.PointC;

k:Wait();
end;

c.MouseIconEnabled=al;

am:Remove();
an:Remove();
end);
end;
if r.UseBlur then
if r.Toggled then
r.BlurEffect.Enabled=true
r.BlurEffect.Size=r.BlurSize
else
r.BlurEffect.Size=0
r.BlurEffect.Enabled=false
end
else
r.BlurEffect.Size=0
r.BlurEffect.Enabled=false
end
end

r:GiveSignal(c.InputBegan:Connect(function(al,am)
if type(r.ToggleKeybind)=='table'and r.ToggleKeybind.Type=='KeyPicker'then
if al.UserInputType==Enum.UserInputType.Keyboard and al.KeyCode.Name==r.ToggleKeybind.Value then
task.spawn(r.Toggle)
end
elseif type(r.ToggleKeybind)=='string'then
if al.UserInputType==Enum.UserInputType.Keyboard and al.KeyCode.Name==r.ToggleKeybind then
task.spawn(r.Toggle)
end
elseif al.KeyCode==Enum.KeyCode.RightControl or(al.KeyCode==Enum.KeyCode.RightShift and(not am))then
task.spawn(r.Toggle)
end
end))

if ac.AutoShow then task.spawn(r.Toggle)end

ad.Holder=ae;
return ad
end;

local function ab()
local ac=u();
for ad,ae in next,q do
if ae.Type=='Dropdown'and ae.SpecialType=='Player'then
ae:SetValues(ac);
end;
end;
end;

g.PlayerAdded:Connect(ab);
g.PlayerRemoving:Connect(ab);

if c.TouchEnabled then
local ac=Instance.new("ScreenGui")
ac.Name="LinoriaMobileUI"
ac.ZIndexBehavior=Enum.ZIndexBehavior.Global
n(ac)
ac.Parent=e

local ad,ae=88,30
local af=40

local function ah(ai,aj,ak)
local al=r:Create('Frame',{
Name=ai.."Outer",
BackgroundColor3=r.OutlineColor,
BorderSizePixel=0,
Position=ak,
Size=UDim2.new(0,ad,0,ae),
ZIndex=300,
Parent=ac,
Active=true,
})
r:AddToRegistry(al,{BackgroundColor3='OutlineColor'})

local am=r:Create('Frame',{
Name=ai.."Accent",
BackgroundColor3=r.AccentColor,
BorderSizePixel=0,
Position=UDim2.new(0,1,0,1),
Size=UDim2.new(1,-2,1,-2),
ZIndex=301,
Parent=al,
})
r:AddToRegistry(am,{BackgroundColor3='AccentColor'})

local an=r:Create('Frame',{
Name=ai.."Inner",
BackgroundColor3=Color3.fromRGB(8,8,12),
BorderSizePixel=0,
Position=UDim2.new(0,1,0,1),
Size=UDim2.new(1,-2,1,-2),
ZIndex=302,
Parent=am,
})

local ao=r:Create('Frame',{
Name=ai.."Gradient",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Size=UDim2.new(1,0,1,0),
ZIndex=303,
Parent=an,
})
r:Create('UIGradient',{
Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0,0.90),
NumberSequenceKeypoint.new(1,1.0)
}),
Rotation=90,
Parent=ao,
})

local ap=r:Create('TextButton',{
Name=ai.."Btn",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Font=Enum.Font.Code,
Text=aj,
TextColor3=Color3.fromRGB(255,255,255),
TextSize=r.FontSize-1,
ZIndex=304,
Parent=an,
Active=true,
})

return al,ap
end

local ai,aj=ah("Toggle","Toggle UI",UDim2.new(0,10,0,10))
local ak,al=ah("Lock","Unlock UI",UDim2.new(0,10,0,10+ae+(af-ae)))

local am=false

local function an(ao,ap,aq)
local x=false
local z=nil
local A=nil
local C=nil
local D=false

ao.InputBegan:Connect(function(E)
if E.UserInputType==Enum.UserInputType.MouseButton1
or E.UserInputType==Enum.UserInputType.Touch then
x=true
D=false
A=E.Position
C=ap.Position
z=E

local F
F=E.Changed:Connect(function()
if E.UserInputState==Enum.UserInputState.End then
x=false
F:Disconnect()
if not D then
aq()
end
end
end)
end
end)

c.InputChanged:Connect(function(E)
if E==z and x then
local F=E.Position-A
if F.Magnitude>3 then
D=true
end
if am and D then
ap.Position=UDim2.new(
C.X.Scale,C.X.Offset+F.X,
C.Y.Scale,C.Y.Offset+F.Y
)
end
end
end)
end

an(aj,ai,function()
r:Toggle()
end)

an(al,ak,function()
am=not am
al.Text=am and"Lock UI"or"Unlock UI"
al.TextColor3=am
and r.AccentColor
or Color3.fromRGB(255,255,255)
end)

local ao=r.UpdateColorsUsingRegistry
r.UpdateColorsUsingRegistry=function(ap)
ao(ap)
end
end

getgenv().Library=r
return r end function a.a():typeof(b())local aa=a.cache.a if not aa then aa={c=b()}a.cache.a=aa end return aa.c end end do local function aa()

local ab=game:GetService('HttpService')
local ac={}do
ac.Folder='LinoriaLibSettings'


ac.Library=nil
ac.BuiltInThemes={
['Default']={1,ab:JSONDecode('{"MainColor":"242328","AccentColor":"faa614","OutlineColor":"323232","BackgroundColor":"212025","FontColor":"ffffff"}')},
['Yuki']={2,ab:JSONDecode('{"MainColor":"171515","AccentColor":"bab972","OutlineColor":"1b1919","BackgroundColor":"131111","FontColor":"c8c8c8"}')},
['Blue']={3,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"181818","AccentColor":"4777b6","BackgroundColor":"141414","OutlineColor":"1f1f1f"}')},
['Primordial']={4,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"181818","AccentColor":"d7a6b0","BackgroundColor":"1f1f1f","OutlineColor":"2a2a2a"}')},
['BBot']={5,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}')},
['Fatality']={6,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","BackgroundColor":"191335","OutlineColor":"3c355d"}')},
['Jester']={7,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},
['Mint']={8,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},
['Tokyo Night']={9,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}')},
['Ubuntu']={10,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}')},
['Quartz']={11,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","BackgroundColor":"1d1b26","OutlineColor":"27232f"}')},
}

function ac:ApplyTheme(ad)
local ae=self:GetCustomTheme(ad)
local af=ae or self.BuiltInThemes[ad]

if not af then return end



local ah=af[2]
for ai,aj in next,ae or ah do
self.Library[ai]=Color3.fromHex(aj)

if Options[ai]then
Options[ai]:SetValueRGB(Color3.fromHex(aj))
end
end

self:ThemeUpdate()
end

function ac:ThemeUpdate()

local ad={"FontColor","MainColor","AccentColor","BackgroundColor","OutlineColor"}
for ae,af in next,ad do
if Options and Options[af]then
self.Library[af]=Options[af].Value
end
end

self.Library.AccentColorDark=self.Library:GetDarkerColor(self.Library.AccentColor);
self.Library:UpdateColorsUsingRegistry()
end

function ac:LoadDefault()
local ad='Default'
local ae=isfile(self.Folder..'/themes/default.txt')and readfile(self.Folder..'/themes/default.txt')

local af=true
if ae then
if self.BuiltInThemes[ae]then
ad=ae
elseif self:GetCustomTheme(ae)then
ad=ae
af=false;
end
elseif self.BuiltInThemes[self.DefaultTheme]then
ad=self.DefaultTheme
end

if af then
Options.ThemeManager_ThemeList:SetValue(ad)
else
self:ApplyTheme(ad)
end
end

function ac:SaveDefault(ad)
writefile(self.Folder..'/themes/default.txt',ad)
end

function ac:CreateThemeManager(ad)
ad:AddLabel('Background color'):AddColorPicker('BackgroundColor',{Default=self.Library.BackgroundColor});
ad:AddLabel('Main color'):AddColorPicker('MainColor',{Default=self.Library.MainColor});
ad:AddLabel('Accent color'):AddColorPicker('AccentColor',{Default=self.Library.AccentColor});
ad:AddLabel('Outline color'):AddColorPicker('OutlineColor',{Default=self.Library.OutlineColor});
ad:AddLabel('Font color'):AddColorPicker('FontColor',{Default=self.Library.FontColor});

local ae={}
for af,ah in next,self.BuiltInThemes do
table.insert(ae,af)
end

table.sort(ae,function(af,ah)return self.BuiltInThemes[af][1]<self.BuiltInThemes[ah][1]end)

ad:AddDivider()
ad:AddDropdown('ThemeManager_ThemeList',{Text='Theme list',Values=ae,Default=1})

ad:AddButton('Set as default',function()
self:SaveDefault(Options.ThemeManager_ThemeList.Value)
self.Library:Notify(string.format('Set default theme to %q',Options.ThemeManager_ThemeList.Value))
end)

Options.ThemeManager_ThemeList:OnChanged(function()
self:ApplyTheme(Options.ThemeManager_ThemeList.Value)
end)

ad:AddDivider()
ad:AddInput('ThemeManager_CustomThemeName',{Text='Custom theme name'})
ad:AddDropdown('ThemeManager_CustomThemeList',{Text='Custom themes',Values=self:ReloadCustomThemes(),AllowNull=true,Default=1})
ad:AddDivider()

ad:AddButton('Save theme',function()
self:SaveCustomTheme(Options.ThemeManager_CustomThemeName.Value)

Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
Options.ThemeManager_CustomThemeList:SetValue(nil)
end):AddButton('Load theme',function()
self:ApplyTheme(Options.ThemeManager_CustomThemeList.Value)
end)

ad:AddButton('Refresh list',function()
Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
Options.ThemeManager_CustomThemeList:SetValue(nil)
end)

ad:AddButton('Set as default',function()
if Options.ThemeManager_CustomThemeList.Value~=nil and Options.ThemeManager_CustomThemeList.Value~=''then
self:SaveDefault(Options.ThemeManager_CustomThemeList.Value)
self.Library:Notify(string.format('Set default theme to %q',Options.ThemeManager_CustomThemeList.Value))
end
end)

ac:LoadDefault()

local function af()
self:ThemeUpdate()
end

Options.BackgroundColor:OnChanged(af)
Options.MainColor:OnChanged(af)
Options.AccentColor:OnChanged(af)
Options.OutlineColor:OnChanged(af)
Options.FontColor:OnChanged(af)
end

function ac:GetCustomTheme(ad)
local ae=self.Folder..'/themes/'..ad
if not isfile(ae)then
return nil
end

local af=readfile(ae)
local ah,ai=pcall(ab.JSONDecode,ab,af)

if not ah then
return nil
end

return ai
end

function ac:SaveCustomTheme(ad)
if ad:gsub(' ','')==''then
return self.Library:Notify('Invalid file name for theme (empty)',3)
end

local ae={}
local af={"FontColor","MainColor","AccentColor","BackgroundColor","OutlineColor"}

for ah,ai in next,af do
ae[ai]=Options[ai].Value:ToHex()
end

writefile(self.Folder..'/themes/'..ad..'.json',ab:JSONEncode(ae))
end

function ac:ReloadCustomThemes()
local ad=listfiles(self.Folder..'/themes')

local ae={}
for af=1,#ad do
local ah=ad[af]
if ah:sub(-5)=='.json'then


local ai=ah:find('.json',1,true)
local aj=ah:sub(ai,ai)

while aj~='/'and aj~='\\'and aj~=''do
ai=ai-1
aj=ah:sub(ai,ai)
end

if aj=='/'or aj=='\\'then
table.insert(ae,ah:sub(ai+1))
end
end
end

return ae
end

function ac:SetLibrary(ad)
self.Library=ad
end

function ac:BuildFolderTree()
local ad={}




local ae=self.Folder:split('/')
for af=1,#ae do
ad[#ad+1]=table.concat(ae,'/',1,af)
end

table.insert(ad,self.Folder..'/themes')
table.insert(ad,self.Folder..'/settings')

for af=1,#ad do
local ah=ad[af]
if not isfolder(ah)then
makefolder(ah)
end
end
end

function ac:SetFolder(ad)
self.Folder=ad
self:BuildFolderTree()
end

function ac:CreateGroupBox(ad)
assert(self.Library,'Must set ThemeManager.Library first!')
return ad:AddLeftGroupbox('Themes')
end

function ac:ApplyToTab(ad)
assert(self.Library,'Must set ThemeManager.Library first!')
local ae=self:CreateGroupBox(ad)
self:CreateThemeManager(ae)
end

function ac:ApplyToGroupbox(ad)
assert(self.Library,'Must set ThemeManager.Library first!')
self:CreateThemeManager(ad)
end

ac:BuildFolderTree()
end

return ac end function a.b():typeof(aa())local ab=a.cache.b if not ab then ab={c=aa()}a.cache.b=ab end return ab.c end end do local function aa()

local ab=game:GetService('HttpService')

local ac={}do
ac.Folder='LinoriaLibSettings'
ac.Ignore={}
ac.Parser={
Toggle={
Save=function(ad,ae)
return{type='Toggle',idx=ad,value=ae.Value}
end,
Load=function(ad,ae)
if Toggles[ad]then
Toggles[ad]:SetValue(ae.value)
end
end,
},
Slider={
Save=function(ad,ae)
return{type='Slider',idx=ad,value=tostring(ae.Value)}
end,
Load=function(ad,ae)
if Options[ad]then
Options[ad]:SetValue(ae.value)
end
end,
},
Dropdown={
Save=function(ad,ae)
return{type='Dropdown',idx=ad,value=ae.Value,mutli=ae.Multi}
end,
Load=function(ad,ae)
if Options[ad]then
Options[ad]:SetValue(ae.value)
end
end,
},
ColorPicker={
Save=function(ad,ae)
return{type='ColorPicker',idx=ad,value=ae.Value:ToHex(),transparency=ae.Transparency}
end,
Load=function(ad,ae)
if Options[ad]then
Options[ad]:SetValueRGB(Color3.fromHex(ae.value),Options[ad].HasTransparency and ae.transparency or 0)
end
end,
},
KeyPicker={
Save=function(ad,ae)
return{type='KeyPicker',idx=ad,mode=ae.Mode,key=ae.Value}
end,
Load=function(ad,ae)
if Options[ad]then
Options[ad]:SetValue({ae.key,ae.mode})
end
end,
},

Input={
Save=function(ad,ae)
return{type='Input',idx=ad,text=ae.Value}
end,
Load=function(ad,ae)
if Options[ad]and type(ae.text)=='string'then
Options[ad]:SetValue(ae.text)
end
end,
},
}

function ac:SetIgnoreIndexes(ad)
for ae,af in next,ad do
self.Ignore[af]=true
end
end

function ac:SetFolder(ad)
self.Folder=ad;
self:BuildFolderTree()
end

function ac:Save(ad)
if(not ad)then
return false,'no config file is selected'
end

local ae=self.Folder..'/settings/'..ad..'.json'

local af={
objects={}
}

for ah,ai in next,Toggles do
if self.Ignore[ah]then continue end

table.insert(af.objects,self.Parser[ai.Type].Save(ah,ai))
end

for ah,ai in next,Options do
if not self.Parser[ai.Type]then continue end
if self.Ignore[ah]then continue end

table.insert(af.objects,self.Parser[ai.Type].Save(ah,ai))
end

local ah,ai=pcall(ab.JSONEncode,ab,af)
if not ah then
return false,'failed to encode data'
end

writefile(ae,ai)
return true
end

function ac:Load(ad)
if(not ad)then
return false,'no config file is selected'
end

local ae=self.Folder..'/settings/'..ad..'.json'
if not isfile(ae)then return false,'invalid file'end

local af,ah=pcall(ab.JSONDecode,ab,readfile(ae))
if not af then return false,'decode error'end

for ai,aj in next,ah.objects do
if self.Parser[aj.type]then
task.spawn(function()self.Parser[aj.type].Load(aj.idx,aj)end)
end
end

return true
end

function ac:IgnoreThemeSettings()
self:SetIgnoreIndexes({
"BackgroundColor","MainColor","AccentColor","OutlineColor","FontColor",
"ThemeManager_ThemeList",'ThemeManager_CustomThemeList','ThemeManager_CustomThemeName',
})
end

function ac:BuildFolderTree()
local ad={
self.Folder,
self.Folder..'/themes',
self.Folder..'/settings'
}

for ae=1,#ad do
local af=ad[ae]
if not isfolder(af)then
makefolder(af)
end
end
end

function ac:RefreshConfigList()
local ad=listfiles(self.Folder..'/settings')

local ae={}
for af=1,#ad do
local ah=ad[af]
if ah:sub(-5)=='.json'then


local ai=ah:find('.json',1,true)
local aj=ai

local ak=ah:sub(ai,ai)
while ak~='/'and ak~='\\'and ak~=''do
ai=ai-1
ak=ah:sub(ai,ai)
end

if ak=='/'or ak=='\\'then
table.insert(ae,ah:sub(ai+1,aj-1))
end
end
end

return ae
end

function ac:SetLibrary(ad)
self.Library=ad
end

function ac:LoadAutoloadConfig()
if isfile(self.Folder..'/settings/autoload.txt')then
local ad=readfile(self.Folder..'/settings/autoload.txt')

local ae,af=self:Load(ad)
if not ae and not SILENT then
return self.Library:Notify('Failed to load autoload config: '..af)
end
if not SILENT then
self.Library:Notify(string.format('Auto loaded config %q',ad))
end
end
end


function ac:BuildConfigSection(ad)
assert(self.Library,'Must set SaveManager.Library')

local ae=ad:AddRightGroupbox('Configuration')

ae:AddInput('SaveManager_ConfigName',{Text='Config name'})
ae:AddDropdown('SaveManager_ConfigList',{Text='Config list',Values=self:RefreshConfigList(),AllowNull=true})

ae:AddDivider()

ae:AddButton('Create config',function()
local af=Options.SaveManager_ConfigName.Value

if af:gsub(' ','')==''then
return self.Library:Notify('Invalid config name (empty)',2)
end

local ah,ai=self:Save(af)
if not ah then
return self.Library:Notify('Failed to save config: '..ai)
end

self.Library:Notify(string.format('Created config %q',af))

Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
Options.SaveManager_ConfigList:SetValue(nil)
end):AddButton('Load config',function()
local af=Options.SaveManager_ConfigList.Value

local ah,ai=self:Load(af)
if not ah then
return self.Library:Notify('Failed to load config: '..ai)
end

self.Library:Notify(string.format('Loaded config %q',af))
end)

ae:AddButton('Overwrite config',function()
local af=Options.SaveManager_ConfigList.Value

local ah,ai=self:Save(af)
if not ah then
return self.Library:Notify('Failed to overwrite config: '..ai)
end

self.Library:Notify(string.format('Overwrote config %q',af))
end)

ae:AddButton('Refresh list',function()
Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
Options.SaveManager_ConfigList:SetValue(nil)
end)

ae:AddButton('Set autoload',function()
local af=Options.SaveManager_ConfigList.Value
if(not af)then
return
end;
writefile(self.Folder..'/settings/autoload.txt',af)
ac.AutoloadLabel:SetText('Current autoload config: '..af)
self.Library:Notify(string.format('Set %q to auto load',af))
end):AddButton('Remove autoload',function()
local af=Options.SaveManager_ConfigList.Value
if(isfile(self.Folder..'/settings/autoload.txt'))then
delfile(self.Folder..'/settings/autoload.txt');
end;
ac.AutoloadLabel:SetText('Current autoload config: none')
self.Library:Notify("removed autoload");
end)

ac.AutoloadLabel=ae:AddLabel('Current autoload config: none',true)

if isfile(self.Folder..'/settings/autoload.txt')then
local af=readfile(self.Folder..'/settings/autoload.txt')
ac.AutoloadLabel:SetText('Current autoload config: '..af)
end

ac:SetIgnoreIndexes({'SaveManager_ConfigList','SaveManager_ConfigName'})
end

ac:BuildFolderTree()
end
getgenv().SaveManager=ac;
return ac end function a.c():typeof(aa())local ab=a.cache.c if not ab then ab={c=aa()}a.cache.c=ab end return ab.c end end do local function aa()




local ab=game:GetService("Players")
local ac=game:GetService("RunService")
local ad=game:GetService("ReplicatedStorage")

local ae=ab.LocalPlayer

local af=require(ad:WaitForChild("References"))
local ah=require(af.PlayerScripts:WaitForChild("Secondary"):WaitForChild("TravelHandler"))




local ai=3
local aj=40
local ak=0.1
local al=40

local am=false
local an=false
local ao=ak
local ap=aj




local aq={
"Mainland","Blizzard Island","Forest Island","Royal Island",
"Desert Island","Glacier Island","Mountain Island","Jungle Island",
"Lunar Islands","Volcano Island",
}

local b={
["Mainland"]=8,["Stable Island"]=1,
["Training Island"]=1,["Royal Island"]=1,
["Volcano Island"]=1,["Blizzard Island"]=1,
["Forest Island"]=1,["Desert Island"]=1,
["Glacier Island"]=1,["Mountain Island"]=1,
["Jungle Island"]=1,["Lunar Islands"]=1,
}

local c={
["Mainland"]={
CFrame.new(665.936,14.998,-201.439,0.160052,0.000000,0.987109,0.000000,1.000000,-0.000000,-0.987109,0.000000,0.160052),
CFrame.new(390.433,19.315,-318.522,0.433055,-0.000000,0.901368,0.000000,1.000000,0.000000,-0.901368,0.000000,0.433055),
CFrame.new(361.149,80.161,-536.547,0.999545,-0.000000,0.030152,0.000000,1.000000,-0.000000,-0.030152,0.000000,0.999545),
CFrame.new(321.848,21.772,-876.733,-0.212789,0.000000,0.977098,0.000000,1.000000,-0.000000,-0.977098,0.000000,-0.212789),
CFrame.new(217.005,104.998,-612.001,-0.733737,-0.000000,-0.679433,-0.000000,1.000000,-0.000000,0.679433,-0.000000,-0.733737),
CFrame.new(43.606,14.998,-61.387,-0.917488,0.000000,0.397764,0.000000,1.000000,-0.000000,-0.397764,-0.000000,-0.917488),
CFrame.new(433.122,33.563,39.955,0.999795,0.000000,-0.020224,-0.000000,1.000000,0.000000,0.020224,-0.000000,0.999795),
CFrame.new(582.080,22.779,150.222,-0.422344,-0.000000,-0.906435,0.000000,1.000000,-0.000000,0.906435,-0.000000,-0.422344),
CFrame.new(861.912,14.998,216.408,-0.386769,0.000000,0.922177,-0.000000,1.000000,-0.000000,-0.922177,-0.000000,-0.386769),
CFrame.new(737.339,14.998,581.619,-0.876427,0.000000,0.481535,0.000000,1.000000,0.000000,-0.481535,0.000000,-0.876427),
CFrame.new(508.405,14.998,816.679,-0.882457,0.000000,0.470393,0.000000,1.000000,-0.000000,-0.470393,-0.000000,-0.882457),
CFrame.new(-20.912,18.419,927.573,0.880280,-0.000000,0.474455,0.000000,1.000000,0.000000,-0.474455,-0.000000,0.880280),
CFrame.new(-380.807,35.123,678.163,0.915341,-0.000000,0.402679,0.000000,1.000000,0.000000,-0.402679,0.000000,0.915341),
CFrame.new(-252.048,39.135,804.587,-0.175896,-0.000000,-0.984409,-0.000000,1.000000,-0.000000,0.984409,0.000000,-0.175896),
CFrame.new(-156.075,133.629,601.806,0.794045,-0.000000,-0.607859,0.000000,1.000000,0.000000,0.607859,-0.000000,0.794045),
CFrame.new(-29.686,193.046,621.971,0.923170,0.000000,0.384391,-0.000000,1.000000,-0.000000,-0.384391,-0.000000,0.923170),
CFrame.new(30.838,122.484,340.240,-0.972864,-0.000000,-0.231379,-0.000000,1.000000,-0.000000,0.231379,-0.000000,-0.972864),
CFrame.new(-770.175,15.971,385.762,0.806249,-0.000000,0.591576,-0.000000,1.000000,0.000000,-0.591576,-0.000000,0.806249),
CFrame.new(-925.341,15.247,65.800,0.998214,-0.000000,-0.059738,0.000000,1.000000,0.000000,0.059738,-0.000000,0.998214),
CFrame.new(-876.237,15.426,-293.784,0.999537,0.000000,-0.030441,-0.000000,1.000000,0.000000,0.030441,-0.000000,0.999537),
CFrame.new(-418.191,14.998,-754.435,0.254495,-0.000000,0.967074,-0.000000,1.000000,0.000000,-0.967074,-0.000000,0.254495),
CFrame.new(-444.135,20.839,-376.701,-0.615930,0.000000,-0.787800,-0.000000,1.000000,0.000000,0.787800,0.000000,-0.615930),
CFrame.new(-483.923,82.639,-177.806,-0.471303,0.000000,0.881971,0.000000,1.000000,-0.000000,-0.881971,0.000000,-0.471303),
CFrame.new(-503.018,116.094,-60.103,-0.965255,0.000000,-0.261309,0.000000,1.000000,0.000000,0.261309,0.000000,-0.965255),
CFrame.new(-629.732,137.707,311.997,-0.199397,0.000000,-0.979919,0.000000,1.000000,0.000000,0.979919,0.000000,-0.199397)
},
["Blizzard Island"]={
CFrame.new(-382.042,92.995,-3522.306,0.460438,0.000000,-0.887692,0.000000,1.000000,0.000000,0.887692,-0.000000,0.460438),
CFrame.new(-758.201,61.008,-3531.670,0.276509,0.000000,0.961011,0.000000,1.000000,-0.000000,-0.961011,0.000000,0.276509),
CFrame.new(-1105.937,109.860,-3519.610,0.726535,-0.000000,-0.687130,-0.000000,1.000000,-0.000000,0.687130,0.000000,0.726535),
CFrame.new(-1257.574,62.161,-3631.305,-0.914364,-0.000000,-0.404892,-0.000000,1.000000,-0.000000,0.404892,-0.000000,-0.914364),
CFrame.new(-967.561,14.404,-3950.552,-0.997720,0.000000,0.067482,0.000000,1.000000,-0.000000,-0.067482,-0.000000,-0.997720),
CFrame.new(-728.238,14.404,-3776.091,-0.382731,0.000000,-0.923860,-0.000000,1.000000,0.000000,0.923860,0.000000,-0.382731),
CFrame.new(-706.962,60.998,-4103.288,-0.236992,0.000000,-0.971512,-0.000000,1.000000,0.000000,0.971512,0.000000,-0.236992),
CFrame.new(-425.512,44.028,-4108.528,-0.182664,-0.000000,-0.983175,-0.000000,1.000000,-0.000000,0.983175,-0.000000,-0.182664),
CFrame.new(-93.559,18.113,-3925.751,-0.259992,-0.000000,-0.965611,-0.000000,1.000000,-0.000000,0.965611,-0.000000,-0.259992),
CFrame.new(146.277,29.452,-3828.152,-0.754581,0.000000,-0.656207,-0.000000,1.000000,0.000000,0.656207,0.000000,-0.754581),
CFrame.new(513.539,35.080,-3722.744,-0.805225,-0.000000,-0.592970,-0.000000,1.000000,-0.000000,0.592970,-0.000000,-0.805225),
CFrame.new(689.042,37.192,-3576.572,-0.837222,-0.000000,-0.546863,-0.000000,1.000000,-0.000000,0.546863,-0.000000,-0.837222),
CFrame.new(869.162,22.305,-3565.883,0.161352,0.000000,-0.986897,-0.000000,1.000000,-0.000000,0.986897,0.000000,0.161352),
CFrame.new(1215.247,19.139,-3584.557,-0.917856,-0.000000,-0.396913,-0.000000,1.000000,-0.000000,0.396913,-0.000000,-0.917856),
CFrame.new(660.312,15.404,-3308.462,0.009147,-0.000000,0.999958,-0.000000,1.000000,0.000000,-0.999958,-0.000000,0.009147),
CFrame.new(178.478,14.537,-3340.854,0.082006,-0.000000,0.996632,-0.000000,1.000000,0.000000,-0.996632,-0.000000,0.082006),
CFrame.new(-165.832,92.998,-3478.214,0.793830,-0.000000,0.608140,0.000000,1.000000,0.000000,-0.608140,-0.000000,0.793830)
},
["Forest Island"]={
CFrame.new(-7472.860,28.764,4463.595,0.551560,0.000000,0.834135,0.000000,1.000000,-0.000000,-0.834135,0.000000,0.551560),
CFrame.new(-7535.876,32.325,4238.738,0.068780,0.000000,0.997632,0.000000,1.000000,-0.000000,-0.997632,0.000000,0.068780),
CFrame.new(-7545.947,37.404,4098.649,-0.198445,-0.000000,0.980112,-0.000000,1.000000,0.000000,-0.980112,0.000000,-0.198445),
CFrame.new(-7684.951,40.998,3959.780,0.147014,0.000000,0.989134,-0.000000,1.000000,-0.000000,-0.989134,0.000000,0.147014),
CFrame.new(-7848.366,45.537,4018.761,-0.623656,0.000000,0.781699,0.000000,1.000000,-0.000000,-0.781699,-0.000000,-0.623656),
CFrame.new(-7997.114,48.987,4179.415,0.798752,0.000000,0.601661,-0.000000,1.000000,-0.000000,-0.601661,0.000000,0.798752),
CFrame.new(-8099.335,34.141,3889.042,0.999798,-0.000000,0.020097,0.000000,1.000000,-0.000000,-0.020097,0.000000,0.999798),
CFrame.new(-8042.408,20.998,3701.553,0.999915,0.000000,0.013039,-0.000000,1.000000,0.000000,-0.013039,-0.000000,0.999915),
CFrame.new(-7689.577,51.595,3598.035,0.535114,0.000000,0.844780,0.000000,1.000000,-0.000000,-0.844780,0.000000,0.535114),
CFrame.new(-7575.774,17.483,3334.014,0.082241,0.000000,-0.996612,0.000000,1.000000,0.000000,0.996612,-0.000000,0.082241),
CFrame.new(-7764.240,20.998,3233.584,-0.684193,-0.000000,0.729301,-0.000000,1.000000,0.000000,-0.729301,-0.000000,-0.684193),
CFrame.new(-7949.454,24.971,3231.008,0.345593,-0.000000,0.938385,0.000000,1.000000,0.000000,-0.938385,-0.000000,0.345593),
CFrame.new(-7901.335,20.971,3084.170,0.578636,0.000000,-0.815586,-0.000000,1.000000,0.000000,0.815586,-0.000000,0.578636),
CFrame.new(-8060.973,24.998,2915.217,0.955658,0.000000,0.294479,0.000000,1.000000,-0.000000,-0.294479,0.000000,0.955658),
CFrame.new(-8177.794,16.998,2739.041,-0.257516,-0.000000,0.966274,0.000000,1.000000,0.000000,-0.966274,0.000000,-0.257516),
CFrame.new(-7852.313,17.017,2649.995,0.726514,0.000000,-0.687151,-0.000000,1.000000,0.000000,0.687151,0.000000,0.726514),
CFrame.new(-7552.338,18.441,2621.408,0.261372,-0.000000,-0.965238,0.000000,1.000000,-0.000000,0.965238,-0.000000,0.261372),
CFrame.new(-7572.040,23.101,2814.098,-0.796524,-0.000000,0.604607,0.000000,1.000000,0.000000,-0.604607,0.000000,-0.796524),
CFrame.new(-8304.572,18.548,3097.513,-0.745587,-0.000000,0.666408,0.000000,1.000000,0.000000,-0.666408,0.000000,-0.745587),
CFrame.new(-8208.253,24.460,3482.972,-0.837417,0.000000,-0.546565,0.000000,1.000000,0.000000,0.546565,0.000000,-0.837417),
CFrame.new(-8240.987,18.951,3839.143,-0.966695,0.000000,0.255932,0.000000,1.000000,-0.000000,-0.255932,-0.000000,-0.966695),
CFrame.new(-8305.184,19.335,4191.374,-0.999586,-0.000000,-0.028773,-0.000000,1.000000,-0.000000,0.028773,-0.000000,-0.999586),
CFrame.new(-8239.147,18.951,4445.735,-0.848891,0.000000,-0.528567,-0.000000,1.000000,0.000000,0.528567,0.000000,-0.848891),
CFrame.new(-7883.821,18.951,4732.082,0.055220,-0.000000,-0.998474,0.000000,1.000000,-0.000000,0.998474,-0.000000,0.055220),
CFrame.new(-7518.997,58.069,3746.335,-0.113768,0.000000,-0.993507,-0.000000,1.000000,0.000000,0.993507,0.000000,-0.113768),
CFrame.new(-7607.815,111.891,3781.745,-0.867879,0.000000,0.496775,-0.000000,1.000000,-0.000000,-0.496775,-0.000000,-0.867879)
},
["Royal Island"]={
CFrame.new(-72.123,81.097,-5076.466,-0.619706,-0.000000,0.784834,-0.000000,1.000000,0.000000,-0.784834,-0.000000,-0.619706),
CFrame.new(-209.632,55.156,-5209.898,-0.154395,0.000000,0.988009,0.000000,1.000000,-0.000000,-0.988009,0.000000,-0.154395),
CFrame.new(27.947,40.998,-5560.313,0.377881,0.000000,-0.925854,-0.000000,1.000000,-0.000000,0.925854,0.000000,0.377881),
CFrame.new(-424.829,74.496,-5903.549,-0.919306,0.000000,0.393543,0.000000,1.000000,0.000000,-0.393543,0.000000,-0.919306),
CFrame.new(-481.518,137.520,-6073.541,0.520545,-0.000000,0.853834,-0.000000,1.000000,0.000000,-0.853834,-0.000000,0.520545),
CFrame.new(-612.957,208.595,-6277.108,0.995154,0.000000,-0.098330,-0.000000,1.000000,-0.000000,0.098330,0.000000,0.995154),
CFrame.new(-640.990,275.037,-6525.042,0.491454,-0.000000,0.870903,0.000000,1.000000,0.000000,-0.870903,0.000000,0.491454),
CFrame.new(-789.431,284.302,-6500.426,0.986291,0.000000,0.165016,-0.000000,1.000000,0.000000,-0.165016,-0.000000,0.986291),
CFrame.new(-478.821,24.998,-6492.742,-0.855233,0.000000,0.518244,0.000000,1.000000,-0.000000,-0.518244,0.000000,-0.855233),
CFrame.new(98.136,57.357,-6496.738,0.462515,0.000000,-0.886611,0.000000,1.000000,0.000000,0.886611,-0.000000,0.462515),
CFrame.new(247.551,24.998,-6520.478,0.132216,-0.000000,-0.991221,0.000000,1.000000,-0.000000,0.991221,0.000000,0.132216),
CFrame.new(183.846,25.728,-6420.287,-0.964619,0.000000,0.263648,0.000000,1.000000,-0.000000,-0.263648,-0.000000,-0.964619),
CFrame.new(292.436,32.998,-6029.453,-0.997315,-0.000000,-0.073233,-0.000000,1.000000,-0.000000,0.073233,-0.000000,-0.997315),
CFrame.new(225.520,56.982,-5711.718,-0.793371,0.000000,-0.608738,0.000000,1.000000,0.000000,0.608738,0.000000,-0.793371),
CFrame.new(514.783,69.082,-5562.985,-0.765907,-0.000000,-0.642951,-0.000000,1.000000,-0.000000,0.642951,-0.000000,-0.765907),
CFrame.new(769.309,60.830,-5532.214,0.919211,0.000000,-0.393766,-0.000000,1.000000,-0.000000,0.393766,0.000000,0.919211),
CFrame.new(953.228,53.977,-5724.733,0.973086,0.000000,-0.230442,0.000000,1.000000,0.000000,0.230442,-0.000000,0.973086),
CFrame.new(1086.085,31.402,-6151.646,0.701825,-0.000000,-0.712349,0.000000,1.000000,-0.000000,0.712349,0.000000,0.701825)
},
["Desert Island"]={
CFrame.new(1057.257,64.998,3448.428,0.089481,0.000000,0.995988,-0.000000,1.000000,-0.000000,-0.995988,-0.000000,0.089481),
CFrame.new(1132.570,15.370,3667.140,-0.879080,0.000000,-0.476674,-0.000000,1.000000,0.000000,0.476674,0.000000,-0.879080),
CFrame.new(1375.584,16.400,3794.933,-0.437227,0.000000,-0.899351,-0.000000,1.000000,0.000000,0.899351,0.000000,-0.437227),
CFrame.new(1480.055,31.172,4003.031,-0.452688,0.000000,0.891669,-0.000000,1.000000,-0.000000,-0.891669,-0.000000,-0.452688),
CFrame.new(1280.563,125.093,3976.117,0.833706,-0.000000,0.552209,0.000000,1.000000,0.000000,-0.552209,-0.000000,0.833706),
CFrame.new(1072.918,124.989,3931.746,-0.265551,0.000000,0.964097,-0.000000,1.000000,-0.000000,-0.964097,-0.000000,-0.265551),
CFrame.new(803.771,125.089,3962.484,-0.258191,-0.000000,0.966094,-0.000000,1.000000,0.000000,-0.966094,0.000000,-0.258191),
CFrame.new(561.074,125.183,4054.734,-0.380536,-0.000000,0.924766,-0.000000,1.000000,0.000000,-0.924766,0.000000,-0.380536),
CFrame.new(547.330,17.074,4279.596,0.902964,-0.000000,0.429716,0.000000,1.000000,0.000000,-0.429716,0.000000,0.902964),
CFrame.new(444.411,15.404,4438.446,-0.999448,0.000000,-0.033216,0.000000,1.000000,0.000000,0.033216,0.000000,-0.999448),
CFrame.new(581.363,45.373,4506.168,0.811399,0.000000,0.584493,-0.000000,1.000000,-0.000000,-0.584493,0.000000,0.811399),
CFrame.new(687.038,124.998,4353.153,0.099777,-0.000000,-0.995010,0.000000,1.000000,-0.000000,0.995010,-0.000000,0.099777),
CFrame.new(966.561,125.118,4342.621,0.264482,-0.000000,-0.964391,-0.000000,1.000000,-0.000000,0.964391,0.000000,0.264482),
CFrame.new(1344.608,103.504,4317.035,-0.869061,0.000000,-0.494705,-0.000000,1.000000,0.000000,0.494705,0.000000,-0.869061),
CFrame.new(1319.893,15.404,4539.259,-0.884852,0.000000,0.465871,0.000000,1.000000,-0.000000,-0.465871,-0.000000,-0.884852),
CFrame.new(1484.599,15.404,4258.654,0.942722,-0.000000,0.333579,0.000000,1.000000,-0.000000,-0.333579,0.000000,0.942722),
CFrame.new(1720.102,63.150,4254.261,-0.034687,-0.000000,-0.999398,-0.000000,1.000000,-0.000000,0.999398,0.000000,-0.034687),
CFrame.new(1004.585,15.431,4625.405,-0.068486,-0.000000,0.997652,0.000000,1.000000,0.000000,-0.997652,0.000000,-0.068486),
CFrame.new(114.073,38.638,4555.410,0.017780,0.002914,0.999838,0.004563,0.999985,-0.002995,-0.999831,0.004616,0.017766),
CFrame.new(-84.351,15.536,4522.342,0.281574,0.000000,0.959540,-0.000000,1.000000,-0.000000,-0.959540,0.000000,0.281574),
CFrame.new(-211.976,77.077,4458.471,0.883683,-0.000000,0.468085,0.000000,1.000000,-0.000000,-0.468085,0.000000,0.883683),
CFrame.new(-425.070,24.569,4420.184,0.493990,0.000000,0.869468,-0.000000,1.000000,-0.000000,-0.869468,-0.000000,0.493990),
CFrame.new(-761.432,17.434,4420.783,0.303166,-0.000000,0.952938,0.000000,1.000000,0.000000,-0.952938,0.000000,0.303166),
CFrame.new(-1081.539,34.009,4359.438,-0.113532,-0.000000,0.993534,-0.000000,1.000000,0.000000,-0.993534,-0.000000,-0.11353),
CFrame.new(-925.370,16.098,4174.521,0.317470,0.000000,-0.948268,0.000000,1.000000,0.000000,0.948268,-0.000000,0.317470),
CFrame.new(-925.370,16.098,4174.521,0.317470,0.000000,-0.948268,0.000000,1.000000,0.000000,0.948268,-0.000000,0.317470),
CFrame.new(-448.702,74.692,3720.310,0.717594,0.000000,-0.696462,-0.000000,1.000000,0.000000,0.696462,0.000000,0.717594),
CFrame.new(-210.401,69.401,3578.062,0.320887,-0.000000,-0.947117,0.000000,1.000000,-0.000000,0.947117,0.000000,0.320887),
CFrame.new(172.042,65.213,3368.040,0.334159,-0.000000,-0.942517,-0.000000,1.000000,-0.000000,0.942517,0.000000,0.334159),
CFrame.new(406.814,47.485,3346.744,-0.148952,-0.000000,-0.988844,0.000000,1.000000,-0.000000,0.988844,-0.000000,-0.148952),
CFrame.new(325.440,15.404,3600.470,-0.519839,0.000000,0.854264,0.000000,1.000000,-0.000000,-0.854264,-0.000000,-0.519839),
CFrame.new(85.659,15.404,3927.667,-0.657984,-0.000000,0.753032,-0.000000,1.000000,0.000000,-0.753032,0.000000,-0.657984),
CFrame.new(-59.720,15.404,4080.630,-0.745152,-0.000000,0.666895,-0.000000,1.000000,0.000000,-0.666895,-0.000000,-0.745152),
CFrame.new(-214.535,15.404,4034.627,-0.180478,-0.000000,0.983579,0.000000,1.000000,0.000000,-0.983579,0.000000,-0.180478),
CFrame.new(-361.872,17.675,4156.984,-0.662197,-0.000000,0.749330,-0.000000,1.000000,0.000000,-0.749330,0.000000,-0.662197),
CFrame.new(-189.597,15.404,4205.576,0.962794,0.000000,0.270236,-0.000000,1.000000,-0.000000,-0.270236,0.000000,0.962794),
CFrame.new(62.058,15.404,4269.560,0.020223,0.000000,-0.999795,0.000000,1.000000,0.000000,0.999795,-0.000000,0.020223),
CFrame.new(476.299,15.404,3826.276,0.890786,-0.000000,-0.454423,-0.000000,1.000000,-0.000000,0.454423,0.000000,0.890786)
},
["Glacier Island"]={
CFrame.new(2400.878,-10.504,-3.798,-0.293389,0.000000,0.955993,-0.000000,1.000000,-0.000000,-0.955993,-0.000000,-0.293389),
CFrame.new(2197.143,25.029,51.597,-0.895651,-0.000000,0.444758,-0.000000,1.000000,-0.000000,-0.444758,-0.000000,-0.895651),
CFrame.new(2993.914,-7.018,89.664,0.920103,0.000000,0.391677,-0.000000,1.000000,0.000000,-0.391677,-0.000000,0.920103),
CFrame.new(3254.097,-7.002,78.091,0.039642,0.000000,-0.999214,-0.000000,1.000000,0.000000,0.999214,-0.000000,0.039642),
CFrame.new(3527.007,-7.002,77.846,-0.293532,-0.000000,-0.955949,0.000000,1.000000,-0.000000,0.955949,-0.000000,-0.293532),
CFrame.new(3183.226,82.592,-231.937,-0.819137,0.000000,0.573598,0.000000,1.000000,-0.000000,-0.573598,0.000000,-0.819137),
CFrame.new(3272.057,82.592,-113.594,-0.837187,-0.000000,-0.546917,0.000000,1.000000,-0.000000,0.546917,-0.000000,-0.837187),
CFrame.new(3364.805,82.592,-71.182,0.110966,-0.000000,-0.993824,-0.000000,1.000000,-0.000000,0.993824,0.000000,0.110966),
CFrame.new(3132.977,82.592,-128.275,0.043340,-0.000000,0.999060,-0.000000,1.000000,0.000000,-0.999060,-0.000000,0.043340),
CFrame.new(3198.475,116.948,-412.867,0.273361,-0.000000,0.961911,-0.000000,1.000000,0.000000,-0.961911,-0.000000,0.273361),
CFrame.new(2849.397,116.998,-367.796,-0.000623,-0.000000,1.000000,0.000000,1.000000,0.000000,-1.000000,0.000000,-0.000623),
CFrame.new(2618.713,116.389,-379.632,0.715373,0.000000,0.698743,-0.000000,1.000000,-0.000000,-0.698743,-0.000000,0.715373),
CFrame.new(2563.353,116.389,-728.223,0.861281,-0.000000,-0.508129,0.000000,1.000000,-0.000000,0.508129,0.000000,0.861281),
CFrame.new(2389.108,116.998,-475.673,-0.162055,-0.000000,0.986782,0.000000,1.000000,0.000000,-0.986782,0.000000,-0.162055),
CFrame.new(2292.616,116.998,-542.623,0.897960,-0.000000,0.440077,-0.000000,1.000000,0.000000,-0.440077,-0.000000,0.897960),
CFrame.new(2183.349,166.967,-405.284,-0.527489,-0.000000,0.849562,0.000000,1.000000,0.000000,-0.849562,0.000000,-0.527489),
CFrame.new(2053.532,173.773,-469.023,-0.073158,-0.000000,0.997320,0.000000,1.000000,0.000000,-0.997320,0.000000,-0.073158),
CFrame.new(2197.752,186.264,-596.579,0.316232,0.000000,-0.948682,0.000000,1.000000,0.000000,0.948682,-0.000000,0.316232),
CFrame.new(2416.479,186.264,-599.388,0.075444,-0.000000,-0.997150,0.000000,1.000000,-0.000000,0.997150,0.000000,0.075444),
CFrame.new(2702.472,193.545,-634.575,-0.066647,0.000000,-0.997777,-0.000000,1.000000,0.000000,0.997777,0.000000,-0.066647),
CFrame.new(2692.565,193.534,-766.698,0.796939,-0.000000,-0.604060,-0.000000,1.000000,-0.000000,0.604060,0.000000,0.796939),
CFrame.new(2768.410,201.882,-1040.510,0.999988,-0.000000,0.004846,0.000000,1.000000,0.000000,-0.004846,-0.000000,0.999988),
CFrame.new(2815.325,200.576,-993.692,-0.470508,0.000000,-0.882396,0.000000,1.000000,0.000000,0.882396,0.000000,-0.470508),
CFrame.new(2662.499,224.998,-1049.144,-0.962307,0.000000,0.271965,0.000000,1.000000,-0.000000,-0.271965,-0.000000,-0.962307),
CFrame.new(2556.227,255.216,-915.980,0.495420,0.000000,0.868654,0.000000,1.000000,-0.000000,-0.868654,0.000000,0.495420),
CFrame.new(2487.840,255.217,-927.118,-0.403209,0.000000,0.915108,0.000000,1.000000,-0.000000,-0.915108,-0.000000,-0.403209),
CFrame.new(2425.859,275.749,-1105.462,0.892337,-0.000000,0.451369,0.000000,1.000000,-0.000000,-0.451369,0.000000,0.892337),
CFrame.new(2358.345,280.232,-1206.390,0.825089,0.000000,0.565002,0.000000,1.000000,-0.000000,-0.565002,0.000000,0.825089),
CFrame.new(2351.815,256.992,-887.120,-0.794428,-0.000000,0.607358,0.000000,1.000000,0.000000,-0.607358,0.000000,-0.794428),
CFrame.new(2135.493,255.326,-878.545,-0.188005,0.000000,0.982168,-0.000000,1.000000,-0.000000,-0.982168,-0.000000,-0.188005),
CFrame.new(2216.487,316.845,-1213.264,-0.910133,0.000000,-0.414316,0.000000,1.000000,0.000000,0.414316,0.000000,-0.910133),
CFrame.new(2070.611,360.757,-1132.188,-0.641953,0.000000,-0.766744,0.000000,1.000000,0.000000,0.766744,0.000000,-0.641953),
CFrame.new(2073.024,329.226,-1267.795,-0.401489,-0.000000,-0.915864,-0.000000,1.000000,-0.000000,0.915864,0.000000,-0.401489),
CFrame.new(3052.000,146.935,-1236.844,0.061776,-0.000000,-0.998090,0.000000,1.000000,-0.000000,0.998090,-0.000000,0.061776),
CFrame.new(3003.948,148.815,-1124.271,-0.980462,0.000000,-0.196708,0.000000,1.000000,-0.000000,0.196708,-0.000000,-0.980462),
CFrame.new(3216.661,146.842,-1222.549,0.482906,0.000000,-0.875672,-0.000000,1.000000,0.000000,0.875672,0.000000,0.482906),
CFrame.new(3172.916,146.842,-997.427,-0.904359,0.000000,0.426773,-0.000000,1.000000,-0.000000,-0.426773,-0.000000,-0.904359),
CFrame.new(3027.217,154.722,-680.357,-0.751371,0.000000,0.659880,-0.000000,1.000000,-0.000000,-0.659880,-0.000000,-0.751371),
CFrame.new(2987.953,147.525,-861.088,0.656116,0.000000,-0.754660,0.000000,1.000000,0.000000,0.754660,-0.000000,0.656116),
CFrame.new(3392.629,147.122,-737.173,-0.744118,-0.000000,0.668049,-0.000000,1.000000,-0.000000,-0.668049,-0.000000,-0.744118),
CFrame.new(3160.088,147.395,-597.373,-0.905875,0.000000,-0.423546,0.000000,1.000000,0.000000,0.423546,-0.000000,-0.905875),
CFrame.new(3007.762,28.994,-757.581,-0.616086,-0.000000,0.787679,0.000000,1.000000,0.000000,-0.787679,0.000000,-0.616086),
CFrame.new(2821.434,31.060,-722.676,-0.161401,0.000000,-0.986889,-0.000000,1.000000,0.000000,0.986889,0.000000,-0.161401),
CFrame.new(2885.220,27.186,-620.042,0.929208,-0.000000,0.369558,0.000000,1.000000,0.000000,-0.369558,-0.000000,0.929208),
CFrame.new(3200.757,-7.745,-755.416,-0.109131,-0.000000,0.994027,-0.000000,1.000000,0.000000,-0.994027,-0.000000,-0.109131),
CFrame.new(3150.148,-7.018,-989.735,0.789689,0.000000,0.613507,-0.000000,1.000000,0.000000,-0.613507,-0.000000,0.789689),
CFrame.new(2523.225,-7.002,-503.811,-0.941150,0.000000,0.337988,0.000000,1.000000,0.000000,-0.337988,0.000000,-0.941150),
CFrame.new(2536.531,-7.002,-396.331,-0.998193,-0.000000,-0.060086,-0.000000,1.000000,0.000000,0.060086,0.000000,-0.998193),
CFrame.new(2378.865,-7.018,-490.483,-0.807392,0.000000,0.590016,0.000000,1.000000,-0.000000,-0.590016,-0.000000,-0.807392)
},
["Mountain Island"]={
CFrame.new(-7214.773,32.530,287.288,0.491617,0.000000,-0.870812,-0.000000,1.000000,0.000000,0.870812,-0.000000,0.491617),
CFrame.new(-7006.402,126.644,165.479,0.217954,-0.000000,-0.975959,-0.000000,1.000000,-0.000000,0.975959,0.000000,0.217954),
CFrame.new(-6841.190,165.338,185.724,0.867930,-0.000000,0.496686,-0.000000,1.000000,0.000000,-0.496686,-0.000000,0.867930),
CFrame.new(-6797.834,228.663,62.782,0.984083,-0.000000,0.177709,0.000000,1.000000,-0.000000,-0.177709,0.000000,0.984083),
CFrame.new(-6774.866,276.932,-98.017,0.214142,0.000000,-0.976802,-0.000000,1.000000,-0.000000,0.976802,0.000000,0.214142),
CFrame.new(-6607.875,372.998,-286.469,-0.661203,0.000000,0.750207,0.000000,1.000000,0.000000,-0.750207,0.000000,-0.661203),
CFrame.new(-6666.319,320.369,-264.341,0.773879,0.000000,-0.633334,-0.000000,1.000000,-0.000000,0.633334,0.000000,0.773879),
CFrame.new(-6524.053,276.998,-69.672,0.499362,0.000000,-0.866393,-0.000000,1.000000,0.000000,0.866393,-0.000000,0.499362),
CFrame.new(-6669.441,224.874,70.515,-0.119839,-0.000000,0.992793,-0.000000,1.000000,0.000000,-0.992793,-0.000000,-0.119839),
CFrame.new(-6757.290,9.018,415.531,0.980146,-0.000000,0.198276,0.000000,1.000000,0.000000,-0.198276,-0.000000,0.980146),
CFrame.new(-6487.353,46.925,288.247,0.512483,-0.000000,-0.858697,0.000000,1.000000,-0.000000,0.858697,0.000000,0.512483),
CFrame.new(-6236.704,32.997,149.049,0.930303,-0.000000,-0.366792,0.000000,1.000000,-0.000000,0.366792,0.000000,0.930303),
CFrame.new(-5920.666,32.998,18.426,-0.061217,-0.000000,-0.998124,-0.000000,1.000000,-0.000000,0.998124,-0.000000,-0.061217),
CFrame.new(-5488.082,45.074,-88.013,0.799946,-0.000000,-0.600072,0.000000,1.000000,-0.000000,0.600072,0.000000,0.799946),
CFrame.new(-5615.074,93.555,-178.742,0.565122,-0.000000,-0.825007,-0.000000,1.000000,-0.000000,0.825007,0.000000,0.565122),
CFrame.new(-5720.867,137.505,-170.928,-0.990899,0.000000,0.134610,0.000000,1.000000,-0.000000,-0.134610,-0.000000,-0.990899),
CFrame.new(-6008.147,170.706,-124.588,-0.904283,0.000000,0.426933,0.000000,1.000000,0.000000,-0.426933,0.000000,-0.904283),
CFrame.new(-5866.254,188.998,-324.966,0.671534,-0.000000,-0.740974,0.000000,1.000000,-0.000000,0.740974,0.000000,0.671534),
CFrame.new(-6095.032,196.998,-396.765,-0.112491,-0.000000,0.993653,-0.000000,1.000000,0.000000,-0.993653,-0.000000,-0.112491),
CFrame.new(-6151.569,220.829,-269.242,-0.998729,0.000000,-0.050399,0.000000,1.000000,0.000000,0.050399,0.000000,-0.998729),
CFrame.new(-6252.735,169.552,-517.140,0.560569,-0.000000,0.828108,0.000000,1.000000,0.000000,-0.828108,-0.000000,0.560569),
CFrame.new(-6603.163,12.105,-890.028,0.627388,-0.000000,0.778707,0.000000,1.000000,0.000000,-0.778707,-0.000000,0.627388),
CFrame.new(-6878.203,13.671,-1044.889,0.525436,-0.000000,0.850833,0.000000,1.000000,0.000000,-0.850833,-0.000000,0.525436),
CFrame.new(-7200.269,109.276,-1177.566,0.067147,-0.000000,0.997743,0.000000,1.000000,0.000000,-0.997743,-0.000000,0.067147),
CFrame.new(-7228.098,147.970,-1137.700,-0.723252,0.000057,0.690584,0.000005,1.000000,-0.000077,-0.690584,-0.000052,-0.723252),
CFrame.new(-7332.619,105.113,-1024.005,-0.723782,0.000000,-0.690029,0.000000,1.000000,0.000000,0.690029,0.000000,-0.723782),
CFrame.new(-7128.717,127.300,-971.255,-0.120213,0.000000,-0.992748,0.000000,1.000000,0.000000,0.992748,-0.000000,-0.120213),
CFrame.new(-7073.085,124.991,-733.655,0.177600,-0.000000,0.984103,0.000000,1.000000,0.000000,-0.984103,-0.000000,0.177600),
CFrame.new(-7255.609,113.053,-641.237,-0.558652,-0.000000,0.829402,0.000000,1.000000,0.000000,-0.829402,0.000000,-0.558652),
CFrame.new(-7478.791,13.166,-746.285,-0.017462,0.000000,0.999848,-0.000000,1.000000,-0.000000,-0.999848,-0.000000,-0.017462),
CFrame.new(-7391.350,33.294,-1053.469,0.910577,-0.000000,0.413340,0.000000,1.000000,-0.000000,-0.413340,0.000000,0.910577),
CFrame.new(-7555.564,19.813,-452.911,-0.941290,-0.000000,-0.337600,-0.000000,1.000000,-0.000000,0.337600,-0.000000,-0.941290),
CFrame.new(-7409.248,55.013,-427.185,0.999950,-0.000000,-0.010043,0.000000,1.000000,-0.000000,0.010043,0.000000,0.999950),
CFrame.new(-7095.168,176.324,-455.400,0.885353,-0.000000,0.464919,0.000000,1.000000,0.000000,-0.464919,-0.000000,0.885353),
CFrame.new(-7163.932,240.998,-684.626,-0.427335,-0.000000,-0.904093,-0.000000,1.000000,-0.000000,0.904093,-0.000000,-0.427335),
CFrame.new(-7154.404,217.219,-930.967,0.688617,-0.000000,-0.725125,-0.000000,1.000000,-0.000000,0.725125,0.000000,0.688617),
CFrame.new(-7256.463,200.997,-1074.188,0.712506,0.000000,0.701667,-0.000000,1.000000,-0.000000,-0.701667,0.000000,0.712506),
CFrame.new(-7039.147,272.293,-690.777,-0.928318,0.000000,-0.371788,-0.000000,1.000000,0.000000,0.371788,0.000000,-0.928318),
CFrame.new(-6896.775,265.244,-379.438,-0.907239,-0.000000,-0.420616,0.000000,1.000000,-0.000000,0.420616,-0.000000,-0.907239),
CFrame.new(-6858.708,263.932,-253.161,-0.963729,0.000000,-0.266883,-0.000000,1.000000,0.000000,0.266883,0.000000,-0.963729)
},
["Jungle Island"]={
CFrame.new(3242.791,18.754,2630.970,-0.903268,0.000000,-0.429076,0.000000,1.000000,0.000000,0.429076,0.000000,-0.903268),
CFrame.new(3498.283,46.975,2810.441,-0.892794,0.000000,0.450466,0.000000,1.000000,-0.000000,-0.450466,0.000000,-0.892794),
CFrame.new(3649.556,17.309,2995.035,-0.748639,-0.000000,-0.662978,0.000000,1.000000,-0.000000,0.662978,-0.000000,-0.748639),
CFrame.new(3544.737,46.949,3248.570,-0.991336,0.000000,-0.131350,0.000000,1.000000,-0.000000,0.131350,-0.000000,-0.991336),
CFrame.new(3316.892,45.557,3499.239,-0.796393,-0.000000,0.604780,-0.000000,1.000000,0.000000,-0.604780,0.000000,-0.796393),
CFrame.new(2939.932,68.979,3562.033,-0.556870,0.000000,0.830600,0.000000,1.000000,-0.000000,-0.830600,-0.000000,-0.556870),
CFrame.new(2937.843,28.430,3325.126,0.971778,-0.000000,-0.235897,0.000000,1.000000,0.000000,0.235897,-0.000000,0.971778),
CFrame.new(3700.291,43.296,3469.382,-0.582111,0.000000,-0.813109,0.000000,1.000000,0.000000,0.813109,0.000000,-0.582111),
CFrame.new(3812.564,18.167,3650.845,-0.950636,0.000000,-0.310308,0.000000,1.000000,0.000000,0.310308,0.000000,-0.950636),
CFrame.new(3936.433,18.818,3570.950,0.107361,0.000000,-0.994220,0.000000,1.000000,0.000000,0.994220,-0.000000,0.107361),
CFrame.new(3936.433,18.818,3570.950,0.107361,0.000000,-0.994220,0.000000,1.000000,0.000000,0.994220,-0.000000,0.107361),
CFrame.new(3715.697,15.403,4417.625,-0.930706,0.000000,-0.365767,0.000000,1.000000,0.000000,0.365767,0.000000,-0.930706),
CFrame.new(3980.756,15.404,4302.282,-0.026813,-0.000000,-0.999640,-0.000000,1.000000,-0.000000,0.999640,0.000000,-0.026813),
CFrame.new(4201.835,120.998,4027.481,0.988359,-0.000000,-0.152141,-0.000000,1.000000,-0.000000,0.152141,0.000000,0.988359),
CFrame.new(4253.639,120.998,3701.066,0.973689,-0.000000,-0.227881,-0.000000,1.000000,-0.000000,0.227881,0.000000,0.973689),
CFrame.new(4250.476,120.998,3375.971,0.998921,0.000000,0.046446,-0.000000,1.000000,-0.000000,-0.046446,0.000000,0.998921),
CFrame.new(4243.121,15.577,2533.673,0.850525,-0.000000,-0.525935,0.000000,1.000000,-0.000000,0.525935,0.000000,0.850525),
CFrame.new(4300.399,15.404,2449.880,0.297536,-0.000000,-0.954711,0.000000,1.000000,-0.000000,0.954711,-0.000000,0.297536),
CFrame.new(3826.826,38.406,2469.223,0.534162,-0.000000,0.845382,0.000000,1.000000,0.000000,-0.845382,0.000000,0.534162),
CFrame.new(3734.817,21.552,2657.648,-0.968356,-0.000000,0.249575,0.000000,1.000000,0.000000,-0.249575,0.000000,-0.968356),
CFrame.new(3997.381,120.998,2186.975,0.999624,-0.000000,-0.027403,0.000000,1.000000,-0.000000,0.027403,0.000000,0.999624),
CFrame.new(3957.398,127.028,1994.268,0.370745,-0.000000,0.928735,-0.000000,1.000000,0.000000,-0.928735,-0.000000,0.370745),
CFrame.new(3582.243,45.969,2037.649,0.970824,0.000000,0.239791,-0.000000,1.000000,-0.000000,-0.239791,0.000000,0.970824),
CFrame.new(4194.147,15.404,1539.364,-0.514991,-0.000000,0.857196,0.000000,1.000000,0.000000,-0.857196,0.000000,-0.514991),
CFrame.new(4145.227,15.404,1209.603,0.930009,-0.000000,0.367536,-0.000000,1.000000,0.000000,-0.367536,-0.000000,0.930009),
CFrame.new(3646.035,120.998,1108.057,0.073999,-0.000000,0.997258,-0.000000,1.000000,0.000000,-0.997258,-0.000000,0.073999),
CFrame.new(3560.289,132.848,707.446,0.977682,-0.000000,0.210090,-0.000000,1.000000,0.000000,-0.210090,-0.000000,0.977682),
CFrame.new(3380.594,120.998,434.143,0.623593,-0.000000,0.781749,-0.000000,1.000000,0.000000,-0.781749,-0.000000,0.623593),
CFrame.new(3283.650,15.404,902.778,0.945511,-0.000000,0.325591,0.000000,1.000000,0.000000,-0.325591,0.000000,0.945511),
CFrame.new(3169.369,36.436,1101.109,-0.406628,-0.000000,0.913594,0.000000,1.000000,0.000000,-0.913594,0.000000,-0.406628),
CFrame.new(3185.811,73.948,1215.060,-0.962469,0.000000,-0.271392,0.000000,1.000000,-0.000000,0.271392,-0.000000,-0.962469),
CFrame.new(3179.302,86.346,1346.582,0.643434,0.000000,0.765502,-0.000000,1.000000,0.000000,-0.765502,-0.000000,0.643434),
CFrame.new(3329.037,29.141,1537.636,-0.916502,-0.000000,0.400030,0.000000,1.000000,0.000000,-0.400030,0.000000,-0.916502),
CFrame.new(3527.567,33.152,1496.425,-0.917907,0.000000,-0.396795,0.000000,1.000000,-0.000000,0.396795,-0.000000,-0.917907),
CFrame.new(3447.305,16.998,1782.471,-0.830702,0.000000,0.556717,0.000000,1.000000,-0.000000,-0.556717,-0.000000,-0.830702),
CFrame.new(2908.122,66.767,2025.434,-0.258916,-0.000000,0.965900,-0.000000,1.000000,0.000000,-0.965900,-0.000000,-0.258916)
},
["Lunar Islands"]={
CFrame.new(-3848.084,13.858,-2062.724,0.954432,-0.000000,0.298429,-0.000000,1.000000,0.000000,-0.298429,-0.000000,0.954432),
CFrame.new(-3615.102,29.024,-2338.882,0.619280,0.000000,-0.785170,0.000000,1.000000,0.000000,0.785170,-0.000000,0.619280),
CFrame.new(-3615.102,28.968,-2338.882,0.619280,-0.000000,-0.785170,-0.000000,1.000000,-0.000000,0.785170,0.000000,0.619280),
CFrame.new(-3325.056,15.404,-2555.110,0.962541,0.000000,0.271135,-0.000000,1.000000,-0.000000,-0.271135,0.000000,0.962541),
CFrame.new(-2988.803,129.599,-2990.796,0.638774,0.000000,-0.769394,0.000000,1.000000,0.000000,0.769394,-0.000000,0.638774),
CFrame.new(-2895.019,204.949,-2927.568,-0.737933,0.000000,-0.674874,-0.000000,1.000000,0.000000,0.674874,0.000000,-0.737933),
CFrame.new(-2527.140,180.883,-3042.093,0.246609,0.000000,-0.969115,0.000000,1.000000,0.000000,0.969115,-0.000000,0.246609),
CFrame.new(-2600.961,185.327,-3373.617,0.859072,0.000000,0.511855,-0.000000,1.000000,0.000000,-0.511855,-0.000000,0.859072),
CFrame.new(-2750.094,63.254,-3574.267,-0.692174,0.000000,0.721731,-0.000000,1.000000,-0.000000,-0.721731,-0.000000,-0.692174),
CFrame.new(-2836.744,15.404,-3682.515,0.519055,0.000000,-0.854741,0.000000,1.000000,0.000000,0.854741,-0.000000,0.519055),
CFrame.new(-3159.135,55.030,-3768.750,-0.752918,0.000000,0.658115,0.000000,1.000000,-0.000000,-0.658115,-0.000000,-0.752918),
CFrame.new(-3259.411,129.574,-4054.177,0.993008,0.000000,0.118048,-0.000000,1.000000,-0.000000,-0.118048,0.000000,0.993008),
CFrame.new(-3402.317,127.905,-4239.881,0.625049,0.000000,0.780585,-0.000000,1.000000,-0.000000,-0.780585,-0.000000,0.625049),
CFrame.new(-3688.774,146.333,-4278.259,-0.041952,-0.000000,0.999120,0.000000,1.000000,0.000000,-0.999120,0.000000,-0.041952),
CFrame.new(-3627.743,147.442,-3693.322,-0.368103,0.000000,-0.929785,-0.000000,1.000000,0.000000,0.929785,0.000000,-0.368103),
CFrame.new(-3535.550,12.240,-4048.549,0.901751,-0.000000,-0.432257,0.000000,1.000000,-0.000000,0.432257,0.000000,0.901751),
CFrame.new(-3386.680,149.475,-3687.410,0.574820,0.000000,-0.818280,0.000000,1.000000,0.000000,0.818280,-0.000000,0.574820),
CFrame.new(-3391.785,20.899,-3454.754,0.169722,0.000000,0.985492,-0.000000,1.000000,-0.000000,-0.985492,-0.000000,0.169722),
CFrame.new(-3148.866,15.275,-3034.570,0.948468,0.000000,-0.316873,-0.000000,1.000000,-0.000000,0.316873,0.000000,0.948468),
CFrame.new(-3325.533,25.653,-2425.765,-0.823623,0.000000,-0.567137,-0.000000,1.000000,0.000000,0.567137,0.000000,-0.823623),
CFrame.new(-3553.793,17.142,-1642.600,-0.912142,0.000000,-0.409875,-0.000000,1.000000,0.000000,0.409875,0.000000,-0.912142),
CFrame.new(-3397.513,27.252,-1431.277,0.993105,-0.000000,0.117232,0.000000,1.000000,-0.000000,-0.117232,0.000000,0.993105),
CFrame.new(-3292.648,35.424,-893.182,-0.600277,0.000000,-0.799792,0.000000,1.000000,0.000000,0.799792,-0.000000,-0.600277),
CFrame.new(-3026.764,24.863,-790.847,-0.250915,0.000000,-0.968009,0.000000,1.000000,0.000000,0.968009,-0.000000,-0.250915),
CFrame.new(-2707.063,56.112,-745.312,-0.129162,-0.000000,-0.991623,0.000000,1.000000,-0.000000,0.991623,-0.000000,-0.129162),
CFrame.new(-2345.119,106.512,-931.376,-0.187430,0.000000,-0.982278,0.000000,1.000000,0.000000,0.982278,-0.000000,-0.187430),
CFrame.new(-2167.360,134.201,-1231.910,0.912997,0.000000,-0.407966,-0.000000,1.000000,-0.000000,0.407966,0.000000,0.912997),
CFrame.new(-2071.372,226.236,-1517.424,0.969284,0.000000,-0.245943,-0.000000,1.000000,-0.000000,0.245943,0.000000,0.969284),
CFrame.new(-2105.362,228.242,-1751.023,0.995166,-0.000000,-0.098209,0.000000,1.000000,-0.000000,0.098209,0.000000,0.995166),
CFrame.new(-2308.253,64.788,-1936.170,0.972440,0.000000,-0.233152,-0.000000,1.000000,0.000000,0.233152,-0.000000,0.972440),
CFrame.new(-2268.345,106.998,-1341.150,-0.481596,0.000000,-0.876393,0.000000,1.000000,0.000000,0.876393,-0.000000,-0.481596)
},
["Volcano Island"]={
CFrame.new(2730.048,29.027,-7504.669,0.998885,0.000000,-0.047207,-0.000000,1.000000,0.000000,0.047207,-0.000000,0.998885),
CFrame.new(2806.406,137.020,-8512.783,-0.610555,-0.000000,-0.791974,-0.000000,1.000000,0.000000,0.791974,0.000000,-0.610555),
CFrame.new(2871.342,32.027,-8414.449,0.279599,0.000000,-0.960117,-0.000000,1.000000,0.000000,0.960117,0.000000,0.279599),
CFrame.new(3555.607,24.998,-8890.222,0.065099,-0.000000,-0.997879,-0.000000,1.000000,-0.000000,0.997879,0.000000,0.065099),
CFrame.new(4200.558,30.585,-8863.275,0.997366,0.000000,0.072534,-0.000000,1.000000,-0.000000,-0.072534,-0.000000,0.997366),
CFrame.new(4860.976,25.462,-7930.800,-0.989602,-0.000000,0.143834,-0.000000,1.000000,0.000000,-0.143834,0.000000,-0.989602),
CFrame.new(4721.313,34.848,-6873.854,-0.148959,-0.000000,-0.988843,-0.000000,1.000000,-0.000000,0.988843,0.000000,-0.148959),
CFrame.new(3700.177,44.611,-6779.036,-0.526967,-0.000000,0.849886,-0.000000,1.000000,0.000000,-0.849886,0.000000,-0.526967)
},
}

local d={
["Mainland"]=CFrame.new(34.923,14.990,-470.256,-0.987316,0,0.158766,0,1,0,-0.158766,0,-0.987316),
["Blizzard Island"]=CFrame.new(-395.354,15.404,-3828.735,-0.763117,0,0.646261,0,1,0,-0.646261,0,-0.763117),
["Forest Island"]=CFrame.new(-7436.085,28.764,4508.391,-0.889721,0,0.456505,0,1,0,-0.456505,0,-0.889721),
["Royal Island"]=CFrame.new(705.109,20.252,-5111.376,0.731477,0,0.681866,0,1,0,-0.681866,0,0.731477),
["Desert Island"]=CFrame.new(826.356,40.998,3601.169,0.420382,0,-0.907347,0,1,0,0.907347,0,0.420382),
["Glacier Island"]=CFrame.new(2702.397,-7.018,-40.926,-0.079052,0.000000,0.996871,0.000000,1.000000,-0.000000,-0.996871,0.000000,-0.079052),
["Mountain Island"]=CFrame.new(-7155.097,9.071,460.569,0.286330,0,-0.958131,0,1,0,0.958131,0,0.286330),
["Jungle Island"]=CFrame.new(3074.222,52.998,2183.594,0.172924,0,-0.984935,0,1,0,0.984935,0,0.172924),
["Lunar Islands"]=CFrame.new(-3615.954,15.423,-1817.699,-0.521454,0,0.853279,0,1,0,-0.853279,0,-0.521454),
["Volcano Island"]=CFrame.new(2858.625,24.998,-7019.049,0.672071,-0.000000,0.740487,0.000000,1.000000,0.000000,-0.740487,0.000000,0.672071)
}

local e={
["Mainland"]=CFrame.new(-50.854,13.037,-941.285,0.818569,0,0.574408,0,1,0,-0.574408,0,0.818569),
["Blizzard Island"]=CFrame.new(-318.315,15.842,-3194.496,-0.997635,0,-0.068731,0,1,0,0.068731,0,-0.997635),
["Forest Island"]=CFrame.new(-7091.160,19.167,4562.860,-0.464963,0,-0.885330,0,1,0,0.885330,0,-0.464963),
["Royal Island"]=CFrame.new(886.675,13.871,-4781.455,-0.996450,0,-0.084187,0,1,0,0.084187,0,-0.996450),
["Desert Island"]=CFrame.new(744.558,9.802,3289.691,0.941137,0,0.338026,0,1,0,-0.338026,0,0.941137),
["Glacier Island"]=CFrame.new(2662.256,-6.468,329.880,-0.753561,-0.000000,0.657378,0.000000,1.000000,0.000000,-0.657378,0.000000,-0.753561),
["Mountain Island"]=CFrame.new(-7530.906,9.253,222.176,0.745782,0,0.666190,0,1,0,-0.666190,0,0.745782),
["Jungle Island"]=CFrame.new(2758.440,15.277,2194.426,-0.396159,0,0.918182,0,1,0,-0.918182,0,-0.396159),
["Lunar Islands"]=CFrame.new(-3508.798,15.270,-1886.841,0.208355,0,-0.978053,0,1,0,0.978053,0,0.208355),
["Volcano Island"]=CFrame.new(2419.245,18.078,-6687.550,-0.860906,0.000000,-0.508763,0.000000,1.000000,-0.000000,0.508763,-0.000000,-0.860906)
}




local f={}
local g=false
local h=false
local i=false
local j=0




local k=7
local l=90
local m=math.rad(60)
local n=70
local o=120
local p=0.5
local q=2
local r=2.0
local s=0.6




local t=nil
local u=nil
local v=nil
local w=nil
local x=nil

local function z(A,C)
for D,E in ipairs(A:GetDescendants())do
if E:IsA("BasePart")then
E.CanCollide=not C
end
end
end




local A=RaycastParams.new()
A.FilterType=Enum.RaycastFilterType.Exclude
A.IgnoreWater=true




local function C()
if w then
local D=w.Parent
if D then z(D,false)end
end

if v then v:Disconnect();v=nil end
if u then u:Destroy();u=nil end
if t then t:Destroy();t=nil end
if w then
w.PlatformStand=false
w=nil
end
x=nil
end





local function D(E,F,G)
local H=workspace:Raycast(E,F.Unit*G,A)
if H and H.Instance then
local I=H.Instance
if I:IsA("Terrain")or(I:IsA("BasePart")and I.CanCollide)then
return true,H.Position
end
end
return false,nil
end



local function E(F,G,H)
local I=G.Position+Vector3.new(0,ai,0)
local J=I-F.Position
local K=J.Magnitude

if K<p then return Vector3.zero,K end

local L=J.Unit

local M={ae.Character}
if x then table.insert(M,x)end
A.FilterDescendantsInstances=M


local N,O=D(F.Position,L,math.min(K,l))

if not N then
return L*math.min(K*60,o),K
end


local P=O and O.Y or F.Position.Y
local Q=Vector3.new(I.X,P+k,I.Z)
local R=(Q-F.Position).Unit


if H then
local S=(R+H*0.8).Unit
return S*math.min(K*60,o),K
end


local S=Vector3.new(L.X,0,L.Z)
if S.Magnitude<0.01 then S=Vector3.new(1,0,0)end
S=S.Unit

local T,U=math.cos(m),math.sin(m)

local V=Vector3.new(
S.X*T-S.Z*(-U),
0,
S.X*(-U)+S.Z*T
).Unit

local W=Vector3.new(
S.X*T-S.Z*U,
0,
S.X*U+S.Z*T
).Unit

local X=D(F.Position,V,n)
local Y=D(F.Position,W,n)

local Z
if not X and Y then
Z=V
elseif not Y and X then
Z=W
elseif not X and not Y then
local _=V:Dot(L)
local ar=W:Dot(L)
Z=(_>=ar)and V or W
else
Z=nil
end

local ar
if Z then
ar=(R+Z*1.2).Unit
else
ar=R
end

return ar*math.min(K*60,o),K
end




local function ar(F)
C()

local G=ae.Character
local H=G and G:FindFirstChild("HumanoidRootPart")
if not H then return end

x=F:FindFirstAncestorOfClass("Model")

local I=G:FindFirstChildOfClass("Humanoid")
if I then
I.PlatformStand=true
w=I
end
z(G,true)


t=Instance.new("Attachment")
t.Parent=H

u=Instance.new("LinearVelocity")
u.Attachment0=t
u.MaxForce=1e6
u.RelativeTo=Enum.ActuatorRelativeTo.World
u.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
u.VectorVelocity=Vector3.zero
u.Parent=H


local J=H.Position
local K=tick()
local L=nil
local M=0

v=ac.Heartbeat:Connect(function()
if not F or not F.Parent then
C()
return
end

local N=ae.Character and ae.Character:FindFirstChild("HumanoidRootPart")
if not N or not u then return end
z(ae.Character,true)
local O=tick()


local P=(N.Position-J).Magnitude
if P>q then
J=N.Position
K=O
if O>M then L=nil end
else
local Q=O-K
if Q>=r and O>M then
local R=F.Position-N.Position
local S=Vector3.new(R.X,0,R.Z)
if S.Magnitude>0.01 then
local T=S.Unit:Cross(Vector3.new(0,1,0)).Unit
L=(math.random(0,1)==0)and T or-T
M=O+s
K=O
end
end
end

local Q=(O<=M)and L or nil

local R,S=E(N,F,Q)
u.VectorVelocity=R
end)
end




local function F(G)
if not G then return end
local H=b[G]or 1
pcall(function()ah.Travel(G,H)end)
end




local function G()
local H=workspace:FindFirstChild("Islands")
if not H then return nil end
for I,J in ipairs(H:GetChildren())do
if J:FindFirstChild(ae.Name)then return J end
end
return nil
end




local function H(I,J)
if not J then return end
if i then return end

local K=c[J.Name]
if not K or#K==0 then return end

local L=K[math.random(1,#K)].Position
local M=ae.Character
if not M then return end
local N=M:FindFirstChildOfClass("Humanoid")

i=true
j=tick()

local O=15

local P=u~=nil
local Q,R=u,t
local S,T=nil,nil

if not P then
if N then N.PlatformStand=true end
T=Instance.new("Attachment")
T.Parent=I
S=Instance.new("LinearVelocity")
S.Attachment0=T
S.MaxForce=1e6
S.RelativeTo=Enum.ActuatorRelativeTo.World
S.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
S.VectorVelocity=Vector3.zero
S.Parent=I
Q,R=S,T
end

local U=40
local V=2

local function W()
if S then S:Destroy()end
if T then T:Destroy()end
if N and not P then N.PlatformStand=false end
i=false
end

local X
X=ac.Heartbeat:Connect(function()

if tick()-j>O then
X:Disconnect()
W()
return
end


local Y=ae.Character
local Z=Y and Y:FindFirstChild("HumanoidRootPart")

if not Z or not Q or not Q.Parent then
X:Disconnect()
W()
return
end

local _=L-Z.Position
local as=_.Magnitude

if as<V then
Q.VectorVelocity=Vector3.zero
X:Disconnect()
W()
else
Q.VectorVelocity=_.Unit*math.min(as*8,U)
end
end)
end

local function as(I,J)
local K=nil
local L=math.huge

if h then
for M,N in ipairs(workspace:GetChildren())do
if N:IsA("Model")then
local O=N:FindFirstChild("HumanoidRootPart")
if O then
local P=(I.Position-O.Position).Magnitude
if P<L then L=P;K=O end
end
end
end
if K then return K end
end

for M,N in ipairs(J:GetDescendants())do
if N:IsA("Model")then
local O=N:FindFirstChild("HumanoidRootPart")
local P=N:FindFirstChild("CaptureProgress",true)
if O and P then
local Q=(I.Position-O.Position).Magnitude
if Q<L then L=Q;K=O end
end
end
end

return K
end

local function I(J)
local K={}
for L,M in ipairs(aq)do
if f[M]then table.insert(K,M)end
end
if#K==0 then return nil end
if#K==1 then return K[1]end
for L,M in ipairs(K)do
if M==J then return K[(L%#K)+1]end
end
return K[1]
end




local function J()
local K=workspace:FindFirstChild("Islands")
if not K then return end
local L=K:FindFirstChild("Volcano Island")
if not L then return end
local M=L:FindFirstChild("LavaParts")
if not M then return end
for N,O in ipairs(M:GetDescendants())do
if O:IsA("TouchTransmitter")then O:Destroy()end
end
end

do
local K=nil
ac.Heartbeat:Connect(function()
local L=G()
if L and L.Name=="Volcano Island"and K~="Volcano Island"then
K="Volcano Island"
J()
elseif not L or L.Name~="Volcano Island"then
K=L and L.Name or nil
end
end)
task.spawn(function()
while true do J();task.wait(3)end
end)
end




do
local K=require(af.PlayerScripts.Secondary:WaitForChild("EquipmentHandler"))
task.spawn(function()
while true do
task.wait(tonumber(ao)or ak)
if not an then continue end
local L=K.object
if not L then continue end
local M=false
if L.controller and L.controller.GetTarget then
local N,O=pcall(L.controller.GetTarget,L)
M=N and O~=nil
elseif L.controller and L.controller.GetAnimals then
local N,O=pcall(L.controller.GetAnimals,L,true,true)
M=N and O and#O>0
else
M=true
end
if M then pcall(function()L:Activate()end)end
end
end)
end




do
local K=5

task.spawn(function()
local L=0
local M=nil
local N=false
local O=0
local P=0

local function Q(R)
if not R then return false end
if not R.Parent then return false end
local S=R:FindFirstAncestorOfClass("Model")
if not S then return false end
if not S.Parent then return false end
return true
end

local function R()
C()
M=nil
P=0
end

local function S(T)
if N then return end
N=true
L=0
O=0
R()
F(T)
local U=tick()+30
repeat
task.wait(1)
local V=G()
if V and V.Name==T then break end
until tick()>U
task.wait(2)
N=false
end

local function T(U)
local V=G()
if not V then return end
H(U,V)
end

while true do
task.wait(0.4)



if i and tick()-j>20 then
i=false
end

if not am then
R()
L=0
O=0
continue
end

if N then continue end

local U=ae.Character
local V=U and U:FindFirstChild("HumanoidRootPart")
if not V then continue end

local W=G()
if not W then continue end

if g and not f[W.Name]then
local X=I(W.Name)
if X then S(X)end
continue
end


if M then
if Q(M)then
P=0
else
P+=1
if P>=K then R()end
end
end


if not M then
local X=as(V,W)
if X then
M=X
P=0
ar(M)
end
end

if M then
L=0
O=0
else
L+=1
O+=0.4

if g and O>=al then
local X=I(W.Name)
if X and X~=W.Name then
S(X)
else
T(V)
O=0
L=0
end
continue
end

if L>=(tonumber(ap)or aj)then
T(V)
L=0
end
end
end
end)
end




return{
setEnabled=function(K)am=K end,
setWildherd=function(K)h=K end,
setAutotravel=function(K)g=K end,
setIsland=function(K,L)f[K]=L end,
setAutoclick=function(K)an=K end,
setClickDuration=function(K)ao=K end,
setIdleLimit=function(K)ap=K end,
}end function a.d():typeof(aa())local ab=a.cache.d if not ab then ab={c=aa()}a.cache.d=ab end return ab.c end end do local function aa()
local ab=game:GetService("ReplicatedStorage")
local ac=game:GetService("Players")
local ad=game:GetService("RunService")

local ae=require(ab:WaitForChild("References"))
local af=ae.Utilities
local ah=require(ae.PlayerScripts.Priority:WaitForChild("Data"))
local ai=ac.LocalPlayer




local aj=0.2
local ak=0.8
local al=1.2
local am=0.05
local an=3




local ao=false
local ap=false
local aq=0
local ar=false




local function as()
return ah.GetLocal({"quickEquipment","Lasso"})
end

local function b()
return ah.GetLocal({"temporary","equippedEquipment"})
end

local function c()
local d=as()
if not d then return false end
return tostring(b())==tostring(d)
end




local function d()
af.Network:FireServer("QuickEquipment","Use","Lasso")

local e=tick()+al
while tick()<e do
task.wait(am)
if c()then
return true
end
end
return false
end

local function e()
if not ao then return end
if ap then return end
if c()then ar=true;return end



if ar then
ar=false
end

local f=tick()
if(f-aq)<ak then return end

local g=as()
if not g then return end

ap=true
aq=tick()

local h,i=pcall(function()
for h=1,an do
if d()then
ar=true
break
end


task.wait(ak*h)
end
end)

if not h then
warn("[AutoLasso] Error on equip attempt:",i)
end

ap=false
end




task.spawn(function()
while true do
task.wait(aj)
e()
end
end)




local function f()
task.wait(1.5)
ap=false
aq=0
ar=false
e()
end

ai.CharacterAdded:Connect(f)




return{
setEnabled=function(g)
ao=g
if not g then

ar=false
ap=false
end
end,
}end function a.e():typeof(aa())local ab=a.cache.e if not ab then ab={c=aa()}a.cache.e=ab end return ab.c end end do local function aa()
local ab=require(game:GetService("ReplicatedStorage").References)
local ac=ab.Utilities
local ad=require(ab.PlayerScripts.Priority.Data)
local ae=game:GetService("Players").LocalPlayer
local af=require(ab.PlayerScripts.Secondary:WaitForChild("EquipmentHandler"))

local ah=false
local ai=0.1
task.spawn(function()
while true do
task.wait(ai)

if not ah then continue end

local aj=af.object
if not aj then continue end

local ak=false

if aj.controller and aj.controller.GetTarget then
local al,am=pcall(aj.controller.GetTarget,aj)
ak=al and am~=nil
elseif aj.controller and aj.controller.GetAnimals then
local al,am=pcall(aj.controller.GetAnimals,aj,true,true)
ak=al and am and#am>0
else
ak=true
end

if ak then
pcall(function()aj:Activate()end)
end
end
end)

return{
setEnabled=function(aj)
ah=aj
end,
setDuration=function(aj)
ai=tonumber(aj)or 0.1
end,
isEnabled=function()
return ah
end,
}end function a.f():typeof(aa())local ab=a.cache.f if not ab then ab={c=aa()}a.cache.f=ab end return ab.c end end do local function aa()




local ab=game:GetService("Players")

local ac=ab.LocalPlayer




local ad=0
local ae=0
local af=0
local ah=0
local ai=nil




local function aj(ak)
if not ak or ak==""then return nil end

ak=ak:gsub(",",""):gsub("%s+","")
local al=1
if ak:sub(1,1)=="-"then al=-1;ak=ak:sub(2)
elseif ak:sub(1,1)=="+"then ak=ak:sub(2)end
local am=tonumber(ak)
return am and(al*math.floor(am))or nil
end

local function ak()
local al=ac:FindFirstChild("PlayerGui");if not al then return nil end
local am=al:FindFirstChild("HUD");if not am then return nil end
local an=am:FindFirstChild("TopBar");if not an then return nil end
local ao=an:FindFirstChild("Tokens");if not ao then return nil end
return ao:FindFirstChild("ChangeLabel")
end





local function al()
if ai then ai:Disconnect();ai=nil end

local am=ak()
if not am then
task.delay(3,al)
return
end

ai=am:GetPropertyChangedSignal("Text"):Connect(function()
local an=aj(am.Text)
if an and an>0 then
ae+=an
end
end)
end




local am={}

function am.recordSell()
ad+=1
af+=1
end

function am.recordLock()
ad+=1
ah+=1
end

function am.getStats()
return{
captures=ad,
sold=af,
locked=ah,
coins=ae,
}
end

function am.reset()
ad=0
ae=0
af=0
ah=0
end

function am.destroy()
if ai then ai:Disconnect();ai=nil end
end

al()

return am end function a.g():typeof(aa())local ab=a.cache.g if not ab then ab={c=aa()}a.cache.g=ab end return ab.c end end do local function aa()





local ab=game:GetService("ReplicatedStorage")
local ac=require(ab.References.HorseVariants)


local ad=a.g()

local ae={
"mismatchHairColour",
"naturallyDyedHairColour",
"islandUniqueCoat",
"islandUniqueHorn",
"islandUniqueHairColour",
"specialIslandUniqueCoat",
"specialCoat",
"specialHair",
"horned",
"rareCoat",
}

local af={}
for ah,ai in ipairs(ae)do
af[ai]=true
end

local ah=0.975

local ai={
["sandy"]=true,["pearly purple"]=true,["pearly gold"]=true,["clear sea glass"]=true,
["blessed"]=true,["iceyBlue"]=true,["iceyWhite"]=true,["iceyPink"]=true,
["iceyBlack"]=true,["iceyGreen"]=true,["winterStreaks"]=true,["flowery"]=true,
["pearlyGreen"]=true,["leafy"]=true,["pearly"]=true,["pastelStreaks"]=true,
["leathery"]=true,["royalStreaks"]=true,["cowPrint"]=true,["pearlyPink"]=true,
["clearQuartz"]=true,["zebraStripes"]=true,["dustyFade"]=true,["limestone"]=true,
["sandstone"]=true,["ruby"]=true,["pearlyRed"]=true,["glacierGreen"]=true,
["glacierPink"]=true,["glacierBlue"]=true,["snowyGlacierFade"]=true,
["pinkCowPrint"]=true,["diamond"]=true,["sapphire"]=true,["pearlyOrange"]=true,
["sunriseStreaks"]=true,["amethyst"]=true,["topaz"]=true,["jaguarSpots"]=true,
["mossy"]=true,["tigerStripes"]=true,["emerald"]=true,["deepSpace"]=true,
["neonBlue"]=true,["obsidian"]=true,["neonPurple"]=true,["moonstone"]=true,
["pearlyBlue"]=true,["volcanicOrange"]=true,["pearlyBlack"]=true,
["crackedLavaFade"]=true,["volcanicBlack"]=true,["prismatic"]=true,
}

local aj=0.5




local function ak(al)
if not al then return false,nil end
local am=al.variants
if not am then return false,nil end

if af["horned"]==true then
if am.horn and am.horn~=""then
return true,"horned"
end
end

if am.colour then
local an=ac.colour[am.colour]
if an then
local ao=an.specialItemIndicator
if ao and af[ao]==true then
return true,ao
end
if af["rareCoat"]==true
and(an.rarityFloat or 0)>=ah then
return true,"rareCoat"
end
end
end

for an,ao in ipairs({"maneColour","tailColour"})do
local ap=am[ao]
if ap then
local aq=ac.maneAndTailColour[ap]
if aq then
local ar=aq.specialItemIndicator
if ar and af[ar]==true then
return true,ar
end
end
if af["islandUniqueHairColour"]==true
and ai[ap]==true then
return true,"islandUniqueHairColour"
end
end
end

if af["mismatchHairColour"]==true then
local an=al.maneColourOg or am.maneColour
local ao=al.tailColourOg or am.tailColour
if an and ao and an~=ao then
return true,"mismatchHairColour"
end
end

if af["naturallyDyedHairColour"]==true
and al.isNatDyed==true then
return true,"naturallyDyedHairColour"
end

if al.specialItemIndicator
and af[al.specialItemIndicator]==true then
return true,al.specialItemIndicator
end

return false,nil
end




local al=getloadedmodules()
local am=nil
local an=nil

for ao,ap in al do
if not ap or ap.ClassName~="ModuleScript"then continue end
if ap.Name=="Network"then am=require(ap)end
if ap.Name=="InventoryHandler"then an=require(ap)end
end

local ao=false
local ap=nil




local function aq(ar)
ao=(ar~=nil)and ar or(not ao)

if ao then
if not ap then
ap=an.Bind("Added",function(as,b)
if not ao then return end

local c,d=ak(b)

task.delay(aj,function()
if not ao then return end

if c then
warn("[AutoSell] Locking:",as,"| Reason:",d)
am:FireServer("Inventory","Lock",as)
sendLockWebhook(as,b,d)
ad.recordLock()
else
warn("[AutoSell] Selling:",as)
am:FireServer("Shopping","QuickSellItem",as)
ad.recordSell()
end
end)
end)
end
else
if ap then
an.Unbind(ap)
ap=nil
end
end
end




return{
setEnabled=function(ar)
aq(ar)
end,
isEnabled=function()
return ao
end,


getStats=ad.getStats,
resetCounters=ad.reset,
snapshotBalance=ad.snapshotBalance,


setLockOption=function(ar,as)
if af[ar]==nil and not table.find(ae,ar)then
warn("[AutoSell] Unknown lock option:",ar)
return
end
af[ar]=as
end,
getLockOption=function(ar)
return af[ar]==true
end,
getAllLockOptions=function()
local ar={}
for as,b in ipairs(ae)do
ar[b]=af[b]==true
end
return ar
end,

setRareThreshold=function(ar)
ah=tonumber(ar)or ah
end,
getRareThreshold=function()
return ah
end,

setActionDelay=function(ar)
aj=tonumber(ar)or aj
end,
getActionDelay=function()
return aj
end,

checkHorse=function(ar)
return ak(ar)
end,

getLockOptionNames=function()
return ae
end,
}end function a.h():typeof(aa())local ab=a.cache.h if not ab then ab={c=aa()}a.cache.h=ab end return ab.c end end do local function aa()
local function ab(ac)
local ad=game:GetService("ReplicatedStorage")
local ae=game:GetService("RunService")
local af=game:GetService("Players")
local ah=af.LocalPlayer

local ai=require(ad.References)
local aj=ai.Utilities
local ak=require(ai.PlayerScripts.Priority.Data)

local al={
CFrame.new(3536.414,20.998,-8541.338,-0.986777,0.000000,0.162083,0.000000,1.000000,-0.000000,-0.162083,-0.000000,-0.986777),
CFrame.new(3081.965,20.998,-8160.560,0.430185,0.000000,-0.902741,0.000000,1.000000,0.000000,0.902741,-0.000000,0.430185),
CFrame.new(3040.943,21.278,-7674.188,0.183440,0.000000,-0.983031,0.000000,1.000000,0.000000,0.983031,-0.000000,0.183440),
CFrame.new(3216.217,31.396,-7417.089,-0.624938,0.000000,-0.780675,0.000000,1.000000,-0.000000,0.780675,-0.000000,-0.624938),
CFrame.new(3437.597,20.998,-7198.555,-0.661883,-0.000000,-0.749607,0.000000,1.000000,-0.000000,0.749607,-0.000000,-0.661883),
CFrame.new(3773.379,20.998,-7077.844,-0.083580,-0.000000,-0.996501,-0.000000,1.000000,-0.000000,0.996501,0.000000,-0.083580),
CFrame.new(4060.921,20.998,-7068.069,-0.231128,0.000000,-0.972923,0.000000,1.000000,0.000000,0.972923,-0.000000,-0.231128),
CFrame.new(4364.559,20.998,-7172.213,0.760222,-0.000000,-0.649663,-0.000000,1.000000,-0.000000,0.649663,0.000000,0.760222),
CFrame.new(4582.479,20.998,-7443.499,0.967904,0.000000,0.251320,0.000000,1.000000,-0.000000,-0.251320,0.000000,0.967904),
CFrame.new(4611.561,20.998,-7778.034,0.980821,0.000000,-0.194913,-0.000000,1.000000,-0.000000,0.194913,0.000000,0.980821),
CFrame.new(4505.688,21.692,-8218.074,-0.065622,0.000000,0.997845,-0.000000,1.000000,-0.000000,-0.997845,-0.000000,-0.065622),
CFrame.new(4175.913,21.119,-8487.763,0.747902,0.000000,0.663810,-0.000000,1.000000,0.000000,-0.663810,-0.000000,0.747902),
CFrame.new(3854.704,20.998,-8574.500,0.874451,0.000000,-0.485114,-0.000000,1.000000,0.000000,0.485114,-0.000000,0.874451),
CFrame.new(3382.399,20.998,-8496.440,-0.170347,0.000000,0.985384,-0.000000,1.000000,-0.000000,-0.985384,-0.000000,-0.170347),
CFrame.new(3150.118,27.933,-8297.297,-0.923549,-0.000000,0.383481,-0.000000,1.000000,0.000000,-0.383481,0.000000,-0.923549),
CFrame.new(3583.769,524.847,-7929.497,-0.971305,0.000000,-0.237838,-0.000000,1.000000,0.000000,0.237838,0.000000,-0.971305),
CFrame.new(3740.703,547.900,-8010.287,0.990457,0.000000,-0.137825,-0.000000,1.000000,-0.000000,0.137825,0.000000,0.990457),
CFrame.new(3907.742,526.523,-7917.505,-0.471205,-0.000000,-0.882024,-0.000000,1.000000,-0.000000,0.882024,0.000000,-0.471205),
}


local am=false
local an=false
local ao=false
local ap=5
local aq=false
local ar=false



local as=nil

local b={
["Rock"]=false,
["Tin Rock"]=false,
["Copper Rock"]=false,
["Bronze Rock"]=false,
["Iron Rock"]=false,
["Random Crystal"]=false,
["Random Rock"]=false,
["Silver Rock"]=false,
["Gold Rock"]=false,
["Ruby Crystal"]=false,
["Frozen Crystal"]=false,
["Clear Quartz Crystal"]=false,
["Archaeological Deposit"]=false,
["Diamond Crystal"]=false,
["Sapphire Crystal"]=false,
["Topaz Crystal"]=false,
["Amethyst Crystal"]=false,
["Emerald Crystal"]=false,
["Obsidian Rock"]=false,
["Moonstone Rock"]=false,
["Prismatic Crystal"]=false,
["Erupted Deposit"]=false,
}

local c={
"Rock","Tin Rock","Copper Rock","Bronze Rock","Iron Rock",
"Random Crystal","Random Rock","Silver Rock","Gold Rock",
"Ruby Crystal","Frozen Crystal","Clear Quartz Crystal",
"Archaeological Deposit","Diamond Crystal","Sapphire Crystal",
"Topaz Crystal","Amethyst Crystal","Emerald Crystal",
"Obsidian Rock","Moonstone Rock","Prismatic Crystal","Erupted Deposit",
}

local d="itemName"
local e="health"

local f=Vector3.zero
local g=tick()


local h=Instance.new("Highlight")
h.FillColor=Color3.fromRGB(0,255,255)
h.OutlineColor=Color3.fromRGB(255,255,255)
h.FillTransparency=0.5
h.OutlineTransparency=0
h.Parent=game:GetService("CoreGui")
h.Enabled=false


local i=Instance.new("Attachment")
local j=Instance.new("LinearVelocity")
j.Attachment0=i
j.MaxForce=1e6
j.RelativeTo=Enum.ActuatorRelativeTo.World
j.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
j.VectorVelocity=Vector3.zero

local function k(l)
if i.Parent~=l then
i.Parent=l
j.Parent=l
end
end

local function l()
j.VectorVelocity=Vector3.zero
i.Parent=nil
j.Parent=nil
end

local function m(n,o)
k(n)
n.CFrame=o
j.VectorVelocity=Vector3.zero
n.AssemblyLinearVelocity=Vector3.zero
n.AssemblyAngularVelocity=Vector3.zero
end


local function n()
local o=workspace:FindFirstChild("Islands")
if not o then return nil end
for p,q in ipairs(o:GetChildren())do
if q:FindFirstChild(ah.Name)then return q end
end
return nil
end

local function o(p)
local q=ah.Character and ah.Character:FindFirstChild("HumanoidRootPart")
if not q then return nil end

local r,s=nil,math.huge

for t,u in ipairs(p:GetDescendants())do

if u==as then continue end

local v=u:GetAttribute(d)
if u:IsA("Model")and b[v]==true then
local w=u:GetAttribute(e)
if w and w>0 then
local x=u.PrimaryPart or u:FindFirstChildWhichIsA("BasePart")
if x then
local z=(q.Position-x.Position).Magnitude
if z<s then
s=z
r=u
end
end
end
end
end

return r
end


local function p()
local q,r=pcall(function()
if not aq then return end
local q=ak.GetLocal({"quickEquipment","Harvester"})
if not q then return end
if not ar then
ar=true
aj.Network:FireServer("QuickEquipment","Use","Harvester")
end
end)
if not q then
warn("[AutoHarvester] Error:",r)
end
end

local function q()
ar=false

as=nil
task.wait(1.5)
p()



end

ak.BindLocal({"temporary","equippedEquipment"},function()
local r=ak.GetLocal({"quickEquipment","Harvester"})
local s=ak.GetLocal({"temporary","equippedEquipment"})
if s~=r then
ar=false
task.wait(0.1)
p()
end
end,true)

if ah.Character then q()end
ah.CharacterAdded:Connect(q)


local r=nil

local function s()
if r then
r:Disconnect()
r=nil
end
l()
h.Enabled=false
end

local function t(u)
local v=u.PrimaryPart or u:FindFirstChildWhichIsA("BasePart")
if not v then return end

local w=u:GetAttribute(d)=="Erupted Deposit"
local x=w and Vector3.new(0,10,0)or Vector3.new(0,2,4)

if r then
r:Disconnect()
r=nil
end

r=ae.Heartbeat:Connect(function()
local z=ah.Character and ah.Character:FindFirstChild("HumanoidRootPart")
if not z or not u.Parent then
s()
return
end

local A=CFrame.new(v.Position+x,v.Position)
k(z)

local C=A.Position-z.Position
if C.Magnitude>0.1 then
j.VectorVelocity=C.Unit*math.min(C.Magnitude*10,200)
else
j.VectorVelocity=Vector3.zero
z.CFrame=A
z.AssemblyLinearVelocity=Vector3.zero
z.AssemblyAngularVelocity=Vector3.zero
end
end)
end


task.spawn(function()
while true do
task.wait(1)

if not am or not ao or as~=nil then
g=tick()
continue
end

local u=ah.Character
local v=u and u:FindFirstChild("HumanoidRootPart")
if not v then continue end

if(v.Position-f).Magnitude>2 then
f=v.Position
g=tick()
elseif tick()-g>ap then
local w=n()
if w then
local x=(w.Name=="Volcano Island")and al or IslandTeleports[w.Name]
if x and#x>0 then
local z=ah.Character and ah.Character:FindFirstChild("HumanoidRootPart")
if z then
m(z,x[math.random(1,#x)])
end
end
end
g=tick()
end
end
end)





task.spawn(function()
while true do
task.wait(0.3)

if not am then
s()


pcall(function()
aj.Network:FireServer("Resource","Disengage")
end)
continue
end


local u=ah.Character
if not u or not u:FindFirstChild("HumanoidRootPart")then
continue
end

local v=n()
if not v then continue end

local w=o(v)
if not w then continue end

local x=w.PrimaryPart or w:FindFirstChildWhichIsA("BasePart")
if not x then continue end

if an then
h.Adornee=w
h.Enabled=true
end


t(w)


as=w




local z,A,C=pcall(function()
return aj.Network:InvokeServer("Resource","Engage",w)
end)


s()
as=nil

if not z then


warn("[Automine] Engage pcall error:",A)
task.wait(1)
continue
end


if not A then

if C then
warn("[Automine] Engage rejected:",C)
end
task.wait(0.5)
end


end
end)


return{
setEnabled=function(u)
am=u
if not u then
s()
pcall(function()
aj.Network:FireServer("Resource","Disengage")
end)
as=nil
end
end,
setPickaxeEnabled=function(u)
aq=u
if u then p()end
end,
isEnabled=function()
return am
end,
setHighlight=function(u)
an=u
if not u then h.Enabled=false end
end,
setRandomTeleport=function(u)
ao=u
end,
setIdleThreshold=function(u)
ap=tonumber(u)or 5
end,
setOreTarget=function(u,v)
if b[u]~=nil then
b[u]=v
end
end,
getOreValues=function()
return c
end,
}
end

return ab end function a.i():typeof(aa())local ab=a.cache.i if not ab then ab={c=aa()}a.cache.i=ab end return ab.c end end do local function aa()
local ab=game:GetService("RunService")
local ac=game:GetService("Players")

local ad=ac.LocalPlayer

getgenv().WalkSpeed_Enabled=false
getgenv().WalkSpeed_Value=16
getgenv().JumpPower_Enabled=false
getgenv().JumpPower_Value=50

local ae=nil
local af=nil
local ah=nil
local ai=false
local aj=false





local function ak()
local al=ad.Character
return al and al:FindFirstChildOfClass("Humanoid")
end

local function al(am)
if am==ah then return end


if ah and ah.Parent then
if ae then
ah.WalkSpeed=ae
end
if af then
ah.JumpPower=af
ah.UseJumpPower=false
end
end

if am then
ae=am.WalkSpeed
af=am.JumpPower
else
ae=nil
af=nil
end

ah=am
end




ab.Heartbeat:Connect(function()
local am=ak()
if not am then return end

al(am)

local an=getgenv().WalkSpeed_Enabled
local ao=getgenv().JumpPower_Enabled


if an then
am.WalkSpeed=getgenv().WalkSpeed_Value
elseif ai and not an then
if ae then
am.WalkSpeed=ae
end
end


if ao then
am.UseJumpPower=true
am.JumpPower=getgenv().JumpPower_Value
elseif aj and not ao then
am.UseJumpPower=false
if af then
am.JumpPower=af
end
end

ai=an
aj=ao
end)




return{
setEnabled=function(am)getgenv().WalkSpeed_Enabled=am end,
setValue=function(am)getgenv().WalkSpeed_Value=am end,
setJumpEnabled=function(am)getgenv().JumpPower_Enabled=am end,
setJumpValue=function(am)getgenv().JumpPower_Value=am end,
}end function a.j():typeof(aa())local ab=a.cache.j if not ab then ab={c=aa()}a.cache.j=ab end return ab.c end end do local function aa()
local ab=game:GetService("RunService")
local ac=game:GetService("Players").LocalPlayer

getgenv().MountSpeedEnabled=false
getgenv().MountJumpEnabled=false
getgenv().MountSpeedValue=16
getgenv().MountJumpValue=50

local ad=nil
local ae=nil
local af=nil
local ah=nil


local ai=false
local aj=false




task.spawn(function()
while true do
local ak=ac.Character
local al=ak and ak:FindFirstChild("HumanoidRootPart")
local am=workspace:FindFirstChild("Islands")

if al and am then
local an=nil
local ao=250

for ap,aq in ipairs(am:GetChildren())do
if aq:FindFirstChild(ac.Name)then
for ar,as in ipairs(aq:GetDescendants())do
if as:IsA("Model")then
local b=as:FindFirstChild("HumanoidRootPart")
local c=as:FindFirstChildOfClass("Humanoid")

if b and c and(
as:FindFirstChildWhichIsA("AlignPosition")or
as:FindFirstChildWhichIsA("AlignOrientation")
)then
local d=(al.Position-b.Position).Magnitude
if d<ao then
ao=d
an=c
end
end
end
end
end
end

if an~=ah then

if ah and ah.Parent then
if ae then ah.WalkSpeed=ae end
if af then
ah.UseJumpPower=true
ah.JumpPower=af
end
end

if an then
ae=an.WalkSpeed
af=an.JumpPower
else
ae=nil
af=nil
end

ah=an
ad=an
end
end

task.wait(1)
end
end)



ab.Heartbeat:Connect(function()
local ak=ad
if not ak or not ak.Parent then return end

local al=getgenv().MountSpeedEnabled
local am=getgenv().MountJumpEnabled


if al then
ak.WalkSpeed=getgenv().MountSpeedValue
elseif ai and not al then

if ae then
ak.WalkSpeed=ae
end
end


if am then
ak.UseJumpPower=true
ak.JumpPower=getgenv().MountJumpValue
elseif aj and not am then

if af then
ak.UseJumpPower=true
ak.JumpPower=af
end
end

ai=al
aj=am
end)

return{
setEnabled=function(ak)getgenv().MountSpeedEnabled=ak end,
setValue=function(ak)getgenv().MountSpeedValue=ak end,
setJumpEnabled=function(ak)getgenv().MountJumpEnabled=ak end,
setJumpValue=function(ak)getgenv().MountJumpValue=ak end,
}end function a.k():typeof(aa())local ab=a.cache.k if not ab then ab={c=aa()}a.cache.k=ab end return ab.c end end do local function aa()









local function ab()


local ac=false
local ad=42
local ae=6
local af=20
local ah=5
local ai=0.6
local aj=1.5
local ak=false
local al=false


local am=game:GetService("RunService")
local an=game:GetService("Players")
local ao=an.LocalPlayer


local ap,aq,ar,as,b,c

local function d()
if aq then return true end

local e=game:GetService("ReplicatedStorage")
local f,g=pcall(require,e.References)
if not f then warn("[CC] References not found:",g);return false end

ap=g
aq=ap.Utilities.Network
ar=ap.Utilities.Time

local h=ao.PlayerScripts:FindFirstChild("RidingHandler",true)
if not h then warn("[CC] RidingHandler not found");return false end
as=require(h)

local i=ao.PlayerScripts:FindFirstChild("CheckpointActivityHandler",true)
if not i then warn("[CC] CheckpointActivityHandler not found");return false end
b=require(i)

local j,k=pcall(function()
return workspace.Islands["Training Island"]["Cross Country"].CheckpointActivity
end)
if not j then warn("[CC] CheckpointActivity model not found:",k);return false end
c=k

return true
end


local e={"Collision","BallCollision","HumanoidRootPart"}
local f={"LowerTorso","UpperTorso"}
local g={}

local function h(i)
for j,k in g do pcall(function()k:Disconnect()end)end
g={}
if not ak or not i then return end

for j,k in e do
local l=i.instance:FindFirstChild(k,true)
if l and l:IsA("BasePart")then
l.CanCollide=false
table.insert(g,l:GetPropertyChangedSignal("CanCollide"):Connect(function()
if ak and l.CanCollide then l.CanCollide=false end
end))
end
end

local j=ao.Character
if j then
for k,l in f do
local m=j:FindFirstChild(l,true)
if m and m:IsA("BasePart")then
m.CanCollide=false
table.insert(g,m:GetPropertyChangedSignal("CanCollide"):Connect(function()
if ak and m.CanCollide then m.CanCollide=false end
end))
end
end
end
end

local function i(j)
for k,l in g do pcall(function()l:Disconnect()end)end
g={}
if not j then return end
for k,l in e do
local m=j.instance:FindFirstChild(l,true)
if m and m:IsA("BasePart")then m.CanCollide=true end
end
local k=ao.Character
if k then
for l,m in f do
local n=k:FindFirstChild(m,true)
if n and n:IsA("BasePart")then n.CanCollide=true end
end
end
end


local function j(k)
local l=Instance.new("Attachment")
l.Parent=k
local m=Instance.new("LinearVelocity")
m.Attachment0=l
m.MaxForce=1e6
m.RelativeTo=Enum.ActuatorRelativeTo.World
m.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
m.VectorVelocity=Vector3.zero
m.Parent=k
return m,l
end


local function k()
return as and as.GetCurrentMount and as.GetCurrentMount()
end

local function l(m)
return m and m.instance and m.instance:FindFirstChild("HumanoidRootPart")
end

local function m()
local n={}
for o,p in workspace:GetDescendants()do
if p:IsA("Part")
and p.Shape==Enum.PartType.Ball
and p.Transparency==1
and p.Anchored
and not p.CanCollide
and p:FindFirstChildOfClass("TouchTransmitter")
and p:GetFullName():find("Cross Country")then
table.insert(n,p)
end
end
local o=workspace:FindFirstChild("Part")
if o and o:IsA("Part")and o:FindFirstChildOfClass("TouchTransmitter")then
table.insert(n,o)
end
return n
end

local function n(o,p)
local q,r=nil,math.huge
for s,t in p do
local u=(t.Position-o).Magnitude
if u<r then q,r=t,u end
end
return q,r
end

local function o(p,q)
if q:FindFirstChildOfClass("TouchTransmitter")then
firetouchinterest(p,q,0)
end
end


local p,q,r,s,t,u
local v=false

local function w()
v=false
if r then pcall(function()r:Disconnect()end);r=nil end
if s then pcall(function()s:Disconnect()end);s=nil end
if p then
pcall(function()p.VectorVelocity=Vector3.zero;p:Destroy()end)
p=nil
end
if q then
pcall(function()q:Destroy()end)
q=nil
end
i(u)
u=nil
print("[CC] Stopped.")
end

local function x()
aq:FireServer("CheckpointActivity","TriggerInteractable",c)
print("[CC] TriggerInteractable fired")
task.wait(2)
t=0
end

local function z()
if v then return end
if not d()then
warn("[CC] Cannot start — refs failed to resolve")
return
end

local A=k()
if not A then warn("[CC] Mount up before enabling");return end
local C=l(A)
if not C then warn("[CC] No HumanoidRootPart on mount");return end

u=A
v=true
t=0
p,q=j(C)

h(A)
x()


s=b.ActivityChanged:Connect(function()
if not v then return end
task.wait(0.3)
if b.currentObject==nil then
print("[CC] Activity ended — restarting in",aj,"s")
if p then p.VectorVelocity=Vector3.zero end
task.wait(aj)
if v and ac then
local D=k()
if D then h(D)end
x()
end
end
end)


r=am.Heartbeat:Connect(function()
if not ac or not v then
if p then p.VectorVelocity=Vector3.zero end
return
end

local D=k()
if not D then if p then p.VectorVelocity=Vector3.zero end;return end
local E=l(D)
if not E then if p then p.VectorVelocity=Vector3.zero end;return end


local F=os.clock()
if F-t>=ai then
t=F
D.lastTimeJumped=ar.Get()
end

local G=E.Position
local H=m()
local I,J=n(G,H)

if not I then
if p then p.VectorVelocity=Vector3.zero end
return
end

if al then
print(string.format("[CC] %s | %.1f studs",I.Name,J))
end

local K=I.Position
local L=J<=af and ae or 0
local M=(Vector3.new(K.X,K.Y+L,K.Z)-G).Unit
p.VectorVelocity=M*ad

if J<=ah then
o(E,I)
end
end)

print("[CC] Running.")
end


return{
setEnabled=function(A)
ac=A
if A and not v then
z()
elseif not A and v then
w()
end
end,

setNoclip=function(A)
ak=A
if v then
local C=k()
if A then h(C)else i(C)end
end
end,

setMoveSpeed=function(A)ad=A end,
setYBias=function(A)ae=A end,
setCloseDist=function(A)af=A end,
setTriggerDist=function(A)ah=A end,
setJumpInterval=function(A)ai=A end,
setRetriggerDelay=function(A)aj=A end,
setDebug=function(A)al=A end,
stop=w,
}
end

return ab end function a.l():typeof(aa())local ab=a.cache.l if not ab then ab={c=aa()}a.cache.l=ab end return ab.c end end end

local aa=os.clock()
local ab=a.a()
local ac=a.b()
local ad=a.c()
local ae=a.d()
local af=a.e()
local ah=a.f()
local ai=a.h()
local aj=a.i()(m_References)
local ak=a.j()
local al=a.k()
local am=a.g()
local an=a.l()
local ao=an()

local ap=getgenv().Options
local aq=getgenv().Toggles

ab.ShowToggleFrameInKeybinds=true
ab.ShowCustomCursor=true
ab.NotifySide="Left"

local ar=ab:CreateWindow({









Title="coconut.xyz",
Center=true,
AutoShow=true,
Resizable=true,
ShowCustomCursor=true,
UnlockMouseWhileOpen=true,
NotifySide="Left",
TabPadding=8,
MenuFadeTime=0.2
})

local as=game:GetService("Players").LocalPlayer
local b=game:GetService("VirtualUser")

as.Idled:Connect(function()
b:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
b:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)







local c={

IlovemyWife=ar:AddTab("<ZEE3"),
Main=ar:AddTab("Automation"),
HorseRender=ar:AddTab("Render"),
Misc=ar:AddTab("Misc"),
["UI Settings"]=ar:AddTab("UI Settings"),
}

local d=c.IlovemyWife:AddLeftGroupbox("Information")

local e=d:AddLabel("I LOVE MY WIFE <font color=\"#D3AA32\">ZEE!!!</font>")

d:AddLabel("My wife is as if she landed on this earth from the heavens, yet\n\ united with flesh. She is among the",true)
d:AddLabel("best of women in this world. She is the best. She is the best to live\n\ she will eternally be my number one",true)
d:AddLabel("and i will forever be her number 1 supporter.\n\ i will love her until we both cross the abyss into the afterlife",true)
d:AddLabel("and i will be there to guide her and love her forever.\n\ our love for each other connects like the stars at night",true)
d:AddLabel("and her love grows a flame in my heart no one would put out.\n\ the spark we have could light a whole forest on fire",true)
d:AddLabel("and out future glows brighter than a planet or the sun.\n\ our love will one day be a folklore myth because",true)
d:AddLabel("no one will ever have our type of love or spark.\n\ ",true)

local f=c.IlovemyWife:AddRightGroupbox("Session Information")

local g=tick()
local h=f:AddLabel('Time Played: 0s')

task.spawn(function()
while true do
task.wait(1)

local i=math.floor(tick()-g)

local j=math.floor(i/3600)
local k=math.floor((i%3600)/60)
local l=i%60

h:SetText(string.format(
"Time Played: %02dh %02dm %02ds",
j,k,l
))
end
end)

local i=f:AddLabel('Coins Earned: 0')

task.spawn(function()
while true do
task.wait(2)
local j=ai.getStats()
i:SetText(string.format("Coins Earned: %d",j.coins))
end
end)

local j=f:AddLabel('Horses Captured: 0')

task.spawn(function()
while true do
task.wait(2)
local k=ai.getStats()
j:SetText(string.format("Horses Captured: %d",k.captures))
end
end)

local k=c.Main:AddLeftTabbox()

local l=k:AddTab("Horses")
local m=k:AddTab("Sell")
local n=k:AddTab("Lassos")

local o=l:AddLabel("<font color=\"#D3AA32\">I LOVE MY WIFE ZEE!!!</font>")

l:AddToggle('Autofarm_Enable',{
Text='Enable',
Default=false,
Tooltip='Enables Autofarm',

Callback=function(p)
ae.setEnabled(p)
end
})

l:AddToggle('CatureHerds',{
Text='Capture Herds',
Default=false,
Tooltip='Enables Capture Herds',

Callback=function(p)
ae.setWildherd(p)
end
})

l:AddToggle('AutoLasso',{
Text='Lasso',
Default=false,
Tooltip='Equips lasso for you',

Callback=function(p)
af.setEnabled(p)
end
})

l:AddToggle('AutoCapture',{
Text='Capture',
Default=false,
Tooltip='Clicks the horse to capture',

Callback=function(p)
ah.setEnabled(p)
end
})

l:AddSlider('CaptureRate',{
Text='Capture Rate',
Default=0.1,
Min=0.05,
Max=5,
Rounding=2,
Compact=true,
HideMax=true,

Callback=function(p)
ah.setDuration(p)
end
})

m:AddToggle('Autosell',{
Text='Auto Sell',
Default=false,
Tooltip='Automatically sells horses',

Callback=function(p)
ai.setEnabled(p)
end
})


local p={
["Mismatched Hair Colour"]="mismatchHairColour",
["Naturally Dyed Hair"]="naturallyDyedHairColour",
["Island Unique Coat"]="islandUniqueCoat",
["Island Unique Horn"]="islandUniqueHorn",
["Island Unique Hair Colour"]="islandUniqueHairColour",
["Special Island Unique Coat"]="specialIslandUniqueCoat",
["Special Coat"]="specialCoat",
["Special Hair"]="specialHair",
["Horned"]="horned",
["Rare Coat"]="rareCoat",
}


local q={}
for r,s in pairs(p)do
q[s]=r
end


local r={}
for s,t in pairs(p)do
table.insert(r,s)
end
table.sort(r)

m:AddDropdown("FilterTypeDropdown",{
Text="Filter",
Values=r,
Default=0,
Multi=true,
Tooltip="Select which horse types to lock instead of sell",

Callback=function(s)

for t,u in pairs(p)do
ai.setLockOption(u,false)
end


for t,u in pairs(s)do
if u then
local v=p[t]
if v then
ai.setLockOption(v,true)
end
end
end
end,

Disabled=false,
Visible=true,
})

m:AddDivider()

local s=c.Main:AddRightTabbox()

local t=s:AddTab("Ores")
local u=s:AddTab("Pickaxe")
local v=s:AddTab("Render")

t:AddToggle('AutoMine',{
Text='Mine',
Default=false,
Tooltip='Auto mines ores for you',

Callback=function(w)
aj.setEnabled(w)
end
})

t:AddToggle("RandomTP",{
Text="Random Teleport",
Default=false,
Tooltip="Teleports to a random spot on the island when idle",

Callback=function(w)
aj.setRandomTeleport(w)
end,
})

t:AddSlider("ClickCooldown",{
Text="Click Cooldown",
Default=0.05,
Min=0,
Max=1,
Rounding=2,
Compact=true,
HideMax=true,
Tooltip="Delay between clicks in seconds",

Callback=function(w)
aj.setClickCooldown(w)
end,
})


t:AddSlider("IdleThreshold",{
Text="Idle Threshold",
Default=5,
Min=1,
Max=30,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="Seconds idle before random teleport fires",

Callback=function(w)
aj.setIdleThreshold(w)
end,
})

local w=aj.getOreValues()

t:AddDropdown("OreSelector",{
Text="Ore Types",
Values=w,
Default=0,
Multi=true,
Tooltip="Select which ores to mine",

Callback=function(x)

for z,A in ipairs(w)do
aj.setOreTarget(A,false)
end

for z,A in pairs(x)do
if A then
aj.setOreTarget(z,true)
end
end
end,

Disabled=false,
Visible=true,
})

u:AddToggle("EquipPickaxe",{
Text="Pickaxe",
Default=false,
Tooltip="Equips the pickaxe for you automatically",

Callback=function(x)
aj.setPickaxeEnabled(x)
end,
})

local x=game:GetService("ReplicatedStorage")
local z=require(x.References)
local A=z.Utilities.Network





local C={
["Harvester"]={shop="Training Island Shop",idx=4},
["Stone Harvester (Train)"]={shop="Training Island Shop",idx=5},
["Tin Harvester (Train)"]={shop="Training Island Shop",idx=6},
["Stone Harvester"]={shop="Mainland Shop",idx=4},
["Tin Harvester"]={shop="Mainland Shop",idx=5},
["Copper Harvester"]={shop="Blizzard Island Shop",idx=4},
["Bronze Harvester"]={shop="Blizzard Island Shop",idx=5},
["Iron Harvester"]={shop="Forest Island Shop",idx=4},
["Silver Harvester"]={shop="Forest Island Shop",idx=5},
["Gold Harvester"]={shop="Desert Island Shop",idx=4},
["Ruby Harvester"]={shop="Desert Island Shop",idx=5},
["Topaz Harvester"]={shop="Jungle Island Shop",idx=4},
["Emerald Harvester"]={shop="Jungle Island Shop",idx=5},
["Amethyst Harvester"]={shop="Jungle Island Shop",idx=6},
["Diamond Harvester"]={shop="Mountain Island Shop",idx=4},
["Sapphire Harvester"]={shop="Mountain Island Shop",idx=5},
["Clear Quartz Harvester"]={shop="Royal Island Shop",idx=4},
["Obsidian Harvester"]={shop="Lunar Islands Shop",idx=4},
["Moonstone Harvester"]={shop="Lunar Islands Shop",idx=5},
["Prismatic Harvester"]={shop="Volcano Island Shop",idx=4},
["Old Pickaxe"]={shop="Competition Shop",idx=11},
["Perfect Harvester"]={shop="Premium Shop",idx=28},
}

local D={
"Harvester",
"Stone Harvester (Train)",
"Tin Harvester (Train)",
"Stone Harvester",
"Tin Harvester",
"Copper Harvester",
"Bronze Harvester",
"Iron Harvester",
"Silver Harvester",
"Gold Harvester",
"Ruby Harvester",
"Topaz Harvester",
"Emerald Harvester",
"Amethyst Harvester",
"Diamond Harvester",
"Sapphire Harvester",
"Clear Quartz Harvester",
"Obsidian Harvester",
"Moonstone Harvester",
"Prismatic Harvester",
"Old Pickaxe",
"Perfect Harvester",
}

local E=D[1]

u:AddDropdown("PickaxeSelector",{
Text="Pickaxe",
Values=D,
Default=1,
Multi=false,
Tooltip="Select which pickaxe to buy",
Callback=function(F)
E=F
end,
Disabled=false,
Visible=true,
})

u:AddButton("Buy Pickaxe",function()
local F=C[E]
if not F then return end


A:FireServer("Shopping","BuyShopItem",F.shop,F.idx,1,nil)
end)

v:AddToggle("HighlightOre",{
Text="Highlight",
Default=false,
Tooltip="Highlights ore that is being mined",

Callback=function(F)
aj.setHighlight(F)
end,
})

local F=c.Main:AddLeftTabbox()

local G=F:AddTab("Train")

G:AddToggle("AutoTrainEnabled",{
Text="Enable",
Default=false,
Tooltip="Automatically completes cross country",
Callback=function(H)
ao.setEnabled(H)
ao.setNoclip(H)
end,
})

local H=F:AddTab("Settings")

local I=c.Misc:AddLeftTabbox()

local J=I:AddTab("Player")
local K=I:AddTab("Horse")

J:AddToggle("WalkspeedEnabled",{
Text="Walkspeed",
Default=false,
Tooltip="Enhances characters speed",
Callback=function(L)
J.setEnabled(L)
end,
})

J:AddSlider("WalkspeedValue",{
Text="Walkspeed Value",
Default=16,
Min=16,
Max=100,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="walkspeed value",
Callback=function(L)
J.setValue(L)
end,
})

J:AddToggle("JumpPowerEnabled",{
Text="JumpPower",
Default=false,
Tooltip="Enhances JumpPower",
Callback=function(L)
J.setJumpEnabled(L)
end,
})

J:AddSlider("JumpPowerValue",{
Text="JumpPower Value",
Default=50,
Min=0,
Max=1000,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="jumppower value",
Callback=function(L)
J.setJumpValue(L)
end,
})




K:AddToggle("HWalkspeedEnabled",{
Text="Walkspeed",
Default=false,
Tooltip="Enhances horses speed",
Callback=function(L)
K.setEnabled(L)
end,
})

K:AddSlider("HWalkspeedValue",{
Text="Walkspeed Value",
Default=16,
Min=16,
Max=100,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="walkspeed value",
Callback=function(L)
K.setValue(L)
end,
})

K:AddToggle("HJumpPowerEnabled",{
Text="JumpPower",
Default=false,
Tooltip="Enhances horses JumpPower",
Callback=function(L)
K.setJumpEnabled(L)
end,
})

K:AddSlider("HJumpPowerValue",{
Text="JumpPower Value",
Default=50,
Min=0,
Max=1000,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="jumppower value",
Callback=function(L)
K.setJumpValue(L)
end,
})

local L=c.Misc:AddRightGroupbox("Performance")

local M=Instance.new("ScreenGui")
M.Name="BackgroundCover"
M.DisplayOrder=-999999
M.IgnoreGuiInset=true
M.Parent=game:GetService("CoreGui")

local N=Instance.new("Frame",M)
N.Size=UDim2.new(1,0,1,0)
N.BackgroundColor3=Color3.fromRGB(0,0,0)
N.BorderSizePixel=0
N.Visible=false

local O={}

L:AddToggle('MuteAmbientMusic',{
Text='Ambient Music',
Default=false,
Tooltip='Turns on or off ambient music or sounds',
Callback=function(P)
local Q=game:GetService("SoundService")
local R=Q:GetDescendants()

for S,T in ipairs(R)do
if T:IsA("Sound")then
if P then

T.Playing=false
else

T.Playing=true
end
end
end
end
})

L:AddToggle('NoGraphics',{
Text='No Graphics',
Default=false,
Tooltip='Disables 3D rendering with a black background',
Callback=function(P)
do
game:GetService("RunService"):Set3dRenderingEnabled(not P)
N.Visible=P
end
end
})

local P=false
local Q=60

L:AddToggle('SetFPS',{
Text='FPS Cap',
Default=false,
Tooltip='Caps the game FPS at the slider value',
Callback=function(R)
do
P=R
if P then
setfpscap(Q)
else
setfpscap(0)
end
end
end
})

L:AddSlider('FPSCap',{
Text='FPS Cap Value',
Default=60,
Min=1,
Max=240,
Rounding=1,
Compact=false,
Callback=function(R)
do
Q=R
if P then
setfpscap(R)
end
end
end
})

local R=c.Misc:AddLeftGroupbox("Redeem")

R:AddButton("Redeem Codes",function()
local S=require(game:GetService("ReplicatedStorage"):WaitForChild("References"))
local T=S.Utilities
local U=require(S.PlayerScripts.Priority.Data)
local V=S.Flags

local W={
"ty-4-100m-visits",
"some-pasture-stuffs",
"tridents-trident",
"when-life-gives-you-lemons",
"koolie-plush",
}

for X,Y in ipairs(W)do
local Z=(V.flags.codes or{})[Y]
if Z==nil then
ab:Notify("No new code: "..Y,2)
elseif U.GetLocal({"codesRedeemed",Y})==true then
ab:Notify("Already redeemed: "..Y,2)
else
T.Network:FireServer("Codes","Submit",Y)
print("[AutoRedeem] Submitted: "..Y)
ab:Notify("Submitted: "..Y,2)
task.wait(1.5)
end
end

end)

R:AddButton("Redeem Volcanic Mineral (5)",function()
for S,T in Functions:GetChildren()do
pcall(function()
T:FireServer("\002","Trade","volcanicMinerals")
end)
end
end)

local S=0

local function T(U)
if U<=255 then
return string.char(U)
end
return string.char(math.floor(U/256),U%256)
end

local function U(V,W)
local X=T(S)
S=(S+1)%4294967296
for Y,Z in Functions:GetChildren()do
pcall(function()
Z:FireServer(X,V,W)
end)
end
end

R:AddButton("Training Receipt (100)",function()
U("Trade","trainingReceipts")
end)

R:AddButton("Golden Apples (20)",function()
U("Trade","goldenAppleBasket")
end)

R:AddButton("Relics (1)",function()
U("Trade","archaeology")
end)




ab:SetWatermarkVisibility(true)


local V=tick()
local W=0;
local X=60;
local Y=(function()return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())end)
local Z=pcall(function()return Y()end)

local _=game:GetService("RunService").RenderStepped:Connect(function()
W+=1;

if(tick()-V)>=1 then
X=W;
V=tick();
W=0;
end;

if Z then
ab:SetWatermark(("coconut - [buyer build] | %d fps | %d ms"):format(
math.floor(X),
Y()
));
else
ab:SetWatermark(("coconut - [buyer build] | %d fps"):format(
math.floor(X)
));
end
end);

ab:OnUnload(function()
_:Disconnect()

print("Unloaded!")
ab.Unloaded=true
end)


local at=c["UI Settings"]:AddLeftGroupbox("Menu")

at:AddToggle("KeybindMenuOpen",{Default=ab.KeybindFrame.Visible,Text="Open Keybind Menu",Callback=function(au)ab.KeybindFrame.Visible=au end})
at:AddToggle("ShowCustomCursor",{Text="Custom Cursor",Default=true,Callback=function(au)ab.ShowCustomCursor=au end})
at:AddDivider()
at:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind",{Default="RightShift",NoUI=true,Text="Menu keybind"})
at:AddButton("Unload",function()ab:Unload()end)

ab.ToggleKeybind=ap.MenuKeybind






ac:SetLibrary(ab)
ad:SetLibrary(ab)



ad:IgnoreThemeSettings()



ad:SetIgnoreIndexes({"MenuKeybind"})




ac:SetFolder("coconut")
ad:SetFolder("coconut/whi")






ad:BuildConfigSection(c["UI Settings"])



ac:ApplyToTab(c["UI Settings"])



ad:LoadAutoloadConfig()

ab:Notify("Loaded in "..tostring(string.format("%."..tostring(3).."f",os.clock()-aa)).." seconds",5)
