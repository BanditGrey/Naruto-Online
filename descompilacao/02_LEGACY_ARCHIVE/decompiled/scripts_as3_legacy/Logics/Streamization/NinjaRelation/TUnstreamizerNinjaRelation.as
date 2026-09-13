package Logics.Streamization.NinjaRelation
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TFetters;
   import Logics.DatebaseVO.VO.TFettersTeam;
   import Logics.NinjaRelation.TNinjaGroupBuff;
   import Logics.NinjaRelation.TNinjaGroupBuffs;
   import Logics.NinjaRelation.TNinjaTeamBuff;
   import Logics.NinjaRelation.TNinjaTeamBuffs;
   import Logics.Streamization.Characters.TUnstreamizerCharacter;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   public class TUnstreamizerNinjaRelation extends TUnstreamizer
   {
      
      protected var FUnstreamizerCharacter:TUnstreamizerCharacter;
      
      public function TUnstreamizerNinjaRelation()
      {
         super();
         this.FUnstreamizerCharacter = new TUnstreamizerCharacter();
      }
      
      protected function UnstreamizationPerformNinjaTeamBuffsByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TNinjaTeamBuffs = null;
         var _loc5_:TNinjaTeamBuff = null;
         var _loc6_:TFettersTeam = null;
         var _loc7_:TBins = null;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:uint = 0;
         var _loc12_:Array = null;
         _loc4_ = param2 as TNinjaTeamBuffs;
         _loc7_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_FettersTeam) as TBins;
         _loc9_ = uint(_loc7_.Count);
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc6_ = _loc7_.GetDatebaseByIndex(_loc8_) as TFettersTeam;
            _loc5_ = new TNinjaTeamBuff();
            _loc12_ = Json.decode(_loc6_.TeamId) as Array;
            _loc5_.GourpID = _loc6_.Identifier;
            _loc5_.TeamName = _loc6_.TeamName;
            _loc11_ = _loc12_.length;
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc5_.TeamIDs[_loc10_] = _loc12_[_loc10_];
               _loc10_++;
            }
            _loc5_.BuffValue[0] = _loc6_.DescriptionOne;
            _loc5_.BuffValue[1] = _loc6_.DescriptionDouble;
            _loc5_.BuffValue[2] = _loc6_.DescriptionTriple;
            _loc5_.BuffValue[3] = _loc6_.DescriptionUltra;
            _loc5_.BuffValue[4] = _loc6_.DescriptionPenta;
            _loc4_.Add(_loc5_);
            _loc8_++;
         }
      }
      
      protected function UnstreamizationPerformNinjaGroupBuffsByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TNinjaGroupBuffs = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:ByteArray = null;
         _loc4_ = param2 as TNinjaGroupBuffs;
         _loc8_ = param1 as ByteArray;
         _loc7_ = new Vector.<uint>();
         _loc6_ = uint(_loc8_.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_.push(_loc8_.readUnsignedInt());
            _loc5_++;
         }
         this.CheckGroupData(_loc7_,_loc4_);
         _loc6_ = uint(_loc8_.readShort());
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            this.UnstreamizationPerformUpdateNinjaGroupBuff(_loc8_,_loc4_,null);
            _loc5_++;
         }
      }
      
      protected function SetGroupData(param1:TNinjaGroupBuffs, param2:uint = 0, param3:uint = 0, param4:uint = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TBins = null;
         var _loc8_:TNinjaGroupBuff = null;
         var _loc9_:TFetters = null;
         var _loc10_:uint = 0;
         _loc7_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Fetters) as TBins;
         _loc9_ = _loc7_.GetDatebaseByValue2("TeamId",param2,"FriendLevel",param4) as TFetters;
         if(_loc9_ != null)
         {
            _loc8_ = param1.GetNinjaGroupBuffByIdentifier(param2);
            _loc8_.CurExpricence = param3;
            _loc8_.FriendLevel = param4;
            _loc8_.IsActivited = param4 > 0;
            _loc8_.CurStartExpricence = _loc9_.NeedExp;
            _loc8_.CurrentBuffDesc = _loc9_.Description;
            _loc8_.NextExpricence = _loc9_.ExpAll + 1;
            _loc8_.ConfigId = _loc9_.Identifier;
            _loc10_ = uint(_loc9_.Identifier);
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Fetters,++_loc10_) as TFetters;
            if(_loc9_ != null)
            {
               _loc8_.AdvancedBuffDesc = _loc9_.Description;
            }
            else if(param3 >= _loc8_.NextExpricence)
            {
               _loc8_.AdvancedBuffDesc = "";
               _loc8_.CurExpricence = _loc8_.NextExpricence;
            }
         }
      }
      
      protected function CheckGroupData(param1:Vector.<uint>, param2:TNinjaGroupBuffs) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TBins = null;
         var _loc8_:TNinjaGroupBuff = null;
         var _loc9_:TFetters = null;
         var _loc10_:THero = null;
         var _loc11_:TBins = null;
         var _loc12_:TConfigValue = null;
         var _loc13_:Vector.<Object> = null;
         var _loc14_:TBaseHero = null;
         _loc11_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TAVERN_Hero_Source) as TConfigValue;
         _loc13_ = _loc12_.Value as Vector.<Object>;
         _loc7_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Fetters) as TBins;
         param2.Clear();
         _loc4_ = uint(_loc7_.Count);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc9_ = _loc7_.GetDatebaseByIndex(_loc3_) as TFetters;
            _loc8_ = param2.GetNinjaGroupBuffByIdentifier(_loc9_.TeamId);
            if(_loc8_ == null)
            {
               _loc8_ = new TNinjaGroupBuff();
               this.SetNinjaGroupBuffInfo(_loc9_,_loc8_);
               _loc8_.IsMistery = Boolean(_loc9_.IsMystical);
               _loc8_.CurrentBuffDesc = _loc9_.Description;
               param2.Add(_loc8_);
               _loc6_ = uint(_loc8_.Heros.Count);
               _loc5_ = 0;
               while(_loc5_ < _loc6_)
               {
                  _loc10_ = _loc8_.Heros.GetHeroByIndex(_loc5_) as THero;
                  _loc14_ = _loc11_.GetDatebaseByIdentifier(_loc10_.Identifier) as TBaseHero;
                  _loc10_.Reousrce = _loc13_[_loc14_.Source] as String;
                  _loc10_.RecruitStatus = this.CheckHeroIsRecruit(param1,_loc10_.Identifier);
                  _loc5_++;
               }
            }
            _loc3_++;
         }
      }
      
      protected function SetNinjaGroupBuffInfo(param1:TFetters, param2:TNinjaGroupBuff) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         _loc4_ = new Vector.<uint>();
         param2.TeamID = param1.TeamId;
         param2.GroupName = param1.Name;
         _loc3_ = Json.decode(param1.Combination) as Array;
         _loc6_ = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_[_loc5_] = _loc3_[_loc5_];
            _loc5_++;
         }
         this.FUnstreamizerCharacter.UnstreamizeGenerateHerosByIdentifiers(null,param2.Heros,_loc4_);
      }
      
      protected function CheckHeroIsRecruit(param1:Vector.<uint>, param2:uint) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc4_ = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param2 == param1[_loc3_])
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function UnstreamizationPerformUpdateNinjaGroupBuff(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TNinjaGroupBuffs = null;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:ByteArray = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         _loc4_ = param2 as TNinjaGroupBuffs;
         _loc7_ = param1 as ByteArray;
         _loc8_ = _loc7_.readUnsignedInt();
         _loc9_ = _loc7_.readUnsignedInt();
         _loc10_ = _loc7_.readUnsignedInt();
         this.SetGroupData(_loc4_,_loc8_,_loc9_,_loc10_);
      }
      
      public function UnstreamizeNinjaTeamBuffsByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformNinjaTeamBuffsByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeNinjaGroupBuffsByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformNinjaGroupBuffsByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeUpdateNinjaGroupBuff(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerformUpdateNinjaGroupBuff(param1,param2,param3);
      }
   }
}

