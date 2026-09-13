package Logics.Items
{
   import Resources.Strings.STRING_COMMON;
   
   public class TItems
   {
      
      private var FItems:Vector.<TItem>;
      
      public function TItems()
      {
         super();
         this.FItems = new Vector.<TItem>();
      }
      
      public function get Count() : int
      {
         return this.FItems.length;
      }
      
      public function RewardByIndex(param1:int) : TItem
      {
         return this.FItems[param1];
      }
      
      public function GetItemById(param1:int) : TItem
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.Count)
         {
            if(this.FItems[_loc2_].ID == param1)
            {
               return this.FItems[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get Money() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 0 && this.FItems[_loc1_].ID == 0)
            {
               _loc2_ += this.FItems[_loc1_].Count;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get Exp() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 2)
            {
               _loc2_ += this.FItems[_loc1_].Count;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get Prestige() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 5)
            {
               _loc2_ += this.FItems[_loc1_].Count;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get Soul() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 6)
            {
               _loc2_ += this.FItems[_loc1_].Count;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get ReincarnatonScore() : String
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 17)
            {
               if(this.FItems[_loc1_].ID == 32)
               {
                  _loc3_ = STRING_COMMON.ITEMNAME_TransmigrationTrialPoint_1;
               }
               else if(this.FItems[_loc1_].ID == 33)
               {
                  _loc3_ = STRING_COMMON.ITEMNAME_TransmigrationTrialPoint_2;
               }
               else
               {
                  _loc3_ = "";
               }
               _loc3_ += "+" + this.FItems[_loc1_].Count;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function get AwakenSoul() : String
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 25)
            {
               _loc3_ = STRING_COMMON.GetItemNameByType(this.FItems[_loc1_].Type,0);
               _loc3_ += "+" + this.FItems[_loc1_].Count;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function get ItemIDs() : Vector.<TItem>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<TItem> = null;
         _loc2_ = new Vector.<TItem>();
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 1 || this.FItems[_loc1_].Type == 3 || this.FItems[_loc1_].Type == 0 && this.FItems[_loc1_].ID == 2 || this.FItems[_loc1_].Type == 18)
            {
               _loc2_.push(this.FItems[_loc1_]);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get ItemIDWithOutExpMoney() : Vector.<uint>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<uint> = null;
         _loc2_ = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(!(this.FItems[_loc1_].Type == 2 || this.FItems[_loc1_].Type == 0 && this.FItems[_loc1_].ID == 0))
            {
               _loc2_.push(this.FItems[_loc1_].ID);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get ItemQuantityWithOutExpMoney() : Vector.<uint>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<uint> = null;
         _loc2_ = new Vector.<uint>();
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(!(this.FItems[_loc1_].Type == 2 || this.FItems[_loc1_].Type == 0 && this.FItems[_loc1_].ID == 0))
            {
               _loc2_.push(this.FItems[_loc1_].Count);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get Items() : Vector.<TItem>
      {
         return this.FItems;
      }
      
      public function set Items(param1:Vector.<TItem>) : void
      {
         this.FItems = param1;
      }
      
      public function get ChallengeHurt() : uint
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FItems.length)
         {
            if(this.FItems[_loc1_].Type == 24)
            {
               _loc2_ += this.FItems[_loc1_].Count;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TItem = null;
         _loc1_ = int(this.FItems.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FItems[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FItems.length = 0;
      }
      
      public function Add(param1:TItem) : void
      {
         param1.StubReferences.Reference(this);
         this.FItems.push(param1);
      }
   }
}

