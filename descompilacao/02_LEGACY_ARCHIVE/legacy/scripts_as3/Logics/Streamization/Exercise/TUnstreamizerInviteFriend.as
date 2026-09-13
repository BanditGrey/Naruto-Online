package Logics.Streamization.Exercise
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNinjafeed;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.InviteFriend.TInviteFriend;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerInviteFriend extends TUnstreamizer
   {
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FFeedConfigBins:TBins;
      
      public function TUnstreamizerInviteFriend()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<uint> = null;
         var _loc14_:Vector.<uint> = null;
         var _loc15_:TBins = null;
         var _loc16_:TBaseBox = null;
         var _loc17_:TInviteFriend = null;
         var _loc18_:TConsumeRankInfo = null;
         var _loc19_:TNinjafeed = null;
         var _loc20_:int = 0;
         _loc17_ = param2 as TInviteFriend;
         this.FFeedConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NinjaFeed);
         _loc17_.Identify = CONST_BASEACTIVITY.TYPE_NewActiveList_InviteFriend;
         _loc17_.BeginTime = param1.readUnsignedInt();
         _loc17_.EndTime = param1.readUnsignedInt();
         _loc20_ = param1.readInt();
         if(_loc17_.FeedBoxStatus != TBaseActivity.STATUS_CANGET)
         {
            _loc17_.FeedBoxStatus = _loc20_;
         }
         _loc17_.CurIndex = param1.readUnsignedInt();
         _loc17_.TotalInvite = param1.readUnsignedInt();
         _loc9_ = new TInventories();
         _loc13_ = new Vector.<uint>();
         _loc14_ = new Vector.<uint>();
         _loc19_ = this.FFeedConfigBins.GetDatebaseByIdentifier(53001) as TNinjafeed;
         _loc12_ = _loc19_.InviteAward[0].Type;
         _loc11_ = _loc19_.InviteAward[0].Code;
         _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
         _loc13_.push(_loc10_);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
         _loc9_.GetInventoryByIndex(0).Quantity = _loc19_.InviteAward[0].Amount;
         _loc17_.Inventories = _loc9_;
         _loc6_ = param1.readShort();
         _loc17_.InviteBoxs.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc16_ = new TBaseBox();
            _loc16_.Identify = param1.readUnsignedInt();
            _loc16_.Status = param1.readUnsignedInt();
            _loc19_ = this.FFeedConfigBins.GetDatebaseByIdentifier(_loc16_.Identify) as TNinjafeed;
            _loc16_.Price = _loc19_.InviteNum;
            _loc16_.Desc1 = _loc19_.Desc1;
            _loc7_ = int(_loc19_.InviteAward.length);
            _loc13_.length = 0;
            _loc14_.length = 0;
            _loc9_ = new TInventories();
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc12_ = _loc19_.InviteAward[_loc5_].Type;
               _loc11_ = _loc19_.InviteAward[_loc5_].Code;
               _loc10_ = CONST_COMMON.GetItemIDByType(_loc12_,_loc11_,_loc15_);
               _loc13_.push(_loc10_);
               _loc14_.push(_loc19_.InviteAward[_loc5_].Amount);
               _loc5_++;
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc13_);
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = _loc9_.GetInventoryByIndex(_loc5_);
               _loc8_.Quantity = _loc14_[_loc5_];
               _loc5_++;
            }
            _loc16_.Inventories = _loc9_;
            _loc17_.InviteBoxs.push(_loc16_);
            _loc4_++;
         }
         _loc6_ = param1.readShort();
         _loc17_.InviteList.length = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc18_ = new TConsumeRankInfo();
            _loc18_.UserName = TUtilityString.FetchUTF(param1);
            _loc18_.Time = param1.readUnsignedInt();
            _loc17_.InviteList.push(_loc18_);
            _loc4_++;
         }
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
   }
}

