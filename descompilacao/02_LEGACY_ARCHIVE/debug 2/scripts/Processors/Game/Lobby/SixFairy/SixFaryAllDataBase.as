package Processors.Game.Lobby.SixFairy
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TSpiritEnergy;
   import Logics.DatebaseVO.VO.TSpiritStage;
   import Logics.Inventories.TInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class SixFaryAllDataBase
   {
      
      protected var FCurCustomsId:int;
      
      protected var FNextCustomId:int;
      
      protected var FIsPlayerEffect:Boolean = false;
      
      protected var FCurPetId:int;
      
      protected var FNextPetId:int;
      
      protected var FCurCustomsLayer:int;
      
      protected var FCurLayerCustoms:int;
      
      protected var FNextCustomsLayer:int;
      
      protected var FNextLayerCustoms:int;
      
      protected var FThisDayCanChallengeCount:int;
      
      protected var FThisThroudCount:int;
      
      protected var FCurPetAttri:Vector.<Number>;
      
      protected var FNextPetAttri:Vector.<Number>;
      
      protected var FCurPetName:String = "";
      
      protected var FCurPetLvel:int;
      
      protected var FCurPetPosition:int;
      
      protected var FBatchCount:int;
      
      protected var FUserLevel:int;
      
      protected var FaddExp:int;
      
      protected var FcurrExp:int;
      
      protected var FCurToNextExp:int;
      
      protected var FrealTimes:int;
      
      protected var FgoldTimes:int;
      
      protected var FPracticeTimes:int;
      
      protected var FGetRewardBtnState:int;
      
      protected var FExpendStuffId:int;
      
      protected var FBreakthroughStuffId:int;
      
      protected var FCurCustoms_customsName:String = "";
      
      protected var FCurCustoms_bossName:String = "";
      
      protected var FCurCustoms_bossId:int;
      
      protected var FCurReinCarnationLevel:uint;
      
      protected var FNextReinCarnationLevel:uint;
      
      protected var FCurCustoms_awards:Vector.<TFixedAward> = null;
      
      protected var FCurCustomsVecId1:Vector.<int>;
      
      protected var FCurCustomsVecId2:Vector.<int>;
      
      protected var FCurCustomsVecId3:Vector.<int>;
      
      protected var FCurCustomsVecId4:Vector.<int>;
      
      protected var FCurCustomsVecId5:Vector.<int>;
      
      protected var FCurCustomsVecId6:Vector.<int>;
      
      protected var FCurCustomsVecId7:Vector.<int>;
      
      protected var FCurCustomsVecId8:Vector.<int>;
      
      protected var FCurCustomsVecId9:Vector.<int>;
      
      protected var FCurCustomsVecId10:Vector.<int>;
      
      protected var FCurCustomsVecId11:Vector.<int>;
      
      protected var FCurCustomsVecId12:Vector.<int>;
      
      protected var FCurCustomsVecId13:Vector.<int>;
      
      protected var FCurCustomsVecId14:Vector.<int>;
      
      protected var FCurCustomsVecId15:Vector.<int>;
      
      protected var FCurCustomsVecId16:Vector.<int>;
      
      protected var FCurCustomsReward1:Array = null;
      
      protected var FCurCustomsReward2:Array = null;
      
      protected var FCurCustomsReward3:Array = null;
      
      protected var FCurCustomsReward4:Array = null;
      
      protected var FCurCustomsReward5:Array = null;
      
      protected var FCurCustomsReward6:Array = null;
      
      protected var FCurCustomsReward7:Array = null;
      
      protected var FCurCustomsReward8:Array = null;
      
      protected var FCurCustomsReward9:Array = null;
      
      protected var FCurCustomsReward10:Array = null;
      
      protected var FCurCustomsReward11:Array = null;
      
      protected var FCurCustomsReward12:Array = null;
      
      protected var FCurCustomsReward13:Array = null;
      
      protected var FCurCustomsReward14:Array = null;
      
      protected var FCurCustomsReward15:Array = null;
      
      protected var FCurCustomsReward16:Array = null;
      
      protected var FCurCustomsName1:Vector.<String> = null;
      
      protected var FCurCustomsName2:Vector.<String> = null;
      
      protected var FCurCustomsName3:Vector.<String> = null;
      
      protected var FCurCustomsName4:Vector.<String> = null;
      
      protected var FCurCustomsName5:Vector.<String> = null;
      
      protected var FCurCustomsName6:Vector.<String> = null;
      
      protected var FCurCustomsName7:Vector.<String> = null;
      
      protected var FCurCustomsName8:Vector.<String> = null;
      
      protected var FCurCustomsName9:Vector.<String> = null;
      
      protected var FCurCustomsName10:Vector.<String> = null;
      
      protected var FCurCustomsName11:Vector.<String> = null;
      
      protected var FCurCustomsName12:Vector.<String> = null;
      
      protected var FCurCustomsName13:Vector.<String> = null;
      
      protected var FCurCustomsName14:Vector.<String> = null;
      
      protected var FCurCustomsName15:Vector.<String> = null;
      
      protected var FCurCustomsName16:Vector.<String> = null;
      
      protected var FCustomsBins:TBins;
      
      protected var FPracticeBins:TBins;
      
      protected var FMilddleValue:int;
      
      protected var Base:int;
      
      protected var FStageStatue:uint;
      
      protected var FNeedLevel:uint;
      
      protected var FCanChangeStatue:Boolean;
      
      protected var FNeedChangeStatue:Boolean;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      public function SixFaryAllDataBase()
      {
         super();
         this.FCurCustomsVecId1 = new Vector.<int>();
         this.FCurCustomsVecId2 = new Vector.<int>();
         this.FCurCustomsVecId3 = new Vector.<int>();
         this.FCurCustomsVecId4 = new Vector.<int>();
         this.FCurCustomsVecId5 = new Vector.<int>();
         this.FCurCustomsVecId6 = new Vector.<int>();
         this.FCurCustomsVecId7 = new Vector.<int>();
         this.FCurCustomsVecId8 = new Vector.<int>();
         this.FCurCustomsVecId9 = new Vector.<int>();
         this.FCurCustomsVecId10 = new Vector.<int>();
         this.FCurCustomsVecId11 = new Vector.<int>();
         this.FCurCustomsVecId12 = new Vector.<int>();
         this.FCurCustomsVecId13 = new Vector.<int>();
         this.FCurCustomsVecId14 = new Vector.<int>();
         this.FCurCustomsVecId15 = new Vector.<int>();
         this.FCurCustomsVecId16 = new Vector.<int>();
         this.FCurCustomsReward1 = new Array();
         this.FCurCustomsReward2 = new Array();
         this.FCurCustomsReward3 = new Array();
         this.FCurCustomsReward4 = new Array();
         this.FCurCustomsReward5 = new Array();
         this.FCurCustomsReward6 = new Array();
         this.FCurCustomsReward7 = new Array();
         this.FCurCustomsReward8 = new Array();
         this.FCurCustomsReward9 = new Array();
         this.FCurCustomsReward10 = new Array();
         this.FCurCustomsReward11 = new Array();
         this.FCurCustomsReward12 = new Array();
         this.FCurCustomsReward13 = new Array();
         this.FCurCustomsReward14 = new Array();
         this.FCurCustomsReward15 = new Array();
         this.FCurCustomsReward16 = new Array();
         this.FCurCustomsName1 = new Vector.<String>();
         this.FCurCustomsName2 = new Vector.<String>();
         this.FCurCustomsName3 = new Vector.<String>();
         this.FCurCustomsName4 = new Vector.<String>();
         this.FCurCustomsName5 = new Vector.<String>();
         this.FCurCustomsName6 = new Vector.<String>();
         this.FCurCustomsName7 = new Vector.<String>();
         this.FCurCustomsName8 = new Vector.<String>();
         this.FCurCustomsName9 = new Vector.<String>();
         this.FCurCustomsName10 = new Vector.<String>();
         this.FCurCustomsName11 = new Vector.<String>();
         this.FCurCustomsName12 = new Vector.<String>();
         this.FCurCustomsName13 = new Vector.<String>();
         this.FCurCustomsName14 = new Vector.<String>();
         this.FCurCustomsName15 = new Vector.<String>();
         this.FCurCustomsName16 = new Vector.<String>();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FCurPetAttri = new Vector.<Number>();
         this.FNextPetAttri = new Vector.<Number>();
      }
      
      public function initilizationData() : void
      {
         var _loc1_:TSpiritStage = null;
         var _loc2_:TSpiritStage = null;
         var _loc4_:int = 0;
         this.FCustomsBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SpiritStage);
         this.FPracticeBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SpiritEnergy);
         _loc1_ = this.FCustomsBins.GetDatebaseByIndex(0) as TSpiritStage;
         _loc2_ = this.FCustomsBins.GetDatebaseByIndex(0) as TSpiritStage;
         this.Base = _loc2_.Identifier - 1;
         var _loc3_:int = this.FCustomsBins.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this.FCustomsBins.GetDatebaseByIndex(_loc4_) as TSpiritStage;
            switch(_loc2_.MonsterPoints)
            {
               case 1:
                  this.FCurCustomsVecId1.push(_loc2_.Image);
                  this.FCurCustomsReward1.push(_loc2_.Awards);
                  this.FCurCustomsName1.push(_loc2_.Name);
                  break;
               case 2:
                  this.FCurCustomsVecId2.push(_loc2_.Image);
                  this.FCurCustomsReward2.push(_loc2_.Awards);
                  this.FCurCustomsName2.push(_loc2_.Name);
                  break;
               case 3:
                  this.FCurCustomsVecId3.push(_loc2_.Image);
                  this.FCurCustomsReward3.push(_loc2_.Awards);
                  this.FCurCustomsName3.push(_loc2_.Name);
                  break;
               case 4:
                  this.FCurCustomsVecId4.push(_loc2_.Image);
                  this.FCurCustomsReward4.push(_loc2_.Awards);
                  this.FCurCustomsName4.push(_loc2_.Name);
                  break;
               case 5:
                  this.FCurCustomsVecId5.push(_loc2_.Image);
                  this.FCurCustomsReward5.push(_loc2_.Awards);
                  this.FCurCustomsName5.push(_loc2_.Name);
                  break;
               case 6:
                  this.FCurCustomsVecId6.push(_loc2_.Image);
                  this.FCurCustomsReward6.push(_loc2_.Awards);
                  this.FCurCustomsName6.push(_loc2_.Name);
                  break;
               case 7:
                  this.FCurCustomsVecId7.push(_loc2_.Image);
                  this.FCurCustomsReward7.push(_loc2_.Awards);
                  this.FCurCustomsName7.push(_loc2_.Name);
                  break;
               case 8:
                  this.FCurCustomsVecId8.push(_loc2_.Image);
                  this.FCurCustomsReward8.push(_loc2_.Awards);
                  this.FCurCustomsName8.push(_loc2_.Name);
                  break;
               case 9:
                  this.FCurCustomsVecId9.push(_loc2_.Image);
                  this.FCurCustomsReward9.push(_loc2_.Awards);
                  this.FCurCustomsName9.push(_loc2_.Name);
                  break;
               case 10:
                  this.FCurCustomsVecId10.push(_loc2_.Image);
                  this.FCurCustomsReward10.push(_loc2_.Awards);
                  this.FCurCustomsName10.push(_loc2_.Name);
                  break;
               case 11:
                  this.FCurCustomsVecId11.push(_loc2_.Image);
                  this.FCurCustomsReward11.push(_loc2_.Awards);
                  this.FCurCustomsName11.push(_loc2_.Name);
                  break;
               case 12:
                  this.FCurCustomsVecId12.push(_loc2_.Image);
                  this.FCurCustomsReward12.push(_loc2_.Awards);
                  this.FCurCustomsName12.push(_loc2_.Name);
                  break;
               case 13:
                  this.FCurCustomsVecId13.push(_loc2_.Image);
                  this.FCurCustomsReward13.push(_loc2_.Awards);
                  this.FCurCustomsName13.push(_loc2_.Name);
                  break;
               case 14:
                  this.FCurCustomsVecId14.push(_loc2_.Image);
                  this.FCurCustomsReward14.push(_loc2_.Awards);
                  this.FCurCustomsName14.push(_loc2_.Name);
                  break;
               case 15:
                  this.FCurCustomsVecId15.push(_loc2_.Image);
                  this.FCurCustomsReward15.push(_loc2_.Awards);
                  this.FCurCustomsName15.push(_loc2_.Name);
                  break;
               case 16:
                  this.FCurCustomsVecId16.push(_loc2_.Image);
                  this.FCurCustomsReward16.push(_loc2_.Awards);
                  this.FCurCustomsName16.push(_loc2_.Name);
            }
            _loc4_++;
         }
      }
      
      public function DataReset() : void
      {
      }
      
      public function set CurCustomsId(param1:int) : void
      {
         this.FCurCustomsId = param1;
         this.SetCurCustomsLayer();
      }
      
      public function updateCustoms() : void
      {
         var _loc1_:TSpiritStage = null;
         _loc1_ = this.FCustomsBins.GetDatebaseByIdentifier(this.FCurCustomsId) as TSpiritStage;
         this.FCurCustoms_awards = _loc1_.Awards;
      }
      
      public function UpdateManual() : void
      {
         this.SetCurCustomsLayer();
         this.CurPetAttriStr(this.FCurPetId);
      }
      
      public function SetCurCustomsLayer() : void
      {
         var _loc1_:TSpiritStage = null;
         if(!this.FCustomsBins)
         {
            return;
         }
         if(this.FCurCustomsId == 0)
         {
            _loc1_ = this.FCustomsBins.GetDatebaseByIndex(0) as TSpiritStage;
            this.FCurCustomsId = _loc1_.Identifier;
            this.FNextCustomId = _loc1_.Identifier;
            this.FNeedLevel = _loc1_.NeedLevel;
            this.FThisThroudCount = 0;
         }
         else
         {
            _loc1_ = this.FCustomsBins.GetDatebaseByIdentifier(this.FCurCustomsId) as TSpiritStage;
            this.FNextCustomId = this.FCurCustomsId + 1;
            this.FNeedLevel = _loc1_.NeedLevel;
            this.FThisThroudCount = this.FCurCustomsId - this.Base;
         }
         this.FCurCustomsLayer = _loc1_.MonsterPoints;
         this.FCurLayerCustoms = _loc1_.Monsterposition;
         _loc1_ = this.FCustomsBins.GetDatebaseByIdentifier(this.FNextCustomId) as TSpiritStage;
         if(!_loc1_)
         {
            this.FNextCustomId = this.FCurCustomsId;
            this.FNextLayerCustoms = this.FCurLayerCustoms + 1;
            this.FNextCustomsLayer = this.FCurCustomsLayer;
         }
         else
         {
            this.FNextLayerCustoms = _loc1_.Monsterposition;
            this.FNextCustomsLayer = _loc1_.MonsterPoints;
         }
         this.FCanChangeStatue = false;
         if(this.FNextCustomsLayer == 17 && this.FStageStatue == 0)
         {
            this.FNextLayerCustoms = this.FCurLayerCustoms + 1;
            this.FNextCustomsLayer = 16;
            this.FCanChangeStatue = true;
         }
         this.FNeedChangeStatue = false;
         if(this.FNextCustomsLayer == 16)
         {
            this.FNeedChangeStatue = true;
         }
         this.updateCustoms();
         this.UpdateIsCanEffect(this.FCurCustomsId);
      }
      
      public function UpdateIsCanEffect(param1:int) : void
      {
         var _loc2_:TSpiritStage = null;
         var _loc3_:int = 0;
         _loc2_ = this.FCustomsBins.GetDatebaseByIdentifier(param1) as TSpiritStage;
         _loc3_ = _loc2_.MonsterPoints;
         if(this.FMilddleValue != 0)
         {
            if(_loc3_ != this.FMilddleValue)
            {
               this.FIsPlayerEffect = true;
            }
            else
            {
               this.FIsPlayerEffect = false;
            }
         }
         this.FMilddleValue = _loc3_;
      }
      
      public function get CurSceneVec() : Vector.<int>
      {
         var _loc1_:Vector.<int> = null;
         switch(this.FNextCustomsLayer)
         {
            case 1:
               _loc1_ = this.FCurCustomsVecId1;
               break;
            case 2:
               _loc1_ = this.FCurCustomsVecId2;
               break;
            case 3:
               _loc1_ = this.FCurCustomsVecId3;
               break;
            case 4:
               _loc1_ = this.FCurCustomsVecId4;
               break;
            case 5:
               _loc1_ = this.FCurCustomsVecId5;
               break;
            case 6:
               _loc1_ = this.FCurCustomsVecId6;
               break;
            case 7:
               _loc1_ = this.FCurCustomsVecId7;
               break;
            case 8:
               _loc1_ = this.FCurCustomsVecId8;
               break;
            case 9:
               _loc1_ = this.FCurCustomsVecId9;
               break;
            case 10:
               _loc1_ = this.FCurCustomsVecId10;
               break;
            case 11:
               _loc1_ = this.FCurCustomsVecId11;
               break;
            case 12:
               _loc1_ = this.FCurCustomsVecId12;
               break;
            case 13:
               _loc1_ = this.FCurCustomsVecId13;
               break;
            case 14:
               _loc1_ = this.FCurCustomsVecId14;
               break;
            case 15:
               _loc1_ = this.FCurCustomsVecId15;
               break;
            case 16:
               _loc1_ = this.FCurCustomsVecId16;
         }
         return _loc1_;
      }
      
      public function get CurCustomsLayer() : int
      {
         return this.FCurCustomsLayer;
      }
      
      public function get CurLayerCustoms() : int
      {
         return this.FCurLayerCustoms;
      }
      
      public function set NextCustomsLayer(param1:int) : void
      {
         this.FNextCustomsLayer = param1;
      }
      
      public function get NextCustomsLayer() : int
      {
         return this.FNextCustomsLayer;
      }
      
      public function get NextLayerCustoms() : int
      {
         return this.FNextLayerCustoms;
      }
      
      public function get CurCustomsReward() : Array
      {
         var _loc1_:Array = null;
         switch(this.FNextCustomsLayer)
         {
            case 1:
               _loc1_ = this.FCurCustomsReward1;
               break;
            case 2:
               _loc1_ = this.FCurCustomsReward2;
               break;
            case 3:
               _loc1_ = this.FCurCustomsReward3;
               break;
            case 4:
               _loc1_ = this.FCurCustomsReward4;
               break;
            case 5:
               _loc1_ = this.FCurCustomsReward5;
               break;
            case 6:
               _loc1_ = this.FCurCustomsReward6;
               break;
            case 7:
               _loc1_ = this.FCurCustomsReward7;
               break;
            case 8:
               _loc1_ = this.FCurCustomsReward8;
               break;
            case 9:
               _loc1_ = this.FCurCustomsReward9;
               break;
            case 10:
               _loc1_ = this.FCurCustomsReward10;
               break;
            case 11:
               _loc1_ = this.FCurCustomsReward11;
               break;
            case 12:
               _loc1_ = this.FCurCustomsReward12;
               break;
            case 13:
               _loc1_ = this.FCurCustomsReward13;
               break;
            case 14:
               _loc1_ = this.FCurCustomsReward14;
               break;
            case 15:
               _loc1_ = this.FCurCustomsReward15;
               break;
            case 16:
               _loc1_ = this.FCurCustomsReward16;
         }
         return _loc1_;
      }
      
      public function get CurCustomsNameVec() : Vector.<String>
      {
         var _loc1_:Vector.<String> = null;
         switch(this.FNextCustomsLayer)
         {
            case 1:
               _loc1_ = this.FCurCustomsName1;
               break;
            case 2:
               _loc1_ = this.FCurCustomsName2;
               break;
            case 3:
               _loc1_ = this.FCurCustomsName3;
               break;
            case 4:
               _loc1_ = this.FCurCustomsName4;
               break;
            case 5:
               _loc1_ = this.FCurCustomsName5;
               break;
            case 6:
               _loc1_ = this.FCurCustomsName6;
               break;
            case 7:
               _loc1_ = this.FCurCustomsName7;
               break;
            case 8:
               _loc1_ = this.FCurCustomsName8;
               break;
            case 9:
               _loc1_ = this.FCurCustomsName9;
               break;
            case 10:
               _loc1_ = this.FCurCustomsName10;
               break;
            case 11:
               _loc1_ = this.FCurCustomsName11;
               break;
            case 12:
               _loc1_ = this.FCurCustomsName12;
               break;
            case 13:
               _loc1_ = this.FCurCustomsName13;
               break;
            case 14:
               _loc1_ = this.FCurCustomsName14;
               break;
            case 15:
               _loc1_ = this.FCurCustomsName15;
               break;
            case 16:
               _loc1_ = this.FCurCustomsName16;
         }
         return _loc1_;
      }
      
      public function get SixOrNine() : int
      {
         var _loc1_:int = 0;
         if(this.FNextCustomsLayer == 1 || this.FNextCustomsLayer == 2 || this.FNextCustomsLayer == 5 || this.FNextCustomsLayer == 6 || this.FNextCustomsLayer == 9 || this.FNextCustomsLayer == 10 || this.FNextCustomsLayer == 13 || this.FNextCustomsLayer == 14)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      public function get CurCustomsId() : int
      {
         return this.FCurCustomsId;
      }
      
      public function set CurPetId(param1:int) : void
      {
         this.FCurPetId = param1;
         this.CurPetAttriStr(param1);
      }
      
      public function CurPetAttriStr(param1:int) : void
      {
         var _loc2_:TSpiritEnergy = null;
         var _loc3_:Vector.<Object> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!this.FPracticeBins)
         {
            return;
         }
         if(param1 == 0)
         {
            return;
         }
         _loc2_ = this.FPracticeBins.GetDatebaseByIdentifier(param1) as TSpiritEnergy;
         this.FCurPetLvel = _loc2_.EnergyLv;
         this.FUserLevel = _loc2_.UserLv;
         _loc3_ = _loc2_.AttributeVec;
         this.FCurPetName = _loc2_.Name;
         this.FCurToNextExp = _loc2_.MaxExp;
         this.FCurPetPosition = _loc2_.EnergyLy;
         this.FExpendStuffId = _loc2_.ItemId;
         this.FBreakthroughStuffId = _loc2_.GradePromoteItemId;
         this.FCurReinCarnationLevel = _loc2_.NeedTransLv;
         this.FCurPetAttri.length = 0;
         this.FNextPetAttri.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            this.FCurPetAttri.push(_loc3_[_loc5_].attrValue);
            _loc5_++;
         }
         if(this.FCurPetLvel == 10 && this.FCurReinCarnationLevel == 2)
         {
            this.FNextPetAttri.length = 0;
            this.FNextReinCarnationLevel = 7;
         }
         else
         {
            param1++;
            _loc2_ = this.FPracticeBins.GetDatebaseByIdentifier(param1) as TSpiritEnergy;
            if(_loc2_)
            {
               _loc3_ = _loc2_.AttributeVec;
               this.FNextReinCarnationLevel = _loc2_.NeedTransLv;
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  this.FNextPetAttri.push(_loc3_[_loc5_].attrValue);
                  _loc5_++;
               }
            }
            else
            {
               this.FNextReinCarnationLevel = 7;
            }
         }
         this.UpdateStuff();
      }
      
      public function UpdateStuff() : void
      {
         this.FTempSelectInventoriesId.length = 0;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.push(this.FExpendStuffId);
         this.FTempSelectInventoriesId.push(this.FBreakthroughStuffId);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
      }
      
      public function get SelectInventories() : TInventories
      {
         return this.FSelectInventories;
      }
      
      public function get CurPetId() : int
      {
         return this.FCurPetId;
      }
      
      public function set NextPetId(param1:int) : void
      {
         this.FNextPetId = param1;
      }
      
      public function get NextPetId() : int
      {
         return this.FNextPetId;
      }
      
      public function set addExp(param1:int) : void
      {
         this.FaddExp = param1;
      }
      
      public function get addExp() : int
      {
         return this.FaddExp;
      }
      
      public function set currExp(param1:int) : void
      {
         this.FcurrExp = param1;
      }
      
      public function get currExp() : int
      {
         return this.FcurrExp;
      }
      
      public function set realTimes(param1:int) : void
      {
         this.FrealTimes = param1;
      }
      
      public function get realTimes() : int
      {
         return this.FrealTimes;
      }
      
      public function set goldTimes(param1:int) : void
      {
         this.FgoldTimes = param1;
      }
      
      public function get goldTimes() : int
      {
         return this.FgoldTimes;
      }
      
      public function set PracticeTimes(param1:int) : void
      {
         this.FPracticeTimes = param1;
      }
      
      public function get PracticeTimes() : int
      {
         return this.FPracticeTimes;
      }
      
      public function set GetRewardBtnState(param1:int) : void
      {
         this.FGetRewardBtnState = param1;
      }
      
      public function get GetRewardBtnState() : int
      {
         return this.FGetRewardBtnState;
      }
      
      public function set CurCustoms_customsName(param1:String) : void
      {
         this.FCurCustoms_customsName = param1;
      }
      
      public function get CurCustoms_customsName() : String
      {
         return this.FCurCustoms_customsName;
      }
      
      public function set CurCustoms_bossName(param1:String) : void
      {
         this.FCurCustoms_bossName = param1;
      }
      
      public function get CurCustoms_bossName() : String
      {
         return this.FCurCustoms_bossName;
      }
      
      public function set CurCustoms_bossId(param1:int) : void
      {
         this.FCurCustoms_bossId = param1;
      }
      
      public function get CurCustoms_bossId() : int
      {
         return this.FCurCustoms_bossId;
      }
      
      public function set ThisDayCanChallengeCount(param1:int) : void
      {
         this.FThisDayCanChallengeCount = param1;
      }
      
      public function get ThisDayCanChallengeCount() : int
      {
         return this.FThisDayCanChallengeCount;
      }
      
      public function get ThisThroudCount() : int
      {
         return this.FThisThroudCount;
      }
      
      public function get CurPetName() : String
      {
         return this.FCurPetName;
      }
      
      public function get CurPetLvel() : int
      {
         return this.FCurPetLvel;
      }
      
      public function get CurPetAttri() : Vector.<Number>
      {
         return this.FCurPetAttri;
      }
      
      public function get NextPetAttri() : Vector.<Number>
      {
         return this.FNextPetAttri;
      }
      
      public function get CurToNextExp() : int
      {
         return this.FCurToNextExp;
      }
      
      public function get CurPetPosition() : int
      {
         return this.FCurPetPosition;
      }
      
      public function get ExpendStuffId() : int
      {
         return this.FExpendStuffId;
      }
      
      public function get BreakthroughStuffId() : int
      {
         return this.FBreakthroughStuffId;
      }
      
      public function get CurReinCarnationLevel() : uint
      {
         return this.FCurReinCarnationLevel;
      }
      
      public function get NextReinCarnationLevel() : uint
      {
         return this.FNextReinCarnationLevel;
      }
      
      public function get BatchCount() : int
      {
         return this.FBatchCount;
      }
      
      public function set BatchCount(param1:int) : void
      {
         this.FBatchCount = param1;
      }
      
      public function get CurCustoms_awards() : Vector.<TFixedAward>
      {
         return this.FCurCustoms_awards;
      }
      
      public function get UserLevel() : int
      {
         return this.FUserLevel;
      }
      
      public function get IsPlayerEffect() : Boolean
      {
         return this.FIsPlayerEffect;
      }
      
      public function get StageStatue() : uint
      {
         return this.FStageStatue;
      }
      
      public function set StageStatue(param1:uint) : void
      {
         this.FStageStatue = param1;
      }
      
      public function get NeedLevel() : uint
      {
         return this.FNeedLevel;
      }
      
      public function get CanChangeStatue() : Boolean
      {
         return this.FCanChangeStatue;
      }
      
      public function get NeedChangeStatue() : Boolean
      {
         return this.FNeedChangeStatue;
      }
   }
}

