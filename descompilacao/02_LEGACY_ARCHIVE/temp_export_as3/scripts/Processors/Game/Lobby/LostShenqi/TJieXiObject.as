package Processors.Game.Lobby.LostShenqi
{
   public class TJieXiObject
   {
      
      protected var FLevelVector:Vector.<uint>;
      
      protected var FValue0Vector:Vector.<uint>;
      
      protected var FValue1Vector:Vector.<uint>;
      
      protected var FValue2Vector:Vector.<uint>;
      
      protected var FValue3Vector:Vector.<uint>;
      
      public function TJieXiObject(param1:Array)
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         super();
         this.FLevelVector = new Vector.<uint>();
         this.FValue0Vector = new Vector.<uint>();
         this.FValue1Vector = new Vector.<uint>();
         this.FValue2Vector = new Vector.<uint>();
         this.FValue3Vector = new Vector.<uint>();
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc3_ = param1[_loc2_];
               this.FLevelVector.push(_loc3_[0]);
               _loc4_ = _loc3_[1];
               _loc5_ = String(_loc4_.typeEffect).split("_");
               this.FValue0Vector.push(_loc5_[0]);
               this.FValue1Vector.push(_loc5_[1]);
               this.FValue2Vector.push(_loc5_[2]);
               this.FValue3Vector.push(_loc5_[3]);
               _loc2_++;
            }
         }
         else
         {
            this.FLevelVector.length = 0;
            this.FValue0Vector.length = 0;
            this.FValue1Vector.length = 0;
            this.FValue2Vector.length = 0;
            this.FValue3Vector.length = 0;
         }
      }
      
      public function get LevelVector() : Vector.<uint>
      {
         return this.FLevelVector;
      }
      
      public function get Value0Vector() : Vector.<uint>
      {
         return this.FValue0Vector;
      }
      
      public function get Value1Vector() : Vector.<uint>
      {
         return this.FValue1Vector;
      }
      
      public function get Value2Vector() : Vector.<uint>
      {
         return this.FValue2Vector;
      }
      
      public function get Value3Vector() : Vector.<uint>
      {
         return this.FValue3Vector;
      }
   }
}

