require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "layout"
import 'android.view.*'
import 'android.widget.*'
import 'android.graphics.*'
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)
activity.setTheme(android.R.style.Theme_Black)
activity.setTheme(android.R.style.Theme_Holo_Light_Panel)

function random(...)
  math.random(1,1000)
  return math.random(...)
end
activity.Title= 'Game'
local pen=Paint()
pen.setARGB(500,0,60,60)
local w=30
local m=23
local x=1
local y=2
local rect={}
local _rect={}
local n=1
rect[1]=Rect(w,w,w,w)
_rect[1]={x=1,y=1}
function p()
  X=random(0,7)
  Y=random(0,7)
  _Rect=Rect(X*w,Y*w,(X+1)*w,(Y+1)*w-1)
end
p()
local f=0
local m_x=0
local m_y=0
function tick()
  g=holder.lockCanvas()
  if not g then
    return
  end
  x=x+m_x
  y=y+m_y
  if x>m then
    x=0
   elseif x<0 then
    x=m
   elseif y>m then
    y=0
   elseif y<0 then
    y=m
  end
  local rectangle=Rect(x*w,y*w,(x+1)*w-1,(y+1)*w-1)
  table.insert (rect,1,rectangle)
  table.insert (_rect,1,{x=x,y=y})
  rect[n+1]= nil
  _rect[n+1]= nil
  if x==X and y==Y then
    n=n+1
    p()
    f=f+10
    tm.Interval=math.max(tm.Interval-2,20)
    activity.Title= 'Score：' ..f
  end
  recth=_rect[1]
  for r=5,#rect do
    if recth.x==_rect[r].x and recth.y==_rect[r].y then

      n=3
      rect[n]=nil
      f=0
      activity.Title= 'Score：' ..f
     elseif n<r then
      rect[r]=nil
    end
  end
  g.drawColor(0xffffff00)
  for k,rectangle in ipairs (rect) do
    g.drawRect(rectangle,pen)
  end
  g.drawRect(_Rect,pen)
  g.drawLine(0,720,720,720,pen)
  holder.unlockCanvasAndPost(ca)
end
tm=Ticker()
tm.Interval=150
tm.Enabled= true
tm.onTick=tick
function up()
  if st~='d' then
    m_x,m_y=0,-1
    st='u'
  end
end
function down()
  if st~='u' then
    m_x,m_y=0,1
    st='d'
  end
end
function left()
  if st~='r' then
    m_x,m_y=-1,0
    st='l'
  end
end
function right()
  if st~='l' then
    m_x,m_y=1,0
    st='r'
  end
end
layout={
  LinearLayout;
  {
    SurfaceView;
    id="sureface";
    layout_width="fill";
    layout_height="fill";
    layout_weight=1;
  };
  {
    FrameLayout;
    {
      Button;
      text="⬆";
      onClick="up";
      layout_gravity="center";
    };
    layout_width="fill";
  };
  {
    FrameLayout;
    {
      LinearLayout;
      {
        Button;
        text="⬅";
        onClick="left";
      };
      {
        Button;
        text="⬇";
        onClick="down";
      };
      {
        Button;
        text="➡";
        onClick="right";
      };
      layout_gravity="center";
    };
    layout_width="fill";
  };
  orientation="vertical";
};
activity.setContentView(layout)
callback=SurfaceHolder.Callback{
  surfaceChanged=function(holder,format,width,height)
  end,
  surfaceCreated=function(holder)
    ca=holder.lockCanvas()
    if not tm.isRun() then
      tm.start()
      right()
    end
    holder.unlockCanvasAndPost(ca)
  end,
  surfaceDestroyed=function(holder)
  end
}
holder=sureface.getHolder()
holder.addCallback(callback)
function onStart()
  tm.Enabled=true
end
function onStop()
  tm.Enabled=false
end


