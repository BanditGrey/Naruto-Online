package Logics.Streamization.Globalboss
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TDafubenMall;
   import Logics.Globalboss.TGlobalboss;
   import Logics.Globalboss.TGlobalbossChapter;
   import Logics.Globalboss.TGlobalbossRank;
   import Logics.Inventories.TInventorySample;
   import Logics.Inventories.TInventorySamples;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventorySample;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerGlobalboss extends TUnstreamizer
   {
      
      public static var CurChapterId:int;
      
      public static var CurNewChapterId:int;
      
      protected var FUnstreamizerInventorySample:TUnstreamizerInventorySample;
      
      public function TUnstreamizerGlobalboss()
      {
         super();
         this.FUnstreamizerInventorySample = new TUnstreamizerInventorySample();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TGlobalboss = null;
         var _loc7_:TGlobalboss = null;
         var _loc8_:TGlobalboss = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc4_ = param1.readShort();
         var _loc9_:Boolean = true;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new TGlobalboss();
            _loc7_.stageId = param1.readUnsignedInt();
            _loc7_.starNum = param1.readUnsignedInt();
            _loc10_ = param1.readShort();
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               _loc7_.PassIds.push(param1.readUnsignedInt());
               _loc11_++;
            }
            if(_loc6_ == null)
            {
               _loc6_ = _loc8_ = _loc7_;
               if(_loc6_.Status == 0 && _loc9_)
               {
                  _loc6_.Status = 1;
                  _loc6_.Current = _loc6_;
                  _loc9_ = false;
               }
            }
            else
            {
               _loc8_.Next = _loc7_;
               _loc8_ = _loc8_.Next;
               if(_loc7_.Status == 0 && _loc9_)
               {
                  _loc7_.Status = 1;
                  _loc6_.Current = _loc7_;
                  _loc9_ = false;
               }
            }
            _loc5_++;
         }
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new TGlobalboss();
            _loc7_.stageId = param1.readUnsignedInt();
            _loc7_.starNum = param1.readUnsignedInt();
            _loc10_ = param1.readShort();
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               _loc7_.PassIds.push(param1.readUnsignedInt());
               _loc11_++;
            }
            _loc8_.Next = _loc7_;
            _loc8_ = _loc8_.Next;
            if(_loc7_.Status == 0 && _loc9_)
            {
               _loc7_.Status = 1;
               _loc6_.Current = _loc7_;
               _loc9_ = false;
            }
            _loc5_++;
         }
         if(_loc6_.Current == null)
         {
            _loc6_.Current = _loc7_;
         }
         SLogicsCore.Globalboss = _loc6_;
      }
      
      public function UnstreamizationPerformNew(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:TGlobalboss = null;
         var _loc9_:TGlobalboss = null;
         var _loc10_:TGlobalboss = null;
         var _loc11_:TGlobalboss = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc6_:Vector.<TGlobalboss> = new Vector.<TGlobalboss>();
         var _loc7_:Vector.<TGlobalboss> = new Vector.<TGlobalboss>();
         _loc4_ = param1.readShort();
         var _loc12_:Boolean = true;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = new TGlobalboss();
            _loc10_.stageId = param1.readUnsignedInt();
            _loc10_.starNum = param1.readUnsignedInt();
            _loc13_ = param1.readShort();
            _loc14_ = 0;
            while(_loc14_ < _loc13_)
            {
               _loc10_.PassIds.push(param1.readUnsignedInt());
               _loc14_++;
            }
            if(_loc10_.Dafuben.Level == 1)
            {
               _loc6_.push(_loc10_);
            }
            else if(_loc10_.Dafuben.Level == 3)
            {
               _loc7_.push(_loc10_);
            }
            _loc5_++;
         }
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = new TGlobalboss();
            _loc10_.stageId = param1.readUnsignedInt();
            _loc10_.starNum = param1.readUnsignedInt();
            _loc13_ = param1.readShort();
            _loc14_ = 0;
            while(_loc14_ < _loc13_)
            {
               _loc10_.PassIds.push(param1.readUnsignedInt());
               _loc14_++;
            }
            if(_loc10_.Dafuben.Level == 1)
            {
               _loc6_.push(_loc10_);
            }
            else if(_loc10_.Dafuben.Level == 3)
            {
               _loc7_.push(_loc10_);
            }
            _loc5_++;
         }
         _loc4_ = int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = _loc6_[_loc5_];
            if(_loc8_ == null)
            {
               _loc8_ = _loc11_ = _loc10_;
               if(_loc8_.Status == 0 && _loc12_)
               {
                  _loc8_.Status = 1;
                  _loc8_.Current = _loc8_;
                  _loc12_ = false;
               }
            }
            else
            {
               _loc11_.Next = _loc10_;
               _loc11_ = _loc11_.Next;
               if(_loc10_.Status == 0 && _loc12_)
               {
                  _loc10_.Status = 1;
                  _loc8_.Current = _loc10_;
                  _loc12_ = false;
               }
            }
            _loc5_++;
         }
         if(Boolean(_loc8_) && _loc8_.Current == null)
         {
            _loc8_.Current = _loc10_;
         }
         _loc4_ = int(_loc7_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = _loc7_[_loc5_];
            if(_loc9_ == null)
            {
               _loc9_ = _loc11_ = _loc10_;
               if(_loc9_.Status == 0 && _loc12_)
               {
                  _loc9_.Status = 1;
                  _loc9_.Current = _loc9_;
                  _loc12_ = false;
               }
            }
            else
            {
               _loc11_.Next = _loc10_;
               _loc11_ = _loc11_.Next;
               if(_loc10_.Status == 0 && _loc12_)
               {
                  _loc10_.Status = 1;
                  _loc9_.Current = _loc10_;
                  _loc12_ = false;
               }
            }
            _loc5_++;
         }
         if(Boolean(_loc9_) && _loc9_.Current == null)
         {
            _loc9_.Current = _loc10_;
         }
         SLogicsCore.Globalboss = _loc8_;
         SLogicsCore.GlobalbossNew = _loc9_;
      }
      
      public function UnstreamizationPerformByIdentity(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TGlobalboss = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         var _loc8_:int = 0;
         _loc4_ = param2 as TGlobalboss;
         _loc5_ = int(param1.readUnsignedInt());
         _loc6_ = param1.readShort();
         _loc7_ = new Vector.<int>();
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_.push(param1.readUnsignedInt());
            _loc8_++;
         }
         while(_loc4_)
         {
            if(_loc4_.stageId == _loc5_)
            {
               _loc4_.PassIds = _loc7_;
            }
            _loc4_ = _loc4_.Next;
         }
      }
      
      public function UnstreamizationGlobalbossChapter(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TGlobalbossChapter = null;
         var _loc7_:TGlobalbossChapter = null;
         var _loc8_:TGlobalbossChapter = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new TGlobalbossChapter();
            _loc7_.Identity = param1.readUnsignedInt();
            _loc7_.starNum = param1.readUnsignedInt();
            _loc7_.unlock = param1.readUnsignedInt();
            _loc9_ = param1.readShort();
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc11_ = param1.readInt();
               _loc12_ = param1.readInt();
               _loc7_.rewardInfo.push({
                  "awardId":_loc11_,
                  "reward":_loc12_
               });
               _loc10_++;
            }
            if(_loc6_ == null)
            {
               _loc6_ = _loc8_ = _loc7_;
            }
            else
            {
               _loc8_.Next = _loc7_;
               _loc8_ = _loc8_.Next;
            }
            _loc5_++;
         }
         SLogicsCore.GlobalbossChapter = _loc6_;
      }
      
      public function UnstreamizationGlobalbossNewChapter(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:TGlobalbossChapter = null;
         var _loc9_:TGlobalbossChapter = null;
         var _loc10_:TGlobalbossChapter = null;
         var _loc11_:TGlobalbossChapter = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc6_:Vector.<TGlobalbossChapter> = new Vector.<TGlobalbossChapter>();
         var _loc7_:Vector.<TGlobalbossChapter> = new Vector.<TGlobalbossChapter>();
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = new TGlobalbossChapter();
            _loc10_.Identity = param1.readUnsignedInt();
            _loc10_.starNum = param1.readUnsignedInt();
            _loc10_.unlock = param1.readUnsignedInt();
            if((CurChapterId == 0 || _loc10_.unlock == 1) && _loc10_.DafubenAward.Level == 1)
            {
               CurChapterId = _loc10_.Identity;
            }
            if((CurNewChapterId == 0 || _loc10_.unlock == 1) && _loc10_.DafubenAward.Level == 3)
            {
               CurNewChapterId = _loc10_.Identity;
            }
            _loc12_ = param1.readShort();
            _loc13_ = 0;
            while(_loc13_ < _loc12_)
            {
               _loc14_ = param1.readInt();
               _loc15_ = param1.readInt();
               _loc10_.rewardInfo.push({
                  "awardId":_loc14_,
                  "reward":_loc15_
               });
               _loc13_++;
            }
            if(_loc10_.DafubenAward.Level == 1)
            {
               _loc6_.push(_loc10_);
            }
            else if(_loc10_.DafubenAward.Level == 3)
            {
               _loc7_.push(_loc10_);
            }
            _loc5_++;
         }
         _loc4_ = int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = _loc6_[_loc5_];
            if(_loc8_ == null)
            {
               _loc8_ = _loc11_ = _loc10_;
            }
            else
            {
               _loc11_.Next = _loc10_;
               _loc11_ = _loc11_.Next;
            }
            _loc5_++;
         }
         _loc4_ = int(_loc7_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = _loc7_[_loc5_];
            if(_loc9_ == null)
            {
               _loc9_ = _loc11_ = _loc10_;
            }
            else
            {
               _loc11_.Next = _loc10_;
               _loc11_ = _loc11_.Next;
            }
            _loc5_++;
         }
         SLogicsCore.GlobalbossChapter = _loc8_;
         SLogicsCore.GlobalbossChapterNew = _loc9_;
      }
      
      public function UnstreamizationGlobalbossRank(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:Vector.<TGlobalbossRank> = null;
         var _loc5_:TGlobalbossRank = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc4_ = param2 as Vector.<TGlobalbossRank>;
         _loc4_.length = 0;
         _loc6_ = param1.readShort();
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = new TGlobalbossRank();
            _loc5_.Rank = param1.readInt();
            _loc5_.StarNum = param1.readInt();
            _loc5_.Username = TUtilityString.FetchUTF(param1);
            _loc5_.Userlevel = param1.readInt();
            _loc5_.Agent = TUtilityString.FetchUTF(param1);
            _loc5_.ServerName = TUtilityString.FetchUTF(param1);
            _loc4_.push(_loc5_);
            _loc7_++;
         }
         _loc4_.sort(this.sortFunctionOnRank);
      }
      
      protected function sortFunctionOnRank(param1:TGlobalbossRank, param2:TGlobalbossRank) : int
      {
         if(param1.Rank > param2.Rank)
         {
            return 1;
         }
         return -1;
      }
      
      protected function UnstreamizationPerform_InventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TBins = null;
         var _loc6_:TDafubenMall = null;
         var _loc7_:TInventorySamples = null;
         var _loc8_:TInventorySample = null;
         _loc7_ = param2 as TInventorySamples;
         _loc5_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DafubenMall);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.Count)
         {
            _loc6_ = _loc5_.GetDatebaseByIndex(_loc4_) as TDafubenMall;
            _loc8_ = new TInventorySample();
            this.FUnstreamizerInventorySample.UnstreamizerGlobalArenaMallByDatabase(null,_loc8_,_loc6_);
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
      }
      
      public function UnstreamizeInventorySamplesByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySamplesByDatabase(param1,param2,param3);
      }
   }
}

