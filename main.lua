local a={cache={}::any}do do local function b()




























writefile(
"Tahoma.ttf",
game:HttpGet("https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/windows-xp-tahoma.ttf")
)

writefile("Tahoma.font",game:GetService("HttpService"):JSONEncode({
name="Tahoma",
faces={
{
name="Regular",
weight=400,
style="normal",
assetId=getcustomasset("Tahoma.ttf"),
},
{
name="Bold",
weight=700,
style="normal",
assetId=getcustomasset("Tahoma.ttf"),
},
},
}))


local c=Font.new("rbxasset://fonts/families/Tahoma.json",Enum.FontWeight.Regular)
local d=Font.new(getcustomasset("Tahoma.font"),Enum.FontWeight.Regular);

local e=game:GetService('UserInputService');
local f=game:GetService('TextService');
local g=game:GetService('CoreGui');
local h=game:GetService('Teams');
local i=game:GetService('Players');
local j=game:GetService('RunService')
local k=game:GetService('TweenService');
local l=game:GetService('Lighting');
local m=j.RenderStepped;
local n=i.LocalPlayer;
local o=n:GetMouse();

local p=protectgui or(syn and syn.protect_gui)or(function()end);

local q=Instance.new('ScreenGui');
p(q);
q.ZIndexBehavior=Enum.ZIndexBehavior.Global;
q.Parent=g;

local r={};
local s={};

getgenv().Toggles=r;
getgenv().Options=s;

local t={
Registry={};
RegistryMap={};

HudRegistry={};

FontColor=Color3.fromRGB(255,255,255);
MainColor=Color3.fromRGB(28,28,28);
BackgroundColor=Color3.fromRGB(20,20,20);
AccentColor=Color3.fromRGB(0,85,255);
SecondAccentColor=Color3.fromRGB(0,82,255);
OutlineColor=Color3.fromRGB(50,50,50);
RiskColor=Color3.fromRGB(255,50,50),

Black=Color3.new(0,0,0);
Font=d,
BoldFont=Font.new(getcustomasset("Tahoma.font"),Enum.FontWeight.Bold),
FontSize=11,

OpenedFrames={};
DependencyBoxes={};

Signals={};
ScreenGui=q;

Toggled=false;
WireframeDrag=true;
UseBlur=true;
BlurSize=15;

KeybindMode='All';

NotifyConfig={
Alignment='Left';
BarSide='Left';
PositionX=0;
PositionY=40;
};
};

t.KeyPickerList={};

t.BlurEffect=Instance.new("BlurEffect")
t.BlurEffect.Name="LinoriaBlur"
t.BlurEffect.Size=0
t.BlurEffect.Enabled=false
pcall(function()t.BlurEffect.Parent=l end)

function t:UpdateBlur()
if t.UseBlur and t.Toggled then
t.BlurEffect.Size=0
t.BlurEffect.Enabled=true

task.wait()

k:Create(
t.BlurEffect,
TweenInfo.new(0.35,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
{Size=t.BlurSize}
):Play()
else
local u=k:Create(
t.BlurEffect,
TweenInfo.new(0.25,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
{Size=0}
)
u:Play()
u.Completed:Connect(function()
if not t.UseBlur or not t.Toggled then
t.BlurEffect.Enabled=false
end
end)
end
end

function t:SetFontSize(u)
t.FontSize=u
for v,w in pairs(q:GetDescendants())do
if w:IsA("TextLabel")or w:IsA("TextBox")or w:IsA("TextButton")then
local x=w:GetAttribute("FontSizeOffset")
if x then
w.TextSize=u+x
end
end
end
local v=g:FindFirstChild("LinoriaMobileUI")
if v then
for w,x in pairs(v:GetDescendants())do
if x:IsA("TextLabel")or x:IsA("TextBox")or x:IsA("TextButton")then
local y=x:GetAttribute("FontSizeOffset")
if y then
x.TextSize=u+y
end
end
end
end
end

local u=0
local v=0

table.insert(t.Signals,m:Connect(function(w)
u=u+w

if u>=(1/60)then
u=0

v=v+(1/400);
if v>1 then
v=0;
end;

t.CurrentRainbowHue=v;
t.CurrentRainbowColor=Color3.fromHSV(v,0.8,1);
end
end))

local function w()
local x=i:GetPlayers();
for y=1,#x do
x[y]=x[y].Name;
end;
table.sort(x,function(y,z)return y<z end);

return x
end;

local function x()
local y=h:GetTeams();
for z=1,#y do
y[z]=y[z].Name;
end;
table.sort(y,function(z,A)return z<A end);

return y
end;

function t:SafeCallback(y,...)
if(not y)then
return
end;
if not t.NotifyOnError then
return y(...)
end;

local z,A=pcall(y,...);
if not z then
local B,C=A:find(":%d+: ");
if not C then
return t:Notify(A)
end;
return t:Notify(A:sub(C+1),3)
end;
end;

function t:AttemptSave()
if t.SaveManager then
t.SaveManager:Save();
end;
end;

function t:Create(y,z)
local A=y;
if type(y)=='string'then
A=Instance.new(y);
end;
for B,C in next,z do
A[B]=C;
end;

if A:IsA("TextLabel")or A:IsA("TextBox")or A:IsA("TextButton")then
if z.TextSize then
A:SetAttribute("FontSizeOffset",z.TextSize-t.FontSize)
else
A:SetAttribute("FontSizeOffset",0)
end
end

return A
end;

function t:ApplyTextStroke(y)
y.TextStrokeTransparency=1;

t:Create('UIStroke',{
Color=Color3.new(0,0,0);
Thickness=1;
LineJoinMode=Enum.LineJoinMode.Miter;
Parent=y;
});
end;

function t:ApplyGlow(y)

end;

function t:CreateLabel(y,z)
local A=t:Create('TextLabel',{
BackgroundTransparency=1;
FontFace=t.Font;
TextColor3=t.FontColor;
TextSize=t.FontSize+2;
TextStrokeTransparency=1;
});
t:ApplyTextStroke(A);

t:AddToRegistry(A,{
TextColor3='FontColor';
},z);
return t:Create(A,y)
end;

function t:MakeDraggable(y,z,A)
y.Active=true;
y.InputBegan:Connect(function(B)
if B.UserInputType==Enum.UserInputType.MouseButton1 or B.UserInputType==Enum.UserInputType.Touch then
local C=y.Position
local D=B.Position

if(D.Y-y.AbsolutePosition.Y)>(z or 40)then
return
end

local E=true
local F=false
local G=nil
local H,I

H=e.InputChanged:Connect(function(J)
if J.UserInputType==Enum.UserInputType.MouseMovement or J==B then
local K=J.Position-D

if A and t.WireframeDrag then
if not F and K.Magnitude>2 then
F=true

G=t:Create("Frame",{
Size=y.Size,
Position=y.Position,
AnchorPoint=y.AnchorPoint,
BackgroundTransparency=1,
Active=false,
ZIndex=100000,
Parent=q
})





t:Create("UIStroke",{
Color=t.AccentColor,
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=G
})
end

if F and G then
G.Position=UDim2.new(
C.X.Scale,C.X.Offset+K.X,
C.Y.Scale,C.Y.Offset+K.Y
)
end
else
y.Position=UDim2.new(
C.X.Scale,C.X.Offset+K.X,
C.Y.Scale,C.Y.Offset+K.Y
)
end
end
end)

I=e.InputEnded:Connect(function(J)
if J==B or J.UserInputType==Enum.UserInputType.Touch then
E=false
H:Disconnect()
I:Disconnect()

if A and t.WireframeDrag and F and G then
y.Position=G.Position

G:Destroy()
G=nil
end
end
end)
end
end)
end;

function t:MakeResizable(y,z,A)
z=z or Vector2.new(400,300)
A=A or Vector2.new(1400,1000)

local B=t:Create('TextButton',{
Name='ResizeGrip',
Text='',
AutoButtonColor=false,
BackgroundTransparency=1,
Size=UDim2.fromOffset(16,16),
Position=UDim2.new(1,-4,1,-4),
AnchorPoint=Vector2.new(1,1),
ZIndex=25,
Parent=y,
})

local C=t:CreateLabel({
BackgroundTransparency=1,
Size=UDim2.fromOffset(16,16),
Position=UDim2.new(1,0,1,0),
AnchorPoint=Vector2.new(1,1),
Text='◢',
TextColor3=t.OutlineColor,
TextSize=t.FontSize+2,
ZIndex=26,
Parent=B,
})
t:AddToRegistry(C,{
TextColor3='OutlineColor',
})

B.InputBegan:Connect(function(D)
if D.UserInputType~=Enum.UserInputType.MouseButton1
and D.UserInputType~=Enum.UserInputType.Touch then
return
end

local E=y.Size
local F=D.Position
local G=false
local H=nil
local I,J

I=e.InputChanged:Connect(function(K)
if K.UserInputType~=Enum.UserInputType.MouseMovement and K~=D then
return
end

local L=K.Position-F
if L.Magnitude<=2 then return end
G=true

local M=math.clamp(E.X.Offset+L.X,z.X,A.X)
local N=math.clamp(E.Y.Offset+L.Y,z.Y,A.Y)
local O=UDim2.fromOffset(M,N)

if t.WireframeDrag then
if not H then
H=t:Create('Frame',{
Size=y.Size,
Position=y.Position,
AnchorPoint=y.AnchorPoint,
BackgroundTransparency=1,
Active=false,
ZIndex=100000,
Parent=q,
})
t:Create('UIStroke',{
Color=Color3.fromRGB(255,255,255),
Thickness=1,
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Parent=H,
})
end
H.Size=O
H.Position=y.Position
else
y.Size=O
end
end)

J=e.InputEnded:Connect(function(K)
if K~=D and K.UserInputType~=Enum.UserInputType.Touch then
return
end

I:Disconnect()
J:Disconnect()

if t.WireframeDrag and G and H then
y.Size=H.Size
H:Destroy()
end
end)
end)
end;

function t:AddToolTip(y,z)
local A,B=t:GetTextBounds(y,t.Font,t.FontSize);
local C=t:Create('Frame',{
BackgroundColor3=t.MainColor,
BorderColor3=t.OutlineColor,

Size=UDim2.fromOffset(A+5,B+4),
ZIndex=100,
Parent=t.ScreenGui,

Visible=false,
})

local D=t:CreateLabel({
Position=UDim2.fromOffset(3,1),
Size=UDim2.fromOffset(A,B);
TextSize=t.FontSize;
Text=y,
TextColor3=t.FontColor,
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=C.ZIndex+1,

Parent=C;
});
t:AddToRegistry(C,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
t:AddToRegistry(D,{
TextColor3='FontColor',
});
local E=false

z.MouseEnter:Connect(function()
if t:MouseIsOverOpenedFrame()then
return
end

E=true

C.Position=UDim2.fromOffset(o.X+15,o.Y+12)
C.Visible=true

while E do
j.Heartbeat:Wait()
C.Position=UDim2.fromOffset(o.X+15,o.Y+12)
end
end)

z.MouseLeave:Connect(function()
E=false
C.Visible=false
end)
end

function t:OnHighlight(y,z,A,B)
y.MouseEnter:Connect(function()
local C=t.RegistryMap[z];

for D,E in next,A do
z[D]=t[E]or E;

if C and C.Properties[D]then
C.Properties[D]=E;
end;
end;
end)

y.MouseLeave:Connect(function()
local C=t.RegistryMap[z];

for D,E in next,B do
z[D]=t[E]or E;

if C and C.Properties[D]then
C.Properties[D]=E;
end;
end;
end)
end;

function t:MouseIsOverOpenedFrame()
for y,z in next,t.OpenedFrames do
local A,B=y.AbsolutePosition,y.AbsoluteSize;
if o.X>=A.X and o.X<=A.X+B.X
and o.Y>=A.Y and o.Y<=A.Y+B.Y then

return true
end;
end;
end;

function t:IsMouseOverFrame(y)
local z,A=y.AbsolutePosition,y.AbsoluteSize;
if o.X>=z.X and o.X<=z.X+A.X
and o.Y>=z.Y and o.Y<=z.Y+A.Y then

return true
end;
end;

function t:UpdateDependencyBoxes()
for y,z in next,t.DependencyBoxes do
z:Update();
end;
end;

function t:MapValue(y,z,A,B,C)
return(1-((y-z)/(A-z)))*B+((y-z)/(A-z))*C
end;

function t:GetTextBounds(y,z,A,B)
local C=Instance.new("GetTextBoundsParams")
C.Text=y
C.Font=z
C.Size=A
C.Width=math.huge

local D=f:GetTextBoundsAsync(C)
return D.X,D.Y
end

function t:GetDarkerColor(y)
local z,A,B=Color3.toHSV(y);
return Color3.fromHSV(z,A,B/1.5)
end;

t.AccentColorDark=t:GetDarkerColor(t.AccentColor);

function t:AddToRegistry(y,z,A)
local B=#t.Registry+1;
local C={
Instance=y;
Properties=z;
Idx=B;
};

table.insert(t.Registry,C);
t.RegistryMap[y]=C;

if A then
table.insert(t.HudRegistry,C);
end;
end;

function t:RemoveFromRegistry(y)
local z=t.RegistryMap[y];

if z then
for A=#t.Registry,1,-1 do
if t.Registry[A]==z then
table.remove(t.Registry,A);
end;
end;

for A=#t.HudRegistry,1,-1 do
if t.HudRegistry[A]==z then
table.remove(t.HudRegistry,A);
end;
end;

t.RegistryMap[y]=nil;
end;
end;

function t:UpdateColorsUsingRegistry()
for y,z in next,t.Registry do
for A,B in next,z.Properties do
if type(B)=='string'then
z.Instance[A]=t[B];
elseif type(B)=='function'then
z.Instance[A]=B()
end
end;
end;
end;

function t:GiveSignal(y)
table.insert(t.Signals,y)
end

function t:Unload()
for y=#t.Signals,1,-1 do
local z=table.remove(t.Signals,y)
z:Disconnect()
end

if t.OnUnload then
t.OnUnload()
end

if t.BlurEffect then
t.BlurEffect:Destroy()
end

q:Destroy()
end

function t:OnUnload(y)
t.OnUnload=y
end

t:GiveSignal(q.DescendantRemoving:Connect(function(y)
if t.RegistryMap[y]then
t:RemoveFromRegistry(y);
end;
end))

local y={};
do
local z={};

function z:AddColorPicker(A,B)
local C=self.TextLabel;
assert(B.Default,'AddColorPicker: Missing default value.');

local D={
Value=B.Default;
Transparency=B.Transparency or 0;
Type='ColorPicker';
Title=type(B.Title)=='string'and B.Title or'Color picker',
Callback=B.Callback or function(D)end;
};

function D:SetHSVFromRGB(E)
local F,G,H=Color3.toHSV(E);
D.Hue=F;
D.Sat=G;
D.Vib=H;
end;

D:SetHSVFromRGB(D.Value);
local E=t:Create('Frame',{
BackgroundColor3=D.Value;
BorderColor3=t:GetDarkerColor(D.Value);
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(0,28,0,14);
ZIndex=6;
Parent=C;
});
local F=t:Create("UIGradient",{
Rotation=90,
Parent=E,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,t.MainColor),
}),
});
local G=t:Create('ImageLabel',{
BorderSizePixel=0;
Size=UDim2.new(0,27,0,13);
ZIndex=5;
Image='http://www.roblox.com/asset/?id=12977615774';
Visible=not not B.Transparency;
Parent=E;
});

local H=t:Create('Frame',{
Name='Color';
BackgroundColor3=Color3.new(1,1,1);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(E.AbsolutePosition.X,E.AbsolutePosition.Y+18),
Size=UDim2.fromOffset(230,B.Transparency and 271 or 253);
Visible=false;
ZIndex=15;
Parent=q,
});
E:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
H.Position=UDim2.fromOffset(E.AbsolutePosition.X,E.AbsolutePosition.Y+18);
end)

local I=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=16;
Parent=H;
});
local J=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,0,2);
ZIndex=17;
Parent=I;
});
local K=t:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,4,0,25);
Size=UDim2.new(0,200,0,200);
ZIndex=17;
Parent=I;
});
local L=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Parent=K;
});
local M=t:Create('ImageLabel',{
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Image='rbxassetid://4155801252';
Parent=L;
});
local N=t:Create('ImageLabel',{
AnchorPoint=Vector2.new(0.5,0.5);
Size=UDim2.new(0,6,0,6);
BackgroundTransparency=1;
Image='http://www.roblox.com/asset/?id=9619665977';
ImageColor3=Color3.new(0,0,0);
ZIndex=19;
Parent=M;
});
local O=t:Create('ImageLabel',{
Size=UDim2.new(0,N.Size.X.Offset-2,0,N.Size.Y.Offset-2);
Position=UDim2.new(0,1,0,1);
BackgroundTransparency=1;
Image='http://www.roblox.com/asset/?id=9619665977';
ZIndex=20;
Parent=N;
})

local P=t:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,208,0,25);
Size=UDim2.new(0,15,0,200);
ZIndex=17;
Parent=I;
});

local Q=t:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Parent=P;
});
local R=t:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
AnchorPoint=Vector2.new(0,0.5);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,0,0,1);
ZIndex=18;
Parent=Q;
});

local S=t:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(4,228),
Size=UDim2.new(0.5,-6,0,20),
ZIndex=18,
Parent=I;
});
local T=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=18,
Parent=S;
});
t:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=T;
});

local U=t:Create('TextBox',{
BackgroundTransparency=1;
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);
FontFace=t.Font;
PlaceholderColor3=Color3.fromRGB(190,190,190);
PlaceholderText='Hex color',
Text='#FFFFFF',
TextColor3=t.FontColor;
TextSize=t.FontSize;
TextStrokeTransparency=0;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=20,
Parent=T;
});

t:ApplyTextStroke(U);

local V=t:Create(S:Clone(),{
Position=UDim2.new(0.5,2,0,228),
Size=UDim2.new(0.5,-6,0,20),
Parent=I
});
local W=t:Create(V.Frame:FindFirstChild('TextBox'),{
Text='255, 255, 255',
PlaceholderText='RGB color',
TextColor3=t.FontColor
});
local X,Y,Z;

if B.Transparency then
X=t:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(4,251);
Size=UDim2.new(1,-8,0,15);
ZIndex=19;
Parent=I;
});
Y=t:Create('Frame',{
BackgroundColor3=D.Value;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=19;
Parent=X;
});
t:AddToRegistry(Y,{BorderColor3='OutlineColor'});

t:Create('ImageLabel',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,0);
Image='http://www.roblox.com/asset/?id=12978095818';
ZIndex=20;
Parent=Y;
});
Z=t:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
AnchorPoint=Vector2.new(0.5,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,1,1,0);
ZIndex=21;
Parent=Y;
});
end;

local _=t:CreateLabel({
Size=UDim2.new(1,0,0,14);
Position=UDim2.fromOffset(5,5);
TextXAlignment=Enum.TextXAlignment.Left;
TextSize=t.FontSize;
Text=D.Title,
TextWrapped=false;
ZIndex=16;
Parent=I;
});
local aa={}
do
aa.Options={}
aa.Container=t:Create('Frame',{
BorderColor3=Color3.new(),
ZIndex=14,
Visible=false,
Parent=q
})

aa.Inner=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.fromScale(1,1);
ZIndex=15;
Parent=aa.Container;
});
t:Create('UIListLayout',{
Name='Layout',
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=aa.Inner;
});
t:Create('UIPadding',{
Name='Padding',
PaddingLeft=UDim.new(0,4),
Parent=aa.Inner,
});
local function ab()
aa.Container.Position=UDim2.fromOffset(
(E.AbsolutePosition.X+E.AbsoluteSize.X)+4,
E.AbsolutePosition.Y+1
)
end

local function ac()
local ad=60
for ae,af in next,aa.Inner:GetChildren()do
if af:IsA('TextLabel')then
ad=math.max(ad,af.TextBounds.X)
end
end

aa.Container.Size=UDim2.fromOffset(
ad+8,
aa.Inner.Layout.AbsoluteContentSize.Y+4
)
end

E:GetPropertyChangedSignal('AbsolutePosition'):Connect(ab)
aa.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(ac)

task.spawn(ab)
task.spawn(ac)

t:AddToRegistry(aa.Inner,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});

function aa:Show()
self.Container.Visible=true
end

function aa:Hide()
self.Container.Visible=false
end

function aa:AddOption(ad,ae)
if type(ae)~='function'then
ae=function()end
end

local af=t:CreateLabel({
Active=false;
Size=UDim2.new(1,0,0,15);
TextSize=t.FontSize-1;
Text=ad;
ZIndex=16;
Parent=self.Inner;
TextXAlignment=Enum.TextXAlignment.Left,
});
t:OnHighlight(af,af,
{TextColor3='AccentColor'},
{TextColor3='FontColor'}
);
af.InputBegan:Connect(function(ag)
if ag.UserInputType~=Enum.UserInputType.MouseButton1 and ag.UserInputType~=Enum.UserInputType.Touch then
return
end

ae()
end)
end

aa:AddOption('Copy color',function()
t.ColorClipboard=D.Value
t:Notify('Copied color!',2)
end)

aa:AddOption('Paste color',function()
if not t.ColorClipboard then
return t:Notify('You have not copied a color!',2)
end
D:SetValueRGB(t.ColorClipboard)
end)


aa:AddOption('Copy HEX',function()
pcall(setclipboard,D.Value:ToHex())
t:Notify('Copied hex code to clipboard!',2)
end)

aa:AddOption('Copy RGB',function()
pcall(setclipboard,table.concat({math.floor(D.Value.R*255),math.floor(D.Value.G*255),math.floor(D.Value.B*255)},', '))
t:Notify('Copied RGB values to clipboard!',2)
end)

end

t:AddToRegistry(I,{BackgroundColor3='BackgroundColor';BorderColor3='OutlineColor';});
t:AddToRegistry(J,{BackgroundColor3='AccentColor';});
t:AddToRegistry(L,{BackgroundColor3='BackgroundColor';BorderColor3='OutlineColor';});
t:AddToRegistry(T,{BackgroundColor3='MainColor';BorderColor3='OutlineColor';});
t:AddToRegistry(V.Frame,{BackgroundColor3='MainColor';BorderColor3='OutlineColor';});
t:AddToRegistry(W,{TextColor3='FontColor',});
t:AddToRegistry(U,{TextColor3='FontColor',});

local ab={};
for ac=0,1,0.1 do
table.insert(ab,ColorSequenceKeypoint.new(ac,Color3.fromHSV(ac,1,1)));
end;

local ac=t:Create('UIGradient',{
Color=ColorSequence.new(ab);
Rotation=90;
Parent=Q;
});
U.FocusLost:Connect(function(ad)
if ad then
local ae,af=pcall(Color3.fromHex,U.Text)
if ae and typeof(af)=='Color3'then
D.Hue,D.Sat,D.Vib=Color3.toHSV(af)
end
end

D:Display()
end)

W.FocusLost:Connect(function(ad)
if ad then
local ae,af,ag=W.Text:match('(%d+),%s*(%d+),%s*(%d+)')
if ae and af and ag then
D.Hue,D.Sat,D.Vib=Color3.toHSV(Color3.fromRGB(ae,af,ag))
end
end

D:Display()
end)

function D:Display()
D.Value=Color3.fromHSV(D.Hue,D.Sat,D.Vib);
M.BackgroundColor3=Color3.fromHSV(D.Hue,1,1);

t:Create(E,{
BackgroundColor3=D.Value;
BackgroundTransparency=D.Transparency;
BorderColor3=t:GetDarkerColor(D.Value);
});
if Y then
Y.BackgroundColor3=D.Value;
Z.Position=UDim2.new(1-D.Transparency,0,0,0);
end;

N.Position=UDim2.new(D.Sat,0,1-D.Vib,0);
R.Position=UDim2.new(0,0,D.Hue,0);

U.Text='#'..D.Value:ToHex()
W.Text=table.concat({math.floor(D.Value.R*255),math.floor(D.Value.G*255),math.floor(D.Value.B*255)},', ')

t:SafeCallback(D.Callback,D.Value);
t:SafeCallback(D.Changed,D.Value);
end;

function D:OnChanged(ad)
D.Changed=ad;
ad(D.Value)
end;

function D:Show()
for ad,ae in next,t.OpenedFrames do
if ad.Name=='Color'then
ad.Visible=false;
t.OpenedFrames[ad]=nil;
end;
end;

H.Visible=true;
t.OpenedFrames[H]=true;
end;
function D:Hide()
H.Visible=false;
t.OpenedFrames[H]=nil;
end;
function D:SetValue(ad,ae)
local af=Color3.fromHSV(ad[1],ad[2],ad[3]);
D.Transparency=ae or 0;
D:SetHSVFromRGB(af);
D:Display();
end;

function D:SetValueRGB(ad,ae)
D.Transparency=ae or 0;
D:SetHSVFromRGB(ad);
D:Display();
end;

M.InputBegan:Connect(function(ad)
if ad.UserInputType==Enum.UserInputType.MouseButton1 or ad.UserInputType==Enum.UserInputType.Touch then
local function ae(af,ag)
local ah=M.AbsolutePosition.X;
local ai=ah+M.AbsoluteSize.X;
local aj=math.clamp(af,ah,ai);

local ak=M.AbsolutePosition.Y;
local al=ak+M.AbsoluteSize.Y;
local am=math.clamp(ag,ak,al);

D.Sat=(aj-ah)/(ai-ah);
D.Vib=1-((am-ak)/(al-ak));
D:Display();
end

ae(ad.Position.X,ad.Position.Y)

local af=e.InputChanged:Connect(function(af)
if af.UserInputType==Enum.UserInputType.MouseMovement or af==ad then
ae(af.Position.X,af.Position.Y)
end
end)

local ag
ag=e.InputEnded:Connect(function(ah)
if ah==ad or ah.UserInputType==Enum.UserInputType.Touch then
af:Disconnect()
ag:Disconnect()
t:AttemptSave()
end
end)
end
end);
Q.InputBegan:Connect(function(ad)
if ad.UserInputType==Enum.UserInputType.MouseButton1 or ad.UserInputType==Enum.UserInputType.Touch then
local function ae(af)
local ag=Q.AbsolutePosition.Y;
local ah=ag+Q.AbsoluteSize.Y;
local ai=math.clamp(af,ag,ah);

D.Hue=((ai-ag)/(ah-ag));
D:Display();
end

ae(ad.Position.Y)

local af=e.InputChanged:Connect(function(af)
if af.UserInputType==Enum.UserInputType.MouseMovement or af==ad then
ae(af.Position.Y)
end
end)

local ag
ag=e.InputEnded:Connect(function(ah)
if ah==ad or ah.UserInputType==Enum.UserInputType.Touch then
af:Disconnect()
ag:Disconnect()
t:AttemptSave()
end
end)
end
end);
E.InputBegan:Connect(function(ad)
if(ad.UserInputType==Enum.UserInputType.MouseButton1 or ad.UserInputType==Enum.UserInputType.Touch)and not t:MouseIsOverOpenedFrame()then
if H.Visible then
D:Hide()
else
aa:Hide()
D:Show()
end;
elseif ad.UserInputType==Enum.UserInputType.MouseButton2 and not t:MouseIsOverOpenedFrame()then
aa:Show()
D:Hide()
end
end);

if Y then
Y.InputBegan:Connect(function(ad)
if ad.UserInputType==Enum.UserInputType.MouseButton1 or ad.UserInputType==Enum.UserInputType.Touch then
local function ae(af)
local ag=Y.AbsolutePosition.X;
local ah=ag+Y.AbsoluteSize.X;
local ai=math.clamp(af,ag,ah);

D.Transparency=1-((ai-ag)/(ah-ag));
D:Display();
end

ae(ad.Position.X)

local af=e.InputChanged:Connect(function(af)
if af.UserInputType==Enum.UserInputType.MouseMovement or af==ad then
ae(af.Position.X)
end
end)

local ag
ag=e.InputEnded:Connect(function(ah)
if ah==ad or ah.UserInputType==Enum.UserInputType.Touch then
af:Disconnect()
ag:Disconnect()
t:AttemptSave()
end
end)
end
end);
end;

t:GiveSignal(e.InputBegan:Connect(function(ad)
if(ad.UserInputType==Enum.UserInputType.MouseButton1 or ad.UserInputType==Enum.UserInputType.Touch)then
local ae,af=H.AbsolutePosition,H.AbsoluteSize;
local ag=E.AbsolutePosition;
local ah=E.AbsoluteSize;

if o.X<ae.X or o.X>ae.X+af.X
or o.Y<ag.Y or o.Y>ae.Y+af.Y then

if not(o.X>=ag.X and o.X<=ag.X+ah.X
and o.Y>=ag.Y and o.Y<=ag.Y+ah.Y)then
D:Hide();
end
end;

if not t:IsMouseOverFrame(aa.Container)then
aa:Hide()
end
end;

if ad.UserInputType==Enum.UserInputType.MouseButton2 and aa.Container.Visible then
if not t:IsMouseOverFrame(aa.Container)and not t:IsMouseOverFrame(E)then
aa:Hide()
end
end
end))

function D:GetTransparency()
return D.Transparency
end;

function D:OnTransparencyChanged(ad)
D.TransparencyChanged=ad;
ad(D.Transparency);
end;

local ad=D.Display;
D.Display=function(ae)
ad(ae);
t:SafeCallback(D.TransparencyChanged,D.Transparency);
end;

D:Display();
D.DisplayFrame=E

s[A]=D;

return self
end;

function z:AddColorPickerAlpha(aa,ab)
ab=ab or{};
if ab.Transparency==nil then
ab.Transparency=0;
end;
return z.AddColorPicker(self,aa,ab)
end;

function z:AddKeyPicker(aa,ab)
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

local ag=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,28,0,15);
ZIndex=6;
Parent=ad;
});
local ah=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=7;
Parent=ag;
});
t:AddToRegistry(ah,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local ai=t:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=t.FontSize-1;
Text=ab.Default;
TextWrapped=true;
ZIndex=8;
Parent=ah;
});
local aj=t:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(ad.AbsolutePosition.X+ad.AbsoluteSize.X+4,ad.AbsolutePosition.Y+1);
Size=UDim2.new(0,60,0,45+2);
Visible=false;
ZIndex=14;
Parent=q;
});
ad:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
aj.Position=UDim2.fromOffset(ad.AbsolutePosition.X+ad.AbsoluteSize.X+4,ad.AbsolutePosition.Y+1);
end);
local ak=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=15;
Parent=aj;
});
t:AddToRegistry(ak,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
t:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=ak;
});
local al=t:Create('Frame',{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,18),
Visible=false,
ZIndex=110,
Parent=t.KeybindContainer,
})

local am=t:CreateLabel({
Position=UDim2.new(0,2,0,0),
Size=UDim2.new(1,-4,1,0),
TextSize=12,
FontFace=Font.new("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.Bold,Enum.FontStyle.Normal),
TextXAlignment=Enum.TextXAlignment.Left,
ZIndex=111,
Parent=al,
},true)

local A=ab.Modes or{'Always','Toggle','Hold'};
local B={};

for C,D in next,A do
local E={};
local F=t:CreateLabel({
Active=false;
Size=UDim2.new(1,0,0,15);
TextSize=t.FontSize-1;
Text=D;
ZIndex=16;
Parent=ak;
});
function E:Select()
for G,H in next,B do
H:Deselect();
end;

af.Mode=D;

F.TextColor3=t.AccentColor;
t.RegistryMap[F].Properties.TextColor3='AccentColor';

aj.Visible=false;
end;
function E:Deselect()
af.Mode=nil;
F.TextColor3=t.FontColor;
t.RegistryMap[F].Properties.TextColor3='FontColor';
end;

F.InputBegan:Connect(function(G)
if(G.UserInputType==Enum.UserInputType.MouseButton1 or G.UserInputType==Enum.UserInputType.Touch)then
E:Select();
t:AttemptSave();
end;
end);
if D==af.Mode then
E:Select();
end;

B[D]=E;
end;

function af:Update()
if ab.NoUI then
return
end;

local C=af:GetState();

local D=(af.Value=='None')and'...'or af.Value
am.Text=string.format('[ %s ] %s',af.Mode or'None',ab.Text);
local E=t.KeybindMode or'All'
if E=='Active'then
al.Visible=C==true
elseif E=='Toggled'then
local F=false
if ac and ac.Type=='Toggle'then
F=ac.Value==true
elseif af.SyncToggleState and ac then
F=ac.Value==true
else
F=true
end
al.Visible=F
else
al.Visible=true
end

am.TextColor3=C and t.AccentColor or t.FontColor;
t.RegistryMap[am].Properties.TextColor3=C and'AccentColor'or'FontColor';

local F=0
local G=0

for H,I in next,t.KeybindContainer:GetChildren()do
if I:IsA('Frame')and I.Visible then
F=F+18;
local J=I:FindFirstChildOfClass('TextLabel')
if J and(J.TextBounds.X+20>G)then
G=J.TextBounds.X+20
end
end;
end;

t.KeybindFrame.Size=UDim2.new(0,math.max(G+10+15,210),0,F+25)
end;
function af:GetState()
if af.Mode=='Always'then
return true
elseif af.Mode=='Hold'then
if af.Value=='None'then
return false
end

local C=af.Value;
if C=='MB1'or C=='MB2'or C=='Touch'then
return C=='MB1'and e:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
or C=='MB2'and e:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
or C=='Touch'and true
else
return e:IsKeyDown(Enum.KeyCode[af.Value])
end;
else
return af.Toggled
end;
end;

function af:SetValue(C)
local D,E=C[1],C[2];
ai.Text=D;
af.Value=D;
B[E]:Select();
af:Update();
end;

function af:OnClick(C)
af.Clicked=C
end

function af:OnChanged(C)
af.Changed=C
C(af.Value)
end

if ac.Addons then
table.insert(ac.Addons,af)
table.insert(t.KeyPickerList,af)
end

function af:DoClick()
if ac.Type=='Toggle'and af.SyncToggleState then
ac:SetValue(not ac.Value)
end

t:SafeCallback(af.Callback,af.Toggled)
t:SafeCallback(af.Clicked,af.Toggled)
end

local C=false;
ag.InputBegan:Connect(function(D)
if(D.UserInputType==Enum.UserInputType.MouseButton1 or D.UserInputType==Enum.UserInputType.Touch)and not t:MouseIsOverOpenedFrame()then
C=true;

ai.Text='';

local E;
local F='';

task.spawn(function()
while(not E)do
if F=='...'then
F='';
end;

F=F..'.';
ai.Text=F;

wait(0.4);
end;
end);

wait(0.2);

local G;
G=e.InputBegan:Connect(function(H)
local I;

if H.UserInputType==Enum.UserInputType.Keyboard then
I=H.KeyCode.Name;
elseif H.UserInputType==Enum.UserInputType.MouseButton1 then
I='MB1';
elseif H.UserInputType==Enum.UserInputType.MouseButton2 then
I='MB2';
elseif H.UserInputType==Enum.UserInputType.Touch then
I='Touch';
end;

E=true;
C=false;

ai.Text=I;
af.Value=I;
t:SafeCallback(af.ChangedCallback,H.KeyCode or H.UserInputType)
t:SafeCallback(af.Changed,H.KeyCode or H.UserInputType)

t:AttemptSave();
G:Disconnect();
end);
elseif D.UserInputType==Enum.UserInputType.MouseButton2 and not t:MouseIsOverOpenedFrame()then
aj.Visible=true;
end;
end);

t:GiveSignal(e.InputBegan:Connect(function(D)
if(not C)then
if af.Mode=='Toggle'then
local E=af.Value;

if E=='MB1'or E=='MB2'or E=='Touch'then
if E=='MB1'and D.UserInputType==Enum.UserInputType.MouseButton1
or E=='MB2'and D.UserInputType==Enum.UserInputType.MouseButton2
or E=='Touch'and D.UserInputType==Enum.UserInputType.Touch then
af.Toggled=not af.Toggled
af:DoClick()
end;
elseif D.UserInputType==Enum.UserInputType.Keyboard then
if D.KeyCode.Name==E then
af.Toggled=not af.Toggled;
af:DoClick()
end;
end;
end;

af:Update();
end;
if(D.UserInputType==Enum.UserInputType.MouseButton1 or D.UserInputType==Enum.UserInputType.Touch)then
local E,F=aj.AbsolutePosition,aj.AbsoluteSize;
if o.X<E.X or o.X>E.X+F.X
or o.Y<(E.Y-20-1)or o.Y>E.Y+F.Y then

aj.Visible=false;
end;
end;
end))

t:GiveSignal(e.InputEnded:Connect(function(D)
if(not C)then
af:Update();
end;
end))

af:Update();
s[aa]=af;

return self
end;

y.__index=z;
y.__namecall=function(aa,ab,...)
return z[ab](...)
end;
end;

local aa={};

do
local ab={};
function ab:AddBlank(ac)
local ad=self;
local ae=ad.Container;
t:Create('Frame',{
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

local ag=t:Create('Frame',{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
ZIndex=1,
Parent=ae
})

t:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Horizontal,
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,8),
Parent=ag
})

local ah={}

for ai=1,af do
local aj={Type='Groupbox'}

local ak=t:Create('Frame',{
BackgroundTransparency=1,
Size=UDim2.new(1/af,-((af-1)*8)/af,1,0),
ZIndex=1,
Parent=ag
})

local al=t:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical,
SortOrder=Enum.SortOrder.LayoutOrder,
Padding=UDim.new(0,4),
Parent=ak
})

aj.Container=ak
setmetatable(aj,aa)

function aj:Resize()
local am=0
for z,A in next,ag:GetChildren()do
if A:IsA('Frame')then
local B=A:FindFirstChildOfClass('UIListLayout')
if B and B.AbsoluteContentSize.Y>am then
am=B.AbsoluteContentSize.Y
end
end
end
ag.Size=UDim2.new(1,0,0,am)
if ad.Resize then
ad:Resize()
end
end

al:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
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

local ah=t:CreateLabel({
Size=UDim2.new(1,-4,0,15);
TextSize=t.FontSize;
Text=ac;
TextWrapped=ad or false,
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=ag;
});
if ad then
local ai=select(2,t:GetTextBounds(ac,t.Font,t.FontSize,Vector2.new(ah.AbsoluteSize.X,math.huge)))
ah.Size=UDim2.new(1,-4,0,ai)
else
t:Create('UIListLayout',{
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
local aj=select(2,t:GetTextBounds(ai,t.Font,t.FontSize,Vector2.new(ah.AbsoluteSize.X,math.huge)))
ah.Size=UDim2.new(1,-4,0,aj)
end

af:Resize();
end

if(not ad)then
setmetatable(ae,y);
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
local ai=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
});
local aj=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=ai;
});
local ak=t:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=t.FontSize;
Text=ah.Text;
ZIndex=6;
Parent=aj;
});

t:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=aj;
});
t:AddToRegistry(ai,{
BorderColor3='Black';
});
t:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});

local al=TweenInfo.new(0.15,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

ai.MouseEnter:Connect(function()
k:Create(ai,al,{BorderColor3=t.AccentColor}):Play()
k:Create(aj,al,{BackgroundColor3=t.AccentColor}):Play()
end)

ai.MouseLeave:Connect(function()
k:Create(ai,al,{BorderColor3=Color3.new(0,0,0)}):Play()
k:Create(aj,al,{BackgroundColor3=t.MainColor}):Play()
end)
return ai,aj,ak
end

local function ah(ai)
local function aj(ak,al,am)
local z=Instance.new('BindableEvent')
local A=ak:Once(function(...)

if type(am)=='function'and am(...)then
z:Fire(true)
else
z:Fire(false)
end
end)
task.delay(al,function()
A:disconnect()
z:Fire(false)
end)
return z.Event:Wait()
end

local function ak(al)
if t:MouseIsOverOpenedFrame()then
return false
end

if al.UserInputType~=Enum.UserInputType.MouseButton1 and al.UserInputType~=Enum.UserInputType.Touch then
return false
end

return true
end

ai.Outer.InputBegan:Connect(function(al)
if not ak(al)then return end

if ai.Locked then return end

if ai.DoubleClick then
t:RemoveFromRegistry(ai.Label)
t:AddToRegistry(ai.Label,{TextColor3='AccentColor'})

ai.Label.TextColor3=t.AccentColor
ai.Label.Text='Are you sure?'
ai.Locked=true

local am=aj(ai.Outer.InputBegan,0.5,ak)

t:RemoveFromRegistry(ai.Label)
t:AddToRegistry(ai.Label,{TextColor3='FontColor'})

ai.Label.TextColor3=t.FontColor
ai.Label.Text=ai.Text
task.defer(rawset,ai,'Locked',false)

if am then
t:SafeCallback(ai.Func)
end

return
end

t:SafeCallback(ai.Func);
end)
end

ac.Outer,ac.Inner,ac.Label=ag(ac)
ac.Outer.Parent=af

ah(ac)

function ac:AddTooltip(ai)
if type(ai)=='string'then
t:AddToolTip(ai,self.Outer)
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
t:AddToolTip(aj,self.Outer)
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
local af=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,5);
ZIndex=5;
Parent=ad;
});
local ag=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=af;
});
t:AddToRegistry(af,{
BorderColor3='Black';
});
t:AddToRegistry(ag,{
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

local ah=t:CreateLabel({
Size=UDim2.new(1,0,0,15);
TextSize=t.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=ag;
});

af:AddBlank(1);

local ai=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
Parent=ag;
});
local aj=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=ai;
});
t:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
t:OnHighlight(ai,ai,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
if type(ad.Tooltip)=='string'then
t:AddToolTip(ad.Tooltip,ai)
end

t:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=aj;
});
local ak=t:Create('Frame',{
BackgroundTransparency=1;
ClipsDescendants=true;

Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);

ZIndex=7;
Parent=aj;
})

local al=t:Create('TextBox',{
BackgroundTransparency=1;

Position=UDim2.fromOffset(0,0),
Size=UDim2.fromScale(5,1),

FontFace=t.Font;
PlaceholderColor3=Color3.fromRGB(190,190,190);
PlaceholderText=ad.Placeholder or'';

Text=ad.Default or'';
TextColor3=t.FontColor;
TextSize=t.FontSize;
TextStrokeTransparency=0;
TextXAlignment=Enum.TextXAlignment.Left;

ZIndex=7;
Parent=ak;
});

t:ApplyTextStroke(al);
function ae:SetValue(am)
if ad.MaxLength and#am>ad.MaxLength then
am=am:sub(1,ad.MaxLength);
end;

if ae.Numeric then
if(not tonumber(am))and am:len()>0 then
am=ae.Value
end
end

ae.Value=am;
al.Text=am;

t:SafeCallback(ae.Callback,ae.Value);
t:SafeCallback(ae.Changed,ae.Value);
end;

if ae.Finished then
al.FocusLost:Connect(function(am)
if not am then return end

ae:SetValue(al.Text);
t:AttemptSave();
end)
else
al:GetPropertyChangedSignal('Text'):Connect(function()
ae:SetValue(al.Text);
t:AttemptSave();
end);
end

local function am()
local z=2
local A=ak.AbsoluteSize.X

if not al:IsFocused()or al.TextBounds.X<=A-2*z then
al.Position=UDim2.new(0,z,0,0)
else
local B=al.CursorPosition
if B~=-1 then
local C=string.sub(al.Text,1,B-1)
local D=f:GetTextSize(C,al.TextSize,al.Font,Vector2.new(math.huge,math.huge)).X

local E=al.Position.X.Offset+D

if E<z then
al.Position=UDim2.fromOffset(z-D,0)
elseif E>A-z-1 then
al.Position=UDim2.fromOffset(A-D-z-1,0)
end
end
end
end

task.spawn(am)

al:GetPropertyChangedSignal('Text'):Connect(am)
al:GetPropertyChangedSignal('CursorPosition'):Connect(am)
al.FocusLost:Connect(am)
al.Focused:Connect(am)

t:AddToRegistry(al,{
TextColor3='FontColor';
});

function ae:OnChanged(z)
ae.Changed=z;
z(ae.Value);
end;

af:AddBlank(5);
af:Resize();

s[ac]=ae;

return ae
end;

function ab:AddToggle(ac,ad)
assert(ad.Text,'AddInput: Missing `Text` string.')

local ae={
Value=ad.Default or false;
Type='Toggle';
Callback=ad.Callback or function(ae)end;
Addons={};
Risky=ad.Risky;
};
local af=self;
local ah=af.Container;

local ai=TweenInfo.new(0.15,Enum.EasingStyle.Quad,Enum.EasingDirection.Out);

local aj=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,13,0,13);
ZIndex=5;
Parent=ah;
});
t:AddToRegistry(aj,{
BorderColor3='Black';
});

local ak=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=aj;
});
t:AddToRegistry(ak,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});

t:Create('UIGradient',{
Rotation=90;
Parent=ak;
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255));
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185));
});
});



local al=t:Create('ImageLabel',{
AnchorPoint=Vector2.new(0.5,0.5);
Position=UDim2.new(0.5,0,0.5,0);
BackgroundTransparency=1;
ImageTransparency=1;
Size=UDim2.new(0,9,0,9);
Image='http://www.roblox.com/asset/?id=18926561620';
ZIndex=9;
Parent=aj;
});

local am=t:CreateLabel({
Size=UDim2.new(0,216,1,0);
Position=UDim2.new(1,6,0,0);
TextSize=t.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=6;
Parent=ak;
});
t:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Right;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=am;
});

local z=t:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(0,170,1,0);
ZIndex=8;
Parent=aj;
});
t:OnHighlight(z,aj,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);

if type(ad.Tooltip)=='string'then
t:AddToolTip(ad.Tooltip,z)
end

function ae:UpdateColors()
ae:Display();
end;

function ae:Display()
local A=ae.Value and t.AccentColor or t.MainColor;
local B=ae.Value and t.AccentColorDark or t.OutlineColor;

k:Create(ak,ai,{
BackgroundColor3=A;
BorderColor3=B;
}):Play();

k:Create(al,ai,{
ImageTransparency=ae.Value and 0 or 1;
}):Play();

t.RegistryMap[ak].Properties.BackgroundColor3=ae.Value and'AccentColor'or'MainColor';
t.RegistryMap[ak].Properties.BorderColor3=ae.Value and'AccentColorDark'or'OutlineColor';
end;

function ae:OnChanged(A)
ae.Changed=A;
A(ae.Value);
end;

function ae:SetValue(A)
A=(not not A);
ae.Value=A;
ae:Display();

for B,C in next,ae.Addons do
if C.Type=='KeyPicker'and C.SyncToggleState then
C.Toggled=A;
C:Update();
end;
end;

t:SafeCallback(ae.Callback,ae.Value);
t:SafeCallback(ae.Changed,ae.Value);
t:UpdateDependencyBoxes();
end;

z.InputBegan:Connect(function(A)
if(A.UserInputType==Enum.UserInputType.MouseButton1 or A.UserInputType==Enum.UserInputType.Touch)and not t:MouseIsOverOpenedFrame()then
ae:SetValue(not ae.Value);
t:AttemptSave();
end;
end);

if ae.Risky then
t:RemoveFromRegistry(am);
am.TextColor3=t.RiskColor;
t:AddToRegistry(am,{TextColor3='RiskColor'});
end;

ae:Display();
af:AddBlank(ad.BlankSize or 5+2);
af:Resize();

ae.TextLabel=am;
ae.Container=ah;
setmetatable(ae,y);

r[ac]=ae;

t:UpdateDependencyBoxes();

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
t:CreateLabel({
Size=UDim2.new(1,0,0,10);
TextSize=t.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
TextYAlignment=Enum.TextYAlignment.Bottom;
ZIndex=5;
Parent=ah;
});
af:AddBlank(3);
end

local ai=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,13);
ZIndex=5;
Parent=ah;
});
t:AddToRegistry(ai,{
BorderColor3='Black';
});
local aj=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=ai;
});
t:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});

local ak=t:Create("UIGradient",{
Rotation=90,
Parent=aj,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,t.MainColor),
}),
});
t:AddToRegistry(ak,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,t.MainColor),
})
end
});

local al=t:Create("UIGradient",{
Rotation=90,
Parent=aj,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185)),
}),
})

t:AddToRegistry(aj,{
BackgroundColor3="MainColor",
BorderColor3="OutlineColor",
})


local am=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderColor3=t.AccentColorDark;
Size=UDim2.new(0,0,1,0);
ZIndex=7;
Parent=aj;
});
t:AddToRegistry(am,{
BackgroundColor3='AccentColor';
BorderColor3='AccentColorDark';
});

local z=t:Create("UIGradient",{
Rotation=90,
Parent=am,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,t.AccentColor),
}),
});
t:AddToRegistry(z,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,t.AccentColor),
})
end
});

local A=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderSizePixel=0;
BackgroundTransparency=1;
Position=UDim2.new(1,0,0,0);
Size=UDim2.new(0,1,1,0);
ZIndex=8;
Parent=am;
});

t:AddToRegistry(am,{
BackgroundColor3="AccentColor",
BorderColor3="AccentColorDark",
})

local B=t:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=t.FontSize;
Text='Infinite';
ZIndex=9;
Parent=aj;
});
t:OnHighlight(ai,ai,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
if type(ad.Tooltip)=='string'then
t:AddToolTip(ad.Tooltip,ai)
end

function ae:UpdateColors()
am.BackgroundColor3=t.AccentColor;
am.BorderColor3=t.AccentColorDark;
end;

local C=TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out);

function ae:Display()
local D=ad.Suffix or'';
if ad.Compact then
B.Text=ad.Text..': '..ae.Value..D
elseif ad.HideMax then
B.Text=string.format('%s',ae.Value..D)
else
B.Text=string.format('%s/%s',ae.Value..D,ae.Max..D);
end

ae.MaxSize=aj.AbsoluteSize.X;
local E=math.ceil(t:MapValue(ae.Value,ae.Min,ae.Max,0,ae.MaxSize));


k:Create(am,C,{
Size=UDim2.new(0,E,1,0);
}):Play();

A.Visible=not(E==ae.MaxSize or E==0);
end;
function ae:OnChanged(D)
ae.Changed=D;
D(ae.Value);
end;
local function D(E)
if ae.Rounding==0 then
return math.floor(E)
end;


return tonumber(string.format('%.'..ae.Rounding..'f',E))
end;
function ae:GetValueFromXOffset(E)
return D(t:MapValue(E,0,ae.MaxSize,ae.Min,ae.Max))
end;
function ae:SetValue(E)
local F=tonumber(E);
if(not F)then
return
end;

F=math.clamp(F,ae.Min,ae.Max);

ae.Value=F;
ae:Display();

t:SafeCallback(ae.Callback,ae.Value);
t:SafeCallback(ae.Changed,ae.Value);
end;
aj.InputBegan:Connect(function(E)
if(E.UserInputType==Enum.UserInputType.MouseButton1 or E.UserInputType==Enum.UserInputType.Touch)and not t:MouseIsOverOpenedFrame()then

local function F(G)
local H=am.AbsolutePosition.X

ae.MaxSize=aj.AbsoluteSize.X

local I=G-H
local J=math.clamp(I,0,ae.MaxSize)

local K=ae:GetValueFromXOffset(J);
local L=ae.Value;

ae.Value=K;

ae:Display();

if K~=L then
t:SafeCallback(ae.Callback,ae.Value);
t:SafeCallback(ae.Changed,ae.Value);
end;
end

F(E.Position.X)

local G=e.InputChanged:Connect(function(G)
if G.UserInputType==Enum.UserInputType.MouseMovement or G==E then
F(G.Position.X)
end
end)

local H
H=e.InputEnded:Connect(function(I)
if I==E or I.UserInputType==Enum.UserInputType.Touch then
G:Disconnect()
H:Disconnect()
t:AttemptSave()
end
end)
end;
end);

ae:Display();
af:AddBlank(ad.BlankSize or 6);
af:Resize();

s[ac]=ae;

return ae
end;
function ab:AddDropdown(ac,ad)
if ad.SpecialType=='Player'then
ad.Values=w();
ad.AllowNull=true;
elseif ad.SpecialType=='Team'then
ad.Values=x();
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
local aj=t:CreateLabel({
Size=UDim2.new(1,0,0,10);
TextSize=t.FontSize;
Text=ad.Text;
TextXAlignment=Enum.TextXAlignment.Left;
TextYAlignment=Enum.TextYAlignment.Bottom;
ZIndex=5;
Parent=ah;
});
af:AddBlank(3);
end

for aj,ak in next,ah:GetChildren()do
if not ak:IsA('UIListLayout')then
ai=ai+ak.Size.Y.Offset;
end;
end;

local aj=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
Parent=ah;
});
t:AddToRegistry(aj,{
BorderColor3='Black';
});
local ak=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=aj;
});
t:AddToRegistry(ak,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
t:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=ak;
});

local al=t:Create('ImageLabel',{
AnchorPoint=Vector2.new(0,0.5);
BackgroundTransparency=1;
Position=UDim2.new(1,-16,0.5,0);
Size=UDim2.new(0,12,0,12);
Image='http://www.roblox.com/asset/?id=6282522798';
ZIndex=8;
Parent=ak;
});
local am=t:CreateLabel({
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);
TextSize=t.FontSize;
Text='--';
TextXAlignment=Enum.TextXAlignment.Left;
TextWrapped=true;
ZIndex=7;
Parent=ak;
});
t:OnHighlight(aj,aj,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
);
if type(ad.Tooltip)=='string'then
t:AddToolTip(ad.Tooltip,aj)
end

local z=8;
local A=t:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
ZIndex=20;
Visible=false;
Parent=q;
});
local function B()
A.Position=UDim2.fromOffset(aj.AbsolutePosition.X,aj.AbsolutePosition.Y+aj.Size.Y.Offset+1);
end;

local function C(D)
A.Size=UDim2.fromOffset(aj.AbsoluteSize.X,D or(z*20+2))
end;
B();
C();

aj:GetPropertyChangedSignal('AbsolutePosition'):Connect(B);

local D=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=21;
Parent=A;
});
t:AddToRegistry(D,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
local E=t:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
CanvasSize=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ZIndex=21;
Parent=D;

TopImage='rbxasset://textures/ui/Scroll/scroll-middle.png',
BottomImage='rbxasset://textures/ui/Scroll/scroll-middle.png',

ScrollBarThickness=3,
ScrollBarImageColor3=t.AccentColor,
});
t:AddToRegistry(E,{
ScrollBarImageColor3='AccentColor'
})

t:Create('UIListLayout',{
Padding=UDim.new(0,0);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=E;
});
function ae:Display()
local F=ae.Values;
local G='';

if ad.Multi then
for H,I in next,F do
if ae.Value[I]then
G=G..I..', ';
end;
end;

G=G:sub(1,#G-2);
else
G=ae.Value or'';
end;

am.Text=(G==''and'--'or G);
end;
function ae:GetActiveValues()
if ad.Multi then
local F={};
for G,H in next,ae.Value do
table.insert(F,G);
end;

return F
else
return ae.Value and 1 or 0
end;
end;

function ae:BuildDropdownList()
local F=ae.Values;
local G={};

for H,I in next,E:GetChildren()do
if not I:IsA('UIListLayout')then
I:Destroy();
end;
end;

local H=0;

for I,J in next,F do
local K={};
H=H+1;

local L=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Middle;
Size=UDim2.new(1,-1,0,20);
ZIndex=23;
Active=true,
Parent=E;
});
t:AddToRegistry(L,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
local M=t:CreateLabel({
Active=false;
Size=UDim2.new(1,-6,1,0);
Position=UDim2.new(0,6,0,0);
TextSize=t.FontSize;
Text=J;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=25;
Parent=L;
});

t:OnHighlight(L,L,
{BorderColor3='AccentColor',ZIndex=24},
{BorderColor3='OutlineColor',ZIndex=23}
);
local N;

if ad.Multi then
N=ae.Value[J];
else
N=ae.Value==J;
end;

function K:UpdateButton()
if ad.Multi then
N=ae.Value[J];
else
N=ae.Value==J;
end;

M.TextColor3=N and t.AccentColor or t.FontColor;
t.RegistryMap[M].Properties.TextColor3=N and'AccentColor'or'FontColor';
end;
M.InputBegan:Connect(function(O)
if(O.UserInputType==Enum.UserInputType.MouseButton1 or O.UserInputType==Enum.UserInputType.Touch)then
local P=not N;

if ae:GetActiveValues()==1 and(not P)and(not ad.AllowNull)then
else
if ad.Multi then
N=P;

if N then
ae.Value[J]=true;
else
ae.Value[J]=nil;
end;
else
N=P;

if N then
ae.Value=J;
else
ae.Value=nil;
end;

for Q,R in next,G do
R:UpdateButton();
end;
end;

K:UpdateButton();
ae:Display();

t:SafeCallback(ae.Callback,ae.Value);
t:SafeCallback(ae.Changed,ae.Value);

t:AttemptSave();
end;
end;
end);

K:UpdateButton();
ae:Display();

G[L]=K;
end;
E.CanvasSize=UDim2.fromOffset(0,(H*20)+1);

local I=math.clamp(H*20,0,z*20)+1;
C(I);
end;

function ae:SetValues(F)
if F then
ae.Values=F;
end;

ae:BuildDropdownList();
end;

function ae:OpenDropdown()
A.Visible=true;
t.OpenedFrames[A]=true;
al.Rotation=180;
end;

function ae:CloseDropdown()
A.Visible=false;
t.OpenedFrames[A]=nil;
al.Rotation=0;
end;

function ae:OnChanged(F)
ae.Changed=F;
F(ae.Value);
end;

function ae:SetValue(F)
if ae.Multi then
local G={};
for H,I in next,F do
if table.find(ae.Values,H)then
G[H]=true
end;
end;

ae.Value=G;
else
if(not F)then
ae.Value=nil;
elseif table.find(ae.Values,F)then
ae.Value=F;
end;
end;

ae:BuildDropdownList();

t:SafeCallback(ae.Callback,ae.Value);
t:SafeCallback(ae.Changed,ae.Value);
end;

aj.InputBegan:Connect(function(F)
if(F.UserInputType==Enum.UserInputType.MouseButton1 or F.UserInputType==Enum.UserInputType.Touch)and not t:MouseIsOverOpenedFrame()then
if A.Visible then
ae:CloseDropdown();
else
ae:OpenDropdown();
end;
end;
end);
e.InputBegan:Connect(function(F)
if(F.UserInputType==Enum.UserInputType.MouseButton1 or F.UserInputType==Enum.UserInputType.Touch)then
local G,H=A.AbsolutePosition,A.AbsoluteSize;

if o.X<G.X or o.X>G.X+H.X
or o.Y<(G.Y-20-1)or o.Y>G.Y+H.Y then

ae:CloseDropdown();
end;
end;
end);
ae:BuildDropdownList();
ae:Display();

local F={}

if type(ad.Default)=='string'then
local G=table.find(ae.Values,ad.Default)
if G then
table.insert(F,G)
end
elseif type(ad.Default)=='table'then
for G,H in next,ad.Default do
local I=table.find(ae.Values,H)
if I then
table.insert(F,I)
end
end
elseif type(ad.Default)=='number'and ae.Values[ad.Default]~=nil then
table.insert(F,ad.Default)
end

if next(F)then
for G=1,#F do
local H=F[G]
if ad.Multi then
ae.Value[ae.Values[H] ]=true
else
ae.Value=ae.Values[H];
end

if(not ad.Multi)then break end
end

ae:BuildDropdownList();
ae:Display();
end

af:AddBlank(ad.BlankSize or 5);
af:Resize();

s[ac]=ae;

return ae
end;
function ab:AddDependencyBox()
local ac={
Dependencies={};
};

local ad=self;
local ae=ad.Container;

local af=t:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,0,0);
Visible=false;
Parent=ae;
});
local ah=t:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,0);
Visible=true;
Parent=af;
});
local ai=t:Create('UIListLayout',{
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
for aj,ak in next,ac.Dependencies do
local al=ak[1];
local am=ak[2];

if al.Type=='Toggle'and al.Value~=am then
af.Visible=false;
ac:Resize();
return
end;
end;

af.Visible=true;
ac:Resize();
end;

function ac:SetupDependencies(aj)
for ak,al in next,aj do
assert(type(al)=='table','SetupDependencies: Dependency is not of type `table`.');
assert(al[1],'SetupDependencies: Dependency is missing element argument.');
assert(al[2]~=nil,'SetupDependencies: Dependency is missing value argument.');
end;

ac.Dependencies=aj;
ac:Update();
end;

ac.Container=ah;

setmetatable(ac,aa);

table.insert(t.DependencyBoxes,ac);

return ac
end;

aa.__index=ab;
aa.__namecall=function(ac,ad,...)
return ab[ad](...)
end;
end;
do
t.NotificationArea=t:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,t.NotifyConfig.PositionX,0,t.NotifyConfig.PositionY);
Size=UDim2.new(0,300,1,-t.NotifyConfig.PositionY);
ZIndex=100;
Parent=q;
});
t.NotifLayout=t:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=t.NotificationArea;
});
local function ab()
local ac=t.NotifyConfig
local ad=t.NotificationArea
local ae=t.NotifLayout

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
t.UpdateNotifAlignment=ab
ab()

local ac=t:Create('Frame',{
AnchorPoint=Vector2.new(0.5,0);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0.5,0,0,8);
Size=UDim2.new(0,213,0,20);
ZIndex=200;
Visible=false;
Parent=q;
});

local ad=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.AccentColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=201;
Parent=ac;
});
t:AddToRegistry(ad,{
BorderColor3='AccentColor';
});
local ae=t:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,1,-2);
ZIndex=202;
Parent=ad;
});
local af=t:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,t:GetDarkerColor(t.MainColor)),
ColorSequenceKeypoint.new(1,t.MainColor),
});
Rotation=-90;
Parent=ae;
});
t:AddToRegistry(af,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,t:GetDarkerColor(t.MainColor)),
ColorSequenceKeypoint.new(1,t.MainColor),
})
end
});
local ah=t:CreateLabel({
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-4,1,0);
TextSize=t.FontSize;
FontFace=Font.new("rbxasset://fonts/families/Tahoma.json",Enum.FontWeight.Bold);
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=203;
Parent=ae;
});
t.Watermark=ac;
t.WatermarkText=ah;
t:MakeDraggable(t.Watermark);

local ai=t:Create('Frame',{
AnchorPoint=Vector2.new(0,0.5);
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,10,0.5,0);
Size=UDim2.new(0,210,0,20);
Visible=false;
ZIndex=100;
Parent=q;
});
t:ApplyGlow(ai);

local aj=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=101;
Parent=ai;
});
t:AddToRegistry(aj,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
},true);


local ak=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,0,21);
ZIndex=102;
Parent=aj;
});
t:AddToRegistry(ak,{BackgroundColor3='AccentColor'},true);


local al=t:Create("UIGradient",{
Rotation=90,
Parent=ak,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,t.MainColor),
}),
});
t:AddToRegistry(al,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1,t.MainColor),
})
end
});


local am=t:CreateLabel({
Size=UDim2.new(1,0,1,0);
FontFace=Font.new("rbxasset://fonts/families/Tahoma.json",Enum.FontWeight.Bold),
TextSize=15,
TextXAlignment=Enum.TextXAlignment.Center;
Text='[ Keybinds ]';
ZIndex=104;
Parent=ak;
},true);


local z=t:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,22);
Size=UDim2.new(1,0,1,-22);
ZIndex=101;
Parent=aj;
});
t:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=z;
});
t:Create('UIPadding',{
PaddingLeft=UDim.new(0,5);
Parent=z;
});

t.KeybindFrame=ai;
t.KeybindContainer=z;
t:MakeDraggable(ai);
end;

function t:SetKeybindMode(ab)
assert(ab=='All'or ab=='Active'or ab=='Toggled',
"SetKeybindMode: Mode must be 'All', 'Active', or 'Toggled'")
t.KeybindMode=ab
t:RefreshKeybinds()
end

function t:RefreshKeybinds()
for ab,ac in ipairs(t.KeyPickerList)do
if not ac.NoUI then
pcall(function()ac:Update()end)
end
end
end

function t:SetWatermarkVisibility(ab)
t.Watermark.Visible=ab;
end;

function t:SetWatermark(ab)
local ac,ad=t:GetTextBounds(ab,t.Font,t.FontSize);
local ae=t.Watermark.Position.Y
t.Watermark.AnchorPoint=Vector2.new(0.5,0)
t.Watermark.Size=UDim2.new(0,ac+15,0,(ad*1.5)+3);
t.Watermark.Position=UDim2.new(0.5,0,ae.Scale,ae.Offset)
t:SetWatermarkVisibility(true)

t.WatermarkText.Text=ab;
end;
function t:Notify(ab,ac)
local ad=t.NotifyConfig
local ae=ad.BarSide or'Left'
local af=ad.Alignment or'Left'

local ah,ai=t:GetTextBounds(ab,t.Font,t.FontSize)
ai=ai+7

local aj=3
local ak=3

local al=(ae=='Left')and 1 or 1
local am=(ae=='Top')and ak or 1
local z=(ae=='Left'or ae=='Right')and-2 or-2
local A=(ae=='Top'or ae=='Bottom')and-(ak+1)or-2

local B=(ae=='Left')and aj+2 or 4
local C=(ae=='Left'or ae=='Right')and-(aj+4)or-4

local D=Vector2.new(0,0)
local E=0
if af=='Center'then
D=Vector2.new(0.5,0)
E=0
elseif af=='Right'then
D=Vector2.new(1,0)
E=0
end

local F=t:Create('Frame',{
BackgroundTransparency=1;
AnchorPoint=D;
BorderColor3=Color3.new(0,0,0);
Position=(af=='Center')
and UDim2.new(0.5,0,0,0)
or(af=='Right'and UDim2.new(1,0,0,0)or UDim2.new(0,0,0,0));
Size=UDim2.new(0,0,0,ai);
ClipsDescendants=true;
ZIndex=100;
Parent=t.NotificationArea;
});
local G=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=101;
Parent=F;
});
t:AddToRegistry(G,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
},true);
local H=t:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Position=UDim2.new(0,al,0,am);
Size=UDim2.new(1,z,1,A);
ZIndex=102;
Parent=G;
});
local I=t:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,t:GetDarkerColor(t.MainColor)),
ColorSequenceKeypoint.new(1,t.MainColor),
});
Rotation=-90;
Parent=H;
});
t:AddToRegistry(I,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,t:GetDarkerColor(t.MainColor)),
ColorSequenceKeypoint.new(1,t.MainColor),
})
end
});
local J=t:CreateLabel({
Position=UDim2.new(0,B,0,0);
Size=UDim2.new(1,C,1,0);
Text=ab;
TextXAlignment=(af=='Center')
and Enum.TextXAlignment.Center
or Enum.TextXAlignment.Left;
TextSize=t.FontSize;
ZIndex=103;
Parent=H;
});
local K=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderSizePixel=0;
ZIndex=104;
Parent=F;
});
if ae=='Left'then
K.Position=UDim2.new(0,-1,0,-1)
K.Size=UDim2.new(0,aj,1,2)
elseif ae=='Right'then
K.Position=UDim2.new(1,-aj+1,0,-1)
K.Size=UDim2.new(0,aj,1,2)
elseif ae=='Top'then
K.Position=UDim2.new(0,-1,0,-1)
K.Size=UDim2.new(1,2,0,ak)
elseif ae=='Bottom'then
K.Position=UDim2.new(0,-1,1,-ak+1)
K.Size=UDim2.new(1,2,0,ak)
end

t:AddToRegistry(K,{
BackgroundColor3='AccentColor';
},true);
local L=ah+8+4
if ae=='Left'or ae=='Right'then
L=L+aj
end
pcall(F.TweenSize,F,
UDim2.new(0,L,0,ai),'Out','Quad',0.4,true);
task.spawn(function()
wait(ac or 5);
pcall(F.TweenSize,F,
UDim2.new(0,0,0,ai),'Out','Quad',0.4,true);
wait(0.4);
F:Destroy();
end);
end;

function t:CreateWindow(...)
local ab={...}
local ac={AnchorPoint=Vector2.zero}

if type(...)=='table'then
ac=...;
else
ac.Title=ab[1]
ac.AutoShow=ab[2]or false;
end

if type(ac.Title)~='string'then ac.Title='No title'end
if type(ac.TabPadding)~='number'then ac.TabPadding=2 end
if type(ac.MenuFadeTime)~='number'then ac.MenuFadeTime=0.2 end

if typeof(ac.Size)~='UDim2'then ac.Size=UDim2.fromOffset(550,600)end
if typeof(ac.Position)~='UDim2'then ac.Position=UDim2.fromOffset(175,50)end

if e.TouchEnabled then
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
t.WireframeDrag=ac.WireframeDrag
end

local ad={
Tabs={};
};

local ae=t:Create('Frame',{
AnchorPoint=ac.AnchorPoint,
BackgroundTransparency=1,
BorderSizePixel=0;
Position=ac.Position,
Size=ac.Size,
Visible=false;
ZIndex=1;
Parent=q;
});
t:MakeDraggable(ae,25,true);

if ac.Resizable then
t:MakeResizable(ae,ac.MinSize,ac.MaxSize)
end

local af=t:Create('Frame',{
Name="Inner",
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,1,-2);
ZIndex=1;
Parent=ae;
});
t:AddToRegistry(af,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});
local ah=t:Create('Frame',{
Name="TempFrame",
BackgroundColor3=Color3.new(1,1,1),
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,0,26);
Transparency=0.5;
ZIndex=1;
Parent=ae;
});
t:AddToRegistry(ah,{

BorderColor3='OutlineColor';
});





















local ai=t:Create("UIGradient",{
Rotation=90,
Parent=ah,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,t.AccentColor),
ColorSequenceKeypoint.new(1,t.SecondAccentColor),
}),
});
t:AddToRegistry(ai,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,t.AccentColor),
ColorSequenceKeypoint.new(1,t.SecondAccentColor),
})
end
});

local aj=t:CreateLabel({
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,0,25);
Text=ac.Title or'';
RichText=true;
TextXAlignment=Enum.TextXAlignment.Center;
ZIndex=3;
Parent=af;
});
local ak=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
Position=UDim2.new(0,0,0,25);
Size=UDim2.new(1,0,0,36);
ZIndex=1;
Parent=af;
});
t:AddToRegistry(ak,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local al=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
BorderMode=Enum.BorderMode.Outline;
Size=UDim2.new(1,0,1,0);
ZIndex=1;
Parent=ak;
});
t:AddToRegistry(al,{
BackgroundColor3='BackgroundColor';
});
local am=t:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ZIndex=1;
Parent=al;
});
local z=t:Create('UIListLayout',{
Padding=UDim.new(0,0);
FillDirection=Enum.FillDirection.Horizontal;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=am;
});
local A=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
Position=UDim2.new(0,0,0,61);
Size=UDim2.new(1,0,1,-61);
ZIndex=1;
Parent=af;
});
t:AddToRegistry(A,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local B=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
BorderMode=Enum.BorderMode.Inset;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ZIndex=1;
Parent=A;
});
t:AddToRegistry(B,{
BackgroundColor3='BackgroundColor';
});
local C=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.OutlineColor;
Position=UDim2.new(0,8,0,8);
Size=UDim2.new(1,-16,1,-16);
ZIndex=2;
Parent=B;
});
t:AddToRegistry(C,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
});

local D={};

local function E()
local F=#D;
if F==0 then return end;
for G,H in ipairs(D)do
H.Size=UDim2.new(1/F,0,1,0);
end;
end;

function ad:SetWindowTitle(F)
aj.Text=F;
end;
function ad:AddTab(F)
local G={
Groupboxes={};
Tabboxes={};
};

local H=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
Size=UDim2.new(1,0,1,0);
ZIndex=1;
Parent=am;
});
table.insert(D,H);
E();
t:AddToRegistry(H,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local I=t:Create("UIGradient",{
Rotation=-90;
Parent=H;
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255));
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185));
});
});
t:AddToRegistry(H,{
BackgroundColor3="BackgroundColor";
BorderColor3="OutlineColor";
});

local J=t:CreateLabel({
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,-3);
Text=F;
FontFace=Font.new("rbxasset://fonts/families/Tahoma.json",Enum.FontWeight.Bold),
TextSize=15,
ZIndex=1;
Parent=H;
});

local K=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,1,-3);
Size=UDim2.new(1,0,0,2);
Visible=false;
ZIndex=4;
Parent=H;
});
t:AddToRegistry(K,{BackgroundColor3='AccentColor'});

local L=t:Create('Frame',{
BackgroundTransparency=1;
BackgroundColor3=t.MainColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
Position=UDim2.new(0,0,0,0);
ZIndex=3;
Visible=false;
Parent=H;
});

t:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1));
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1));
ColorSequenceKeypoint.new(1,Color3.new(1,1,1));
});
Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0,1);
NumberSequenceKeypoint.new(0.2,0.6);
NumberSequenceKeypoint.new(0.5,0);
NumberSequenceKeypoint.new(0.8,0.6);
NumberSequenceKeypoint.new(1,1);
});
Rotation=0;
Parent=K;
});

local M=t:Create('Frame',{
Name='TabClip';
BackgroundTransparency=1;
BorderSizePixel=0;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ClipsDescendants=true;
ZIndex=2;
Parent=C;
});

local N=t:Create('Frame',{
Name='TabFrame';
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
Visible=false;
ZIndex=2;
Parent=M;
});
local O=t:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
Position=UDim2.new(0,8-1,0,8-1);
Size=UDim2.new(0.5,-12+2,1,-16);
CanvasSize=UDim2.new(0,0,0,0);
BottomImage='';
TopImage='';
ScrollBarThickness=0;
ZIndex=2;
Parent=N;
});
local P=t:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
Position=UDim2.new(0.5,4+1,0,8-1);
Size=UDim2.new(0.5,-12+2,1,-16);
CanvasSize=UDim2.new(0,0,0,0);
BottomImage='';
TopImage='';
ScrollBarThickness=0;
ZIndex=2;
Parent=N;
});
t:Create('UIListLayout',{
Padding=UDim.new(0,8);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
HorizontalAlignment=Enum.HorizontalAlignment.Center;
Parent=O;
});
t:Create('UIListLayout',{
Padding=UDim.new(0,8);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
HorizontalAlignment=Enum.HorizontalAlignment.Center;
Parent=P;
});
for Q,R in next,{O,P}do
R:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
R.CanvasSize=UDim2.fromOffset(0,R.UIListLayout.AbsoluteContentSize.Y);
end);
end;

local Q={}

function G:ShowTab()
for R,S in next,ad.Tabs do
if S~=G then
S:HideTab()
end
end

if Q[N]then
Q[N]:Cancel()
Q[N]=nil
end

L.Visible=true
H.BackgroundColor3=t.MainColor
t.RegistryMap[H].Properties.BackgroundColor3='MainColor'

N.Position=UDim2.new(0,0,0,12)
N.Visible=true
K.Visible=true

local R=k:Create(N,TweenInfo.new(0.18,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
Position=UDim2.new(0,0,0,0),
})
Q[N]=R
R:Play()
R.Completed:Connect(function()
Q[N]=nil
end)
end

function G:HideTab()
if Q[N]then
Q[N]:Cancel()
Q[N]=nil
end

L.Visible=false
H.BackgroundColor3=t.BackgroundColor
t.RegistryMap[H].Properties.BackgroundColor3='BackgroundColor'
K.Visible=false

local R=k:Create(N,TweenInfo.new(0.05,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{
Position=UDim2.new(0,0,0,8),
})
Q[N]=R
R:Play()
R.Completed:Connect(function(S)
if S==Enum.PlaybackState.Completed then
N.Visible=false
end
Q[N]=nil
end)
end
function G:SetLayoutOrder(R)
H.LayoutOrder=R;
z:ApplyLayout();
end;
function G:AddGroupbox(R)
local S={};
local T=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,0,507+2);
ZIndex=2;
Parent=R.Side==1 and O or P;
});
t:AddToRegistry(T,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local U=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-2,1,-2);
Position=UDim2.new(0,1,0,1);
ZIndex=4;
Parent=T;
});
t:AddToRegistry(U,{
BackgroundColor3='BackgroundColor';
});
local V=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(0,2,0,19);
ZIndex=5;
Parent=U;
});
t:AddToRegistry(V,{
BackgroundColor3='AccentColor';
});
local W=t:Create("UIGradient",{
Rotation=90,
Parent=V,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,t.AccentColor),
ColorSequenceKeypoint.new(1,t.SecondAccentColor),
}),
});
t:AddToRegistry(W,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,t.AccentColor),
ColorSequenceKeypoint.new(1,t.SecondAccentColor),
})
end
});
local X=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,0,20);
ZIndex=4;
Parent=U;
});
t:AddToRegistry(X,{
BackgroundColor3='BackgroundColor';
});

local Y=t:Create("UIGradient",{
Rotation=-90;
Parent=X;
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255));
ColorSequenceKeypoint.new(1,Color3.fromRGB(185,185,185));
});
});
t:AddToRegistry(H,{
BackgroundColor3="BackgroundColor";
BorderColor3="OutlineColor";
});


















local Z=t:CreateLabel({
Size=UDim2.new(1,-10,1,0);
Position=UDim2.new(0,10,0,0);
FontFace=Font.new("rbxasset://fonts/families/Tahoma.json",Enum.FontWeight.Bold);
TextSize=15;
Text=R.Name;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=X;
});
local _=t:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,4,0,20);
Size=UDim2.new(1,-4,1,-20);
ZIndex=1;
Parent=U;
});
t:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=_;
});
function S:Resize()
local an=0;
for ao,ap in next,S.Container:GetChildren()do
if(not ap:IsA('UIListLayout'))and ap.Visible then
an=an+ap.Size.Y.Offset;
end;
end;

T.Size=UDim2.new(1,0,0,20+an+2+2);
end;

S.Container=_;
setmetatable(S,aa);
S:AddBlank(3);
S:Resize();

G.Groupboxes[R.Name]=S;

return S
end;

function G:AddLeftGroupbox(an)
return G:AddGroupbox({Side=1;Name=an;})
end;

function G:AddRightGroupbox(an)
return G:AddGroupbox({Side=2;Name=an;})
end;

function G:AddTabbox(an)
local ao={
Tabs={};
};

local ap=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,0,0);
ZIndex=2;
Parent=an.Side==1 and O or P;
});
t:AddToRegistry(ap,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
});
local R=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderColor3=t.MainColor;
Size=UDim2.new(1,-2,1,-2);
Position=UDim2.new(0,1,0,1);
ZIndex=4;
Parent=ap;
});
t:AddToRegistry(R,{
BackgroundColor3='BackgroundColor';
});
local S=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,1);
Size=UDim2.new(1,0,0,18);
ZIndex=5;
Parent=R;
});
t:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Left;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=S;
});
function ao:AddTab(T)
local U={};
local V=t:Create('Frame',{
BackgroundColor3=t.MainColor;
BorderColor3=t.BackgroundColor;
Size=UDim2.new(0.5,0,1,0);
ZIndex=6;
Parent=S;
});
t:AddToRegistry(V,{
BackgroundColor3='MainColor';
});
local W=t:Create('Frame',{
BackgroundColor3=t.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(0,-1,0,-2);
Size=UDim2.new(1,1,0,2);
Visible=false;
ZIndex=10;
Parent=V;
});
t:AddToRegistry(W,{
BackgroundColor3='AccentColor';
});
local X=t:Create("UIGradient",{
Rotation=90,
Parent=W,
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,t.AccentColor),
ColorSequenceKeypoint.new(1,t.SecondAccentColor),
}),
});
t:AddToRegistry(X,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,t.AccentColor),
ColorSequenceKeypoint.new(1,t.SecondAccentColor),
})
end
});
local Y=t:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=t.FontSize;
Text=T;
TextXAlignment=Enum.TextXAlignment.Center;
ZIndex=7;
Parent=V;
});
local Z=t:Create('Frame',{
BackgroundColor3=t.BackgroundColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,1,0);
Size=UDim2.new(1,0,0,1);
Visible=false;
ZIndex=9;
Parent=V;
});
t:AddToRegistry(Z,{
BackgroundColor3='BackgroundColor';
});
local _=t:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,4,0,20);
Size=UDim2.new(1,-4,1,-20);
ZIndex=1;
Visible=false;
Parent=R;
});
t:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=_;
});
function U:Show()
for aq,ar in next,ao.Tabs do
ar:Hide();
end;

_.Visible=true;
Z.Visible=true;
W.Visible=true;

V.BackgroundColor3=t.BackgroundColor;
t.RegistryMap[V].Properties.BackgroundColor3='BackgroundColor';

U:Resize();
end;
function U:Hide()
_.Visible=false;
Z.Visible=false;
W.Visible=false;

V.BackgroundColor3=t.MainColor;
t.RegistryMap[V].Properties.BackgroundColor3='MainColor';
end;
function U:Resize()
local aq=0;
for ar,as in next,ao.Tabs do
aq=aq+1;
end;

for ar,as in next,S:GetChildren()do
if not as:IsA('UIListLayout')then
as.Size=UDim2.new(1/aq,0,1,0);
end;
end;

if(not _.Visible)then
return
end;

local ar=0;

for as,at in next,U.Container:GetChildren()do
if(not at:IsA('UIListLayout'))and at.Visible then
ar=ar+at.Size.Y.Offset;
end;
end;

ap.Size=UDim2.new(1,0,0,20+ar+2+2);
end;
V.InputBegan:Connect(function(aq)
if(aq.UserInputType==Enum.UserInputType.MouseButton1 or aq.UserInputType==Enum.UserInputType.Touch)and not t:MouseIsOverOpenedFrame()then
U:Show();
U:Resize();
end;
end);

U.Container=_;
ao.Tabs[T]=U;

setmetatable(U,aa);

U:AddBlank(3);
U:Resize();

if#S:GetChildren()==2 then
U:Show();
end;

return U
end;

G.Tabboxes[an.Name or'']=ao;

return ao
end;
function G:AddLeftTabbox(an)
return G:AddTabbox({Name=an,Side=1;})
end;

function G:AddRightTabbox(an)
return G:AddTabbox({Name=an,Side=2;})
end;

H.InputBegan:Connect(function(an)
if(an.UserInputType==Enum.UserInputType.MouseButton1 or an.UserInputType==Enum.UserInputType.Touch)then
G:ShowTab();
end;
end);
if#C:GetChildren()==1 then
G:ShowTab();
end;
ad.Tabs[F]=G;
return G
end;

local an=t:Create('TextButton',{
BackgroundTransparency=1;
Size=UDim2.new(0,0,0,0);
Visible=true;
Text='';
Modal=false;
Parent=q;
});
function t:Toggle()
t.Toggled=not t.Toggled;
an.Modal=t.Toggled;
ae.Visible=t.Toggled;
if t.Toggled then
task.spawn(function()
local ao=e.MouseIconEnabled;

local ap=Drawing.new('Triangle');
ap.Thickness=1;
ap.Filled=true;
ap.Visible=true;

local aq=Drawing.new('Triangle');
aq.Thickness=1;
aq.Filled=false;
aq.Color=Color3.new(0,0,0);
aq.Visible=true;

while t.Toggled and q.Parent do
e.MouseIconEnabled=false;

local ar=e:GetMouseLocation();

ap.Color=t.AccentColor;

ap.PointA=Vector2.new(ar.X,ar.Y);
ap.PointB=Vector2.new(ar.X+16,ar.Y+6);
ap.PointC=Vector2.new(ar.X+6,ar.Y+16);
aq.PointA=ap.PointA;
aq.PointB=ap.PointB;
aq.PointC=ap.PointC;

m:Wait();
end;

e.MouseIconEnabled=ao;

ap:Remove();
aq:Remove();
end);
end;
if t.UseBlur then
if t.Toggled then
t.BlurEffect.Enabled=true
t.BlurEffect.Size=t.BlurSize
else
t.BlurEffect.Size=0
t.BlurEffect.Enabled=false
end
else
t.BlurEffect.Size=0
t.BlurEffect.Enabled=false
end
end

t:GiveSignal(e.InputBegan:Connect(function(ao,ap)
if type(t.ToggleKeybind)=='table'and t.ToggleKeybind.Type=='KeyPicker'then
if ao.UserInputType==Enum.UserInputType.Keyboard and ao.KeyCode.Name==t.ToggleKeybind.Value then
task.spawn(t.Toggle)
end
elseif type(t.ToggleKeybind)=='string'then
if ao.UserInputType==Enum.UserInputType.Keyboard and ao.KeyCode.Name==t.ToggleKeybind then
task.spawn(t.Toggle)
end
elseif ao.KeyCode==Enum.KeyCode.RightControl or(ao.KeyCode==Enum.KeyCode.RightShift and(not ap))then
task.spawn(t.Toggle)
end
end))

if ac.AutoShow then task.spawn(t.Toggle)end

ad.Holder=ae;
return ad
end;

local function ab()
local ac=w();
for ad,ae in next,s do
if ae.Type=='Dropdown'and ae.SpecialType=='Player'then
ae:SetValues(ac);
end;
end;
end;

i.PlayerAdded:Connect(ab);
i.PlayerRemoving:Connect(ab);

if e.TouchEnabled then
local ac=Instance.new("ScreenGui")
ac.Name="LinoriaMobileUI"
ac.ZIndexBehavior=Enum.ZIndexBehavior.Global
p(ac)
ac.Parent=g

local ad,ae=88,30
local af=40

local function ah(ai,aj,ak)
local al=t:Create('Frame',{
Name=ai.."Outer",
BackgroundColor3=t.OutlineColor,
BorderSizePixel=0,
Position=ak,
Size=UDim2.new(0,ad,0,ae),
ZIndex=300,
Parent=ac,
Active=true,
})
t:AddToRegistry(al,{BackgroundColor3='OutlineColor'})

local am=t:Create('Frame',{
Name=ai.."Accent",
BackgroundColor3=t.AccentColor,
BorderSizePixel=0,
Position=UDim2.new(0,1,0,1),
Size=UDim2.new(1,-2,1,-2),
ZIndex=301,
Parent=al,
})
t:AddToRegistry(am,{BackgroundColor3='AccentColor'})

local an=t:Create('Frame',{
Name=ai.."Inner",
BackgroundColor3=Color3.fromRGB(8,8,12),
BorderSizePixel=0,
Position=UDim2.new(0,1,0,1),
Size=UDim2.new(1,-2,1,-2),
ZIndex=302,
Parent=am,
})

local ao=t:Create('Frame',{
Name=ai.."Gradient",
BackgroundColor3=Color3.new(1,1,1),
BorderSizePixel=0,
Size=UDim2.new(1,0,1,0),
ZIndex=303,
Parent=an,
})
t:Create('UIGradient',{
Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0,0.90),
NumberSequenceKeypoint.new(1,1.0)
}),
Rotation=90,
Parent=ao,
})

local ap=t:Create('TextButton',{
Name=ai.."Btn",
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Font=Enum.Font.Code,
Text=aj,
TextColor3=Color3.fromRGB(255,255,255),
TextSize=t.FontSize-1,
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
local ar=false
local as=nil
local at=nil
local z=nil
local A=false

ao.InputBegan:Connect(function(B)
if B.UserInputType==Enum.UserInputType.MouseButton1
or B.UserInputType==Enum.UserInputType.Touch then
ar=true
A=false
at=B.Position
z=ap.Position
as=B

local C
C=B.Changed:Connect(function()
if B.UserInputState==Enum.UserInputState.End then
ar=false
C:Disconnect()
if not A then
aq()
end
end
end)
end
end)

e.InputChanged:Connect(function(B)
if B==as and ar then
local C=B.Position-at
if C.Magnitude>3 then
A=true
end
if am and A then
ap.Position=UDim2.new(
z.X.Scale,z.X.Offset+C.X,
z.Y.Scale,z.Y.Offset+C.Y
)
end
end
end)
end

an(aj,ai,function()
t:Toggle()
end)

an(al,ak,function()
am=not am
al.Text=am and"Lock UI"or"Unlock UI"
al.TextColor3=am
and t.AccentColor
or Color3.fromRGB(255,255,255)
end)

local ao=t.UpdateColorsUsingRegistry
t.UpdateColorsUsingRegistry=function(ap)
ao(ap)
end
end

getgenv().Library=t
return t end function a.a():typeof(b())local aa=a.cache.a if not aa then aa={c=b()}a.cache.a=aa end return aa.c end end do local function aa()
local ab=game:GetService('HttpService')
local ac={}do
ac.Folder='LinoriaLibSettings'


ac.Library=nil
ac.BuiltInThemes={
['Default']={1,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"242328","AccentColor":"faa614","SecondAccentColor":"fcc55a","BackgroundColor":"212025","OutlineColor":"323232"}')},
['Blue']={2,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"181818","AccentColor":"4777b6","SecondAccentColor":"5a8fd4","BackgroundColor":"141414","OutlineColor":"1f1f1f"}')},
['Dracula']={3,ab:JSONDecode('{"FontColor":"f8f8f2","MainColor":"282a36","AccentColor":"bd93f9","SecondAccentColor":"d4b5ff","BackgroundColor":"1e1f29","OutlineColor":"44475a"}')},
['Yuki']={4,ab:JSONDecode('{"FontColor":"c8c8c8","MainColor":"171515","AccentColor":"bab972","SecondAccentColor":"d4d48a","BackgroundColor":"131111","OutlineColor":"1b1919"}')},
['Primordial']={5,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"181818","AccentColor":"d7a6b0","SecondAccentColor":"ecc4cc","BackgroundColor":"1f1f1f","OutlineColor":"2a2a2a"}')},
['BBot']={6,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","SecondAccentColor":"9e60c9","BackgroundColor":"232323","OutlineColor":"141414"}')},
['Fatality']={7,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","SecondAccentColor":"e8196a","BackgroundColor":"191335","OutlineColor":"3c355d"}')},
['Jester']={8,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"db4467","SecondAccentColor":"f05c80","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},
['Mint']={9,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","SecondAccentColor":"55d4a4","BackgroundColor":"1c1c1c","OutlineColor":"373737"}')},
['Tokyo Night']={10,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","SecondAccentColor":"8470d4","BackgroundColor":"16161f","OutlineColor":"323232"}')},
['Ubuntu']={11,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","SecondAccentColor":"ff7035","BackgroundColor":"323232","OutlineColor":"191919"}')},
['Quartz']={12,ab:JSONDecode('{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","SecondAccentColor":"5a90b0","BackgroundColor":"1d1b26","OutlineColor":"27232f"}')},
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

local ad={"FontColor","MainColor","AccentColor","SecondAccentColor","BackgroundColor","OutlineColor"}
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
ad:AddLabel('2nd Accent'):AddColorPicker('SecondAccentColor',{Default=self.Library.SecondAccentColor});
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
local af={"FontColor","MainColor","AccentColor","SecondAccentColor","BackgroundColor","OutlineColor"}

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
"BackgroundColor","MainColor","AccentColor","SecondAccentColor","OutlineColor","FontColor",
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

local ar={
["Mainland"]=8,["Stable Island"]=1,
["Training Island"]=1,["Royal Island"]=1,
["Volcano Island"]=1,["Blizzard Island"]=1,
["Forest Island"]=1,["Desert Island"]=1,
["Glacier Island"]=1,["Mountain Island"]=1,
["Jungle Island"]=1,["Lunar Islands"]=1,
}

local as={
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

local at={
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

local b={
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




local c={
["Mainland"]=false,
["Blizzard Island"]=false,
["Forest Island"]=false,
["Royal Island"]=false,
["Desert Island"]=false,
["Glacier Island"]=false,
["Mountain Island"]=false,
["Jungle Island"]=false,
["Lunar Islands"]=false,
["Volcano Island"]=false
}
local d=false
local e=false
local f=false
local g=0




local h=7
local i=90
local j=math.rad(60)
local k=70
local l=120
local m=0.5
local n=2
local o=2.0
local p=0.6




local q=nil
local r=nil
local s=nil
local t=nil
local u=nil

local function v(w,x)
for y,z in ipairs(w:GetDescendants())do
if z:IsA("BasePart")then
z.CanCollide=not x
end
end
end




local w=RaycastParams.new()
w.FilterType=Enum.RaycastFilterType.Exclude
w.IgnoreWater=true




local function x()
if t then
local y=t.Parent
if y then v(y,false)end
end

if s then s:Disconnect();s=nil end
if r then r:Destroy();r=nil end
if q then q:Destroy();q=nil end
if t then
t.PlatformStand=false
t=nil
end
u=nil
end





local function y(z,A,B)
local C=workspace:Raycast(z,A.Unit*B,w)
if C and C.Instance then
local D=C.Instance
if D:IsA("Terrain")or(D:IsA("BasePart")and D.CanCollide)then
return true,C.Position
end
end
return false,nil
end



local function z(A,B,C)
local D=B.Position+Vector3.new(0,ai,0)
local E=D-A.Position
local F=E.Magnitude

if F<m then return Vector3.zero,F end

local G=E.Unit

local H={ae.Character}
if u then table.insert(H,u)end
w.FilterDescendantsInstances=H


local I,J=y(A.Position,G,math.min(F,i))

if not I then
return G*math.min(F*60,l),F
end


local K=J and J.Y or A.Position.Y
local L=Vector3.new(D.X,K+h,D.Z)
local M=(L-A.Position).Unit


if C then
local N=(M+C*0.8).Unit
return N*math.min(F*60,l),F
end


local N=Vector3.new(G.X,0,G.Z)
if N.Magnitude<0.01 then N=Vector3.new(1,0,0)end
N=N.Unit

local O,P=math.cos(j),math.sin(j)

local Q=Vector3.new(
N.X*O-N.Z*(-P),
0,
N.X*(-P)+N.Z*O
).Unit

local R=Vector3.new(
N.X*O-N.Z*P,
0,
N.X*P+N.Z*O
).Unit

local S=y(A.Position,Q,k)
local T=y(A.Position,R,k)

local U
if not S and T then
U=Q
elseif not T and S then
U=R
elseif not S and not T then
local V=Q:Dot(G)
local W=R:Dot(G)
U=(V>=W)and Q or R
else
U=nil
end

local V
if U then
V=(M+U*1.2).Unit
else
V=M
end

return V*math.min(F*60,l),F
end




local function A(B)
x()

local C=ae.Character
local D=C and C:FindFirstChild("HumanoidRootPart")
if not D then return end

u=B:FindFirstAncestorOfClass("Model")

local E=C:FindFirstChildOfClass("Humanoid")
if E then
E.PlatformStand=true
t=E
end
v(C,true)


q=Instance.new("Attachment")
q.Parent=D

r=Instance.new("LinearVelocity")
r.Attachment0=q
r.MaxForce=1e6
r.RelativeTo=Enum.ActuatorRelativeTo.World
r.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
r.VectorVelocity=Vector3.zero
r.Parent=D


local F=D.Position
local G=tick()
local H=nil
local I=0

s=ac.Heartbeat:Connect(function()
if not B or not B.Parent then
x()
return
end

local J=ae.Character and ae.Character:FindFirstChild("HumanoidRootPart")
if not J or not r then return end
v(ae.Character,true)
local K=tick()


local L=(J.Position-F).Magnitude
if L>n then
F=J.Position
G=K
if K>I then H=nil end
else
local M=K-G
if M>=o and K>I then
local N=B.Position-J.Position
local O=Vector3.new(N.X,0,N.Z)
if O.Magnitude>0.01 then
local P=O.Unit:Cross(Vector3.new(0,1,0)).Unit
H=(math.random(0,1)==0)and P or-P
I=K+p
G=K
end
end
end

local M=(K<=I)and H or nil

local N,O=z(J,B,M)
r.VectorVelocity=N
end)
end




local function B(C)
if not C then return end
local D=ar[C]or 1
pcall(function()ah.Travel(C,D)end)
end




local function C()
local D=workspace:FindFirstChild("Islands")
if not D then return nil end
for E,F in ipairs(D:GetChildren())do
if F:FindFirstChild(ae.Name)then return F end
end
return nil
end




local function D(E,F)
if not F then return end
if f then return end

local G=as[F.Name]
if not G or#G==0 then return end

local H=G[math.random(1,#G)].Position
local I=ae.Character
if not I then return end
local J=I:FindFirstChildOfClass("Humanoid")

f=true
g=tick()

local K=15

local L=r~=nil
local M,N=r,q
local O,P=nil,nil

if not L then
if J then J.PlatformStand=true end
P=Instance.new("Attachment")
P.Parent=E
O=Instance.new("LinearVelocity")
O.Attachment0=P
O.MaxForce=1e6
O.RelativeTo=Enum.ActuatorRelativeTo.World
O.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
O.VectorVelocity=Vector3.zero
O.Parent=E
M,N=O,P
end

local Q=40
local R=2

local function S()
if O then O:Destroy()end
if P then P:Destroy()end
if J and not L then J.PlatformStand=false end
f=false
end

local T
T=ac.Heartbeat:Connect(function()

if tick()-g>K then
T:Disconnect()
S()
return
end


local U=ae.Character
local V=U and U:FindFirstChild("HumanoidRootPart")

if not V or not M or not M.Parent then
T:Disconnect()
S()
return
end

local W=H-V.Position
local X=W.Magnitude

if X<R then
M.VectorVelocity=Vector3.zero
T:Disconnect()
S()
else
M.VectorVelocity=W.Unit*math.min(X*8,Q)
end
end)
end

local function E(F,G)
local H=nil
local I=math.huge

if e then
for J,K in ipairs(workspace:GetChildren())do
if K:IsA("Model")then
local L=K:FindFirstChild("HumanoidRootPart")
if L then
local M=(F.Position-L.Position).Magnitude
if M<I then I=M;H=L end
end
end
end
if H then return H end
end

for J,K in ipairs(G:GetDescendants())do
if K:IsA("Model")then
local L=K:FindFirstChild("HumanoidRootPart")
local M=K:FindFirstChild("CaptureProgress",true)
if L and M then
local N=(F.Position-L.Position).Magnitude
if N<I then I=N;H=L end
end
end
end

return H
end

local function F(G)
local H={}
for I,J in ipairs(aq)do
if c[J]then table.insert(H,J)end
end
if#H==0 then return nil end
if#H==1 then return H[1]end
for I,J in ipairs(H)do
if J==G then return H[(I%#H)+1]end
end
return H[1]
end




local function G()
local H=workspace:FindFirstChild("Islands")
if not H then return end
local I=H:FindFirstChild("Volcano Island")
if not I then return end
local J=I:FindFirstChild("LavaParts")
if not J then return end
for K,L in ipairs(J:GetDescendants())do
if L:IsA("TouchTransmitter")then L:Destroy()end
end
end

do
local H=nil
ac.Heartbeat:Connect(function()
local I=C()
if I and I.Name=="Volcano Island"and H~="Volcano Island"then
H="Volcano Island"
G()
elseif not I or I.Name~="Volcano Island"then
H=I and I.Name or nil
end
end)
task.spawn(function()
while true do G();task.wait(3)end
end)
end




do
local H=require(af.PlayerScripts.Secondary:WaitForChild("EquipmentHandler"))
task.spawn(function()
while true do
task.wait(tonumber(ao)or ak)
if not an then continue end
local I=H.object
if not I then continue end
local J=false
if I.controller and I.controller.GetTarget then
local K,L=pcall(I.controller.GetTarget,I)
J=K and L~=nil
elseif I.controller and I.controller.GetAnimals then
local K,L=pcall(I.controller.GetAnimals,I,true,true)
J=K and L and#L>0
else
J=true
end
if J then pcall(function()I:Activate()end)end
end
end)
end




do
local H=5

task.spawn(function()
local I=0
local J=nil
local K=false
local L=0
local M=0

local function N(O)
if not O then return false end
if not O.Parent then return false end
local P=O:FindFirstAncestorOfClass("Model")
if not P then return false end
if not P.Parent then return false end
return true
end

local function O()
x()
J=nil
M=0
end

local function P(Q)
if K then return end
K=true
I=0
L=0
O()
B(Q)
local R=tick()+30
repeat
task.wait(1)
local S=C()
if S and S.Name==Q then break end
until tick()>R
task.wait(2)
K=false
end

local function Q(R)
local S=C()
if not S then return end
D(R,S)
end

while true do
task.wait(0.4)



if f and tick()-g>20 then
f=false
end

if not am then
O()
I=0
L=0
continue
end

if K then continue end

local R=ae.Character
local S=R and R:FindFirstChild("HumanoidRootPart")
if not S then continue end

local T=C()
if not T then continue end

if d and not c[T.Name]then
local U=F(T.Name)
if U then P(U)end
continue
end


if J then
if N(J)then
M=0
else
M+=1
if M>=H then O()end
end
end


if not J then
local U=E(S,T)
if U then
J=U
M=0
A(J)
end
end

if J then
I=0
L=0
else
I+=1
L+=0.4

if d and L>=al then
local U=F(T.Name)
if U and U~=T.Name then
P(U)
else
Q(S)
L=0
I=0
end
continue
end

if I>=(tonumber(ap)or aj)then
Q(S)
I=0
end
end
end
end)
end







return{
autofarm_islands=c,
setEnabled=function(H)am=H end,
setWildherd=function(H)e=H end,
setAutotravel=function(H)d=H end,
setIsland=function(H,I)c[H]=I end,
setAutoclick=function(H)an=H end,
setClickDuration=function(H)ao=H end,
setIdleLimit=function(H)ap=H end,
}end function a.d():typeof(aa())local ab=a.cache.d if not ab then ab={c=aa()}a.cache.d=ab end return ab.c end end do local function aa()





local ab=a.a()

local ac=game:GetService("ReplicatedStorage")
local ad=game:GetService("Players")
local ae=game:GetService("RunService")

local af=require(ac:WaitForChild("References"))
local ah=af.Utilities
local ai=require(af.PlayerScripts.Priority:WaitForChild("Data"))
local aj=require(af.PlayerScripts.Priority:WaitForChild("InventoryHandler"))
local ak=ad.LocalPlayer








local al={

{id=401,name="Prismatic Lasso",strength=30,craftable=true},
{id=32,name="Perfect Lasso",strength=25,craftable=false},
{id=1349,name="Rescue Lasso",strength=25,craftable=false},
{id=31,name="Moonstone Lasso",strength=24,craftable=true},
{id=30,name="Obsidian Lasso",strength=22,craftable=true},
{id=29,name="Amethyst Lasso",strength=20,craftable=true},
{id=28,name="Emerald Lasso",strength=18,craftable=true},
{id=27,name="Topaz Lasso",strength=16,craftable=true},
{id=26,name="Sapphire Lasso",strength=14,craftable=true},
{id=25,name="Diamond Lasso",strength=12,craftable=true},
{id=1243,name="Ice Lasso",strength=11,craftable=true},
{id=24,name="Ruby Lasso",strength=10,craftable=true},
{id=325,name="Clear Quartz Lasso",strength=7,craftable=true},
{id=21,name="Iron Lasso",strength=7,craftable=true},
{id=22,name="Silver Lasso",strength=7,craftable=true},
{id=23,name="Gold Lasso",strength=8,craftable=true},
{id=20,name="Bronze Lasso",strength=6,craftable=true},
{id=19,name="Copper Lasso",strength=5,craftable=true},
{id=18,name="Tin Lasso",strength=4,craftable=true},
{id=191,name="Stone Lasso",strength=3,craftable=true},
{id=17,name="Wooden Lasso",strength=2,craftable=true},
{id=1029,name="Corrupt Lasso",strength=20,craftable=false},
{id=1163,name="Lasso",strength=1,craftable=false},
}


local am={}
for an,ao in ipairs(al)do
am[ao.id]=an
end







local an={
[17]={{id=102,qty=1},{id=70,qty=1}},
[18]={{id=102,qty=1},{id=35,qty=3}},
[19]={{id=102,qty=1},{id=34,qty=3}},
[20]={{id=102,qty=1},{id=36,qty=3}},
[21]={{id=102,qty=1},{id=37,qty=3}},
[22]={{id=102,qty=1},{id=38,qty=3}},
[23]={{id=102,qty=1},{id=39,qty=3}},
[24]={{id=102,qty=1},{id=40,qty=2}},
[25]={{id=102,qty=1},{id=41,qty=2}},
[26]={{id=102,qty=1},{id=42,qty=2}},
[27]={{id=102,qty=1},{id=43,qty=2}},
[28]={{id=102,qty=1},{id=44,qty=2}},
[29]={{id=102,qty=1},{id=45,qty=2}},
[30]={{id=102,qty=1},{id=46,qty=2}},
[31]={{id=102,qty=1},{id=47,qty=2}},
[191]={{id=102,qty=1},{id=33,qty=3}},
[325]={{id=102,qty=1},{id=323,qty=3}},
[401]={{id=102,qty=1},{id=381,qty=2}},
[1243]={{id=102,qty=1},{id=1238,qty=2}},
}






local ao={
[102]={shop="Mainland Shop",slot=1},
[70]={shop="Mainland Shop",slot=8},
[33]={shop="Mainland Shop",slot=9},
[35]={shop="Mainland Shop",slot=10},
[34]={shop="Blizzard Island Shop",slot=8},
[36]={shop="Blizzard Island Shop",slot=9},
[37]={shop="Forest Island Shop",slot=8},
[38]={shop="Forest Island Shop",slot=9},
[39]={shop="Desert Island Shop",slot=8},
[40]={shop="Desert Island Shop",slot=9},
[41]={shop="Mountain Island Shop",slot=8},
[42]={shop="Mountain Island Shop",slot=9},
[43]={shop="Jungle Island Shop",slot=9},
[44]={shop="Jungle Island Shop",slot=10},
[45]={shop="Jungle Island Shop",slot=11},
[46]={shop="Lunar Islands Shop",slot=8},
[47]={shop="Lunar Islands Shop",slot=9},
[323]={shop="Royal Island Shop",slot=7},
[381]={shop="Volcano Island Shop",slot=7},
[1238]={shop="Glacier Island Shop",slot=6},
}




local ap={
autoEquipEnabled=false,
autoCraftEnabled=false,
selectedLassoId=191,
restockThreshold=50,
restockAmount=100,
pollInterval=0.5,
craftPollInterval=3,
buyCooldown=0.4,
craftCooldown=1.0,
confirmTimeout=5,
confirmInterval=0.1,
}

local aq=250
local ar=1000




local as=false
local at=false
local b=0
local c=0.8
local d=1.2
local e=0.05
local f=3




local function g(h)
local i,j=pcall(aj.GetAmountOf,h)
return(i and tonumber(j))or 0
end

local function h()
return ai.GetLocal({"quickEquipment","Lasso"})
end

local function i()
return ai.GetLocal({"temporary","equippedEquipment"})
end

local function j()
local k=h()
if not k then return false end
return tostring(i())==tostring(k)
end






local function k()
for l,m in ipairs(al)do
if g(m.id)>0 then
return m.id
end
end
return 1163
end






local function l()
ah.Network:FireServer("QuickEquipment","Use","Lasso")
local m=tick()+d
while tick()<m do
task.wait(e)
if j()then return true end
end
return false
end

local function m(n)


local o=aj.GetGuidsOfItemId(n)
if not o or#o==0 then return false end

ah.Network:FireServer("QuickEquipment","Set","Lasso",o[1])
task.wait(0.3)
return true
end

local function n()
if not ap.autoEquipEnabled then return end
if as then return end

local o=k()
local p=h()


local q=p and aj.GetGuidsOfItemId(o)
local r=q and table.find(q,p)~=nil


if j()and r then return end

local s=tick()
if(s-b)<c then return end


if not r then
local t=m(o)
if not t then return end
end

as=true
b=tick()

local t,u=pcall(function()
for t=1,f do
if l()then break end
task.wait(c*t)
end
end)

if not t then warn("[AutoLasso] Equip error:",u)end
as=false
end




local function o(p,q)
local r=tick()+ap.confirmTimeout
while tick()<r do
task.wait(ap.confirmInterval)
if g(p)>q then return true end
end
return false
end

local function p(q,r)
local s=ao[q]
if not s then
warn(string.format("[AutoLasso] No shop source for material id=%d",q))
return 0
end

r=math.min(r,ar)
if r<=0 then return 0 end

local t=g(q)
ah.Network:FireServer("Shopping","BuyShopItem",s.shop,s.slot,r,nil)

local u=o(q,t)
if not u then
warn(string.format("[AutoLasso] Buy timed out id=%d shop=%s slot=%d qty=%d",
q,s.shop,s.slot,r))
return 0
end
return g(q)-t
end

local function q(r,s)
s=math.min(s,aq)
if s<=0 then return 0 end

local t=g(r)
ah.Network:FireServer("Crafting","Craft",{
id=r,
variants={},
amt=s,
})

local u=o(r,t)
if not u then
warn(string.format("[AutoLasso] Craft timed out id=%d qty=%d",r,s))
return 0
end
return g(r)-t
end

local function r(s,t)
local u=an[s]
if not u then
warn(string.format("[AutoLasso] No recipe for lasso id=%d",s))
return
end

t=math.min(t,aq)


for v,w in ipairs(u)do
local x=w.qty*t
local y=g(w.id)
local z=math.max(0,x-y)
if z>0 then
local A=p(w.id,z)
if A<z then
warn(string.format("[AutoLasso] Material short: id=%d needed=%d got=%d",
w.id,z,A))
end
task.wait(ap.buyCooldown)
end
end


local v=t
for w,x in ipairs(u)do
local y=g(x.id)
local z=math.floor(y/x.qty)
v=math.min(v,z)
end

v=math.min(v,aq)
if v<=0 then
warn("[AutoLasso] No materials to craft after buying — aborting.")
return
end

task.wait(ap.craftCooldown)

local w=q(s,v)
if w>0 then
library:Notify("Crafted %d lasso (id=%d)",w,2)


local x=k()
local y=am[s]or 999
local z=am[x]or 999
if y<=z then
m(s)
task.wait(0.3)
ah.Network:FireServer("QuickEquipment","Use","Lasso")
end
else
warn("[AutoLasso] Craft fired but no lassos received.")
end
end






task.spawn(function()
while true do
task.wait(ap.pollInterval)
n()
end
end)


task.spawn(function()
while true do
task.wait(ap.craftPollInterval)

if not ap.autoCraftEnabled then continue end
if at then continue end

local s=ap.selectedLassoId
local t=g(s)

if t<=ap.restockThreshold then
at=true
local u,v=pcall(r,s,ap.restockAmount)
if not u then warn("[AutoLasso] Restock error:",v)end
at=false
end
end
end)


ak.CharacterAdded:Connect(function()
task.wait(1.5)
as=false
b=0
at=false
end)




return{

setEnabled=function(s)
ap.autoEquipEnabled=s
if not s then
as=false
end
end,


setCraftEnabled=function(s)
ap.autoCraftEnabled=s
if not s then at=false end
end,


setSelectedLasso=function(s)
ap.selectedLassoId=tonumber(s)or 191
end,


setRestockThreshold=function(s)
ap.restockThreshold=tonumber(s)or 50
end,


setRestockAmount=function(s)
ap.restockAmount=math.min(tonumber(s)or 100,aq)
end,


getCraftableLassos=function()
local s={}
for t,u in ipairs(al)do
if u.craftable then
table.insert(s,{id=u.id,name=u.name,strength=u.strength})
end
end
return s
end,


getStatus=function()
local s=k()
return{
autoEquipEnabled=ap.autoEquipEnabled,
autoCraftEnabled=ap.autoCraftEnabled,
isCycleRunning=at,
bestLassoId=s,
bestLassoName=(function()
for t,u in ipairs(al)do
if u.id==s then return u.name end
end
return"Unknown"
end)(),
selectedCraftId=ap.selectedLassoId,
selectedCraftCount=g(ap.selectedLassoId),
threshold=ap.restockThreshold,
}
end,


triggerRestock=function()
if at then return end
at=true
local s,t=pcall(r,ap.selectedLassoId,ap.restockAmount)
if not s then warn("Manual restock error:",t)end
at=false
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
"summer2026",
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
if(am.hornStyle and am.hornStyle~="")
or(am.hornColour and am.hornColour~="")then
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
local an=am.maneColour
local ao=am.tailColour
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
ap=an.Bind("Added",function(as,at)
if not ao then return end

local b,c=ak(at)

task.delay(aj,function()
if not ao then return end

if b then
am:FireServer("Inventory","Lock",as)
sendLockWebhook(as,at,c)
ad.recordLock()
else
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
for as,at in ipairs(ae)do
ar[at]=af[at]==true
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
local function ab(ac,ad)
local ae=game:GetService("ReplicatedStorage")
local af=game:GetService("RunService")
local ah=game:GetService("Players")
local ai=ah.LocalPlayer
local aj=workspace.CurrentCamera
local ak=game:GetService("VirtualInputManager")

local al=require(ae.References)
local am=al.Utilities
local an=require(al.PlayerScripts.Priority.Data)

local ao={
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


local ap=false
local aq=false
local ar=false
local as=0.05
local at=5
local b=false
local c=false
local d=false
local e=false

local f={
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

local g={
"Rock","Tin Rock","Copper Rock","Bronze Rock","Iron Rock",
"Random Crystal","Random Rock","Silver Rock","Gold Rock",
"Ruby Crystal","Frozen Crystal","Clear Quartz Crystal",
"Archaeological Deposit","Diamond Crystal","Sapphire Crystal",
"Topaz Crystal","Amethyst Crystal","Emerald Crystal",
"Obsidian Rock","Moonstone Rock","Prismatic Crystal","Erupted Deposit",
}

local h="itemName"
local i="health"

local j=Vector3.zero
local k=tick()


local l=Instance.new("Highlight")
l.FillColor=Color3.fromRGB(0,255,255)
l.OutlineColor=Color3.fromRGB(255,255,255)
l.FillTransparency=0.5
l.OutlineTransparency=0
l.Parent=game:GetService("CoreGui")
l.Enabled=false


local m=Instance.new("Attachment")
local n=Instance.new("LinearVelocity")
n.Attachment0=m
n.MaxForce=1e6
n.RelativeTo=Enum.ActuatorRelativeTo.World
n.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
n.VectorVelocity=Vector3.zero

local o=120
local p=1.5

local function q(r)
if m.Parent~=r then
m.Parent=r
n.Parent=r
end
end

local function r()
n.VectorVelocity=Vector3.zero
m.Parent=nil
n.Parent=nil
end





local s=nil

local function t()
local u=ai.Character
if not u then return end
for v,w in ipairs(u:GetDescendants())do
if w:IsA("BasePart")then
w.CanCollide=false
end
end
end

local function u()
local v=ai.Character
if not v then return end
for w,x in ipairs(v:GetDescendants())do
if x:IsA("BasePart")then
x.CanCollide=true
end
end
end

local function v(w)
e=w
if w then
if not s then
s=af.Stepped:Connect(function()
if e then
t()
end
end)
end
else
if s then
s:Disconnect()
s=nil
end
u()
end
end


ai.CharacterAdded:Connect(function()
if e then
task.wait(0.1)
t()
end
end)


local function w()
pcall(function()
if not b then return end
local x=an.GetLocal({"quickEquipment","Harvester"})
if not x then return end
if not c then
c=true
am.Network:FireServer("QuickEquipment","Use","Harvester")
end
end)
end

local function x()
c=false
task.wait(1.5)
w()
end

an.BindLocal({"temporary","equippedEquipment"},function()
local y=an.GetLocal({"quickEquipment","Harvester"})
local z=an.GetLocal({"temporary","equippedEquipment"})
if z~=y then
c=false
task.wait(0.1)
w()
end
end,true)

if ai.Character then x()end
ai.CharacterAdded:Connect(x)


local function y()
local z=workspace:FindFirstChild("Islands")
if not z then return nil end
for A,B in ipairs(z:GetChildren())do
if B:FindFirstChild(ai.Name)then return B end
end
return nil
end

local function z(A)
local B,C=aj:WorldToViewportPoint(A)
return B.X,B.Y,C
end

local function A(B)
aj.CFrame=CFrame.new(aj.CFrame.Position,B.Position)
local C,D,E=z(B.Position)
if not E then return false end
pcall(function()
ak:SendMouseMoveEvent(C,D,game)
ak:SendMouseButtonEvent(C,D,0,true,game,1)
task.wait(0.05)
ak:SendMouseButtonEvent(C,D,0,false,game,1)
end)
return true
end

local function B(C)
local D=ai.Character and ai.Character:FindFirstChild("HumanoidRootPart")
if not D then return nil end
local E,F=nil,math.huge
for G,H in ipairs(C:GetDescendants())do
local I=H:GetAttribute(h)
if H:IsA("Model")and f[I]==true then
local J=H:GetAttribute(i)
if J and J>0 then
local K=H.PrimaryPart or H:FindFirstChildWhichIsA("BasePart")
if K then
local L=(D.Position-K.Position).Magnitude
if L<F then
F=L
E=H
end
end
end
end
end
return E
end


task.spawn(function()
while true do
task.wait(1)
if not ap or not ar or d then
k=tick()
continue
end
local C=ai.Character
local D=C and C:FindFirstChild("HumanoidRootPart")
if not D then continue end
if(D.Position-j).Magnitude>2 then
j=D.Position
k=tick()
elseif tick()-k>at then
local E=y()
if E then
local F=(E.Name=="Volcano Island")
and ao
or(ad and ad[E.Name])
if F and#F>0 then
local G=ai.Character and ai.Character:FindFirstChild("HumanoidRootPart")
if G then
G.CFrame=F[math.random(1,#F)]
end
end
end
k=tick()
end
end
end)


local C=nil

local function D()
if C then
C:Disconnect()
C=nil
end
r()
d=false
l.Enabled=false
end

task.spawn(function()
while true do
task.wait(0.3)

if not ap then
D()
continue
end

local E=y()
if not E then continue end

local F=B(E)
if not F then
D()
continue
end

local G=F.PrimaryPart or F:FindFirstChildWhichIsA("BasePart")
if not G then continue end

if aq then
l.Adornee=F
l.Enabled=true
end

local H=F:GetAttribute(h)=="Erupted Deposit"
local I=H and Vector3.new(0,10,0)or Vector3.new(0,2,2)

D()

aj.CFrame=CFrame.new(aj.CFrame.Position,G.Position)

if H then
task.wait(3)
if not F.Parent or(F:GetAttribute(i)or 0)<=0 then continue end
end

d=true
C=af.Heartbeat:Connect(function()
local J=ai.Character and ai.Character:FindFirstChild("HumanoidRootPart")
if not J then D();return end

if not F or not F.Parent or(F:GetAttribute(i)or 0)<=0 then
D()
return
end

local K=G.Position+I
q(J)

local L=K-J.Position
local M=L.Magnitude

if M<=p then
n.VectorVelocity=Vector3.zero
else
n.VectorVelocity=L.Unit*math.min(M*10,o)
end

aj.CFrame=CFrame.new(aj.CFrame.Position,G.Position)
end)

local J=F:GetAttribute(i)

while ap
and F.Parent
and(F:GetAttribute(i)or 0)>0
and f[F:GetAttribute(h)]==true
do
A(G)

local K=tick()
while tick()-K<5 do
task.wait(0.05)
if not F.Parent or(F:GetAttribute(i)or 0)<=0 then break end
local L=F:GetAttribute(i)
if L~=J then
J=L
break
end
end

if as>0 then
task.wait(as)
end
end

D()
end
end)


return{
setEnabled=function(E)
ap=E
if not E then D()end
end,
setPickaxeEnabled=function(E)
b=E
if E then w()end
end,
isEnabled=function()return ap end,
setHighlight=function(E)
aq=E
if not E then l.Enabled=false end
end,
setRandomTeleport=function(E)ar=E end,
setIdleThreshold=function(E)at=tonumber(E)or 5 end,
setClickCooldown=function(E)as=tonumber(E)or 0.05 end,
setOreTarget=function(E,F)
if f[E]~=nil then f[E]=F end
end,
getOreValues=function()return g end,
setNoclip=function(E)v(E)end,
isNoclipEnabled=function()return e end,
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
local at=as:FindFirstChild("HumanoidRootPart")
local b=as:FindFirstChildOfClass("Humanoid")

if at and b and(
as:FindFirstChildWhichIsA("AlignPosition")or
as:FindFirstChildWhichIsA("AlignOrientation")
)then
local c=(al.Position-at.Position).Magnitude
if c<ao then
ao=c
an=b
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


local ap,aq,ar,as,at,b

local function c()
if aq then return true end

local d=game:GetService("ReplicatedStorage")
local e,f=pcall(require,d.References)
if not e then warn("[CC] References not found:",f);return false end

ap=f
aq=ap.Utilities.Network
ar=ap.Utilities.Time

local g=ao.PlayerScripts:FindFirstChild("RidingHandler",true)
if not g then warn("[CC] RidingHandler not found");return false end
as=require(g)

local h=ao.PlayerScripts:FindFirstChild("CheckpointActivityHandler",true)
if not h then warn("[CC] CheckpointActivityHandler not found");return false end
at=require(h)

local i,j=pcall(function()
return workspace.Islands["Training Island"]["Cross Country"].CheckpointActivity
end)
if not i then warn("[CC] CheckpointActivity model not found:",j);return false end
b=j

return true
end


local d={"Collision","BallCollision","HumanoidRootPart"}
local e={"LowerTorso","UpperTorso"}
local f={}

local function g(h)
for i,j in f do pcall(function()j:Disconnect()end)end
f={}
if not ak or not h then return end

for i,j in d do
local k=h.instance:FindFirstChild(j,true)
if k and k:IsA("BasePart")then
k.CanCollide=false
table.insert(f,k:GetPropertyChangedSignal("CanCollide"):Connect(function()
if ak and k.CanCollide then k.CanCollide=false end
end))
end
end

local i=ao.Character
if i then
for j,k in e do
local l=i:FindFirstChild(k,true)
if l and l:IsA("BasePart")then
l.CanCollide=false
table.insert(f,l:GetPropertyChangedSignal("CanCollide"):Connect(function()
if ak and l.CanCollide then l.CanCollide=false end
end))
end
end
end
end

local function h(i)
for j,k in f do pcall(function()k:Disconnect()end)end
f={}
if not i then return end
for j,k in d do
local l=i.instance:FindFirstChild(k,true)
if l and l:IsA("BasePart")then l.CanCollide=true end
end
local j=ao.Character
if j then
for k,l in e do
local m=j:FindFirstChild(l,true)
if m and m:IsA("BasePart")then m.CanCollide=true end
end
end
end


local function i(j)
local k=Instance.new("Attachment")
k.Parent=j
local l=Instance.new("LinearVelocity")
l.Attachment0=k
l.MaxForce=1e6
l.RelativeTo=Enum.ActuatorRelativeTo.World
l.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
l.VectorVelocity=Vector3.zero
l.Parent=j
return l,k
end


local function j()
return as and as.GetCurrentMount and as.GetCurrentMount()
end

local function k(l)
return l and l.instance and l.instance:FindFirstChild("HumanoidRootPart")
end

local function l()
local m={}
for n,o in workspace:GetDescendants()do
if o:IsA("Part")
and o.Shape==Enum.PartType.Ball
and o.Transparency==1
and o.Anchored
and not o.CanCollide
and o:FindFirstChildOfClass("TouchTransmitter")
and o:GetFullName():find("Cross Country")then
table.insert(m,o)
end
end
local n=workspace:FindFirstChild("Part")
if n and n:IsA("Part")and n:FindFirstChildOfClass("TouchTransmitter")then
table.insert(m,n)
end
return m
end

local function m(n,o)
local p,q=nil,math.huge
for r,s in o do
local t=(s.Position-n).Magnitude
if t<q then p,q=s,t end
end
return p,q
end

local function n(o,p)
if p:FindFirstChildOfClass("TouchTransmitter")then
firetouchinterest(o,p,0)
end
end


local o,p,q,r,s,t
local u=false

local function v()
u=false
if q then pcall(function()q:Disconnect()end);q=nil end
if r then pcall(function()r:Disconnect()end);r=nil end
if o then
pcall(function()o.VectorVelocity=Vector3.zero;o:Destroy()end)
o=nil
end
if p then
pcall(function()p:Destroy()end)
p=nil
end
h(t)
t=nil
print("[CC] Stopped.")
end

local function w()
aq:FireServer("CheckpointActivity","TriggerInteractable",b)
print("[CC] TriggerInteractable fired")
task.wait(2)
s=0
end

local function x()
if u then return end
if not c()then
warn("[CC] Cannot start — refs failed to resolve")
return
end

local y=j()
if not y then warn("[CC] Mount up before enabling");return end
local z=k(y)
if not z then warn("[CC] No HumanoidRootPart on mount");return end

t=y
u=true
s=0
o,p=i(z)

g(y)
w()


r=at.ActivityChanged:Connect(function()
if not u then return end
task.wait(0.3)
if at.currentObject==nil then
print("[CC] Activity ended — restarting in",aj,"s")
if o then o.VectorVelocity=Vector3.zero end
task.wait(aj)
if u and ac then
local A=j()
if A then g(A)end
w()
end
end
end)


q=am.Heartbeat:Connect(function()
if not ac or not u then
if o then o.VectorVelocity=Vector3.zero end
return
end

local A=j()
if not A then if o then o.VectorVelocity=Vector3.zero end;return end
local B=k(A)
if not B then if o then o.VectorVelocity=Vector3.zero end;return end


local C=os.clock()
if C-s>=ai then
s=C
A.lastTimeJumped=ar.Get()
end

local D=B.Position
local E=l()
local F,G=m(D,E)

if not F then
if o then o.VectorVelocity=Vector3.zero end
return
end

if al then
print(string.format("[CC] %s | %.1f studs",F.Name,G))
end

local H=F.Position
local I=G<=af and ae or 0
local J=(Vector3.new(H.X,H.Y+I,H.Z)-D).Unit
o.VectorVelocity=J*ad

if G<=ah then
n(B,F)
end
end)

print("[CC] Running.")
end


return{
setEnabled=function(y)
ac=y
if y and not u then
x()
elseif not y and u then
v()
end
end,

setNoclip=function(y)
ak=y
if u then
local z=j()
if y then g(z)else h(z)end
end
end,

setMoveSpeed=function(y)ad=y end,
setYBias=function(y)ae=y end,
setCloseDist=function(y)af=y end,
setTriggerDist=function(y)ah=y end,
setJumpInterval=function(y)ai=y end,
setRetriggerDelay=function(y)aj=y end,
setDebug=function(y)al=y end,
stop=v,
}
end

return ab end function a.l():typeof(aa())local ab=a.cache.l if not ab then ab={c=aa()}a.cache.l=ab end return ab.c end end do local function aa()




local ab=a.a()







local function ac()


local ad=false
local ae=45
local af=47
local ah=15
local ai=true


local aj=game:GetService("Players")
local ak=aj.LocalPlayer


local al=false
local am=nil


local an,ao

local function ap()
if an then return true end

local aq,ar=pcall(require,game:GetService("ReplicatedStorage").References)
if not aq then
warn("[WAL] References failed:",ar)
return false
end



an=ar.Utilities.Network

local as,at=pcall(function()
return workspace.Islands["Carnival Island"].Pier.Games["Whack A Larry"]["Whack a Larry Minigame"]
end)
if not as or not at then
warn("[WAL] Game object not found:",at)
ab:Notify("Game object not found:",at,2)
return false
end

ao=at
return true
end


local function aq()
if ai then end

local ar,as=pcall(function()
return an:InvokeServer("Minigame","Play",ao,nil)
end)

if not ar then
warn("[WAL] Play error:",as)
return false
end

if not as then
if ai then end
return false
end

if ai then ab:Notify("Play Accepted - waiting",ae,2)end


local at=0
while at<ae do
if not al or not ad then return false end
task.wait(0.5)
at+=0.5
end

if not al or not ad then return false end

if ai then print("[WAL] Invoking End(true,",ah,")")end



local b,c=pcall(function()
return an:InvokeServer("Minigame","End",true,ah)
end)

if not b then
warn("[WAL] End error:",c)
elseif ai then

end

return true
end


local function ar()
al=true

am=task.spawn(function()
while al and ad do
local as=aq()
if not al or not ad then break end

if as then
if ai then print("[WAL] Cooldown:",af,"s")end
local at=0
while at<af do
if not al or not ad then break end
task.wait(0.5)
at+=0.5
end
else

task.wait(5)
end
end

al=false
if ai then end
end)
end

local function as()
al=false
am=nil
end


return{
setEnabled=function(at)
ad=at
if at and not al then
if not ap()then
warn("[WAL] Cannot start — refs failed")
ad=false
return
end
ar()
elseif not at and al then
as()
end
end,

setGameDuration=function(at)ae=at end,
setLoopCooldown=function(at)af=at end,
setClaimedScore=function(at)ah=at end,
setDebug=function(at)ai=at end,
stop=as,
}
end

return ac end function a.m():typeof(aa())local ab=a.cache.m if not ab then ab={c=aa()}a.cache.m=ab end return ab.c end end do local function aa()









local function ab()


local ac=false
local ad=0.15
local ae=0.5
local af=3
local ah=0.3
local ai=30
local aj=8
local ak=0.1
local al=120
local am=1.5
local an=false
local ao=false


local ap=game:GetService("RunService")
local aq=game:GetService("Players")
local ar=game:GetService("VirtualUser")
local as=aq.LocalPlayer
local at=workspace.CurrentCamera


local b=false
local c=nil
local d=false
local e=0
local f={}


local g,h,i,j

local function k()
if h then return true end

local l,m=pcall(require,game:GetService("ReplicatedStorage").References)
if not l then warn("[AT] References failed:",m);return false end
g=m
h=g.Utilities

local n=as.PlayerScripts:FindFirstChild("Data",true)
if not n then warn("[AT] Data not found");return false end
local o,p=pcall(require,n)
if not o then warn("[AT] Data require failed:",p);return false end
i=p

local q=as.PlayerScripts:FindFirstChild("CharacterHandler",true)
if not q then warn("[AT] CharacterHandler not found");return false end
local r,s=pcall(require,q)
if not r then warn("[AT] CharacterHandler require failed:",s);return false end
j=s

return true
end


local l={"LowerTorso","UpperTorso","HumanoidRootPart"}

local function m()
for n,o in f do pcall(function()o:Disconnect()end)end
f={}
if not an then return end

local n=as.Character
if not n then return end

for o,p in l do
local q=n:FindFirstChild(p,true)
if q and q:IsA("BasePart")then
q.CanCollide=false
table.insert(f,q:GetPropertyChangedSignal("CanCollide"):Connect(function()
if an and q.CanCollide then
q.CanCollide=false
end
end))
end
end
end

local function n()
for o,p in f do pcall(function()p:Disconnect()end)end
f={}

local o=as.Character
if not o then return end
for p,q in l do
local r=o:FindFirstChild(q,true)
if r and r:IsA("BasePart")then r.CanCollide=true end
end
end


as.CharacterAdded:Connect(function()
task.wait(1.5)
d=false
e=0
if an then m()end
end)


local function o(p)
local q=as.Character
if not q then return end
local r=q:FindFirstChild("HumanoidRootPart")
if not r then return end

local s=q:FindFirstChildOfClass("Humanoid")
if s then s.PlatformStand=true end

local t=Instance.new("Attachment")
t.Parent=r

local u=Instance.new("LinearVelocity")
u.Attachment0=t
u.MaxForce=1e6
u.RelativeTo=Enum.ActuatorRelativeTo.World
u.VelocityConstraintMode=Enum.VelocityConstraintMode.Vector
u.VectorVelocity=Vector3.zero
u.Parent=r

local v=false

local w=ap.Heartbeat:Connect(function()
local w=as.Character and as.Character:FindFirstChild("HumanoidRootPart")
if not w or not u.Parent then v=true;return end

local x=p-w.Position
local y=x.Magnitude

if y<am then
u.VectorVelocity=Vector3.zero
v=true
else
u.VectorVelocity=x.Unit*math.min(y*8,al)
end
end)

local x=tick()+8
while not v and tick()<x do
task.wait(0.05)
end

w:Disconnect()
u:Destroy()
t:Destroy()
if s then s.PlatformStand=false end


if an then m()end
end

local function p(q)
o(q+Vector3.new(0,4,0))
end


local function q()
if d then return end
local r=tick()
if(r-e)<ae then return end

local s,t=pcall(function()
local s=i.GetLocal({"quickEquipment","Tool"})
if not s then return end

local t=i.GetLocal({"temporary","equippedEquipment"})
if tostring(t)==tostring(s)then return end

d=true
e=tick()

for u=1,af do
h.Network:FireServer("QuickEquipment","Use","Tool")
task.wait(ah)
local v=i.GetLocal({"temporary","equippedEquipment"})
if tostring(v)==tostring(s)then break end
end

d=false
end)

if not s then
d=false
warn("[AT] equipShovel error:",t)
end
end

local function r()
pcall(function()
h.Network:FireServer(
"Inventory","Use",
i.GetLocal({"quickEquipment","Tool"}),
"Unequip"
)
end)
task.wait(0.4)
d=false
e=0
q()
task.wait(0.4)
end


local function s()
local t,u=pcall(function()
return h.Network:InvokeServer("BuriedTreasure","GetPoint")
end)
if t and u then return u end
return nil
end



local function t(u)
pcall(function()
local v=at.ViewportSize
local w=Vector2.new(v.X/2,v.Y/2)
for x=1,u do
ar:ClickButton1(w,at.CFrame)
task.wait(ak)
end
end)
end


local function u()
b=true

if an then m()end

c=task.spawn(function()
while b and ac do
task.wait(ad)


q()
task.wait(0.6)


local v=nil
local w=0

while not v and w<10 do
if not b or not ac then break end
v=s()
if not v then
w+=1
r()
task.wait(0.5)
end
end

if not v then
if ao then print("[AT] No treasure point found — retrying")end
task.wait(1)
continue
end

if ao then print("[AT] Treasure at",tostring(v))end


p(v)


if not j.object:InRange(v,ai)then
if ao then print("[AT] Not in range — re-teleporting")end
p(v)
end


r()
r()
task.wait(0.3)


t(aj)
task.wait(1.5)


r()
task.wait(1)
end

b=false
if ao then print("[AT] Loop exited.")end
end)
end

local function v()
b=false
c=nil
n()
print("[AT] Stopped.")
end


return{
setEnabled=function(w)
ac=w
if w and not b then
if not k()then
warn("[AT] Cannot start — refs failed")
ac=false
return
end
u()
elseif not w and b then
v()
end
end,

setNoclip=function(w)
an=w
if b then
if w then m()else n()end
end
end,

setDigClicks=function(w)aj=w end,
setDigClickDelay=function(w)ak=w end,
setDigRange=function(w)ai=w end,
setTeleSpeed=function(w)al=w end,
setPollInterval=function(w)ad=w end,
setEquipCooldown=function(w)ae=w end,
setDebug=function(w)ao=w end,
stop=v,
}
end

return ab end function a.n():typeof(aa())local ab=a.cache.n if not ab then ab={c=aa()}a.cache.n=ab end return ab.c end end end

local aa=os.clock()
local ab=a.a()
local ac=a.b()
local ad=a.c()
local ae=a.d()
local af=a.e()
local ah=a.f()
local ai=a.h()
local aj=a.i()
local ak=aj(m_References,IslandTeleports)
local al=a.j()
local am=a.k()
local an=a.g()
local ao=a.l()
local ap=ao()
local aq=a.m()
local ar=aq()
local as=a.n()
local at=as()

local b=getgenv().Options
local c=getgenv().Toggles

ab.ShowToggleFrameInKeybinds=true
ab.ShowCustomCursor=true
ab.NotifySide="Left"

local d=ab:CreateWindow({









Title="coconut.xyz",
Center=true,
AutoShow=true,
Resizable=true,
ShowCustomCursor=true,
UnlockMouseWhileOpen=true,
NotifySide="Left",
TabPadding=8,
Size=UDim2.new(0,558,0,482),
MenuFadeTime=0.2
})

local e=game:GetService("Players").LocalPlayer
local f=game:GetService("VirtualUser")

e.Idled:Connect(function()
f:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
f:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)







local g={

IlovemyWife=d:AddTab("Home"),
Main=d:AddTab("Automation"),
HorseRender=d:AddTab("Render"),
Misc=d:AddTab("Misc"),
["UI Settings"]=d:AddTab("UI Settings"),
}

local h=g.IlovemyWife:AddLeftGroupbox("Information")

local i=g.IlovemyWife:AddRightGroupbox("Session Information")

local j=tick()
local k=i:AddLabel('Time Played: 0s')

task.spawn(function()
while true do
task.wait(1)

local l=math.floor(tick()-j)

local m=math.floor(l/3600)
local n=math.floor((l%3600)/60)
local o=l%60

k:SetText(string.format(
"Time Played: %02dh %02dm %02ds",
m,n,o
))
end
end)

local l=i:AddLabel('Coins Earned: 0')

task.spawn(function()
while true do
task.wait(2)
local m=ai.getStats()
l:SetText(string.format("Coins Earned: %d",m.coins))
end
end)

local m=i:AddLabel('Horses Captured: 0')

task.spawn(function()
while true do
task.wait(2)
local n=ai.getStats()
m:SetText(string.format("Horses Captured: %d",n.captures))
end
end)

local n=g.Main:AddLeftTabbox()

local o=n:AddTab("Horses")
local p=n:AddTab("Sell")
local q=n:AddTab("Lassos")

o:AddToggle('Autofarm_Enable',{
Text='Enable',
Default=false,
Tooltip='Enables Autofarm',

Callback=function(r)
ae.setEnabled(r)
end
})

o:AddToggle('CatureHerds',{
Text='Capture Herds',
Default=false,
Tooltip='Enables Capture Herds',

Callback=function(r)
ae.setWildherd(r)
end
})

o:AddToggle("AutoLasso",{
Text="Lasso",
Default=false,
Tooltip="sloppy joe",
Callback=function(r)
af.setEnabled(r)
end,
})

o:AddToggle('AutoCapture',{
Text='Capture',
Default=false,
Tooltip='Clicks the horse to capture',

Callback=function(r)
ah.setEnabled(r)
end
})

o:AddSlider('CaptureRate',{
Text='Capture Rate',
Default=0.1,
Min=0.05,
Max=5,
Rounding=2,
Compact=true,
HideMax=true,

Callback=function(r)
ah.setDuration(r)
end
})

o:AddToggle('autotravel',{
Text='Travel',
Default=false,
Tooltip='type shit',

Callback=function(r)
ae.setAutotravel(r)
end
})


local r=ae.autofarm_islands or{}
local s={}


for t,u in pairs(r)do
table.insert(s,t)
end


o:AddDropdown("IslandSelection",{
Text="Select Islands",
Values=s,
Default={},
Multi=true,
Tooltip="Select Islands type shit",

Callback=function(t)
for u,v in pairs(t)do
ae.setIsland(u,v)
end
end,

Disabled=false,
Visible=true,
})

p:AddToggle('Autosell',{
Text='Auto Sell',
Default=false,
Tooltip='Automatically sells horses',

Callback=function(t)
ai.setEnabled(t)
end
})

local t={
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
["Summer 2026"]="summer2026"
}


local u={}
for v,w in pairs(t)do
u[w]=v
end


local v={}
for w,x in pairs(t)do
table.insert(v,w)
end
table.sort(v)

p:AddDropdown("FilterTypeDropdown",{
Text="Filter",
Values=v,
Default=0,
Multi=true,
Tooltip="Select which horse types to lock instead of sell",

Callback=function(w)

for x,y in pairs(t)do
ai.setLockOption(y,false)
end


for x,y in pairs(w)do
if y then
local z=t[x]
if z then
ai.setLockOption(z,true)
end
end
end
end,

Disabled=false,
Visible=true,
})

p:AddDivider()

local w=af.getCraftableLassos()
local x={}
local y={}

for z,A in ipairs(w)do
local B=A.name.." (str "..A.strength..")"
table.insert(x,B)
y[B]=A.id
end





q:AddToggle("AutoCraftLasso",{
Text="Auto Craft",
Default=false,
Tooltip="makes lassos when ur ur running low",
Callback=function(z)
af.setCraftEnabled(z)
end,
})

q:AddDropdown("LassoToCraft",{
Text="Lasso Type",
Values=x,
Default=1,
Multi=false,
Tooltip="which lasso to restock",
Callback=function(z)
local A=y[z]
if A then af.setSelectedLasso(A)end
end,
Disabled=false,
Visible=true,
})

q:AddSlider("LassoRestockThreshold",{
Text="Restock Threshold",
Default=50,
Min=1,
Max=250,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="threshold til buying more lassos",
Callback=function(z)
af.setRestockThreshold(z)
end,
})

q:AddSlider("LassoRestockAmount",{
Text="Restock Amount",
Default=100,
Min=1,
Max=250,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="how many lassos u want",
Callback=function(z)
af.setRestockAmount(z)
end,
})

q:AddButton("Restock Now",function()
af.triggerRestock()
end)


local z=g.Main:AddRightTabbox()

local A=z:AddTab("Ores")
local B=z:AddTab("Pickaxe")
local C=z:AddTab("Render")

A:AddToggle('AutoMine',{
Text='Mine',
Default=false,
Tooltip='Auto mines ores for you',

Callback=function(D)
ak.setEnabled(D)
ak.setNoclip(D)
end
})

A:AddToggle("RandomTP",{
Text="Random Teleport",
Default=false,
Tooltip="Teleports to a random spot on the island when idle",

Callback=function(D)
ak.setRandomTeleport(D)
end,
})

A:AddSlider("ClickCooldown",{
Text="Click Cooldown",
Default=0.05,
Min=0,
Max=1,
Rounding=2,
Compact=true,
HideMax=true,
Tooltip="Delay between clicks in seconds",

Callback=function(D)
ak.setClickCooldown(D)
end,
})


A:AddSlider("IdleThreshold",{
Text="Idle Threshold",
Default=5,
Min=1,
Max=30,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="Seconds idle before random teleport fires",

Callback=function(D)
ak.setIdleThreshold(D)
end,
})

local D=ak.getOreValues()

A:AddDropdown("OreSelector",{
Text="Ore Types",
Values=D,
Default=0,
Multi=true,
Tooltip="Select which ores to mine",

Callback=function(E)

for F,G in ipairs(D)do
ak.setOreTarget(G,false)
end

for F,G in pairs(E)do
if G then
ak.setOreTarget(F,true)
end
end
end,

Disabled=false,
Visible=true,
})

B:AddToggle("EquipPickaxe",{
Text="Pickaxe",
Default=false,
Tooltip="Equips the pickaxe for you automatically",

Callback=function(E)
ak.setPickaxeEnabled(E)
end,
})

local E=game:GetService("ReplicatedStorage")
local F=require(E.References)
local G=F.Utilities.Network





local H={
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
}

local I={
"Harvester",
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
}

local J=I[1]

B:AddDropdown("PickaxeSelector",{
Text="Pickaxe",
Values=I,
Default=1,
Multi=false,
Tooltip="Select which pickaxe to buy",
Callback=function(K)
J=K
end,
Disabled=false,
Visible=true,
})

B:AddButton("Buy Pickaxe",function()
local K=H[J]
if not K then return end


G:FireServer("Shopping","BuyShopItem",K.shop,K.idx,1,nil)
end)

C:AddToggle("HighlightOre",{
Text="Highlight",
Default=false,
Tooltip="Highlights ore that is being mined",

Callback=function(K)
ak.setHighlight(K)
end,
})

local K=g.Main:AddLeftTabbox()

local L=K:AddTab("Train")

L:AddToggle("AutoTrainEnabled",{
Text="Enable",
Default=false,
Tooltip="Automatically completes cross country",
Callback=function(M)
ap.setEnabled(M)
ap.setNoclip(M)
end,
})

local M=K:AddTab("Settings")

M:AddSlider("TrainSpeed",{
Text="Speed",
Default=42,
Min=20,
Max=80,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="training speed",
Callback=function(N)
ap.setMoveSpeed(N)
end,
})

local N=g.Main:AddRightGroupbox("Treasure")

N:AddToggle("TreasureEnabled",{
Text="Enable",
Default=false,
Tooltip="Auto digs treasure",
Callback=function(O)
at.setEnabled(O)
at.setNoclip(O)
end,
})

local O=g.Main:AddRightGroupbox("Wack A Larry")

O:AddToggle("TreasureEnabled",{
Text="Enable",
Default=false,
Tooltip="Auto completes larry",
Callback=function(P)
ar.setEnabled(P)
end,
})

local P=g.Misc:AddLeftTabbox()

local Q=P:AddTab("Player")
local R=P:AddTab("Horse")

Q:AddToggle("WalkspeedEnabled",{
Text="Walkspeed",
Default=false,
Tooltip="Enhances characters speed",
Callback=function(S)
al.setEnabled(S)
end,
})

Q:AddSlider("WalkspeedValue",{
Text="Walkspeed Value",
Default=16,
Min=16,
Max=100,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="walkspeed value",
Callback=function(S)
al.setValue(S)
end,
})

Q:AddToggle("JumpPowerEnabled",{
Text="JumpPower",
Default=false,
Tooltip="Enhances JumpPower",
Callback=function(S)
al.setJumpEnabled(S)
end,
})

Q:AddSlider("JumpPowerValue",{
Text="JumpPower Value",
Default=50,
Min=0,
Max=1000,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="jumppower value",
Callback=function(S)
al.setJumpValue(S)
end,
})

R:AddToggle("HWalkspeedEnabled",{
Text="Walkspeed",
Default=false,
Tooltip="Enhances horses speed",
Callback=function(S)
am.setEnabled(S)
end,
})

R:AddSlider("HWalkspeedValue",{
Text="Walkspeed Value",
Default=16,
Min=16,
Max=100,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="walkspeed value",
Callback=function(S)
am.setValue(S)
end,
})

R:AddToggle("HJumpPowerEnabled",{
Text="JumpPower",
Default=false,
Tooltip="Enhances horses JumpPower",
Callback=function(S)
am.setJumpEnabled(S)
end,
})

R:AddSlider("HJumpPowerValue",{
Text="JumpPower Value",
Default=50,
Min=0,
Max=1000,
Rounding=0,
Compact=true,
HideMax=true,
Tooltip="jumppower value",
Callback=function(S)
am.setJumpValue(S)
end,
})

local S=g.Misc:AddRightGroupbox("Performance")

local T=Instance.new("ScreenGui")
T.Name="BackgroundCover"
T.DisplayOrder=-999999
T.IgnoreGuiInset=true
T.Parent=game:GetService("CoreGui")

local U=Instance.new("Frame",T)
U.Size=UDim2.new(1,0,1,0)
U.BackgroundColor3=Color3.fromRGB(0,0,0)
U.BorderSizePixel=0
U.Visible=false

local V={}

S:AddToggle('MuteAmbientMusic',{
Text='Ambient Music',
Default=false,
Tooltip='Turns on or off ambient music or sounds',
Callback=function(W)
local X=game:GetService("SoundService")
local Y=X:GetDescendants()

for Z,_ in ipairs(Y)do
if _:IsA("Sound")then
if W then

_.Playing=false
else

_.Playing=true
end
end
end
end
})

S:AddToggle('NoGraphics',{
Text='No Graphics',
Default=false,
Tooltip='Disables 3D rendering with a black background',
Callback=function(W)
do
game:GetService("RunService"):Set3dRenderingEnabled(not W)
U.Visible=W
end
end
})

local W=false
local X=60

S:AddToggle('SetFPS',{
Text='FPS Cap',
Default=false,
Tooltip='Caps the game FPS at the slider value',
Callback=function(Y)
do
W=Y
if W then
setfpscap(X)
else
setfpscap(0)
end
end
end
})

S:AddSlider('FPSCap',{
Text='FPS Cap Value',
Default=60,
Min=1,
Max=240,
Rounding=1,
Compact=false,
Callback=function(Y)
do
X=Y
if W then
setfpscap(Y)
end
end
end
})

local Y=g.Misc:AddLeftGroupbox("Redeem")

Y:AddButton("Redeem Codes",function()
local Z=require(game:GetService("ReplicatedStorage"):WaitForChild("References"))
local _=Z.Utilities
local au=require(Z.PlayerScripts.Priority.Data)
local av=Z.Flags

local aw={
"ty-4-100m-visits",
"some-pasture-stuffs",
"tridents-trident",
"when-life-gives-you-lemons",
"koolie-plush",
}

for ax,ay in ipairs(aw)do
local az=(av.flags.codes or{})[ay]
if az==nil then
ab:Notify("No new code: "..ay,2)
elseif au.GetLocal({"codesRedeemed",ay})==true then
ab:Notify("Already redeemed: "..ay,2)
else
_.Network:FireServer("Codes","Submit",ay)
print("[AutoRedeem] Submitted: "..ay)
ab:Notify("Submitted: "..ay,2)
task.wait(1.5)
end
end

end)

Y:AddButton("Redeem Volcanic Mineral (5)",function()
for au,av in Functions:GetChildren()do
pcall(function()
av:FireServer("\002","Trade","volcanicMinerals")
end)
end
end)

local au=0

local function av(aw)
if aw<=255 then
return string.char(aw)
end
return string.char(math.floor(aw/256),aw%256)
end

local function aw(ax,ay)
local az=av(au)
au=(au+1)%4294967296
for Z,_ in Functions:GetChildren()do
pcall(function()
_:FireServer(az,ax,ay)
end)
end
end

Y:AddButton("Training Receipt (100)",function()
aw("Trade","trainingReceipts")
end)

Y:AddButton("Golden Apples (20)",function()
aw("Trade","goldenAppleBasket")
end)

Y:AddButton("Relics (1)",function()
aw("Trade","archaeology")
end)




ab:SetWatermarkVisibility(true)


local ax=tick()
local ay=0;
local az=60;
local Z=(function()return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())end)
local _=pcall(function()return Z()end)

local aA=game:GetService("RunService").RenderStepped:Connect(function()
ay+=1;

if(tick()-ax)>=1 then
az=ay;
ax=tick();
ay=0;
end;

if _ then
ab:SetWatermark(("coconut - [buyer build] | %d fps | %d ms"):format(
math.floor(az),
Z()
));
else
ab:SetWatermark(("coconut - [buyer build] | %d fps"):format(
math.floor(az)
));
end
end);

ab:OnUnload(function()
aA:Disconnect()

print("Unloaded!")
ab.Unloaded=true
end)


local aB=g["UI Settings"]:AddLeftGroupbox("Menu")

aB:AddToggle("KeybindMenuOpen",{Default=ab.KeybindFrame.Visible,Text="Open Keybind Menu",Callback=function(aC)ab.KeybindFrame.Visible=aC end})
aB:AddToggle("BlurEnabled",{Default=true,Text="Blur",Callback=function(aC)ab.BlurEffect.Enabled=aC end})
aB:AddDivider()
aB:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind",{Default="RightShift",NoUI=true,Text="Menu keybind"})
aB:AddButton("Unload",function()ab:Unload()end)

ab.ToggleKeybind=b.MenuKeybind






ac:SetLibrary(ab)
ad:SetLibrary(ab)



ad:IgnoreThemeSettings()



ad:SetIgnoreIndexes({"MenuKeybind"})




ac:SetFolder("coconut")
ad:SetFolder("coconut/whi")






ad:BuildConfigSection(g["UI Settings"])



ac:ApplyToTab(g["UI Settings"])



ad:LoadAutoloadConfig()

ab:Notify("Loaded in "..tostring(string.format("%."..tostring(3).."f",os.clock()-aa)).." seconds",5)
