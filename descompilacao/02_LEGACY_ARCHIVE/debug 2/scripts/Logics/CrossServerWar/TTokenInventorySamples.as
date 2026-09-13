package Logics.CrossServerWar
{
   public class TTokenInventorySamples
   {
      
      protected var FTokenInventorySamples:Vector.<TTokenInventorySample>;
      
      public function TTokenInventorySamples()
      {
         super();
         this.FTokenInventorySamples = new Vector.<TTokenInventorySample>();
      }
      
      public function get Count() : int
      {
         return this.FTokenInventorySamples.length;
      }
      
      public function GetInventorySampleByIndex(param1:int) : TTokenInventorySample
      {
         return this.FTokenInventorySamples[param1];
      }
      
      public function GetTokenInventorySampleByTemplateID(param1:uint) : TTokenInventorySample
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TTokenInventorySample = null;
         _loc2_ = int(this.FTokenInventorySamples.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FTokenInventorySamples[_loc3_];
            if(_loc4_.TemplateID == param1)
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
         _loc1_ = int(this.FTokenInventorySamples.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FTokenInventorySamples.pop();
            _loc2_++;
         }
         this.FTokenInventorySamples.length = 0;
      }
      
      public function Add(param1:TTokenInventorySample) : void
      {
         this.FTokenInventorySamples.push(param1);
      }
      
      public function DeleteSampleByIndex(param1:int) : TTokenInventorySample
      {
         var _loc2_:TTokenInventorySample = null;
         _loc2_ = this.FTokenInventorySamples[param1];
         this.FTokenInventorySamples.splice(param1,1);
         return _loc2_;
      }
   }
}

