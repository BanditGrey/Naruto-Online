package Logics.Characters
{
   import Foundation.Utilities.TUtilityString;
   
   public class TFriendDigests
   {
      
      public static const TYPE_White:uint = TFriendDigest.TYPE_White;
      
      public static const TYPE_Black:uint = TFriendDigest.TYPE_Black;
      
      public static const TYPE_Recommend:uint = TFriendDigest.TYPE_Recommend;
      
      protected var FFriendDigests:Vector.<TFriendDigest>;
      
      protected var FFriendDigestTiLis:Vector.<TFriendDigestTiLi>;
      
      protected var FTempVec:Vector.<TFriendDigestTiLi>;
      
      protected var FGiveCountMax:int;
      
      protected var FGetCountMax:int;
      
      protected var FOneTimesNum:int;
      
      public function TFriendDigests()
      {
         super();
         this.FFriendDigests = new Vector.<TFriendDigest>();
         this.FFriendDigestTiLis = new Vector.<TFriendDigestTiLi>();
         this.FTempVec = new Vector.<TFriendDigestTiLi>();
      }
      
      public function get Count() : int
      {
         return this.FFriendDigests.length;
      }
      
      public function GetDigestByIndex(param1:int) : TFriendDigest
      {
         return this.FFriendDigests[param1];
      }
      
      public function GetDigestByIdentifier(param1:uint, param2:uint) : TFriendDigest
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.Count)
         {
            if(this.FFriendDigests[_loc3_].Identifier0 == param1 && this.FFriendDigests[_loc3_].Identifier1 == param2)
            {
               return this.FFriendDigests[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function GetDigestByName(param1:String) : TFriendDigest
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < this.Count)
         {
            _loc3_ = TUtilityString.StringsAreEquals(param1,this.FFriendDigests[_loc2_].Name);
            if(_loc3_)
            {
               return this.FFriendDigests[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFriendDigest = null;
         _loc1_ = int(this.FFriendDigests.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FFriendDigests[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FFriendDigests.length = 0;
      }
      
      public function ClearRecommendList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFriendDigest = null;
         _loc1_ = int(this.FFriendDigests.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FFriendDigests[_loc2_];
            if(_loc3_.Type == TYPE_Recommend)
            {
               this.Delete(_loc3_);
            }
            _loc2_++;
         }
      }
      
      public function Add(param1:TFriendDigest) : void
      {
         param1.StubReferences.Reference(this);
         this.FFriendDigests.push(param1);
      }
      
      public function Delete(param1:TFriendDigest) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FFriendDigests.length)
         {
            if(param1.Identifier0 == this.FFriendDigests[_loc2_].Identifier0 && param1.Identifier1 == this.FFriendDigests[_loc2_].Identifier1)
            {
               param1.StubReferences.Dereference(this);
               this.FFriendDigests.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function get TiLiCount() : uint
      {
         return this.FFriendDigestTiLis.length;
      }
      
      public function TiLiAdd(param1:TFriendDigestTiLi) : void
      {
         param1.StubReferences.Reference(this);
         this.FFriendDigestTiLis.push(param1);
      }
      
      public function GetBooleanForEffect() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FFriendDigestTiLis.length)
         {
            if(this.FFriendDigestTiLis[_loc1_].Type == 1)
            {
               if(this.FFriendDigestTiLis[_loc1_].IsGet == 0)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function GetTiLiFriendById(param1:uint, param2:uint) : TFriendDigestTiLi
      {
         var _loc4_:int = 0;
         var _loc3_:TFriendDigestTiLi = null;
         _loc4_ = 0;
         while(_loc4_ < this.FFriendDigestTiLis.length)
         {
            if(param1 == this.FFriendDigestTiLis[_loc4_].Identifier0 && param2 == this.FFriendDigestTiLis[_loc4_].Identifier1)
            {
               if(this.FFriendDigestTiLis[_loc4_].Type == 2)
               {
                  _loc3_ = this.FFriendDigestTiLis[_loc4_];
                  break;
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function TiLiDelete(param1:TFriendDigestTiLi) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FFriendDigestTiLis.length)
         {
            if(param1.Identifier0 == this.FFriendDigestTiLis[_loc2_].Identifier0 && param1.Identifier1 == this.FFriendDigestTiLis[_loc2_].Identifier1)
            {
               param1.StubReferences.Dereference(this);
               this.FFriendDigestTiLis.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function OneKeyGetIsCanClcik() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FFriendDigestTiLis.length)
         {
            if(this.FFriendDigestTiLis[_loc1_].Type == 1)
            {
               if(!this.FFriendDigestTiLis[_loc1_].IsGet)
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function GetCountByType(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.FFriendDigestTiLis.length)
         {
            if(this.FFriendDigestTiLis[_loc3_].Type == param1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function GetLingQuCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FFriendDigestTiLis.length)
         {
            if(this.FFriendDigestTiLis[_loc2_].Type == 1)
            {
               if(this.FFriendDigestTiLis[_loc2_].IsGet)
               {
                  _loc1_++;
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function TiLiClear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TFriendDigestTiLi = null;
         _loc1_ = int(this.FFriendDigestTiLis.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FFriendDigestTiLis[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FFriendDigestTiLis.length = 0;
      }
      
      public function GetVecByType(param1:int) : Vector.<TFriendDigestTiLi>
      {
         var _loc2_:int = 0;
         this.FTempVec.length = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FFriendDigestTiLis.length)
         {
            if(this.FFriendDigestTiLis[_loc2_].Type == param1)
            {
               this.FTempVec.push(this.FFriendDigestTiLis[_loc2_]);
            }
            _loc2_++;
         }
         return this.FTempVec;
      }
      
      public function get FriendDigestTiLis() : Vector.<TFriendDigestTiLi>
      {
         return this.FFriendDigestTiLis;
      }
      
      public function set OneTimesNum(param1:int) : void
      {
         this.FOneTimesNum = param1;
      }
      
      public function get OneTimesNum() : int
      {
         return this.FOneTimesNum;
      }
      
      public function set GetCountMax(param1:int) : void
      {
         this.FGetCountMax = param1;
      }
      
      public function get GetCountMax() : int
      {
         return this.FGetCountMax;
      }
      
      public function set GiveCountMax(param1:int) : void
      {
         this.FGiveCountMax = param1;
      }
      
      public function get GiveCountMax() : int
      {
         return this.FGiveCountMax;
      }
   }
}

