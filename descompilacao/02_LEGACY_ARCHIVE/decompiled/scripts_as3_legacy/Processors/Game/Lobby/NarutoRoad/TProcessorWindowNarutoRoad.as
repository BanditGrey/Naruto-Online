package Processors.Game.Lobby.NarutoRoad
{
   import Components.ScrollBar.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import Logics.NarutoRoad.*;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.NarutoRoad.Components.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class TProcessorWindowNarutoRoad extends TProcessorLobbyWindow
   {
      
      public static const TAB_LEVEL_COUNT:int = CONST_NARUTOROAD.GROW_ROAD_TAB_NUM;
      
      public static const LEVEL_BOX_COUNT:int = CONST_NARUTOROAD.LEVEL_BOX_COUNT;
      
      public static const REWARD_BUTTON_COUNT:int = CONST_NARUTOROAD.REWARD_BUTTON_COUNT;
      
      public static const MIN_SCROLL_HEIGHT:Number = 351;
      
      public static const ITEM_STAMP:Number = -8;
      
      public static const SINGLE_ITEM_STAMP:Number = 68;
      
      public static const TIP_COUNT:int = 5;
      
      protected var FMC_Scene:Sprite;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FCurPage:int;
      
      protected var FSelectPage:int;
      
      protected var FTotlePage:int;
      
      protected var FUITabVect:Vector.<MovieClip>;
      
      protected var FUIArrowVect:Vector.<MovieClip>;
      
      protected var FGroupId:uint;
      
      protected var FSelectMission:uint;
      
      protected var FChgMissionId:uint;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_Context:TextField;
      
      protected var FTF_Target:TextField;
      
      protected var FMC_BeVip:Sprite;
      
      protected var FTF_BeVip:TextField;
      
      protected var FTF_VipTip:TextField;
      
      protected var FBeVipFormat:TextFormat;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FTaskItemList:Vector.<TNarutoRoadTaskItem>;
      
      protected var FFreeTaskItemList:Vector.<TNarutoRoadTaskItem>;
      
      protected var FBtn_Goto:MovieClip;
      
      protected var FBtn_GetReward:MovieClip;
      
      protected var FBtn_GetVipReward:MovieClip;
      
      protected var FLevelBoxVect:Vector.<MovieClip>;
      
      protected var FTF_LevelTip:TextField;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FProcessorWindowBuyBox:TProcessorWindowBuyBox;
      
      protected var FBuyIndex:int;
      
      protected var FEffectsBaseGlowTab:Vector.<TEffectBaseGlow>;
      
      protected var FEffectsBaseGlowBtn:Vector.<TEffectBaseGlow>;
      
      protected var FMissionGetStatus:Vector.<Boolean>;
      
      protected var FCharacter:TCharacter;
      
      protected var FNarutoData:TNarutoRoadData;
      
      protected var FCurGroupData:TNarutoRoadGroup;
      
      protected var FHintBoxTip:THint;
      
      protected var FRewardStatus:Vector.<uint>;
      
      protected var FCompleteStatus:Vector.<uint>;
      
      protected var FOnGoto:Function;
      
      protected var FHintOnMove:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnNarutoRoadInfoReq:Function;
      
      public function TProcessorWindowNarutoRoad(param1:TUIComponent)
      {
         super(param1);
         this.FTaskItemList = new Vector.<TNarutoRoadTaskItem>();
         this.FFreeTaskItemList = new Vector.<TNarutoRoadTaskItem>();
         this.FUITabVect = new Vector.<MovieClip>();
         this.FUIArrowVect = new Vector.<MovieClip>();
         this.FLevelBoxVect = new Vector.<MovieClip>(LEVEL_BOX_COUNT);
         this.FHintBoxTip = new THint();
         this.FBeVipFormat = new TextFormat();
         this.FCharacter = SLogicsCore.Character;
         this.FNarutoData = SLogicsCore.NarutoRoadData;
         this.FEffectsBaseGlowTab = new Vector.<TEffectBaseGlow>(TAB_LEVEL_COUNT);
         this.FEffectsBaseGlowBtn = new Vector.<TEffectBaseGlow>(REWARD_BUTTON_COUNT);
         this.FMissionGetStatus = new Vector.<Boolean>(REWARD_BUTTON_COUNT);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.Resources_UIDispatch_Tab();
         this.Resources_UIDispatch_Task();
         this.Resources_UIDispatch_Context();
         this.Resources_UIDispatch_Shop();
      }
      
      protected function Resources_UIDispatch_Tab() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:TEffectBaseGlow = null;
         this.FUI_Left_Btn = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_BTN_LEFT];
         this.FUI_Right_Btn = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_BTN_RIGHT];
         TGameUtil.setButtonMode(this.FUI_Left_Btn,true);
         TGameUtil.setButtonMode(this.FUI_Right_Btn,true);
         _loc2_ = 0;
         while(_loc2_ < TAB_LEVEL_COUNT)
         {
            _loc1_ = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_MC_TabLevel + _loc2_];
            TGameUtil.setButtonMode(_loc1_,true);
            _loc1_.TF_Text.mouseEnabled = false;
            _loc1_.TF_Level.mouseEnabled = false;
            _loc3_ = new TEffectBaseGlow();
            _loc3_.SetParameters(_loc1_,15911245,1);
            _loc3_.visible = false;
            this.FEffectsBaseGlowTab[_loc2_] = _loc3_;
            _loc1_.addEventListener(MouseEvent.CLICK,this.ProcessorOnTabClick);
            this.FUITabVect.push(_loc1_);
            _loc1_ = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_MC_Arrow + _loc2_];
            this.FUIArrowVect.push(_loc1_);
            _loc2_++;
         }
         this.FCurPage = 0;
         this.FSelectPage = 0;
         this.FSelectMission = 0;
         this.FTotlePage = this.FNarutoData.Count - TAB_LEVEL_COUNT;
      }
      
      protected function Resources_UIDispatch_Task() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_List = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_MC_List];
         this.FScrollBar = new TScrollBar(this.FMC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
      }
      
      protected function Resources_UIDispatch_Context() : void
      {
         var _loc1_:TEffectBaseGlow = null;
         this.FTF_Title = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_TF_Title];
         this.FTF_Context = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_TF_Context];
         this.FTF_Target = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_Target];
         this.FMC_BeVip = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_BeVip];
         this.FTF_BeVip = this.FMC_BeVip[CONST_NARUTOROAD.RESOURCE_Link_TF_BeVip];
         this.FTF_VipTip = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_VipTip];
         this.FBeVipFormat.underline = true;
         this.FTF_BeVip.setTextFormat(this.FBeVipFormat);
         this.FMC_BeVip.buttonMode = true;
         this.FMC_BeVip.mouseChildren = false;
         this.FBtn_Goto = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_Btn_Goto];
         this.FBtn_GetReward = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_Btn_GetReward];
         this.FBtn_GetVipReward = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_Btn_GetVipReward];
         TGameUtil.setButtonMode(this.FBtn_Goto,true);
         TGameUtil.setButtonMode(this.FBtn_GetReward,true);
         TGameUtil.setButtonMode(this.FBtn_GetVipReward,false);
         _loc1_ = new TEffectBaseGlow();
         _loc1_.SetParameters(this.FBtn_GetReward,15911245,1);
         _loc1_.visible = false;
         this.FEffectsBaseGlowBtn[0] = _loc1_;
         _loc1_ = new TEffectBaseGlow();
         _loc1_.SetParameters(this.FBtn_GetVipReward,15911245,1);
         _loc1_.visible = false;
         this.FEffectsBaseGlowBtn[1] = _loc1_;
      }
      
      protected function Resources_UIDispatch_Shop() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         this.FTF_LevelTip = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_TF_LevelTip];
         _loc1_ = 0;
         while(_loc1_ < LEVEL_BOX_COUNT)
         {
            _loc2_ = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_LevelBox + _loc1_];
            TGameUtil.setButtonMode(_loc2_[CONST_NARUTOROAD.RESOURCE_Link_Btn_Buy],false);
            _loc2_[CONST_NARUTOROAD.RESOURCE_Link_Btn_Buy].addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnBtnBuyUp);
            this.FLevelBoxVect[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent.Parent);
         this.FUIWindowRecharge.x = (FUICore.StageWidth - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (FUICore.StageHeight - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FProcessorWindowBuyBox = new TProcessorWindowBuyBox(this);
         this.FProcessorWindowBuyBox.OnClose = this.ProcessorWindowBuyBoxClose;
         this.FProcessorWindowBuyBox.BoxOnBuy = this.ProcessorWindowBuyBoxComfirm;
         this.FProcessorWindowBuyBox.HintOnMove = this.ShowHint;
         this.FProcessorWindowBuyBox.HintOnOut = this.HideHint;
         this.FProcessorWindowBuyBox.X = 260;
         this.FProcessorWindowBuyBox.Y = 130;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Sprite = null;
         this.FUI_Left_Btn.addEventListener(MouseEvent.CLICK,this.ProcessorOnBtnLeftClick);
         this.FUI_Right_Btn.addEventListener(MouseEvent.CLICK,this.ProcessorOnBtnRightClick);
         this.FBtn_Goto.addEventListener(MouseEvent.CLICK,this.ProcessorOnBtnGotoUp);
         this.FBtn_GetReward.addEventListener(MouseEvent.CLICK,this.ProcessorOnBtnGetAwardUp);
         this.FBtn_GetVipReward.addEventListener(MouseEvent.CLICK,this.ProcessorOnBtnGetAwardUp);
         this.FMC_BeVip.addEventListener(MouseEvent.CLICK,this.ProcessorOnBeVipUp);
         _loc1_ = 0;
         while(_loc1_ < TIP_COUNT)
         {
            _loc2_ = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_MC_BoxTip + _loc1_];
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnRollOver);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.OnRollOut);
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateSelectTabUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TNarutoRoadGroup = null;
         var _loc3_:TNarutoRoadPackage = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.FNarutoData.SortById();
         _loc1_ = 0;
         while(_loc1_ < TAB_LEVEL_COUNT)
         {
            _loc2_ = this.FNarutoData.GetGroupByIndex(_loc1_ + this.FCurPage);
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.NarutoRoadPackage;
               _loc4_ = this.FUITabVect[_loc1_];
               _loc5_ = this.FUIArrowVect[_loc1_];
               if(this.FSelectPage == _loc1_)
               {
                  TGameUtil.setButtonMode(_loc4_,false);
                  _loc4_.gotoAndStop("selected");
                  if(this.FGroupId == 0)
                  {
                     this.FGroupId = _loc2_.Identifier;
                  }
                  if(this.FGroupId != _loc2_.Identifier && this.FOnNarutoRoadInfoReq != null)
                  {
                     this.FGroupId = _loc2_.Identifier;
                     this.FOnNarutoRoadInfoReq(this.FGroupId);
                  }
               }
               else if(this.FCharacter.GetMainLevel() >= _loc3_.OpenLevel)
               {
                  TGameUtil.setButtonMode(_loc4_,true);
                  _loc4_.gotoAndStop("up");
               }
               else
               {
                  TGameUtil.setButtonMode(_loc4_,false);
               }
               if(_loc5_ != null)
               {
                  if(this.FCharacter.GetMainLevel() >= _loc3_.OpenLevel)
                  {
                     _loc5_.visible = true;
                     _loc6_ = _loc1_;
                  }
                  else
                  {
                     _loc5_.visible = false;
                  }
                  _loc5_.stop();
               }
               else if(this.FCharacter.GetMainLevel() >= _loc3_.OpenLevel)
               {
                  _loc6_ = _loc1_;
               }
               _loc4_[CONST_NARUTOROAD.RESOURCE_LINK_TF_Text].text = _loc3_.Name;
               _loc4_[CONST_NARUTOROAD.RESOURCE_LINK_TF_Level].text = TUtilityString.Format(STRING_NARUTOROAD.FORMAT_LevelTitle,_loc3_.OpenLevel,_loc3_.EndLevel);
               _loc7_ = this.FCompleteStatus[_loc1_ + this.FCurPage];
               _loc4_[CONST_NARUTOROAD.Resource_Link_MC_Complete].visible = Boolean(_loc7_);
            }
            _loc1_++;
         }
         if(this.FUIArrowVect[_loc6_] != null)
         {
            this.FUIArrowVect[_loc6_].play();
         }
         while(_loc1_ < TAB_LEVEL_COUNT)
         {
            _loc4_ = this.FUITabVect[_loc1_];
            _loc4_.visible = false;
            _loc1_++;
         }
      }
      
      protected function UpdateTask() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:TNarutoRoadTaskItem = null;
         var _loc5_:TNarutoRoadMission = null;
         var _loc6_:int = 0;
         this.FCurGroupData = this.FNarutoData.GetGroupByIndex(this.FSelectPage + this.FCurPage);
         this.FCurGroupData.SortByValue();
         if(this.FChgMissionId != 0)
         {
            this.FSelectMission = this.FCurGroupData.GetMissionIndexById(this.FChgMissionId);
            this.FChgMissionId = 0;
         }
         _loc3_ = int(this.FCurGroupData.Count);
         _loc6_ = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc5_ = this.FCurGroupData.GetMissionByIndex(_loc1_);
            if(_loc6_ < this.FTaskItemList.length)
            {
               _loc4_ = this.FTaskItemList[_loc6_];
            }
            else
            {
               _loc4_ = this.FFreeTaskItemList.pop();
               if(_loc4_ == null)
               {
                  _loc4_ = new TNarutoRoadTaskItem(this);
                  _loc4_.OnTaskUp = this.ProcessorOnTaskUp;
               }
               this.FTaskItemList.push(_loc4_);
               this.FScrollBar.AddItem(_loc4_);
            }
            _loc4_.MissionData = _loc5_;
            _loc4_.Update();
            _loc4_.IsSelected = Boolean(_loc6_ == this.FSelectMission);
            _loc4_.y = _loc6_ * SINGLE_ITEM_STAMP;
            _loc6_++;
            _loc1_++;
         }
         _loc3_ = int(this.FTaskItemList.length);
         _loc2_ = int(_loc3_ - 1);
         while(_loc2_ >= _loc6_)
         {
            _loc4_ = this.FScrollBar.DelItem(_loc2_) as TNarutoRoadTaskItem;
            this.FTaskItemList.splice(_loc2_,1);
            this.FFreeTaskItemList.push(_loc4_);
            _loc2_--;
         }
      }
      
      protected function UpdateContext() : void
      {
         var _loc1_:TNarutoRoadMission = null;
         var _loc2_:TNarutoRoadTask = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         this.FCurGroupData.SortByValue();
         _loc1_ = this.FCurGroupData.GetMissionByIndex(this.FSelectMission);
         if(_loc1_ != null)
         {
            _loc2_ = _loc1_.NarutoRoadTask;
            this.FTF_Title.text = _loc2_.Name;
            this.FTF_Context.text = _loc2_.Description;
            this.FTF_Target.text = TUtilityString.Format(_loc2_.TaskTarget,_loc1_.MissionCount);
            this.FBtn_GetReward.visible = true;
            this.FBtn_GetVipReward.visible = true;
            if(_loc1_.MissionStatus != 2)
            {
               _loc3_ = false;
               _loc4_ = false;
            }
            else
            {
               _loc3_ = Boolean(_loc1_.RewardType == 0 && this.FCharacter.VipLevel >= _loc2_.RewardLevel);
               _loc4_ = Boolean(_loc1_.VipRewardType == 0 && this.FCharacter.VipLevel >= _loc2_.RewardVipLevel);
            }
            this.FBtn_Goto.visible = Boolean(_loc2_.Isgoto != 0);
            if(this.FCharacter.VipLevel < _loc2_.RewardVipLevel)
            {
               this.FTF_VipTip.visible = true;
               this.FTF_VipTip.text = TUtilityString.Format(STRING_NARUTOROAD.FORMAT_VipTip,_loc2_.RewardVipLevel);
            }
            else
            {
               this.FTF_VipTip.visible = false;
            }
         }
         else
         {
            this.FTF_Title.text = STRING_COMMON.COMMON_NONE;
            this.FTF_Context.text = STRING_COMMON.COMMON_NONE;
            this.FTF_Target.text = STRING_COMMON.COMMON_NONE;
            _loc3_ = false;
            _loc4_ = false;
            this.FBtn_Goto.visible = false;
         }
         TGameUtil.setButtonMode(this.FBtn_GetReward,_loc3_);
         TGameUtil.setButtonMode(this.FBtn_GetVipReward,_loc4_);
         this.FMissionGetStatus[0] = _loc3_;
         this.FMissionGetStatus[1] = _loc4_;
         if(_loc1_ != null)
         {
            if(_loc1_.RewardType != 0)
            {
               this.FBtn_GetReward.gotoAndStop("got");
            }
            if(_loc1_.VipRewardType != 0)
            {
               this.FBtn_GetVipReward.gotoAndStop("got");
            }
            else if(this.FBtn_GetVipReward.tf_info)
            {
               this.FBtn_GetVipReward.tf_info.text = TUtilityString.Format(STRING_NARUTOROAD.FORMAT_VipLevelGet,_loc2_.RewardVipLevel);
            }
         }
      }
      
      protected function UpdateShop() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TNarutoRoadPackage = null;
         var _loc4_:uint = 0;
         _loc3_ = this.FCurGroupData.NarutoRoadPackage;
         this.FTF_LevelTip.text = TUtilityString.Format(STRING_NARUTOROAD.FORMAT_LevelTip,_loc3_.OpenLevel,_loc3_.EndLevel);
         _loc1_ = 0;
         while(_loc1_ < LEVEL_BOX_COUNT)
         {
            _loc4_ = _loc3_.RewardNumberVect[_loc1_] - this.FCurGroupData.BuyCount[_loc1_];
            _loc2_ = this.FLevelBoxVect[_loc1_];
            _loc2_[CONST_NARUTOROAD.RESOURCE_Link_TF_Discount].text = TUtilityString.Format(STRING_NARUTOROAD.FORMAT_Discount,_loc3_.RewardDiscountVect[_loc1_]);
            _loc2_[CONST_NARUTOROAD.RESOURCE_Link_TF_Count].text = TUtilityString.Format(STRING_NARUTOROAD.FORMAT_TaskProcess,_loc4_,_loc3_.RewardNumberVect[_loc1_]);
            if(this.FCharacter.GetMainLevel() < _loc3_.OpenLevel || this.FCharacter.GetMainLevel() > _loc3_.EndLevel)
            {
               TGameUtil.setButtonMode(_loc2_[CONST_NARUTOROAD.RESOURCE_Link_Btn_Buy],false);
               _loc2_[CONST_NARUTOROAD.RESOURCE_Link_MC_OutLevel].visible = Boolean(_loc4_ > 0);
            }
            else
            {
               _loc2_[CONST_NARUTOROAD.RESOURCE_Link_MC_OutLevel].visible = false;
               if(_loc3_.RewardNumberVect[_loc1_] - this.FCurGroupData.BuyCount[_loc1_] <= 0)
               {
                  TGameUtil.setButtonMode(_loc2_[CONST_NARUTOROAD.RESOURCE_Link_Btn_Buy],false);
                  _loc2_[CONST_NARUTOROAD.RESOURCE_Link_Btn_Buy].gotoAndStop(5);
               }
               else
               {
                  TGameUtil.setButtonMode(_loc2_[CONST_NARUTOROAD.RESOURCE_Link_Btn_Buy],true);
               }
            }
            _loc2_[CONST_NARUTOROAD.RESOURCE_Link_MC_SellEnd].visible = Boolean(_loc4_ <= 0);
            _loc1_++;
         }
      }
      
      protected function ProcessorOnTaskUp(param1:Object, param2:TNarutoRoadMission) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:TNarutoRoadTaskItem = null;
         _loc3_ = 0;
         while(_loc3_ < this.FTaskItemList.length)
         {
            _loc4_ = this.FTaskItemList[_loc3_];
            if(param1 != _loc4_)
            {
               _loc4_.IsSelected = false;
            }
            else
            {
               this.FSelectMission = this.FCurGroupData.GetMissionIndexById(param2.Identifier);
            }
            _loc3_++;
         }
         this.UpdateContext();
      }
      
      protected function GetTipStr(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:TNarutoRoadMission = null;
         var _loc6_:Array = null;
         var _loc4_:String = "";
         if(this.FCurGroupData == null)
         {
            return "";
         }
         _loc5_ = this.FCurGroupData.GetMissionByIndex(this.FSelectMission);
         if(_loc5_ == null)
         {
            return "";
         }
         _loc4_ = "";
         if(param1 < LEVEL_BOX_COUNT)
         {
            _loc6_ = this.FCurGroupData.NarutoRoadPackage.RewardVect[param1];
            _loc4_ = STRING_NARUTOROAD.FORMAT_BuyBox;
            _loc3_ = int(_loc6_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ += STRING_COMMON.GetItemNameByType(_loc6_[_loc2_]["type"],_loc6_[_loc2_]["code"]) + ": *" + _loc6_[_loc2_]["amount"] + "\n";
               _loc2_++;
            }
         }
         else
         {
            if(param1 == LEVEL_BOX_COUNT + 0)
            {
               _loc6_ = _loc5_.NarutoRoadTask.RewardsVect;
            }
            else if(param1 == LEVEL_BOX_COUNT + 1)
            {
               _loc6_ = _loc5_.NarutoRoadTask.RewardsVipVect;
            }
            _loc4_ = STRING_NARUTOROAD.FORMAT_GetReward;
            _loc3_ = int(_loc6_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ += STRING_COMMON.GetItemNameByType(_loc6_[_loc2_]["type"],_loc6_[_loc2_]["code"]) + ": *" + _loc6_[_loc2_]["amount"] + "\n";
               _loc2_++;
            }
         }
         return _loc4_;
      }
      
      protected function ProcessorWindowBuyBoxClose() : void
      {
         this.FProcessorWindowBuyBox.Visible = false;
      }
      
      protected function ProcessorWindowBuyBoxComfirm(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         _loc4_ = this.FCurGroupData.NarutoRoadPackage.RewardPriceVect[this.FBuyIndex] * param1;
         if(_loc4_ > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_BuyReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FCurGroupData.Identifier);
         _loc3_.writeByte(this.FBuyIndex);
         _loc3_.writeByte(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnBtnLeftClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         --this.FCurPage;
         if(this.FCurPage < 0)
         {
            this.FCurPage = 0;
         }
         ++this.FSelectPage;
         this.CheckBtn();
         this.UpdateSelectTabUI();
      }
      
      protected function ProcessorOnBtnRightClick(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         ++this.FCurPage;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         --this.FSelectPage;
         this.CheckBtn();
         this.UpdateSelectTabUI();
      }
      
      protected function CheckBtn() : void
      {
         if(this.FTotlePage < 0)
         {
            this.FUI_Left_Btn.visible = false;
            this.FUI_Right_Btn.visible = false;
            return;
         }
         this.FUI_Left_Btn.visible = Boolean(this.FCurPage != 0);
         this.FUI_Right_Btn.visible = Boolean(this.FCurPage != this.FTotlePage);
      }
      
      protected function ProcessorOnTabClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(11));
         if(_loc2_ == this.FSelectPage)
         {
            return;
         }
         this.FSelectPage = _loc2_;
         this.FSelectMission = 0;
         this.UpdateSelectTabUI();
         this.UpdateTask();
         this.UpdateContext();
         this.FScrollBar.ScrollToUp();
      }
      
      protected function ProcessorOnBtnGotoUp(param1:MouseEvent) : void
      {
         var _loc2_:TNarutoRoadMission = null;
         _loc2_ = this.FCurGroupData.GetMissionByIndex(this.FSelectMission);
         if(_loc2_ != null && _loc2_.NarutoRoadTask.Isgoto != 0 && this.FOnGoto != null)
         {
            this.FOnGoto(this,_loc2_.NarutoRoadTask.Isgoto);
         }
      }
      
      protected function ProcessorOnBtnGetAwardUp(param1:MouseEvent) : void
      {
         var _loc2_:TNarutoRoadMission = null;
         var _loc3_:uint = 0;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         _loc2_ = this.FCurGroupData.GetMissionByIndex(this.FSelectMission);
         if(_loc2_ == null)
         {
            return;
         }
         if(param1.currentTarget.name == "Btn_GetVipReward")
         {
            _loc3_ = 1;
            TGameUtil.setButtonMode(this.FBtn_GetVipReward,false);
         }
         else
         {
            _loc3_ = 0;
            TGameUtil.setButtonMode(this.FBtn_GetReward,false);
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NarutoRoad_GetRewardReq);
         _loc5_ = _loc4_.Data;
         _loc5_.writeUnsignedInt(_loc2_.Identifier);
         _loc5_.writeByte(_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function ProcessorOnBtnBuyUp(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         this.FBuyIndex = int(param1.currentTarget.parent.name.slice(11));
         this.FProcessorWindowBuyBox.Visible = true;
         this.FProcessorWindowBuyBox.UpdateData(this.FCurGroupData.NarutoRoadPackage,this.FBuyIndex,this.FCurGroupData.BuyCount[this.FBuyIndex]);
      }
      
      protected function ProcessorOnBeVipUp(param1:MouseEvent) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(this,CONST_POPTIPS.POPTIP_Goto_Vip);
         }
      }
      
      protected function OnRollOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         this.ShowHint(this,_loc2_);
      }
      
      protected function OnRollOut(param1:MouseEvent) : void
      {
         this.HideHint(this);
      }
      
      protected function ShowHint(param1:Object, param2:int) : void
      {
         var _loc3_:String = null;
         _loc3_ = this.GetTipStr(param2);
         this.FHintBoxTip.Caption = _loc3_;
         if(this.FHintOnMove != null)
         {
            this.FHintOnMove(param1,this.FHintBoxTip);
         }
      }
      
      protected function HideHint(param1:Object) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function get HintOnMove() : Function
      {
         return this.FHintOnMove;
      }
      
      public function set HintOnMove(param1:Function) : void
      {
         this.FHintOnMove = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get OnNarutoRoadInfoReq() : Function
      {
         return this.FOnNarutoRoadInfoReq;
      }
      
      public function set OnNarutoRoadInfoReq(param1:Function) : void
      {
         this.FOnNarutoRoadInfoReq = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
      }
      
      public function GetAwardUpdata() : void
      {
         this.UpdateTask();
         this.UpdateContext();
      }
      
      public function BuyUpdateShop() : void
      {
         this.UpdateShop();
      }
      
      public function VipLevelUpdate() : void
      {
         this.UpdateTask();
         this.UpdateContext();
      }
      
      public function Updata() : void
      {
         this.UpdateSelectTabUI();
         this.UpdateTask();
         this.UpdateContext();
         this.UpdateShop();
         this.CheckBtn();
      }
      
      public function SetSelectPage(param1:uint, param2:uint) : void
      {
         var _loc3_:uint = 0;
         if(param1 < TAB_LEVEL_COUNT)
         {
            this.FCurPage = 0;
            this.FSelectPage = param1;
         }
         else
         {
            this.FCurPage = param1 - TAB_LEVEL_COUNT + 1;
            this.FSelectPage = TAB_LEVEL_COUNT - 1;
         }
         this.FChgMissionId = param2;
         if(this.FScrollBar != null)
         {
            this.FScrollBar.ScrollToUp();
         }
      }
      
      public function SetTabStatus(param1:Vector.<uint>, param2:Vector.<uint>) : void
      {
         this.FRewardStatus = param1;
         this.FCompleteStatus = param2;
         if(this.FMC_Scene != null)
         {
            this.UpdateSelectTabUI();
         }
      }
      
      public function UpdateEffectsGlow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEffectBaseGlow = null;
         _loc2_ = int(this.FEffectsBaseGlowTab.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEffectsBaseGlowTab[_loc1_];
            if(Boolean(this.FRewardStatus) && Boolean(this.FRewardStatus[_loc1_ + this.FCurPage]))
            {
               _loc3_.Run();
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.Stop();
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         _loc2_ = int(this.FEffectsBaseGlowBtn.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEffectsBaseGlowBtn[_loc1_];
            if(this.FMissionGetStatus[_loc1_])
            {
               _loc3_.Run();
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.Stop();
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
   }
}

