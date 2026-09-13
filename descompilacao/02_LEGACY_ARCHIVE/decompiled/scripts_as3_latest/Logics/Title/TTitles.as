package Logics.Title
{
   public class TTitles
   {
      
      protected var FTitles:Vector.<TTitle>;
      
      protected var FHasNewTitle:Boolean;
      
      public function TTitles()
      {
         super();
         this.FTitles = new Vector.<TTitle>();
         this.FHasNewTitle = false;
      }
      
      protected function SortById(param1:TTitle, param2:TTitle) : int
      {
         if(param1.IsEquiped > param2.IsEquiped)
         {
            return -1;
         }
         if(param1.IsEquiped < param2.IsEquiped)
         {
            return 1;
         }
         if(param1.Identifier > param2.Identifier)
         {
            return 1;
         }
         if(param1.Identifier < param2.Identifier)
         {
            return -1;
         }
         return 0;
      }
      
      public function get Count() : int
      {
         return this.FTitles.length;
      }
      
      public function get HasNewTitle() : Boolean
      {
         return this.FHasNewTitle;
      }
      
      public function set HasNewTitle(param1:Boolean) : void
      {
         this.FHasNewTitle = param1;
      }
      
      public function Add(param1:TTitle) : void
      {
         this.FTitles.push(param1);
      }
      
      public function GetTitleByIndex(param1:int) : TTitle
      {
         if(param1 >= this.FTitles.length)
         {
            return null;
         }
         return this.FTitles[param1];
      }
      
      public function GetTitleByIdentifier(param1:uint) : TTitle
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTitle = null;
         _loc3_ = this.FTitles.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FTitles[_loc2_];
            if(_loc4_.Identifier == param1)
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
         var _loc2_:int = 0;
         var _loc3_:TTitle = null;
         _loc1_ = int(this.FTitles.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FTitles.pop();
            _loc2_++;
         }
         this.FTitles.length = 0;
      }
      
      public function DeleteTitleByIdentifier(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TTitle = null;
         _loc2_ = int(this.FTitles.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FTitles[_loc3_];
            if(_loc4_.Identifier == param1)
            {
               this.FTitles.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function SetEquipTitle(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTitle = null;
         _loc3_ = this.FTitles.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FTitles[_loc2_];
            if(param1 == 0)
            {
               _loc4_.IsEquiped = 2;
            }
            if(_loc4_.Identifier == param1)
            {
               _loc4_.IsEquiped = 1;
            }
            else if(Boolean(_loc4_.IsEquiped))
            {
               _loc4_.IsEquiped = 0;
            }
            _loc2_++;
         }
      }
      
      public function Sort() : void
      {
         this.FTitles.sort(this.SortById);
      }
   }
}

