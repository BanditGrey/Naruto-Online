package Logics.Battle.model
{
   import Debugging.*;
   import flash.utils.*;
   
   public class TResultInfo
   {
      
      protected var FCMD:uint;
      
      protected var FHurtHp:Number;
      
      protected var FHurtAnger:int;
      
      protected var FBuffId:int;
      
      protected var FBuffTurn:int;
      
      protected var FCurHp:Number;
      
      protected var FCurAllHp:Number;
      
      public var IsNull:Boolean;
      
      public function TResultInfo()
      {
         super();
         this.FHurtHp = 0;
         this.FHurtAnger = 0;
      }
      
      public function get CMD() : uint
      {
         return this.FCMD;
      }
      
      public function set CMD(param1:uint) : void
      {
         this.FCMD = param1;
      }
      
      public function get HurtHp() : Number
      {
         return this.FHurtHp;
      }
      
      public function set HurtHp(param1:Number) : void
      {
         this.FHurtHp = param1;
      }
      
      public function get HurtAnger() : int
      {
         return this.FHurtAnger;
      }
      
      public function set HurtAnger(param1:int) : void
      {
         this.FHurtAnger = param1;
      }
      
      public function get BuffId() : int
      {
         return this.FBuffId;
      }
      
      public function set BuffId(param1:int) : void
      {
         this.FBuffId = param1;
      }
      
      public function get BuffTurn() : int
      {
         return this.FBuffTurn;
      }
      
      public function set BuffTurn(param1:int) : void
      {
         this.FBuffTurn = param1;
      }
      
      public function get CurHp() : Number
      {
         return this.FCurHp;
      }
      
      public function set CurHp(param1:Number) : void
      {
         this.FCurHp = param1;
      }
      
      public function get CurAllHp() : Number
      {
         return this.FCurAllHp;
      }
      
      public function set CurAllHp(param1:Number) : void
      {
         this.FCurAllHp = param1;
      }
      
      public function SetDataByObj(param1:Object) : void
      {
         this.FCMD = param1.CMD;
         this.FHurtHp = param1.HurtHp;
         this.FHurtAnger = param1.HurtAnger;
         this.FBuffId = param1.BuffId;
         this.FBuffTurn = param1.BuffTurn;
         this.FCurHp = param1.CurHp;
         this.FCurAllHp = param1.CurAllHp;
      }
      
      public function toString() : String
      {
         return "{ \"CMD\":" + this.FCMD + ", \"HurtHp\":" + this.FHurtHp + ", \"HurtAnger\":" + this.FHurtAnger + ", \"BuffId\":" + this.FBuffId + ", \"BuffTurn\":" + this.FBuffTurn + ", FCurHp:" + this.FCurHp + ", FCurAllHp:" + this.FCurAllHp + "}";
      }
   }
}

