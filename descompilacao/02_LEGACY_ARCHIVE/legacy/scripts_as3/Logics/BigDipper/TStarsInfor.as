package Logics.BigDipper
{
   import Foundation.Utilities.*;
   import Logics.*;
   import Processors.Game.Lobby.BigDipper.*;
   import Resources.Constants.*;
   
   public class TStarsInfor
   {
      
      protected var FStarsInfor:Vector.<TStarInfor>;
      
      protected var FFreeTime:int;
      
      protected var FFplayTimes:int;
      
      public function TStarsInfor()
      {
         super();
         this.FStarsInfor = new Vector.<TStarInfor>();
      }
      
      public function get FreeTime() : int
      {
         return this.FFreeTime;
      }
      
      public function set FreeTime(param1:int) : void
      {
         this.FFreeTime = param1;
      }
      
      public function get FplayTimes() : int
      {
         return this.FFplayTimes;
      }
      
      public function set FplayTimes(param1:int) : void
      {
         this.FFplayTimes = param1;
      }
      
      public function AddStar(param1:TStarInfor) : void
      {
         this.FStarsInfor.push(param1);
      }
      
      public function GetStarByIndex(param1:int) : TStarInfor
      {
         return this.FStarsInfor[param1];
      }
      
      public function GetStarByStarNameID(param1:int) : TStarInfor
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FStarsInfor.length)
         {
            if(param1 == this.FStarsInfor[_loc2_].StarNameID)
            {
               return this.FStarsInfor[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function IsFull() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:TStarInfor = null;
         _loc1_ = 0;
         while(_loc1_ < this.FStarsInfor.length)
         {
            _loc2_ = this.FStarsInfor[_loc1_];
            if(_loc2_.CurrentLevelCeiling != _loc2_.StarLevel)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
   }
}

