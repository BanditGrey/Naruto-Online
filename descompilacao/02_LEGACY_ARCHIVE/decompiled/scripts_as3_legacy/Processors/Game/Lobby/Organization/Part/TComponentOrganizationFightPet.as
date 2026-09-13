package Processors.Game.Lobby.Organization.Part
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TOrganizationBase;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Organization.TBaseOrganization;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_ORGANIZATION;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TComponentOrganizationFightPet extends TUIComponent
   {
      
      public static const Three:int = 3;
      
      protected static const RENDERINGSTATE_Normal:int = 1;
      
      protected static const RENDERINGSTATE_Hovering:int = 2;
      
      protected static const RENDERINGSTATE_Pressed:int = 3;
      
      protected static const RENDERINGSTATE_Disabled:int = 4;
      
      protected static const RENDERINGSTATE_Spcial:int = 5;
      
      protected var FInitialized:Boolean;
      
      protected var FMC_Scene:MovieClip = null;
      
      protected var FVecBtn:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      protected var VecLists1:Vector.<TUISlot> = new Vector.<TUISlot>(Three);
      
      protected var VecLists2:Vector.<TUISlot> = new Vector.<TUISlot>(Three);
      
      protected var VecLists3:Vector.<TUISlot> = new Vector.<TUISlot>(Three);
      
      protected var FurGodIndex0:int = 1;
      
      protected var FAllGodIndex0:int = 1;
      
      protected var FurGodIndex1:int = 1;
      
      protected var FAllGodIndex1:int = 1;
      
      protected var FurGodIndex2:int = 1;
      
      protected var FAllGodIndex2:int = 1;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var BeiginTime01:Array;
      
      protected var BeiginTime02:Array;
      
      protected var EndTime01:Array;
      
      protected var EndTime02:Array;
      
      protected var FTimeAm:Vector.<Object>;
      
      protected var FCallReward:Vector.<Object>;
      
      protected var FParticiPationReward:Vector.<Object>;
      
      protected var FParticiLossReward:Vector.<Object>;
      
      protected var FOneRewardId:Vector.<uint>;
      
      protected var FOneRewardIdcount:Vector.<uint>;
      
      protected var FTwoRewardId:Vector.<uint>;
      
      protected var FTwoRewardIdcount:Vector.<uint>;
      
      protected var FThreeRewardId:Vector.<uint>;
      
      protected var FThreeRewardIdcount:Vector.<uint>;
      
      protected var FInventoriesOne:TInventories;
      
      protected var FInventoriesTwo:TInventories;
      
      protected var FInventoriesThree:TInventories;
      
      protected var DayCanCallCoun:int;
      
      protected var CallCounGode:int;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FEffectGenerateTextByErrorCode:Function;
      
      protected var Farent:TUIComponent;
      
      protected var FSetRoot:Function;
      
      protected var FIsIndexPre:int = 0;
      
      protected var FIsIndexNext:int = 0;
      
      protected var OrgBaseBin:TBins;
      
      protected var FCurCount:int = 0;
      
      protected var FApplyState:int = 0;
      
      protected var TempOrgBase:TOrganizationBase;
      
      protected var FLastCout:int;
      
      public function TComponentOrganizationFightPet(param1:TUIComponent)
      {
         super(param1);
      }
      
      public static function setButtonMode(param1:MovieClip, param2:int, param3:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param3)
         {
            param1.mouseEnabled = true;
            param1.mouseChildren = true;
            param1.buttonMode = true;
            if(!param1.hasEventListener(MouseEvent.ROLL_OVER))
            {
               param1.addEventListener(MouseEvent.ROLL_OVER,onBtnResponse,false,0,true);
            }
            if(!param1.hasEventListener(MouseEvent.ROLL_OUT))
            {
               param1.addEventListener(MouseEvent.ROLL_OUT,onBtnResponse,false,0,true);
            }
            if(!param1.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               param1.addEventListener(MouseEvent.MOUSE_DOWN,onBtnResponse,false,0,true);
            }
            if(!param1.hasEventListener(MouseEvent.MOUSE_UP))
            {
               param1.addEventListener(MouseEvent.MOUSE_UP,onBtnResponse,false,0,true);
            }
            param1.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else
         {
            param1.mouseEnabled = false;
            param1.mouseChildren = false;
            param1.buttonMode = false;
            if(param1.hasEventListener(MouseEvent.ROLL_OVER))
            {
               param1.removeEventListener(MouseEvent.ROLL_OVER,onBtnResponse);
            }
            if(param1.hasEventListener(MouseEvent.ROLL_OUT))
            {
               param1.removeEventListener(MouseEvent.ROLL_OUT,onBtnResponse);
            }
            if(param1.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               param1.removeEventListener(MouseEvent.MOUSE_DOWN,onBtnResponse);
            }
            if(param1.hasEventListener(MouseEvent.MOUSE_UP))
            {
               param1.removeEventListener(MouseEvent.MOUSE_UP,onBtnResponse);
            }
            if(param2 == 2)
            {
               param1.gotoAndStop(RENDERINGSTATE_Spcial);
            }
            else
            {
               param1.gotoAndStop(RENDERINGSTATE_Disabled);
            }
         }
      }
      
      private static function onBtnResponse(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Hovering);
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Normal);
         }
         else if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Pressed);
         }
         else if(param1.type == MouseEvent.MOUSE_UP)
         {
            param1.currentTarget.gotoAndStop(RENDERINGSTATE_Normal);
         }
      }
      
      public function set SetRoot(param1:Function) : void
      {
         this.FSetRoot = param1;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.addEventDate();
         this.FInitialized = true;
      }
      
      protected function addEventDate() : void
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:TUISlot = null;
         if(!this.FMC_Scene)
         {
            return;
         }
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FOneRewardId = new Vector.<uint>();
         this.FOneRewardIdcount = new Vector.<uint>();
         this.FTwoRewardId = new Vector.<uint>();
         this.FTwoRewardIdcount = new Vector.<uint>();
         this.FThreeRewardId = new Vector.<uint>();
         this.FThreeRewardIdcount = new Vector.<uint>();
         this.FInventoriesOne = new TInventories();
         this.FInventoriesTwo = new TInventories();
         this.FInventoriesThree = new TInventories();
         this.BeiginTime01 = new Array();
         this.BeiginTime02 = new Array();
         this.EndTime01 = new Array();
         this.EndTime02 = new Array();
         var _loc1_:int = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossTimeAm) as TConfigValue;
         this.FTimeAm = _loc2_.Value as Vector.<Object>;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossTimecall) as TConfigValue;
         this.FCallReward = _loc2_.Value as Vector.<Object>;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossTimeJoin) as TConfigValue;
         this.FParticiPationReward = _loc2_.Value as Vector.<Object>;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossTimegodle) as TConfigValue;
         this.FParticiLossReward = _loc2_.Value as Vector.<Object>;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossCallCount) as TConfigValue;
         this.DayCanCallCoun = _loc2_.Value as int;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.KillAnimalBossTimeConsum) as TConfigValue;
         this.CallCounGode = _loc2_.Value as int;
         this.OrgBaseBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrganizationBase);
         _loc1_ = 0;
         while(_loc1_ < this.FCallReward.length)
         {
            this.FOneRewardId.push(this.FCallReward[_loc1_].code);
            this.FOneRewardIdcount.push(this.FCallReward[_loc1_].amount);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FParticiPationReward.length)
         {
            this.FTwoRewardId.push(this.FParticiPationReward[_loc1_].code);
            this.FTwoRewardIdcount.push(this.FParticiPationReward[_loc1_].amount);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FParticiLossReward.length)
         {
            this.FThreeRewardId.push(this.FParticiLossReward[_loc1_].code);
            this.FThreeRewardIdcount.push(this.FParticiLossReward[_loc1_].amount);
            _loc1_++;
         }
         this.FVecBtn.push(this.FMC_Scene["MC_Reward_All"]["MC_right_btn0"],this.FMC_Scene["MC_Reward_All"]["MC_left_btn0"]);
         this.FVecBtn.push(this.FMC_Scene["MC_Reward_All"]["MC_right_btn1"],this.FMC_Scene["MC_Reward_All"]["MC_left_btn1"]);
         this.FVecBtn.push(this.FMC_Scene["MC_Reward_All"]["MC_right_btn2"],this.FMC_Scene["MC_Reward_All"]["MC_left_btn2"]);
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene["MC_Reward_All"]["mc_slot_" + _loc1_] as MovieClip;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.UIComponentsHintOnOver;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc3_.Init();
            this.VecLists1[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene["MC_Reward_All"]["mc_slot_0" + _loc1_] as MovieClip;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.UIComponentsHintOnOver;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc3_.Init();
            this.VecLists2[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Scene["MC_Reward_All"]["mc_slot_00" + _loc1_] as MovieClip;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.UIComponentsHintOnOver;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc3_.Init();
            this.VecLists3[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FVecBtn.length)
         {
            this.FVecBtn[_loc1_].addEventListener(MouseEvent.CLICK,this.equioClick);
            _loc1_++;
         }
         this.UnstreamizerInventoryReference();
         this.Loadequip();
         MovieClip(this.FMC_Scene["MC_Call_Btn"]).addEventListener(MouseEvent.CLICK,this.fightpetSend);
         MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).addEventListener(MouseEvent.CLICK,this.ApplypetSend);
         TextField(this.FMC_Scene["TF_BattlePower"]).text = this.FTimeAm[0].begin + "~" + this.FTimeAm[0].end + "," + this.FTimeAm[1].begin + "~" + this.FTimeAm[1].end;
         this.BeiginTime01 = String(this.FTimeAm[0].begin).split(":");
         this.BeiginTime02 = String(this.FTimeAm[0].end).split(":");
         this.EndTime01 = String(this.FTimeAm[1].begin).split(":");
         this.EndTime02 = String(this.FTimeAm[1].end).split(":");
         this.FOverlayerAppliance = new TOverlayerAppliance(this.Farent,CONST_MODULES.MODULE_FightPet);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      public function initization(param1:int, param2:int, param3:int, param4:int, param5:int, param6:TBaseOrganization) : void
      {
         if(this.OrgBaseBin == null || param6 == null)
         {
            return;
         }
         if(param6.OrgLevel == 0)
         {
            return;
         }
         this.TempOrgBase = this.OrgBaseBin.GetDatebaseByIndex(param6.OrgLevel - 1) as TOrganizationBase;
         this.FLastCout = this.DayCanCallCoun - param2;
         TextField(this.FMC_Scene["MC_BossLevl"]["TF_Level"]).text = String(param1);
         TextField(this.FMC_Scene["MC_Call_Count"]["TF_BattlePower"]).text = String(this.FLastCout);
         TextField(this.FMC_Scene["TF_ApplyCount"]).text = STRING_ORGANIZATION.STRING_PlayerCount + param3 + "/" + this.TempOrgBase.OrgMinSumBossNumber;
         this.FCurCount = param3;
         this.FApplyState = param5;
         if(param4 == 2)
         {
            setButtonMode(this.FMC_Scene["MC_Call_Btn"],1,false);
            MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = false;
            MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = true;
         }
         if(param4 == 0)
         {
            if(param3 == this.TempOrgBase.OrgMinSumBossNumber)
            {
               setButtonMode(this.FMC_Scene["MC_Call_Btn"],1,true);
               MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = false;
               MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = true;
            }
            else if(param5 == 1)
            {
               setButtonMode(this.FMC_Scene["MC_Applyl_Btn"],1,false);
               MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = true;
               MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = false;
            }
            else
            {
               setButtonMode(this.FMC_Scene["MC_Applyl_Btn"],1,true);
               MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = true;
               MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = false;
            }
         }
         if(this.FLastCout == 0)
         {
            setButtonMode(this.FMC_Scene["MC_Applyl_Btn"],2,false);
            MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = true;
            MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = false;
         }
      }
      
      protected function IsCanCallFilter() : void
      {
         if(this.TempOrgBase.OrgMinSumBossNumber == this.FCurCount)
         {
            if(this.GetCanCallAnimal())
            {
               if(this.FIsIndexPre != this.FIsIndexNext)
               {
                  setButtonMode(this.FMC_Scene["MC_Call_Btn"],1,true);
               }
            }
            else if(this.FIsIndexPre != this.FIsIndexNext)
            {
               setButtonMode(this.FMC_Scene["MC_Call_Btn"],1,false);
            }
            this.FIsIndexNext = this.FIsIndexPre;
         }
      }
      
      public function GetCanCallAnimal() : Boolean
      {
         this.FIsIndexPre = 0;
         var _loc1_:Date = new Date(STimingCore.GetServerTime());
         var _loc2_:Number = _loc1_.getHours();
         var _loc3_:Number = _loc1_.getMinutes();
         if(_loc2_ * 60 + _loc3_ >= Number(this.BeiginTime01[0]) * 60 + Number(this.BeiginTime01[1]))
         {
            if(_loc2_ * 60 + _loc3_ <= Number(this.BeiginTime02[0]) * 60 + Number(this.BeiginTime02[1]))
            {
               this.FIsIndexPre = 1;
               return true;
            }
         }
         if(_loc2_ * 60 + _loc3_ >= Number(this.EndTime01[0]) * 60 + Number(this.EndTime01[1]))
         {
            if(_loc2_ * 60 + _loc3_ <= Number(this.EndTime02[0]) * 60 + Number(this.EndTime02[1]))
            {
               this.FIsIndexPre = 1;
               return true;
            }
         }
         return false;
      }
      
      public function fightpetSend(param1:MouseEvent) : void
      {
         this.FSetRoot(this);
      }
      
      public function PACKETID_SC_AnimalSeall_Open_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:TPacket = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readUnsignedInt();
         if(_loc3_ != 0)
         {
            this.FEffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_OrganizeBossStage);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      public function PopWindowOnOk() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AnimalSeall_Open_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function ApplypetSend(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AnimalSeall_Apply_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function updateinitization(param1:TBaseOrganization) : void
      {
         var _loc2_:TOrganizationBase = null;
         _loc2_ = this.OrgBaseBin.GetDatebaseByIndex(param1.OrgLevel - 1) as TOrganizationBase;
         TextField(this.FMC_Scene["TF_ApplyCount"]).text = STRING_ORGANIZATION.STRING_PlayerCount + this.FCurCount + "/" + _loc2_.OrgMinSumBossNumber;
         if(this.FCurCount == _loc2_.OrgMinSumBossNumber)
         {
            TGameUtil.setButtonMode(this.FMC_Scene["MC_Call_Btn"],true);
            MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = false;
            MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = true;
         }
         else if(this.FApplyState == 1)
         {
            TGameUtil.setButtonMode(this.FMC_Scene["MC_Applyl_Btn"],false);
            MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = true;
            MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Scene["MC_Applyl_Btn"],true);
            MovieClip(this.FMC_Scene["MC_Applyl_Btn"]).visible = true;
            MovieClip(this.FMC_Scene["MC_Call_Btn"]).visible = false;
         }
      }
      
      protected function UnstreamizerInventoryReference() : void
      {
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventoriesOne,this.FOneRewardId);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventoriesTwo,this.FTwoRewardId);
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventoriesThree,this.FThreeRewardId);
         this.setCount();
      }
      
      protected function setCount() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FInventoriesOne.Count)
         {
            this.FInventoriesOne.GetInventoryByIndex(_loc1_).Quantity = this.FOneRewardIdcount[_loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FInventoriesTwo.Count)
         {
            this.FInventoriesTwo.GetInventoryByIndex(_loc1_).Quantity = this.FTwoRewardIdcount[_loc1_];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FInventoriesThree.Count)
         {
            this.FInventoriesThree.GetInventoryByIndex(_loc1_).Quantity = this.FThreeRewardIdcount[_loc1_];
            _loc1_++;
         }
      }
      
      protected function Loadequip() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Number = Number(this.FInventoriesOne.Count);
         this.FAllGodIndex0 = Math.ceil(_loc2_ / Three);
         var _loc3_:Number = Number(this.FInventoriesTwo.Count);
         this.FAllGodIndex1 = Math.ceil(_loc3_ / Three);
         var _loc4_:Number = Number(this.FInventoriesThree.Count);
         this.FAllGodIndex2 = Math.ceil(_loc4_ / Three);
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc5_ = _loc1_ + (this.FurGodIndex0 - 1) * Three;
            if(_loc5_ > _loc2_ - 1)
            {
               this.VecLists1[_loc1_].Context = null;
            }
            else
            {
               this.VecLists1[_loc1_].Context = this.FInventoriesOne.GetInventoryByIndex(_loc5_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc6_ = _loc1_ + (this.FurGodIndex1 - 1) * Three;
            if(_loc6_ > _loc3_ - 1)
            {
               this.VecLists2[_loc1_].Context = null;
            }
            else
            {
               this.VecLists2[_loc1_].Context = this.FInventoriesTwo.GetInventoryByIndex(_loc6_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc7_ = _loc1_ + (this.FurGodIndex2 - 1) * Three;
            if(_loc7_ > _loc4_ - 1)
            {
               this.VecLists3[_loc1_].Context = null;
            }
            else
            {
               this.VecLists3[_loc1_].Context = this.FInventoriesThree.GetInventoryByIndex(_loc7_);
            }
            _loc1_++;
         }
         this.setBtnState();
      }
      
      public function equioClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Scene["MC_Reward_All"]["MC_right_btn0"]:
               if(this.FurGodIndex0 < this.FAllGodIndex0)
               {
                  this.FurGodIndex0 += 1;
                  this.Loadequip();
               }
               break;
            case this.FMC_Scene["MC_Reward_All"]["MC_left_btn0"]:
               if(this.FurGodIndex0 > 1)
               {
                  --this.FurGodIndex0;
                  this.Loadequip();
               }
               break;
            case this.FMC_Scene["MC_Reward_All"]["MC_right_btn1"]:
               if(this.FurGodIndex1 < this.FAllGodIndex1)
               {
                  this.FurGodIndex1 += 1;
                  this.Loadequip();
               }
               break;
            case this.FMC_Scene["MC_Reward_All"]["MC_left_btn1"]:
               if(this.FurGodIndex1 > 1)
               {
                  --this.FurGodIndex1;
                  this.Loadequip();
               }
               break;
            case this.FMC_Scene["MC_Reward_All"]["MC_right_btn2"]:
               if(this.FurGodIndex2 < this.FAllGodIndex2)
               {
                  this.FurGodIndex2 += 1;
                  this.Loadequip();
               }
               break;
            case this.FMC_Scene["MC_Reward_All"]["MC_left_btn2"]:
               if(this.FurGodIndex2 > 1)
               {
                  --this.FurGodIndex2;
                  this.Loadequip();
               }
         }
      }
      
      protected function setBtnState() : void
      {
         if(this.FAllGodIndex0 <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn0"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn0"]),false);
            MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn0"]).visible = false;
            MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn0"]).visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn0"]),this.FurGodIndex0 == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn0"]),this.FurGodIndex0 >= this.FAllGodIndex0 ? false : true);
            if(this.FurGodIndex0 == 1)
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn0"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn0"]).visible = true;
            }
            if(this.FurGodIndex0 >= this.FAllGodIndex0)
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn0"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn0"]).visible = true;
            }
         }
         if(this.FAllGodIndex1 <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn1"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn1"]),false);
            MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn1"]).visible = false;
            MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn1"]).visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn1"]),this.FurGodIndex1 == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn1"]),this.FurGodIndex1 >= this.FAllGodIndex1 ? false : true);
            if(this.FurGodIndex1 == 1)
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn1"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn1"]).visible = true;
            }
            if(this.FurGodIndex1 >= this.FAllGodIndex1)
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn1"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn1"]).visible = true;
            }
         }
         if(this.FAllGodIndex2 <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn2"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn2"]),false);
            MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn2"]).visible = false;
            MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn2"]).visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn2"]),this.FurGodIndex2 == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn2"]),this.FurGodIndex2 >= this.FAllGodIndex2 ? false : true);
            if(this.FurGodIndex2 == 1)
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn2"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_left_btn2"]).visible = true;
            }
            if(this.FurGodIndex2 >= this.FAllGodIndex2)
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn2"]).visible = false;
            }
            else
            {
               MovieClip(this.FMC_Scene["MC_Reward_All"]["MC_right_btn2"]).visible = true;
            }
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Organization);
         }
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.Visible)
         {
            this.UpdateUI();
            this.IsCanCallFilter();
         }
      }
      
      private function UpdateUI() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            if(_loc1_ + (this.FurGodIndex0 - 1) * Three <= this.FInventoriesOne.Count - 1)
            {
               this.VecLists1[_loc1_].Update();
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            if(_loc1_ + (this.FurGodIndex1 - 1) * Three <= this.FInventoriesTwo.Count - 1)
            {
               this.VecLists2[_loc1_].Update();
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            if(_loc1_ + (this.FurGodIndex2 - 1) * Three <= this.FInventoriesThree.Count - 1)
            {
               this.VecLists3[_loc1_].Update();
            }
            _loc1_++;
         }
      }
      
      public function set EffectGenerateTextByError(param1:Function) : void
      {
         this.FEffectGenerateTextByErrorCode = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip, param2:TUIComponent) : void
      {
         this.Farent = param2;
         this.Resources_UIDispatch(param1);
      }
   }
}

