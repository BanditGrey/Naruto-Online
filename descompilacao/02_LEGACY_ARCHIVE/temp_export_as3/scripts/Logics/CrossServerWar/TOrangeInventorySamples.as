package Logics.CrossServerWar
{
   public class TOrangeInventorySamples
   {
      
      protected var FOrangeInventorySamples:Vector.<TOrangeInventorySample>;
      
      public function TOrangeInventorySamples()
      {
         super();
         this.FOrangeInventorySamples = new Vector.<TOrangeInventorySample>();
      }
      
      public function get Count() : int
      {
         return this.FOrangeInventorySamples.length;
      }
      
      public function GetInventorySampleByIndex(param1:int) : TOrangeInventorySample
      {
         return this.FOrangeInventorySamples[param1];
      }
      
      public function GetOrangeInventorySampleByTemplateID(param1:uint) : TOrangeInventorySample
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TOrangeInventorySample = null;
         _loc2_ = int(this.FOrangeInventorySamples.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FOrangeInventorySamples[_loc3_];
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
         _loc1_ = int(this.FOrangeInventorySamples.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FOrangeInventorySamples.pop();
            _loc2_++;
         }
         this.FOrangeInventorySamples.length = 0;
      }
      
      public function Add(param1:TOrangeInventorySample) : void
      {
         this.FOrangeInventorySamples.push(param1);
      }
      
      public function DeleteSampleByIndex(param1:int) : TOrangeInventorySample
      {
         var _loc2_:TOrangeInventorySample = null;
         _loc2_ = this.FOrangeInventorySamples[param1];
         this.FOrangeInventorySamples.splice(param1,1);
         return _loc2_;
      }
   }
}

