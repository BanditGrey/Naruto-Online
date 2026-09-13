package Logics.DatebaseVO.VO.Json
{
   import ghostcat.util.data.Json;
   
   public class TSignForReward
   {
      
      protected var FReward:Array;
      
      protected var FType:Vector.<uint>;
      
      protected var FCode:Vector.<uint>;
      
      protected var FAmount:Vector.<uint>;
      
      public function TSignForReward(param1:Object)
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         super();
         _loc5_ = Json.decode(String(param1));
         this.FReward = _loc5_ as Array;
         _loc3_ = int(this.FReward.length);
         this.FType = new Vector.<uint>(_loc3_);
         this.FCode = new Vector.<uint>(_loc3_);
         this.FAmount = new Vector.<uint>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FReward[_loc2_];
            this.FType[_loc2_] = _loc4_.type;
            this.FCode[_loc2_] = _loc4_.code;
            this.FAmount[_loc2_] = _loc4_.amount;
            _loc2_++;
         }
      }
      
      public function get Reward() : Array
      {
         return this.FReward;
      }
      
      public function get Type() : Vector.<uint>
      {
         return this.FType;
      }
      
      public function get Code() : Vector.<uint>
      {
         return this.FCode;
      }
      
      public function get Amount() : Vector.<uint>
      {
         return this.FAmount;
      }
   }
}

