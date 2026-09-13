package Logics.Magic
{
   import Resources.Constants.CONST_MAGIC;
   
   public class TMagics
   {
      
      protected var FMagics:Vector.<TMagic>;
      
      public function TMagics()
      {
         super();
         this.FMagics = new Vector.<TMagic>(CONST_MAGIC.CAPACITY_Levels);
      }
      
      public function get Count() : uint
      {
         return this.FMagics.length;
      }
      
      public function GetMagicByIndex(param1:int) : TMagic
      {
         if(this.FMagics.length == 0)
         {
            return null;
         }
         return this.FMagics[param1];
      }
      
      public function Add(param1:TMagic) : void
      {
         this.FMagics.push(param1);
      }
      
      public function GetMagicByIdentifier(param1:uint) : TMagic
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TMagic = null;
         _loc3_ = this.FMagics.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMagics[_loc2_];
            if(_loc4_.MagicID == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.FMagics.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMagics.pop();
            _loc1_++;
         }
         this.FMagics.length = 0;
      }
   }
}

