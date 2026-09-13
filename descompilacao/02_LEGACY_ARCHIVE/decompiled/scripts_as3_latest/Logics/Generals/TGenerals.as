package Logics.Generals
{
   public class TGenerals
   {
      
      protected var FGenerals:Vector.<TGeneral>;
      
      public function TGenerals()
      {
         super();
         this.FGenerals = new Vector.<TGeneral>();
      }
      
      public function get Count() : int
      {
         return this.FGenerals.length;
      }
      
      public function GetGeneralByIndex(param1:int) : TGeneral
      {
         return this.FGenerals[param1];
      }
      
      public function GetGeneralByIdentifier(param1:uint) : TGeneral
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TGeneral = null;
         _loc2_ = int(this.FGenerals.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FGenerals[_loc3_];
            if(_loc4_.ID == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TGeneral = null;
         _loc1_ = int(this.FGenerals.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FGenerals[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FGenerals.length = 0;
      }
      
      public function Add(param1:TGeneral) : void
      {
         param1.StubReferences.Reference(this);
         this.FGenerals.push(param1);
      }
      
      public function ChangeRecruitGeneral(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TGeneral = null;
         _loc3_ = int(this.FGenerals.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FGenerals[_loc4_];
            if(_loc5_.Recruited == param1)
            {
               _loc5_.Recruited = param2;
            }
            _loc4_++;
         }
      }
   }
}

