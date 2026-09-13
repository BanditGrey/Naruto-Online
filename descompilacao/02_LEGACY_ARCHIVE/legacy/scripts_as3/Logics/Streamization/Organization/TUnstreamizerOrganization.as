package Logics.Streamization.Organization
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TKamiTree;
   import Logics.DatebaseVO.VO.TOrganizationBase;
   import Logics.Organization.Elements.TBaseRankList;
   import Logics.Organization.TBaseOrganization;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.Organization.TBaseOrganiztionList;
   import Logics.Organization.TMuyeGuardRank;
   import Logics.Organization.TreasureTree.TBasicTreasureTree;
   import Logics.Organization.TreasureTree.TOperatingShowInfo;
   import Logics.Organization.TreasureTree.TOperatingShowInfos;
   import Logics.Organization.TreasureTree.TUserFruitInfo;
   import Logics.Organization.TreasureTree.TUserFruitInfos;
   import Logics.Organization.TreasureTree.TUserWaterInfo;
   import Logics.Organization.TreasureTree.TUserWaterInfos;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerOrganization extends TUnstreamizer
   {
      
      protected var FTreeExps:Vector.<uint>;
      
      public function TUnstreamizerOrganization()
      {
         super();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBaseOrganization = null;
         var _loc7_:Vector.<Object> = null;
         var _loc8_:TBins = null;
         var _loc9_:TOrganizationBase = null;
         var _loc10_:Object = null;
         _loc6_ = param2 as TBaseOrganization;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         _loc6_.OrgId = param1.readUnsignedInt();
         if(_loc6_.OrgId > 0)
         {
            _loc6_.OrgName = TUtilityString.FetchUTF(param1);
            _loc6_.OrgFamily = param1.readShort();
            _loc6_.OrgMoney = param1.readUnsignedInt();
            _loc6_.MasterName = TUtilityString.FetchUTF(param1);
            _loc6_.OrgLevel = param1.readUnsignedInt();
            _loc6_.OrgContribution = param1.readUnsignedInt();
            _loc6_.OrgMembers = param1.readUnsignedInt();
            _loc6_.OrgExploit.High = param1.readUnsignedInt();
            _loc6_.OrgExploit.Low = param1.readUnsignedInt();
            _loc6_.OrgNotice = TUtilityString.FetchUTF(param1);
            _loc6_.OrgPower = param1.readByte();
            _loc5_ = param1.readShort();
            _loc7_ = new Vector.<Object>(_loc5_);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc10_ = {
                  "type":0,
                  "level":0
               };
               _loc7_[_loc4_] = _loc10_;
               _loc7_[_loc4_].type = param1.readUnsignedInt();
               _loc7_[_loc4_].level = param1.readUnsignedInt();
               _loc4_++;
            }
            _loc6_.OrgAddition = _loc7_;
            _loc9_ = _loc8_.GetDatebaseByIndex(_loc6_.OrgLevel - 1) as TOrganizationBase;
            _loc6_.MoneyAddition = _loc9_.GetMoreSiv;
            _loc6_.ExpAddition = _loc9_.GetMoreExp;
            _loc6_.OrgMaxMemberCount = _loc9_.OrgMaxNumber;
         }
         else
         {
            _loc6_.OrgName = "";
            _loc6_.OrgFamily = 0;
            _loc6_.OrgMoney = 0;
            _loc6_.MasterName = "";
            _loc6_.OrgLevel = 0;
            _loc6_.OrgContribution = 0;
            _loc6_.OrgMembers = 0;
            _loc6_.OrgExploit.High = 0;
            _loc6_.OrgExploit.Low = 0;
            _loc6_.OrgNotice = "";
            _loc6_.OrgPower = 0;
         }
      }
      
      protected function Unstreamization_OrgMembersList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TBaseOrganizationMember = null;
         var _loc5_:Vector.<TBaseOrganizationMember> = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc5_ = param2 as Vector.<TBaseOrganizationMember>;
         _loc7_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc4_ = new TBaseOrganizationMember(_loc8_,_loc9_);
            _loc4_.PlayerName = TUtilityString.FetchUTF(param1);
            _loc4_.Rank = param1.readUnsignedInt();
            _loc4_.PlayerLevel = param1.readUnsignedInt();
            _loc4_.OrgDuties = param1.readUnsignedInt();
            _loc4_.TodayContribution = param1.readUnsignedInt();
            _loc4_.TotalContribution = param1.readUnsignedInt();
            _loc4_.LastLogginTime = param1.readUnsignedInt();
            _loc4_.PlayerOrgPower.High = param1.readUnsignedInt();
            _loc4_.PlayerOrgPower.Low = param1.readUnsignedInt();
            _loc5_[_loc6_] = _loc4_;
            _loc6_++;
         }
      }
      
      protected function Unstreamization_OrgApplyAndSwitchList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TBaseOrganizationMember = null;
         var _loc5_:Vector.<TBaseOrganizationMember> = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         _loc5_ = param2 as Vector.<TBaseOrganizationMember>;
         _loc7_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = param1.readUnsignedInt();
            _loc9_ = param1.readUnsignedInt();
            _loc4_ = new TBaseOrganizationMember(_loc8_,_loc9_);
            _loc4_.PlayerName = TUtilityString.FetchUTF(param1);
            _loc4_.PlayerLevel = param1.readShort();
            _loc4_.Rank = param1.readUnsignedInt();
            _loc4_.PlayerOrgPower.High = param1.readUnsignedInt();
            _loc4_.PlayerOrgPower.Low = param1.readUnsignedInt();
            _loc5_[_loc6_] = _loc4_;
            _loc6_++;
         }
      }
      
      protected function Unstreamization_OrgList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TBaseOrganiztionList = null;
         var _loc7_:Vector.<TBaseOrganiztionList> = null;
         var _loc8_:TBins = null;
         var _loc9_:TOrganizationBase = null;
         _loc7_ = param2 as Vector.<TBaseOrganiztionList>;
         _loc8_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         _loc5_ = param1.readShort();
         if(_loc5_ > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = new TBaseOrganiztionList();
               _loc6_.OrgID = param1.readUnsignedInt();
               _loc6_.OrgName = TUtilityString.FetchUTF(param1);
               _loc6_.OrgLevel = param1.readShort();
               _loc6_.OrgMembersCount = param1.readShort();
               _loc6_.OrgMasterName = TUtilityString.FetchUTF(param1);
               _loc6_.OrgFamily = param1.readByte();
               _loc6_.OrgIsApply = false;
               _loc9_ = _loc8_.GetDatebaseByIndex(_loc6_.OrgLevel - 1) as TOrganizationBase;
               _loc6_.OrgMaxMemberCount = _loc9_.OrgMaxNumber;
               _loc7_[_loc4_] = _loc6_;
               _loc4_++;
            }
         }
      }
      
      protected function Unstreamize_MuyeGuardRank(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TBaseRankList = null;
         var _loc8_:TMuyeGuardRank = null;
         _loc8_ = param2 as TMuyeGuardRank;
         _loc6_ = param1.readUnsignedInt();
         if(_loc6_ != 0)
         {
            _loc8_.WinStatus = false;
            _loc8_.CurTurnOrgName = "";
            _loc8_.CurTurnOrgFamily = 0;
            _loc8_.BeferTurnOrgName = "";
            _loc8_.BeferTurnOrgFamily = 0;
            _loc8_.DefendDay = 0;
            _loc8_.OrgRankList.length = 0;
            return;
         }
         _loc8_.WinStatus = Boolean(param1.readUnsignedByte());
         _loc8_.CurTurnOrgName = TUtilityString.FetchUTF(param1);
         _loc8_.CurTurnOrgFamily = param1.readUnsignedByte();
         _loc8_.BeferTurnOrgName = TUtilityString.FetchUTF(param1);
         _loc8_.BeferTurnOrgFamily = param1.readUnsignedByte();
         _loc8_.DefendDay = param1.readUnsignedShort();
         _loc8_.OrgRankList.length = 0;
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = new TBaseRankList();
            _loc7_.RankName = TUtilityString.FetchUTF(param1);
            _loc7_.RankFamily = param1.readUnsignedByte();
            _loc7_.RankScore = param1.readUnsignedInt();
            _loc8_.OrgRankList.push(_loc7_);
            _loc4_++;
         }
      }
      
      protected function Unstreamize_MuyeBattleRank(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Vector.<TBaseOrganiztionList> = null;
         var _loc7_:TBaseOrganiztionList = null;
         var _loc8_:Vector.<TBaseOrganizationMember> = null;
         var _loc9_:TBaseOrganizationMember = null;
         _loc6_ = param2 as Vector.<TBaseOrganiztionList>;
         _loc8_ = param3 as Vector.<TBaseOrganizationMember>;
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = new TBaseOrganiztionList();
            _loc7_.OrgFamily = param1.readUnsignedByte();
            TUtilityString.FetchUTF(param1);
            _loc7_.OrgName = TUtilityString.FetchUTF(param1);
            _loc7_.Score = param1.readUnsignedInt();
            _loc6_.push(_loc7_);
            _loc4_++;
         }
         _loc5_ = param1.readUnsignedShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc9_ = new TBaseOrganizationMember(0,0);
            _loc9_.PlayerFamily = param1.readUnsignedByte();
            _loc9_.PlayerName = TUtilityString.FetchUTF(param1);
            _loc9_.OrgName = TUtilityString.FetchUTF(param1);
            _loc9_.Score = param1.readUnsignedInt();
            _loc8_.push(_loc9_);
            _loc4_++;
         }
      }
      
      protected function UnstreamizationPerformTreasureTree(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TBasicTreasureTree = null;
         var _loc5_:ByteArray = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:TConfigValue = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:TUserWaterInfos = null;
         var _loc16_:TUserWaterInfo = null;
         var _loc17_:TUserFruitInfo = null;
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KAMITREE_EXP) as TConfigValue;
         this.FTreeExps = _loc12_.Value as Vector.<uint>;
         _loc4_ = param2 as TBasicTreasureTree;
         _loc5_ = param1 as ByteArray;
         this.UnstreamizationPerformTreasureTreeWaterInfos(param1,_loc4_.UserWaterInfos,param3);
         this.UnstreamizationPerformTreasureTreeFruitInfos(param1,_loc4_.UserFruitInfos,null);
         _loc4_.OrgFruitMatureTimes = _loc5_.readUnsignedInt();
         _loc4_.OrgFruitPickCount = _loc5_.readUnsignedInt();
         _loc4_.UserFruitPickCount = _loc5_.readUnsignedInt();
         _loc4_.UserWaterCount = _loc5_.readUnsignedInt();
         _loc4_.PushChakaraCount = _loc5_.readUnsignedInt();
         _loc4_.OrgFruitUpdateTime = _loc5_.readUnsignedInt();
         _loc17_ = new TUserFruitInfo();
         _loc17_.FruitName = STRING_ORGANIZATION.STRING_SecretFruit;
         _loc17_.FruitMatureTime = _loc4_.OrgFruitMatureTimes;
         _loc17_.FruitEvolveTime = _loc4_.OrgFruitUpdateTime;
         _loc4_.UserFruitInfos.Add(_loc17_);
         _loc6_ = _loc5_.readUnsignedInt();
         _loc4_.TreeCurrentExp = _loc6_;
         _loc4_.AddPushChakaraRestCount = _loc5_.readUnsignedInt();
         if(_loc6_ >= this.FTreeExps[this.FTreeExps.length - 2])
         {
            _loc4_.TreeLevel = this.FTreeExps.length;
            _loc4_.TreeLevelupExp = 0;
         }
         else
         {
            _loc8_ = this.FTreeExps.length;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc11_ = this.FTreeExps[_loc7_];
               if(_loc11_ > _loc6_)
               {
                  _loc4_.TreeLevel = _loc7_ + 1;
                  _loc4_.TreeLevelupExp = _loc11_;
                  break;
               }
               _loc7_++;
            }
         }
         _loc8_ = uint(_loc5_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc13_ = _loc5_.readUnsignedInt();
            _loc14_ = _loc5_.readUnsignedInt();
            if(!(_loc13_ == SLogicsCore.Character.Identifier0 && _loc14_ == SLogicsCore.Character.Identifier1))
            {
               _loc16_ = _loc4_.UserWaterInfos.GetUserWaterByIdentifier(_loc13_,_loc14_);
               if(_loc16_ != null)
               {
                  if(_loc16_.OrgMemberID0 == _loc13_ && _loc16_.OrgMemberID1 == _loc14_)
                  {
                     _loc16_.IsOnline = true;
                  }
               }
            }
            _loc7_++;
         }
         this.UnstreamizationPerformTreasureTreeShowInfos(param1,_loc4_.OperatingShowInfos,null);
         _loc4_.UserWaterInfos.Sort();
         _loc4_.PushChakaraCDTime = _loc5_.readUnsignedInt();
         _loc4_.IsPickOrgFruit = _loc5_.readUnsignedInt();
      }
      
      protected function UnstreamizationPerformTreasureTreeWaterInfos(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TUserWaterInfos = null;
         var _loc6_:TUserWaterInfo = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Vector.<TBaseOrganizationMember> = null;
         var _loc14_:TBaseOrganizationMember = null;
         var _loc15_:uint = 0;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TUserWaterInfos;
         _loc13_ = param3 as Vector.<TBaseOrganizationMember>;
         _loc5_.Clear();
         _loc10_ = _loc13_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc10_)
         {
            _loc14_ = _loc13_[_loc8_];
            if(!(_loc14_.Identifier0 == SLogicsCore.Character.Identifier0 && _loc14_.Identifier1 == SLogicsCore.Character.Identifier1))
            {
               _loc6_ = new TUserWaterInfo();
               _loc6_.OrgMemberID0 = _loc14_.Identifier0;
               _loc6_.OrgMemberID1 = _loc14_.Identifier1;
               _loc6_.OrgMemberName = _loc14_.PlayerName;
               _loc6_.OrgDuty = _loc14_.OrgDuties;
               _loc6_.OrgMemberLevel = _loc14_.PlayerLevel;
               _loc5_.Add(_loc6_);
            }
            _loc8_++;
         }
         _loc9_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc11_ = _loc4_.readUnsignedInt();
            _loc12_ = _loc4_.readUnsignedInt();
            _loc6_ = _loc5_.GetUserWaterByIdentifier(_loc11_,_loc12_);
            if(_loc6_ != null)
            {
               _loc6_.NextWaterTime = _loc4_.readUnsignedInt();
            }
            else
            {
               _loc15_ = _loc4_.readUnsignedInt();
            }
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformTreasureTreeFruitInfos(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:TUserFruitInfos = null;
         var _loc6_:TUserFruitInfo = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TKamiTree = null;
         _loc4_ = param1 as ByteArray;
         _loc5_ = param2 as TUserFruitInfos;
         _loc5_.Clear();
         _loc8_ = uint(_loc4_.readShort());
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc6_ = new TUserFruitInfo();
            _loc6_.FruitID = _loc4_.readUnsignedInt();
            _loc6_.FruitLevel = _loc4_.readUnsignedInt();
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_KamiTree,_loc6_.FruitID) as TKamiTree;
            if(_loc9_ != null)
            {
               _loc6_.FruitName = _loc9_.Name;
            }
            _loc6_.FruitMatureTime = _loc4_.readUnsignedInt();
            _loc6_.FruitEvolveTime = _loc4_.readUnsignedInt();
            _loc5_.Add(_loc6_);
            _loc7_++;
         }
      }
      
      protected function UnstreamizationPerformTreasureTreeShowInfos(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:TOperatingShowInfos = null;
         var _loc8_:TOperatingShowInfo = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:TKamiTree = null;
         _loc6_ = param1 as ByteArray;
         _loc7_ = param2 as TOperatingShowInfos;
         _loc7_.Clear();
         _loc5_ = uint(_loc6_.readShort());
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc8_ = new TOperatingShowInfo();
            _loc8_.ShowIndex = _loc6_.readUnsignedInt();
            _loc8_.ShowType = _loc6_.readUnsignedInt();
            _loc8_.UserName = TUtilityString.FetchUTF(_loc6_);
            _loc8_.UserQuality = _loc6_.readUnsignedInt();
            _loc8_.AddExp = _loc6_.readUnsignedInt();
            _loc8_.CurrentTreeLevel = _loc6_.readUnsignedInt();
            _loc9_ = _loc6_.readUnsignedInt();
            _loc10_ = _loc6_.readUnsignedInt();
            _loc8_.RewardName = STRING_COMMON.GetItemNameByType(_loc9_,_loc10_);
            _loc8_.RewardCount = _loc6_.readUnsignedInt();
            _loc8_.FruitID = _loc6_.readUnsignedInt();
            _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_KamiTree,_loc8_.FruitID) as TKamiTree;
            if(_loc11_ != null)
            {
               _loc8_.FruitName = _loc11_.Name;
            }
            _loc7_.Add(_loc8_);
            _loc4_++;
         }
         _loc7_.Sort();
      }
      
      override public function Unstreamize(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform(param1,param2,param3);
      }
      
      public function UnstreamizeOrganizationMembers(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamization_OrgMembersList(param1,param2,param3);
      }
      
      public function UnstreamizeOrganizationApplyAndSwitchList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamization_OrgApplyAndSwitchList(param1,param2,param3);
      }
      
      public function UnstreamizeOrganizationList(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamization_OrgList(param1,param2,param3);
      }
      
      public function UnstreamizeMuyeGuardRank(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamize_MuyeGuardRank(param1,param2,param3);
      }
      
      public function UnstreamizeMuyeBattleRank(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamize_MuyeBattleRank(param1,param2,param3);
      }
      
      public function UnstreamizeTreasureTree(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformTreasureTree(param1,param2,param3);
      }
   }
}

