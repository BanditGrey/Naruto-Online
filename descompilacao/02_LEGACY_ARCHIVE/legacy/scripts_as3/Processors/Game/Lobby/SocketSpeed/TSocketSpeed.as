package Processors.Game.Lobby.SocketSpeed
{
   import Foundation.Timing.STimingCore;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   
   public class TSocketSpeed
   {
      
      protected static const CONST_TIMEOUT:uint = 3000;
      
      protected static const TYPE_LoginIn:uint = 1;
      
      protected static const TYPE_LoginOut:uint = 2;
      
      protected var FIpVect:Vector.<String>;
      
      protected var FPortVect:Vector.<uint>;
      
      protected var FConnetTickVect:Vector.<uint>;
      
      protected var FCurConnetCount:uint;
      
      protected var FConnetTick:uint;
      
      protected var FFastTick:uint;
      
      protected var FSocket:Socket;
      
      protected var FEndCallBack:Function;
      
      public function TSocketSpeed()
      {
         super();
         this.FSocket = new Socket();
         this.FSocket.addEventListener(Event.CONNECT,this.SocketOnConnect);
         this.FSocket.addEventListener(Event.CLOSE,this.SocketOnClose);
         this.FSocket.addEventListener(IOErrorEvent.IO_ERROR,this.SocketOnIOError);
         this.FSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.SocketOnSecurityError);
         this.FSocket.timeout = CONST_TIMEOUT;
         this.FIpVect = new Vector.<String>();
         this.FPortVect = new Vector.<uint>();
         this.FConnetTickVect = new Vector.<uint>();
      }
      
      protected function SocketOnConnect(param1:Event) : void
      {
         this.FConnetTickVect[this.FCurConnetCount] = STimingCore.TickCount - this.FConnetTick;
         this.FFastTick = Math.min(this.FFastTick,this.FConnetTickVect[this.FCurConnetCount]);
         this.FSocket.close();
         this.SocketOnClose();
      }
      
      protected function SocketOnClose(param1:Event = null) : void
      {
         var _loc2_:uint = 0;
         if(this.FEndCallBack != null)
         {
            if(this.FFastTick < CONST_TIMEOUT)
            {
               this.FEndCallBack(this.FIpVect[this.FCurConnetCount],this.FPortVect[this.FCurConnetCount],this.FFastTick);
               return;
            }
         }
         ++this.FCurConnetCount;
         if(this.FCurConnetCount >= this.FIpVect.length)
         {
            if(this.FEndCallBack != null)
            {
               if(this.FFastTick >= CONST_TIMEOUT)
               {
                  this.FEndCallBack("",0,this.FFastTick);
                  return;
               }
               _loc2_ = this.FConnetTickVect.indexOf(this.FFastTick);
               if(_loc2_ < 0 || _loc2_ > this.FIpVect.length)
               {
                  this.FEndCallBack("",0,this.FFastTick);
                  return;
               }
               this.FEndCallBack(this.FIpVect[_loc2_],this.FPortVect[_loc2_],this.FFastTick);
            }
         }
         else
         {
            this.StartConnect();
         }
      }
      
      protected function SocketOnIOError(param1:IOErrorEvent) : void
      {
         try
         {
            this.FSocket.close();
            this.SocketOnClose();
         }
         catch(E:Error)
         {
         }
      }
      
      protected function SocketOnSecurityError(param1:SecurityErrorEvent) : void
      {
         try
         {
            this.FSocket.close();
            this.SocketOnClose();
         }
         catch(E:Error)
         {
         }
      }
      
      protected function StartConnect() : void
      {
         var _loc1_:String = null;
         var _loc2_:uint = 0;
         this.FConnetTick = STimingCore.TickCount;
         _loc1_ = this.FIpVect[this.FCurConnetCount];
         _loc2_ = this.FPortVect[this.FCurConnetCount];
         this.FSocket.connect(_loc1_,_loc2_);
      }
      
      public function get EndCallBack() : Function
      {
         return this.FEndCallBack;
      }
      
      public function set EndCallBack(param1:Function) : void
      {
         this.FEndCallBack = param1;
      }
      
      public function AddServerInfo(param1:String, param2:uint) : void
      {
         if(param1.length <= 0)
         {
            return;
         }
         this.FIpVect.push(param1);
         this.FPortVect.push(param2);
         this.FConnetTickVect.push(10000);
      }
      
      public function Start() : void
      {
         this.FCurConnetCount = 0;
         this.FFastTick = uint.MAX_VALUE;
         this.StartConnect();
      }
      
      public function Clear() : void
      {
         this.FFastTick = uint.MAX_VALUE;
         this.FIpVect.length = 0;
         this.FPortVect.length = 0;
         this.FConnetTickVect.length = 0;
      }
   }
}

