package Logics.Exercise.NinjiaVillage
{
   import Logics.Exercise.TBaseActivity;
   
   public class TNinjiaVillageData extends TBaseActivity
   {
      
      protected var FDataVect:Vector.<TNinjiaVillageBaseData>;
      
      protected var FFundID:int;
      
      protected var FReturnType:int;
      
      public var FiveCountryReturnType:int;
      
      public var FundReturnType:int;
      
      public var rechargeGoldNum:int = 0;
      
      public function TNinjiaVillageData()
      {
         super();
         this.FDataVect = new Vector.<TNinjiaVillageBaseData>();
      }
      
      public function get DataVect() : Vector.<TNinjiaVillageBaseData>
      {
         return this.FDataVect;
      }
      
      public function set DataVect(param1:Vector.<TNinjiaVillageBaseData>) : void
      {
         this.FDataVect = param1;
      }
      
      public function get FundID() : int
      {
         return this.FFundID;
      }
      
      public function set FundID(param1:int) : void
      {
         this.FFundID = param1;
      }
      
      public function get ReturnType() : int
      {
         return this.FReturnType;
      }
      
      public function set ReturnType(param1:int) : void
      {
         this.FReturnType = param1;
      }
      
      public function GetDataByIdentify(param1:uint) : TNinjiaVillageBaseData
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FDataVect.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1 == this.FDataVect[_loc2_].Identify)
            {
               return this.FDataVect[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}

