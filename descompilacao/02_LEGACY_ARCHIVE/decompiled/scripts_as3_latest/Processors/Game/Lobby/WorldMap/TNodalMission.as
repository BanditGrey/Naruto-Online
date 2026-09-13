package Processors.Game.Lobby.WorldMap
{
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Campaign.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Quests.TQuest;
   import Logics.Quests.TQuests;
   import Processors.Game.Common.Effects.Texts.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TNodalMission extends TUIComponent
   {
      
      protected static const MAX_COUNT:int = 6;
      
      protected static const MAX_STAR:int = 5;
      
      protected static const MISSION_TYPE_NORMAL:uint = 1;
      
      protected static const MISSION_TYPE_SELECT:uint = 2;
      
      protected static const MISSION_TYPE_NONE:uint = 3;
      
      protected static const ELEMENT_STAMP_WIDTH:Number = 115;
      
      protected var FFreeSlotVect:Vector.<MovieClip>;
      
      protected var FMissionSlotVect:Vector.<MovieClip>;
      
      protected var FMissionAgv:Vector.<uint>;
      
      protected var FGotoMission:uint;
      
      protected var FSelectIndex:int;
      
      protected var FCurCityID:int;
      
      protected var FMaxMission:int;
      
      protected var FBlockPointVect:Vector.<TBlockPoint>;
      
      protected var FBlockPointBins:TBins;
      
      protected var FNodalModel:TNodal;
      
      protected var FCharacter:TCharacter;
      
      protected var FSceneInit:Boolean;
      
      protected var FOnEffectText:Function;
      
      protected var FAddPopTips:Function;
      
      protected var FOnTutorialNextStep:Function;
      
      protected var FOpenAutoInfo:Function;
      
      public function TNodalMission(param1:TNodalChoose, param2:TNodal)
      {
         super(param1);
         this.FNodalModel = param2;
         this.FCharacter = SLogicsCore.Character;
         this.FSceneInit = false;
         this.InitNodalMission();
      }
      
      protected function InitNodalMission() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Bitmap = null;
         this.FFreeSlotVect = new Vector.<MovieClip>();
         this.FMissionSlotVect = new Vector.<MovieClip>();
         this.FBlockPointBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BlockPoint);
         this.FBlockPointVect = new Vector.<TBlockPoint>();
      }
      
      protected function GetMissionSlot() : MovieClip
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Bitmap = null;
         if(this.FFreeSlotVect.length > 0)
         {
            _loc1_ = this.FFreeSlotVect.pop();
         }
         else
         {
            _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CAMPAIGN.RESOURCE_ClassName_MissionSlot) as MovieClip;
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.OnMissionRoll);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.OnMissionRoll);
            _loc1_.btn_auto.addEventListener(MouseEvent.CLICK,this.OnAuto,false,0,true);
            _loc1_.mc_slot.addEventListener(MouseEvent.MOUSE_UP,this.OnEnter,false,0,true);
            _loc1_.mc_slot.mc_select.mouseEnable = false;
            _loc2_ = new Bitmap();
            _loc1_.mc_slot.mc_head.addChild(_loc2_);
            _loc1_.mc_slot.mc_head["bitmap"] = _loc2_;
            _loc1_.mc_slot.tf_name.mouseEnabled = false;
            _loc1_.mc_slot.tf_index.mouseEnabled = false;
         }
         addChild(_loc1_);
         this.FMissionSlotVect.push(_loc1_);
         return _loc1_;
      }
      
      protected function SaveAllMissionSlot() : void
      {
         var _loc1_:MovieClip = null;
         while(this.FMissionSlotVect.length)
         {
            _loc1_ = this.FMissionSlotVect.pop();
            if(Boolean(_loc1_) && Boolean(_loc1_.parent))
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            this.FFreeSlotVect.push(_loc1_);
         }
      }
      
      protected function SetStar(param1:DisplayObjectContainer, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < MAX_STAR)
         {
            param1["star_" + _loc3_].visible = Boolean(_loc3_ < param2);
            _loc3_++;
         }
      }
      
      protected function OnMissionRoll(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(8)));
         _loc3_ = this.FMissionAgv[_loc2_];
         if(_loc3_ <= this.FMaxMission)
         {
            if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget["mc_slot"]))
            {
               if(param1.type == MouseEvent.ROLL_OVER)
               {
                  param1.currentTarget["mc_slot"].gotoAndStop(MISSION_TYPE_SELECT);
               }
               else if(param1.type == MouseEvent.ROLL_OUT)
               {
                  param1.currentTarget["mc_slot"].gotoAndStop(MISSION_TYPE_NORMAL);
               }
            }
         }
      }
      
      protected function OnEnter(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         if(this.FCharacter.CreditMilitaryOrders + this.FCharacter.CreditMilitaryOrdersBuff <= 0)
         {
            this.EffectGenerateText(STRING_WORLDMAP.STRINGS_MilitaryOrders_NotEnough);
            if(this.FAddPopTips != null)
            {
               this.FAddPopTips(this,CONST_POPTIPS.POPTIP_InsufficientMobility);
            }
            return;
         }
         _loc2_ = uint(int(String(param1.currentTarget.parent.name).slice(8)));
         if(this.FMissionAgv[_loc2_] > this.FMaxMission)
         {
            return;
         }
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Enter_Hurdle);
         _loc4_ = _loc3_.Data;
         _loc4_.writeInt(this.FCurCityID);
         _loc4_.writeInt(this.FMissionAgv[_loc2_]);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         if(this.FMissionAgv[_loc2_] == this.FNodalModel.CurMissionID)
         {
            if(this.FOnTutorialNextStep != null)
            {
               this.FOnTutorialNextStep(this,300);
            }
         }
      }
      
      protected function OnAuto(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         if(Boolean(param1.currentTarget) && Boolean(param1.currentTarget.parent))
         {
            _loc2_ = uint(int(String(param1.currentTarget.parent.name).slice(8)));
            if(this.FOpenAutoInfo != null)
            {
               this.FOpenAutoInfo(this.FMissionAgv[_loc2_]);
            }
         }
      }
      
      protected function EffectGenerateText(param1:String, param2:TEffectTextParameters = null, param3:TEffectCoordinateParameters = null) : void
      {
         if(this.FOnEffectText != null)
         {
            this.FOnEffectText(this,param1,param2,param3);
         }
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function get AddPopTips() : Function
      {
         return this.FAddPopTips;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function get OnTutorialNextStep() : Function
      {
         return this.FOnTutorialNextStep;
      }
      
      public function set OnTutorialNextStep(param1:Function) : void
      {
         this.FOnTutorialNextStep = param1;
      }
      
      public function get OpenAutoInfo() : Function
      {
         return this.FOpenAutoInfo;
      }
      
      public function set OpenAutoInfo(param1:Function) : void
      {
         this.FOpenAutoInfo = param1;
      }
      
      public function SetMissionID(param1:uint, param2:uint, param3:Vector.<uint>, param4:uint) : void
      {
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:TBlockPoint = null;
         var _loc10_:uint = 0;
         var _loc11_:TBins = null;
         var _loc12_:int = 0;
         this.FCurCityID = param1;
         this.FMaxMission = param2;
         this.FMissionAgv = param3;
         this.FGotoMission = param4;
         if(!this.FSceneInit)
         {
            return;
         }
         _loc11_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Task);
         _loc10_ = this.FCharacter.GetMainLevel();
         this.SaveAllMissionSlot();
         this.FBlockPointVect.length = 0;
         _loc12_ = 0;
         _loc5_ = 0;
         while(_loc5_ < this.FMissionAgv.length)
         {
            _loc6_ = this.GetMissionSlot();
            _loc7_ = this.FMissionAgv[_loc5_];
            _loc9_ = this.FBlockPointBins.GetDatebaseByIdentifier(_loc7_) as TBlockPoint;
            this.FBlockPointVect.push(_loc9_);
            _loc6_.mc_slot.gotoAndStop(MISSION_TYPE_NORMAL);
            _loc6_.mc_slot.tf_name.text = _loc9_.Name;
            _loc6_.mc_slot.tf_index.text = String(_loc5_ + 1);
            _loc6_.name = "mission_" + _loc5_;
            _loc8_ = this.FNodalModel.GetMissionStarByID(_loc7_);
            this.SetStar(_loc6_.mc_slot,_loc8_);
            _loc6_.mc_slot.mc_select.visible = Boolean(param4 == _loc7_);
            if(_loc7_ <= this.FMaxMission && _loc10_ >= _loc9_.LevelCopy && this.GetBoolean(_loc9_,this.FMaxMission))
            {
               _loc6_.buttonMode = true;
               this.SetMissionMcStatus(_loc6_.mc_slot,false);
               _loc6_.mc_slot.mc_pass.visible = Boolean(_loc8_ > 0);
            }
            else
            {
               _loc12_++;
               _loc6_.buttonMode = false;
               this.SetMissionMcStatus(_loc6_.mc_slot,true);
               if(_loc10_ < _loc9_.LevelCopy && _loc12_ == 1)
               {
                  _loc6_.mc_slot.tf_levelOpen.visible = true;
                  _loc6_.mc_slot.tf_levelOpen.text = TUtilityString.Format(STRING_WORLDMAP.STRING_OPENLEVEL,_loc9_.LvDec);
               }
               else
               {
                  _loc6_.mc_slot.tf_levelOpen.visible = false;
               }
               if(_loc12_ == 1 && !this.GetBoolean(_loc9_,this.FMaxMission,0))
               {
                  _loc6_.mc_slot.tf_levelOpen1.visible = true;
                  _loc6_.mc_slot.tf_levelOpen1.text = TUtilityString.Format(STRING_WORLDMAP.STRING_OPENLEVEL_Copy,this.GetNameById(_loc9_.TaskIdArr[0],_loc11_));
               }
               else
               {
                  _loc6_.mc_slot.tf_levelOpen1.visible = false;
               }
            }
            _loc6_.btn_auto.visible = Boolean(_loc8_ > 0);
            _loc6_.x = _loc5_ * ELEMENT_STAMP_WIDTH;
            if(_loc8_ > 0)
            {
               _loc6_.btn_auto.visible = Boolean(_loc10_ >= _loc9_.LevelCopy);
            }
            _loc5_++;
         }
      }
      
      protected function GetNameById(param1:uint, param2:TBins) : String
      {
         var _loc3_:TTask = null;
         _loc3_ = param2.GetDatebaseByIdentifier(param1) as TTask;
         if(_loc3_)
         {
            return _loc3_.Name;
         }
         return "";
      }
      
      protected function GetBoolean(param1:TBlockPoint, param2:uint, param3:int = 1) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:TQuest = null;
         var _loc4_:Array = param1.TaskIdArr;
         if(!_loc4_)
         {
            return true;
         }
         if(_loc4_.length == 0)
         {
            return true;
         }
         if(param3)
         {
            if(param1.Identifier != param2)
            {
               return true;
            }
         }
         var _loc5_:TQuests = SLogicsCore.Character.MainQuestsAlreadyAccept;
         var _loc6_:TQuests = SLogicsCore.Character.SubQuestsAlreadyAccept;
         _loc7_ = 0;
         while(_loc7_ < _loc5_.Count)
         {
            _loc8_ = _loc5_.GetQuestByIndex(_loc7_);
            if(_loc8_.CurQuestId == _loc4_[0])
            {
               return true;
            }
            _loc7_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc6_.Count)
         {
            _loc8_ = _loc6_.GetQuestByIndex(_loc7_);
            if(_loc8_.CurQuestId == _loc4_[0])
            {
               return true;
            }
            _loc7_++;
         }
         return false;
      }
      
      protected function SetMissionMcStatus(param1:MovieClip, param2:Boolean) : void
      {
         if(param2)
         {
            param1.gotoAndStop(MISSION_TYPE_NONE);
         }
         else
         {
            param1.gotoAndStop(MISSION_TYPE_NORMAL);
         }
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FSceneInit = true;
         param1.addChild(this);
         this.SetMissionID(this.FCurCityID,this.FMaxMission,this.FMissionAgv,this.FGotoMission);
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FMissionAgv == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FMissionSlotVect.length)
         {
            if(this.FBlockPointVect[_loc1_] != null && this.GetBoolean(this.FBlockPointVect[_loc1_],this.FMaxMission))
            {
               if(this.FMissionAgv[_loc1_] > this.FMaxMission)
               {
                  TGameUtil.ShowImageByID(TGameUtil.Type_None,this.FMissionSlotVect[_loc1_].mc_slot.mc_head["bitmap"],CONST_MODULES.MODULE_WorldMap);
               }
               else
               {
                  _loc2_ = this.FBlockPointVect[_loc1_].BossIcon;
                  if(_loc2_ != 0)
                  {
                     TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FMissionSlotVect[_loc1_].mc_slot.mc_head["bitmap"],CONST_MODULES.MODULE_WorldMap,int(_loc2_));
                  }
               }
            }
            _loc1_++;
         }
      }
   }
}

