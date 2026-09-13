package Processors.Game.Lobby.MainScene
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.*;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Resources.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Inventories.*;
   import Logics.Quests.*;
   import Logics.SLogicsCore;
   import Processors.Game.Common.Effects.Texts.TEffectCoordinateParameters;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Rendering.Overlayers.*;
   import Rendering.Overlayers.Inventories.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class TLayerNpcDialog extends TProcessorLobbyWindow
   {
      
      protected static const MOTHERBOARD_HEIGHT:int = 273;
      
      protected static const SLOTNUM:uint = 6;
      
      protected static const Type_LargeIcon:int = 4;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected static const State_Ready:int = 0;
      
      protected static const State_AtPanle1:int = 1;
      
      protected static const State_AtPanle2:int = 2;
      
      protected static const State_WaitAcceptQuestBack:int = 3;
      
      protected static const State_WaitBackQuestBack:int = 4;
      
      protected static const State_Continue:int = 5;
      
      protected var FSence:Sprite;
      
      protected var FCurrentShowState:int;
      
      protected var FCurrentState:int;
      
      protected var FCurrentHandleQuest:TQuest;
      
      protected var FOtherNpcQuest:TQuest;
      
      protected var FInitialize:Boolean;
      
      protected var FMC_ScrollBar:TScrollBar;
      
      protected var FMC_QuestShortcuts:Vector.<MovieClip>;
      
      protected var FMC_FreeQuestShortcuts:Vector.<MovieClip>;
      
      protected var FMC_Reward:MovieClip;
      
      protected var FMC_RewardUseHide:Vector.<MovieClip>;
      
      protected var FRewardSlots:Vector.<TUISlot>;
      
      protected var FRewardTF:TextField;
      
      protected var FRewardInventories:TInventories;
      
      protected var FCutOffLine:MovieClip;
      
      protected var FTF_DialogText:TextField;
      
      protected var FTF_NpcName:TextField;
      
      protected var FNpcPic:MovieClip;
      
      protected var FNpcBitmap:Bitmap;
      
      protected var FNeedUpdateNpcPicture:Boolean;
      
      protected var FBtnContinue:MovieClip;
      
      protected var FBtnClose:SimpleButton;
      
      protected var FOverlayerEquipment:TOverlayerEquipment;
      
      protected var FOverlayerTreasure:TOverlayerTreasure;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FOverlayerAccessory:TOverlayerAccessory;
      
      protected var FCloseTick:int;
      
      protected var FCloseNpcID:int;
      
      protected var FEffectCoordinateParameters:TEffectCoordinateParameters;
      
      protected var FQueryCoordinate:TQueryCoordinate;
      
      protected var FUINpc:TUIRoleNpc;
      
      protected var FOpenDiaLog:Function;
      
      protected var FTaskOnClick:Function;
      
      protected var FOpenNpcUserTypeWindow:Function;
      
      protected var FAfterHideDialog:Function;
      
      protected var FOnEffectAcquireInventory:Function;
      
      protected var FOnQueryShortcutCoordinate:Function;
      
      public function TLayerNpcDialog(param1:TUIComponent)
      {
         super(param1);
         this.FNpcBitmap = new Bitmap();
         this.ConstructEffectParameters();
         this.FQueryCoordinate = new TQueryCoordinate();
      }
      
      protected function ConstructEffectParameters() : void
      {
         this.FEffectCoordinateParameters = new TEffectCoordinateParameters();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(301989889);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         var _loc3_:MovieClip = null;
         this.FSence = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACCOUNT.RESOURCE_ClassName_NpcDialog) as Sprite;
         this.addChild(this.FSence);
         this.FTF_NpcName = this.FSence["NpcName"]["NpcNameInner"];
         this.FTF_DialogText = this.FSence["TalkContent"];
         this.FMC_ScrollBar = new TScrollBar(this.FSence["MC_ShowReport"]["mc_list"],104,false,2);
         this.FMC_QuestShortcuts = new Vector.<MovieClip>();
         this.FMC_FreeQuestShortcuts = new Vector.<MovieClip>();
         this.FMC_Reward = TUtilityReflection.CreateDisplayObjectInstance("QuestReward") as MovieClip;
         this.FSence.addChild(this.FMC_Reward);
         this.FMC_Reward.x = 377;
         this.FMC_Reward.y = 270;
         this.FMC_Reward.visible = false;
         this.FRewardTF = this.FMC_Reward["TF_ItemText"];
         this.FRewardSlots = new Vector.<TUISlot>();
         this.FMC_RewardUseHide = new Vector.<MovieClip>();
         _loc1_ = 0;
         while(_loc1_ < SLOTNUM)
         {
            _loc2_ = new TUISlot(this);
            _loc3_ = this.FMC_Reward["MC_Slot_" + (_loc1_ + 1)];
            this.FMC_RewardUseHide.push(_loc3_);
            _loc2_.Resource = _loc3_;
            this.FRewardSlots.push(_loc2_);
            _loc1_++;
         }
         this.FCutOffLine = this.FSence["cutOffLine"];
         this.FNpcPic = this.FSence["NpcPic"];
         this.FBtnContinue = this.FSence["ShortcutBack"];
         this.FBtnClose = this.FSence["BtnClose"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:MovieClip = null;
         while(Boolean(this.FNpcPic) && Boolean(this.FNpcPic.numChildren))
         {
            this.FNpcPic.removeChildAt(0);
         }
         this.FNpcBitmap.x = 0;
         this.FNpcBitmap.y = 0;
         this.FNpcPic.addChild(this.FNpcBitmap);
         this.FNpcPic.mouseEnabled = false;
         this.FOverlayerEquipment = new TOverlayerEquipment(this,CONST_MODULES.MODULE_MainScene);
         this.FOverlayerEquipment.Visible = false;
         this.FOverlayerTreasure = new TOverlayerTreasure(this,CONST_MODULES.MODULE_MainScene);
         this.FOverlayerTreasure.Visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this,CONST_MODULES.MODULE_MainScene);
         this.FOverlayerAppliance.Visible = false;
         this.FOverlayerAccessory = new TOverlayerAccessory(this,CONST_MODULES.MODULE_MainScene);
         this.FOverlayerAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAccessory);
         _loc2_ = int(this.FRewardSlots.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRewardSlots[_loc1_];
            TJadeCommon.InitSlot(_loc3_,CONST_MODULES.MODULE_MainScene);
            _loc3_.tabIndex = _loc1_;
            _loc3_.Init();
            _loc3_.OnOverlay = this.UIComponentsHintOnOver;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc1_++;
         }
         TGameUtil.setButtonMode(this.FBtnContinue,true);
         this.FBtnContinue.addEventListener(MouseEvent.CLICK,this.BtnContinueClick);
         this.FBtnContinue.mouseChildren = false;
         this.FBtnClose.addEventListener(MouseEvent.CLICK,this.ShortcutBackClick);
         this.FRewardInventories = new TInventories();
         this.FInitialize = true;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialize)
         {
            this.UpdateSlots();
            if(this.FNpcBitmap.bitmapData == null && this.FNeedUpdateNpcPicture)
            {
               this.UpdateNpcPicture();
            }
         }
      }
      
      protected function FindSpecialQuestDescription(param1:int, param2:Vector.<int>, param3:Vector.<String>) : String
      {
         var _loc4_:int = param2.indexOf(param1);
         return param3[_loc4_];
      }
      
      protected function CreateQuestLable(param1:TQuest) : String
      {
         if(param1.TaskState == CONST_QUEST.STATE_ACCEPT && param1.RequirementLevelMin > SLogicsCore.Character.GetMainLevel())
         {
            return STRING_MAINSCENE.STRING_CannotReceive;
         }
         return this.FindSpecialQuestDescription(param1.TaskState,STRING_SCENEWINDOW.QUESTICON_STATE,STRING_SCENEWINDOW.QUESTICON_TEXTLAYER1);
      }
      
      protected function UpdateBtnLableByQuest(param1:TQuest) : void
      {
         var _loc2_:TextField = null;
         _loc2_ = this.FBtnContinue["BtnLable"];
         switch(param1.TaskState)
         {
            case CONST_QUEST.STATE_ACCEPT:
               _loc2_.text = STRING_MAINSCENE.STRING_ReceiveQuest;
               break;
            case CONST_QUEST.STATE_TASKING:
               _loc2_.text = STRING_MAINSCENE.STRING_ContinueQuest;
               break;
            case CONST_QUEST.STATE_TASKBACK:
               if(param1.BackTaskNpc != this.FUINpc.RoleData.RoleTemplateID)
               {
                  _loc2_.text = STRING_MAINSCENE.STRING_ContinueQuest;
               }
               else
               {
                  _loc2_.text = STRING_MAINSCENE.STRING_CompleteQuest;
               }
         }
      }
      
      protected function InitUIOnNormaDialog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TQuest = null;
         var _loc6_:MovieClip = null;
         _loc2_ = this.FUINpc.NpcQuestes.Count;
         _loc3_ = this.FUINpc.RoleData.UserType > 1 ? 1 : 0;
         this.FMC_Reward.visible = false;
         this.FMC_ScrollBar.Visible = true;
         this.FCutOffLine.visible = Boolean(_loc2_ + _loc3_ != 0);
         this.FBtnContinue.visible = Boolean(_loc2_ != 0);
         if(_loc2_ != 0)
         {
            _loc5_ = this.FUINpc.NpcQuestes.GetQuestByIndex(0);
            this.UpdateBtnLableByQuest(_loc5_);
         }
         while(this.FMC_ScrollBar.Count > 0)
         {
            _loc6_ = this.FMC_ScrollBar.DelItem(this.FMC_ScrollBar.Count - 1) as MovieClip;
            this.FMC_FreeQuestShortcuts.push(_loc6_);
            this.FMC_QuestShortcuts.splice(this.FMC_ScrollBar.Count - 1,1);
         }
      }
      
      protected function CreateQuestShortcut() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(this.FMC_FreeQuestShortcuts.length > 0)
         {
            _loc1_ = this.FMC_FreeQuestShortcuts.pop();
         }
         else
         {
            _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_ACCOUNT.RESOURCE_ClassName_QuestShortcut) as MovieClip;
            _loc1_.addEventListener(MouseEvent.CLICK,this.QuestShortcutClicked);
            TGameUtil.setButtonMode(_loc1_,true);
         }
         return _loc1_;
      }
      
      protected function UpdateNormaDialog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TextField = null;
         var _loc6_:String = null;
         var _loc7_:TQuest = null;
         var _loc8_:MovieClip = null;
         this.InitUIOnNormaDialog();
         if(this.FUINpc.RoleData.UserType == CONST_NPC.NPC_FUNCTION_YUELAO)
         {
            _loc6_ = this.FUINpc.RoleData.NormalTalkText;
            this.FTF_DialogText.htmlText = _loc6_;
            _loc8_ = this.CreateQuestShortcut();
            _loc5_ = _loc8_["TF_ItemText"];
            if(THomelandModel.selfHome.status == 1)
            {
               _loc5_.textColor = 16711697;
               _loc5_.text = TIllustratedModel.TextFormat(70480026);
            }
            else
            {
               _loc5_.textColor = 65297;
               _loc5_.text = TIllustratedModel.TextFormat(70480025);
            }
            this.FMC_QuestShortcuts.push(_loc8_);
            this.FMC_ScrollBar.AddItem(_loc8_);
         }
         else
         {
            _loc2_ = this.FUINpc.NpcQuestes.Count;
            if(_loc2_ != 0)
            {
               _loc6_ = this.GetTalkContentByStatus(this.FUINpc.NpcQuestes.GetQuestByIndex(0));
            }
            else
            {
               _loc6_ = this.FUINpc.RoleData.NormalTalkText;
            }
            this.FTF_DialogText.htmlText = _loc6_;
            _loc3_ = this.FUINpc.RoleData.UserType > 1 ? 1 : 0;
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               _loc8_ = this.CreateQuestShortcut();
               this.FMC_QuestShortcuts.push(_loc8_);
               this.FMC_ScrollBar.AddItem(_loc8_);
               _loc5_ = this.FMC_QuestShortcuts[_loc1_]["TF_ItemText"];
               _loc5_.textColor = 16762394;
               _loc5_.text = STRING_MAINSCENE.NPCUserType[this.FUINpc.RoleData.UserType];
               _loc1_++;
            }
            _loc4_ = _loc2_ + _loc3_;
            _loc1_ = _loc3_;
            while(_loc1_ < _loc4_)
            {
               _loc8_ = this.CreateQuestShortcut();
               this.FMC_QuestShortcuts.push(_loc8_);
               this.FMC_ScrollBar.AddItem(_loc8_);
               _loc7_ = this.FUINpc.NpcQuestes.GetQuestByIndex(_loc1_ - _loc3_);
               _loc5_ = this.FMC_QuestShortcuts[_loc1_]["TF_ItemText"];
               _loc6_ = this.CreateQuestLable(_loc7_);
               _loc6_ = TUtilityString.Format(STRING_SCENEWINDOW.FORMAT_QuestLable,_loc7_.Name,_loc6_);
               if(_loc7_.TaskState == CONST_QUEST.STATE_ACCEPT)
               {
                  if(_loc7_.RequirementLevelMin > SLogicsCore.Character.GetMainLevel())
                  {
                     _loc5_.textColor = 16711680;
                  }
                  else
                  {
                     _loc5_.textColor = 65280;
                  }
               }
               else
               {
                  _loc5_.textColor = 16762394;
               }
               _loc5_.text = _loc6_;
               _loc1_++;
            }
         }
         this.FMC_ScrollBar.ScrollToUp();
      }
      
      protected function InitUIOnQuesteDialog(param1:TInventories) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FCutOffLine.visible = true;
         this.FBtnContinue.visible = true;
         this.FMC_ScrollBar.Visible = false;
         this.FMC_Reward.visible = true;
         this.UpdateBtnLableByQuest(this.FCurrentHandleQuest);
         this.FRewardTF.text = "";
         _loc3_ = param1.Count;
         _loc2_ = 0;
         while(_loc2_ < SLOTNUM)
         {
            if(_loc2_ < _loc3_)
            {
               this.FMC_RewardUseHide[_loc2_].visible = true;
            }
            else
            {
               this.FMC_RewardUseHide[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function UpdateQuesteDialog() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         var _loc5_:TInventories = null;
         this.FRewardInventories.Clear();
         this.GetRewardsOfInventory(this.FCurrentHandleQuest.RewardsInventory,this.FRewardInventories);
         this.InitUIOnQuesteDialog(this.FRewardInventories);
         _loc1_ = this.GetTalkContentByStatus(this.FCurrentHandleQuest);
         this.FTF_DialogText.htmlText = _loc1_;
         this.FRewardTF.text = this.GetRewardDescription(this.FCurrentHandleQuest.RewardsInventory);
         _loc3_ = this.FRewardInventories.Count;
         _loc2_ = 0;
         while(_loc2_ < this.FRewardSlots.length)
         {
            if(_loc2_ < _loc3_)
            {
               _loc4_ = this.FRewardInventories.GetInventoryByIndex(_loc2_);
               this.FRewardSlots[_loc2_].Context = _loc4_;
            }
            else
            {
               this.FRewardSlots[_loc2_].Context = null;
               this.FRewardSlots[_loc2_].visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function GetRewardDescription(param1:TInventories) : String
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Vector.<uint> = null;
         _loc6_ = "";
         _loc4_ = param1.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.GetInventoryByIndex(_loc3_);
            _loc2_ = this.IfInventory(_loc5_.IDTemplate);
            if(!_loc2_)
            {
               _loc10_ = CONST_COMMON.REWARDIDNotInventory_DATA;
               _loc9_ = _loc10_.indexOf(_loc5_.IDTemplate);
               _loc7_ = int(CONST_COMMON.REWARDID_TOMAINCODE[_loc9_]);
               _loc8_ = int(CONST_COMMON.REWARDID_TOSUBCODE[_loc9_]);
               _loc6_ += STRING_COMMON.GetItemNameByType(_loc7_,_loc8_);
               _loc6_ = _loc6_ + (":" + _loc5_.Quantity + "    ");
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      protected function GetRewardsOfInventory(param1:TInventories, param2:TInventories) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         _loc5_ = param1.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = param1.GetInventoryByIndex(_loc4_);
            _loc3_ = this.IfInventory(_loc6_.IDTemplate);
            if(_loc3_)
            {
               param2.Add(_loc6_);
            }
            _loc4_++;
         }
      }
      
      protected function GetAllRewardDescription(param1:TInventories) : String
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Vector.<uint> = null;
         _loc6_ = "";
         _loc4_ = param1.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.GetInventoryByIndex(_loc3_);
            _loc2_ = this.IfInventory(_loc5_.IDTemplate);
            if(!_loc2_)
            {
               _loc10_ = CONST_COMMON.REWARDIDNotInventory_DATA;
               _loc9_ = _loc10_.indexOf(_loc5_.IDTemplate);
               _loc7_ = int(CONST_COMMON.REWARDID_TOMAINCODE[_loc9_]);
               _loc8_ = int(CONST_COMMON.REWARDID_TOSUBCODE[_loc9_]);
               _loc6_ += STRING_COMMON.GetItemNameByType(_loc7_,_loc8_);
               _loc6_ = _loc6_ + ("*" + _loc5_.Quantity + "\n");
            }
            else
            {
               _loc6_ += _loc5_.Name + "*" + _loc5_.Quantity + "\n";
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      protected function IfInventory(param1:uint) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc3_ = CONST_COMMON.REWARDIDNotInventory_DATA;
         _loc2_ = _loc3_.indexOf(param1);
         return _loc2_ < 0;
      }
      
      protected function InitUIOtherNpcQuestDialog() : void
      {
         var _loc1_:TextField = null;
         this.FMC_Reward.visible = false;
         this.FCutOffLine.visible = false;
         this.FBtnContinue.visible = true;
         _loc1_ = this.FBtnContinue["BtnLable"];
         if(this.FOtherNpcQuest != null)
         {
            _loc1_.text = STRING_MAINSCENE.STRING_Continue;
            return;
         }
      }
      
      protected function UpdateUIOtherNpcQuestDialog() : void
      {
         this.InitUIOtherNpcQuestDialog();
      }
      
      protected function GetTalkContentByStatus(param1:TQuest) : String
      {
         switch(param1.TaskState)
         {
            case CONST_QUEST.STATE_ACCEPT:
               return param1.TalkBefor;
            case CONST_QUEST.STATE_TASKING:
               return param1.TalkBefor;
            case CONST_QUEST.STATE_TASKBACK:
               if(param1.BackTaskNpc == this.FUINpc.RoleData.RoleTemplateID)
               {
                  return param1.TalkEnd;
               }
               return param1.TalkBefor;
               break;
            default:
               return "";
         }
      }
      
      protected function UpdateNpcName() : void
      {
         this.FTF_NpcName.text = this.FUINpc.RoleData.RoleName;
      }
      
      protected function UpdateNpcPicture() : void
      {
         var _loc1_:Point = null;
         TGameUtil.ShowImageByID(Type_LargeIcon,this.FNpcBitmap,CONST_MODULES.MODULE_MainScene,this.FUINpc.NPcStyleTextureID);
         if(this.FNpcBitmap.bitmapData != null)
         {
            this.FSence.x = (CONST_COMMON.STAGE_Width - this.FSence.width) / 2;
            this.FSence.y = (CONST_COMMON.STAGE_Height - 450) / 2;
            this.visible = true;
         }
      }
      
      protected function UpdateSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = int(this.FRewardSlots.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRewardSlots[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function ChangeState(param1:int) : void
      {
         this.FCurrentState = param1;
         switch(param1)
         {
            case State_AtPanle1:
               this.UpdateNormaDialog();
               break;
            case State_AtPanle2:
               this.UpdateQuesteDialog();
               break;
            case State_WaitAcceptQuestBack:
            case State_WaitBackQuestBack:
               break;
            case State_Continue:
               this.InitUIOtherNpcQuestDialog();
         }
      }
      
      protected function ProcessorEffectAcquireInventory(param1:Vector.<TUISlot>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TUISlot = null;
         var _loc6_:Object = null;
         var _loc7_:TInventory = null;
         var _loc8_:TCoordinate = null;
         _loc3_ = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = param1[_loc2_];
            _loc6_ = _loc5_.Context;
            if(_loc6_ == null)
            {
               break;
            }
            _loc7_ = _loc6_ as TInventory;
            switch(_loc7_.Category)
            {
               case CONST_INVENTORY.CATEGORY_Normal:
                  switch(_loc7_.CategorySecond)
                  {
                     case 300:
                        _loc4_ = CONST_SHORTCUTS.TYPE_Function_TacticalDeployment;
                        break;
                     default:
                        _loc4_ = CONST_SHORTCUTS.TYPE_Function_Backpack;
                  }
            }
            _loc4_ = CONST_SHORTCUTS.TYPE_Function_Backpack;
            if(this.FOnQueryShortcutCoordinate != null)
            {
               this.FOnQueryShortcutCoordinate(this,_loc4_,this.FQueryCoordinate);
            }
            _loc8_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc5_.Resource);
            _loc8_.X += 4;
            _loc8_.Y += 4;
            this.FEffectCoordinateParameters.CoordinateSource.Assign(_loc8_);
            this.FEffectCoordinateParameters.CoordinateDestination.Assign(this.FQueryCoordinate.Value);
            if(this.FOnEffectAcquireInventory != null)
            {
               this.FOnEffectAcquireInventory(this,_loc6_,this.FEffectCoordinateParameters);
            }
            _loc2_++;
         }
      }
      
      protected function QuestShortcutClicked(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:int = this.FMC_QuestShortcuts.indexOf(_loc2_);
         if(this.FUINpc.RoleData.UserType != 1)
         {
            if(this.FUINpc.RoleData.UserType == CONST_NPC.NPC_FUNCTION_YUELAO)
            {
               if(this.FOpenNpcUserTypeWindow != null)
               {
                  this.FOpenNpcUserTypeWindow(this.FUINpc.RoleData.UserType,_loc3_);
               }
               this.HideDialog();
            }
            else if(_loc3_ == 0)
            {
               if(this.FOpenNpcUserTypeWindow != null)
               {
                  this.FOpenNpcUserTypeWindow(this.FUINpc.RoleData.UserType);
               }
               this.HideDialog();
            }
            else
            {
               this.FCurrentHandleQuest = this.FUINpc.NpcQuestes.GetQuestByIndex(_loc3_ - 1);
               this.ChangeState(State_AtPanle2);
            }
         }
         else
         {
            this.FCurrentHandleQuest = this.FUINpc.NpcQuestes.GetQuestByIndex(_loc3_);
            this.ChangeState(State_AtPanle2);
         }
      }
      
      protected function ShortcutBackClick(param1:MouseEvent) : void
      {
         this.HideDialog();
         TutorialNextStep(103);
      }
      
      protected function BtnContinueClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(this.FUINpc.RoleData.RoleTemplateID);
         param1.stopImmediatePropagation();
         switch(this.FCurrentState)
         {
            case State_AtPanle1:
               this.FCurrentHandleQuest = this.FUINpc.NpcQuestes.GetQuestByIndex(0);
               if(this.FCurrentHandleQuest.TaskState == CONST_QUEST.STATE_ACCEPT)
               {
                  this.FTaskOnClick(this.FCurrentHandleQuest,_loc2_);
                  this.ChangeState(State_WaitAcceptQuestBack);
               }
               else if(this.FCurrentHandleQuest.TaskState == CONST_QUEST.STATE_TASKING)
               {
                  this.FTaskOnClick(this.FCurrentHandleQuest,_loc2_);
                  this.HideDialog();
               }
               else if(this.FCurrentHandleQuest.TaskState == CONST_QUEST.STATE_TASKBACK)
               {
                  this.FTaskOnClick(this.FCurrentHandleQuest,_loc2_);
                  this.ChangeState(State_WaitBackQuestBack);
               }
               break;
            case State_AtPanle2:
               if(this.FCurrentHandleQuest.TaskState == CONST_QUEST.STATE_ACCEPT)
               {
                  if(this.FCurrentHandleQuest.RequirementLevelMin > SLogicsCore.Character.GetMainLevel())
                  {
                     EffectGenerateText(STRING_COMMON.NOTENOUGH_Level);
                     break;
                  }
                  this.FTaskOnClick(this.FCurrentHandleQuest,_loc2_);
                  this.ChangeState(State_WaitAcceptQuestBack);
               }
               else if(this.FCurrentHandleQuest.TaskState == CONST_QUEST.STATE_TASKING)
               {
                  this.FTaskOnClick(this.FCurrentHandleQuest,_loc2_);
                  this.HideDialog();
               }
               else if(this.FCurrentHandleQuest.TaskState == CONST_QUEST.STATE_TASKBACK)
               {
                  if(this.FCurrentHandleQuest.BackTaskNpc != this.FUINpc.RoleData.RoleTemplateID)
                  {
                     this.FTaskOnClick(this.FCurrentHandleQuest,_loc2_);
                     this.HideDialog();
                  }
                  else
                  {
                     this.FTaskOnClick(this.FCurrentHandleQuest,_loc2_);
                     this.ChangeState(State_WaitBackQuestBack);
                  }
               }
               break;
            case State_Continue:
               this.FTaskOnClick(this.FOtherNpcQuest,_loc2_);
               this.HideDialog();
               this.FOtherNpcQuest = null;
         }
         TutorialNextStep(101);
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:TInventory) : void
      {
         var _loc3_:TOverlayer = null;
         switch(param2.Category)
         {
            case CATEGORY_Equipment:
               _loc3_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc3_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc3_ = this.FOverlayerAccessory;
               break;
            default:
               _loc3_ = this.FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Context = param2;
            _loc3_.Render(FUICore.MouseCoordinate);
            _loc3_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:TInventory) : void
      {
         var _loc3_:TOverlayer = null;
         switch(param2.Category)
         {
            case CATEGORY_Equipment:
               _loc3_ = this.FOverlayerEquipment;
               break;
            case CATEGORY_Treasure:
               _loc3_ = this.FOverlayerTreasure;
               break;
            case CATEGORY_Accessories:
               _loc3_ = this.FOverlayerAccessory;
               break;
            default:
               _loc3_ = this.FOverlayerAppliance;
         }
         if(_loc3_ != null)
         {
            _loc3_.Hide();
         }
      }
      
      public function set OpenDiaLog(param1:Function) : void
      {
         this.FOpenDiaLog = param1;
      }
      
      public function set TaskOnClick(param1:Function) : void
      {
         this.FTaskOnClick = param1;
      }
      
      public function set UINpc(param1:TUIRoleNpc) : void
      {
         this.FUINpc = param1;
      }
      
      public function set OpenNpcUserTypeWindow(param1:Function) : void
      {
         this.FOpenNpcUserTypeWindow = param1;
      }
      
      public function set AfterHideDialog(param1:Function) : void
      {
         this.FAfterHideDialog = param1;
      }
      
      public function get OnEffectAcquireInventory() : Function
      {
         return this.FOnEffectAcquireInventory;
      }
      
      public function set OnEffectAcquireInventory(param1:Function) : void
      {
         this.FOnEffectAcquireInventory = param1;
      }
      
      public function get OnQueryShortcutCoordinate() : Function
      {
         return this.FOnQueryShortcutCoordinate;
      }
      
      public function set OnQueryShortcutCoordinate(param1:Function) : void
      {
         this.FOnQueryShortcutCoordinate = param1;
      }
      
      public function ShowDialog() : void
      {
         if(this.FUINpc.NpcQuestes.Count != 0)
         {
            this.FCurrentHandleQuest = this.FUINpc.NpcQuestes.GetQuestByIndex(0);
            switch(this.FCurrentHandleQuest.TaskState)
            {
               case CONST_QUEST.STATE_ACCEPT:
                  this.ChangeState(State_AtPanle1);
                  break;
               case CONST_QUEST.STATE_TASKING:
                  this.ChangeState(State_AtPanle1);
                  break;
               case CONST_QUEST.STATE_TASKBACK:
                  this.ChangeState(State_AtPanle2);
            }
         }
         else if(this.FOtherNpcQuest != null)
         {
            this.ChangeState(State_Continue);
         }
         else
         {
            this.ChangeState(State_AtPanle1);
         }
         this.UpdateNpcName();
         this.UpdateNpcPicture();
         this.FNeedUpdateNpcPicture = true;
         if(this.FUINpc.NpcQuestes.Count != 0 || this.FOtherNpcQuest != null)
         {
            TutorialNextStep(102);
         }
      }
      
      public function HideDialog() : void
      {
         this.visible = false;
         this.FNeedUpdateNpcPicture = false;
         this.FOtherNpcQuest = null;
         if(this.FAfterHideDialog != null)
         {
            this.FAfterHideDialog(this);
         }
      }
      
      public function AddNewQuest(param1:TQuest) : void
      {
         var _loc2_:Vector.<int> = null;
         var _loc3_:int = 0;
         if(STimingCore.TickCount - this.FCloseTick < 10000 && this.FCloseTick != 0)
         {
            _loc2_ = CONST_FRESHGUIDE.CompleteTaskTriggerPoint;
            _loc3_ = _loc2_.indexOf(param1.Identifier);
            if(_loc3_ < 0)
            {
               if(param1.AcceptTaskNpc == this.FCloseNpcID)
               {
                  this.ShowDialog();
               }
               else
               {
                  this.FOtherNpcQuest = param1;
                  this.ShowDialog();
               }
            }
            else
            {
               if(visible)
               {
                  this.HideDialog();
               }
               this.FOtherNpcQuest = null;
            }
         }
      }
      
      public function UpdateQuestState(param1:TQuest) : void
      {
         if(!visible)
         {
            return;
         }
         if(this.FCurrentHandleQuest.Identifier == param1.Identifier)
         {
            switch(this.FCurrentState)
            {
               case State_WaitAcceptQuestBack:
                  this.ChangeState(State_AtPanle2);
                  break;
               case State_WaitBackQuestBack:
                  if(this.FUINpc.NpcQuestes.Count > 0)
                  {
                     this.ShowDialog();
                  }
                  else
                  {
                     this.HideDialog();
                     this.FCloseNpcID = this.FUINpc.RoleData.RoleTemplateID;
                     this.FCloseTick = STimingCore.TickCount;
                  }
                  EffectGenerateText(this.GetAllRewardDescription(param1.RewardsInventory));
                  this.ProcessorEffectAcquireInventory(this.FRewardSlots);
            }
         }
      }
   }
}

