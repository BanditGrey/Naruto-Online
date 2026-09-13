package Logics.Talent
{
   public class TNinjaTalentData
   {
      
      protected var FNinjaTalentVOList:Vector.<TNinjaTalentVO>;
      
      public var CurHeroId:int;
      
      public var RefreshStatus:Boolean;
      
      public function TNinjaTalentData()
      {
         super();
         this.FNinjaTalentVOList = new Vector.<TNinjaTalentVO>();
      }
      
      public function get Count() : int
      {
         return this.FNinjaTalentVOList.length;
      }
      
      public function Clear() : void
      {
         this.FNinjaTalentVOList.length = 0;
      }
      
      public function Add(param1:TNinjaTalentVO) : void
      {
         this.FNinjaTalentVOList.push(param1);
      }
      
      public function GetNinjaTalentVOByIndex(param1:int) : TNinjaTalentVO
      {
         return this.FNinjaTalentVOList[param1];
      }
   }
}

