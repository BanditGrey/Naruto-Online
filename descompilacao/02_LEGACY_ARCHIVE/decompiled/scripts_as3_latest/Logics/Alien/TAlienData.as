package Logics.Alien
{
   public class TAlienData
   {
      
      protected var FAliens:Vector.<TAlien>;
      
      public function TAlienData()
      {
         super();
         this.FAliens = new Vector.<TAlien>();
      }
      
      public function get Aliens() : Vector.<TAlien>
      {
         return this.FAliens;
      }
      
      public function Add(param1:TAlien) : void
      {
         this.FAliens.push(param1);
      }
      
      public function GetTAlienByIdentifier(param1:uint) : TAlien
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TAlien = null;
         _loc3_ = this.FAliens.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FAliens[_loc2_];
            if(_loc4_.Id == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetTAliensByLevel(param1:uint) : Vector.<TAlien>
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TAlien = null;
         var _loc2_:Vector.<TAlien> = new Vector.<TAlien>();
         _loc4_ = this.FAliens.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this.FAliens[_loc3_];
            if(_loc5_.Level == param1)
            {
               _loc2_.push(_loc5_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function GetAlienHerosByLevel(param1:uint) : TAlien
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TAlien = null;
         _loc3_ = this.FAliens.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FAliens[_loc2_];
            if(_loc4_.Level == param1)
            {
               if(_loc4_.Heros)
               {
                  return _loc4_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TAlien = null;
         _loc2_ = this.FAliens.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FAliens[_loc1_];
            _loc3_.Status = 0;
            _loc1_++;
         }
      }
   }
}

