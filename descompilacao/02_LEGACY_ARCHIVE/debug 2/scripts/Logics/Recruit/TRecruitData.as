package Logics.Recruit
{
   public class TRecruitData
   {
      
      protected var FRecruits:Vector.<TRecruit>;
      
      public var Score:int;
      
      public var Point:int;
      
      public function TRecruitData()
      {
         super();
         this.FRecruits = new Vector.<TRecruit>();
      }
      
      public function get Recruits() : Vector.<TRecruit>
      {
         return this.FRecruits;
      }
      
      public function Add(param1:TRecruit) : void
      {
         this.FRecruits.push(param1);
      }
      
      public function get Size() : int
      {
         return this.FRecruits.length;
      }
      
      public function GetTRecruitByIdentifier(param1:uint) : TRecruit
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRecruit = null;
         _loc3_ = this.FRecruits.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FRecruits[_loc2_];
            if(_loc4_.heroId == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
   }
}

